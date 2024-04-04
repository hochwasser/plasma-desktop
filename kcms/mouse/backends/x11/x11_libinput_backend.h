/*
    SPDX-FileCopyrightText: 2018 Roman Gilg <subdiff@gmail.com>

    SPDX-License-Identifier: GPL-2.0-or-later
*/

#pragma once

#include "inputbackend.h"

#include <QList>

class X11LibinputBackend : public InputBackend
{
    Q_OBJECT

public:
    explicit X11LibinputBackend(QObject *parent = nullptr);
    ~X11LibinputBackend() = default;

    void kcmInit() override;

    bool applyConfig() override;
    bool getConfig() override;
    bool getDefaultConfig() override;
    bool isChangedConfig() const override;
    QString errorString() const override
    {
        return m_errorString;
    }

    int deviceCount() const override
    {
        return 1;
    }
    bool isAnonymousDevice() const override
    {
        return true;
    }
    QList<QObject *> getDevices() const override
    {
        return QList<QObject *>(1, m_device);
    }

private:
    QObject *m_device;
    QString m_errorString = QString();
};
