Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6896ED69E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 23:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbjDXVOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 17:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjDXVOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 17:14:06 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F97FC;
        Mon, 24 Apr 2023 14:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1682370818; i=w_armin@gmx.de;
        bh=D/ZN5W3dxwtxO1mrqGKlXXawYyZ5eBPYQPVaAUgQueM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=pIbgoZvqh7hBGe61WG27nvLjzZftCS93ZWF4Cm1caxGneVGcNBjzngOsezKMbjgxp
         Qp3/5jfGKsBlIPVNDqL8oi422sw2aVtYo6uIbcsEHejFp13lQxyl2yA9jHGGYpVOtQ
         Ib3cgyeRZNKlJ+7uv6guRXSLMOqf5eKDSRAnj9kwjtB2I8/1Hdsik0XPLW2tqXJb3b
         XOPa5FlH0f8VIM1BhTLspMRi+dFX6mVOFX1e7E7fdiOsTFyotL6B8nOEhgyaKkFomZ
         7zuAlTbAxYerzxfTviNvCsf0Di1NDbcguPUOz1KMOGW2fvuMzLVqFI28JdBAOS7L1c
         oKlBZ7IWoegfQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M42jQ-1pr3VC05j6-00068s; Mon, 24
 Apr 2023 23:13:38 +0200
Subject: Re: [PATCH v3] hwmon: add HP WMI Sensors driver
To:     James Seo <james@equiv.tech>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230424100459.41672-1-james@equiv.tech>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <cd81a7d6-4b81-f074-1f28-6d1b5300b937@gmx.de>
Date:   Mon, 24 Apr 2023 23:13:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20230424100459.41672-1-james@equiv.tech>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:kA26GrKYWeZbBYych+Jbke5q+cqlzfapEAwQbkcZ4TiqLNnteT7
 vvGDGb3VUjYZxgMXO3r4ykRpkIsRmQu9/LKp1yNs0WGchxfYg6VRDpgh5z5SLLgp8WsrTWg
 MP98+YA61r6lnL+WgDheDw/t+wmLqDdSbFgCDU1B8h7AMZ8guxBjWx7tcEgx/+xQUaXkMDT
 5lfHlFiLVMNJfcEnuT68w==
UI-OutboundReport: notjunk:1;M01:P0:oZLLvp9Y5as=;I3gHSQuyf4HWc0yn1doV449V3DZ
 K3iBpl/3AnwBCRt+IjC5ooULCktqMEhS6+Gt3hz2+oTV0ClS0CHaVMvh9vZiUi7lPj1Ot81oi
 IJkkiZ7q83BQSVM0of2IuayxV0H6rkeiQE3f+bD/XpvkJKJHmQTQl9MlSOrSH46Ct76gdq61c
 8meQsafmlGYzY4zGE4vY1fW99pK9qdQp2P3Dg47DcQjUt//HKKo6IhwyOzqEd79V6BWhR0OtB
 GkVUI3AFSDTGoTByp65tdHPYyCc0hfYbJ7Sxj38gsuheDfj3Lww042FYwS5hk3ZdynI7szehi
 4dMzsUe4cyOtd/8z5Qb6drhzaPbP5BWoYPK4ghBQyw5ONAHWzanT+P2eexPOZdafYuaShTiGZ
 9eOpMSqAud5P9Qo81AfvnoikJ3ZBstTwbQLCNTX/l3QJrzoNp850iOXDG9wjzIMHUkaBXft5Z
 FZPqIzOiDfBCQuLzc+jMzA142iX+wL619/mqsabb7YhQN7x7bUo9b/1h4ARdct7fnnCwsTkaG
 rKy0KZiiqNOZ1JSJ5hCcNdQwQYZFfTB52WTEzPEfu1o/cfYE2eAmuRkhk736DzH3uhvUdfiK0
 EUNfluT3rJoTpEHF0jd9swSO6KCboUp876/IxnGc7Q2Ud8Hmy5vzga8uwG1LzupFMpgfRpYvA
 BTRFKUUuHtPg3Xv1ZZR3pvakTeGB8rTe7IOX5vyOaLcP0SH6vClz2zPCGHQ7Fr38VYLUjp4KK
 x0bSR65Ged5Rco81ltH8BhLW5YgpgFPSNAxriDDy+LjeDcYLCrCMvbl5YIcDeg1s4pK/pzU5u
 9S/VdkivqcWfmz2J+pIJUWSpuelb+rQfDpV4Q+risX4Uit6XCGYTJIMFa4YSXHBdfgsjI2vwd
 hocZhMZzWGPXuvkV5BK5atWChR6lLRAtEJUVbI+Mw8sUQXkQcHa8FXiRdYHoOsdrhj3gN3Iks
 KZXdcUmhbBl4vxwIKIrndlkBhpc=
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FUZZY_MILLION,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 24.04.23 um 12:05 schrieb James Seo:

> Hewlett-Packard (and some HP Compaq) business-class computers report
> hardware monitoring information via WMI. This driver exposes that
> information to hwmon.
>
> Initial support is provided for temperature, fan speed, and intrusion
> sensor types. Provisional support is provided for voltage and current
> sensor types.
>
> HP's WMI implementation permits many other types of numeric sensors.
> Therefore, a debugfs interface is also provided to enumerate and
> inspect all numeric sensors visible on the WMI side. This should
> facilitate adding support for other sensor types in the future.
>
> Tested on a HP Z420, a HP EliteOne 800 G1, and a HP Compaq Elite 8300
> SFF.
>
> Note that provisionally supported sensor types are untested and seem
> to be rare-to-nonexistent in the wild, having been encountered
> neither on test systems nor in ACPI dumps from the Linux Hardware
> Database. They are included because their general popularity makes
> their presence on past or future HP systems plausible and because no
> doubt exists as to how the sensors themselves would be represented in
> WMI (alarm attributes will need to wait for hardware to be located).
> A 2005 HP whitepaper gives the relevant sensor object MOF definition
> and sensor value scaling calculation, and both this driver and the
> official HP Performance Advisor utility comply with them (confirmed
> in the latter case by reverse engineering).
>
> Link: https://h20331.www2.hp.com/hpsub/downloads/cmi_whitepaper.pdf
> Signed-off-by: James Seo <james@equiv.tech>
>
> ---
>
> Changes in v3:
> * Address reviewer comments
>    - Filter out only disconnected sensors
>    - Remove unnecessary GUID check
>    - Add comment about HP's odd choice of fan RPM sensor type
>    - Detect fault condition in a more nuanced manner
>    - Change format string for debugfs root directory name
>    - Don't have an else branch after return in an if statement
>    - Don't goto a return statement without cleanup before it
>    - Remove unused pointer from driver state struct
> * Cleanups and minor changes
>    - Add support for "Temperature Index" Celsius sensors
>    - Adjust a goto to avoid an unnecessary call to kfree()
>    - Trim strings received from WMI
>    - Reword help entry in Kconfig
> * Implement temperature, fan, and intrusion alarm attributes
> * Expose "platform events" used for alarms in debugfs
> * Significantly rework driver initialization
> * Update commit message
> * Update documentation
>
> Changes in v2:
> * Cleanups and minor changes
>    - Remove stray #include
>    - Use DIV_ROUND_CLOSEST in F to C conversion
>    - Consolidate uses of mutex_lock()/mutex_unlock()
>    - Process sensors in forward order by type
> * Update commit message
> * Update documentation
>
> History:
> v2: https://lore.kernel.org/linux-hwmon/20230406152321.42010-1-james@equ=
iv.tech/
> v1: https://lore.kernel.org/linux-hwmon/20230403084859.26286-1-james@equ=
iv.tech/
> ---
>   Documentation/hwmon/hp-wmi-sensors.rst |  137 ++
>   Documentation/hwmon/index.rst          |    1 +
>   MAINTAINERS                            |    7 +
>   drivers/hwmon/Kconfig                  |   12 +
>   drivers/hwmon/Makefile                 |    1 +
>   drivers/hwmon/hp-wmi-sensors.c         | 1883 ++++++++++++++++++++++++
>   6 files changed, 2041 insertions(+)
>   create mode 100644 Documentation/hwmon/hp-wmi-sensors.rst
>   create mode 100644 drivers/hwmon/hp-wmi-sensors.c
>
> diff --git a/Documentation/hwmon/hp-wmi-sensors.rst b/Documentation/hwmo=
n/hp-wmi-sensors.rst
> new file mode 100644
> index 000000000000..bbc2aee95d72
> --- /dev/null
> +++ b/Documentation/hwmon/hp-wmi-sensors.rst
> @@ -0,0 +1,137 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +.. include:: <isonum.txt>
> +
> +Linux HP WMI Sensors Driver
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +
> +:Copyright: |copy| 2023 James Seo <james@equiv.tech>
> +
> +Description
> +-----------
> +
> +Hewlett-Packard (and some HP Compaq) business-class computers report ha=
rdware
> +monitoring information via Windows Management Instrumentation (WMI). Th=
is
> +driver exposes that information to the Linux ``hwmon`` subsystem, allow=
ing
> +userspace utilities like ``sensors`` to gather numeric sensor readings.
> +
> +``sysfs`` interface
> +-------------------
> +
> +When the driver is loaded, it discovers the sensors available on the cu=
rrent
> +system and creates the following ``sysfs`` attributes as necessary with=
in
> +``/sys/class/hwmon/hwmon[X]``:
> +
> +(``[X]`` is some number that depends on other system components.)
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Name			Perm	Description
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +curr[X]_input           RO      Current in milliamperes (mA).
> +curr[X]_label           RO      Current sensor label.
> +fan[X]_input            RO      Fan speed in RPM.
> +fan[X]_label            RO      Fan sensor label.
> +fan[X]_fault            RO      Fan sensor fault indicator.
> +fan[X]_alarm            RO      Fan sensor alarm indicator.
> +in[X]_input             RO      Voltage in millivolts (mV).
> +in[X]_label             RO      Voltage sensor label.
> +temp[X]_input           RO      Temperature in millidegrees Celsius
> +                                (m\ |deg|\ C).
> +temp[X]_label           RO      Temperature sensor label.
> +temp[X]_fault           RO      Temperature sensor fault indicator.
> +temp[X]_alarm           RO      Temperature sensor alarm indicator.
> +intrusion[X]_alarm      RW      Chassis intrusion alarm indicator.
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +``fault`` attributes
> +  Reading ``1`` instead of ``0`` as the ``fault`` attribute for a senso=
r
> +  indicates that it has encountered some issue during operation such th=
at
> +  measurements from it should not be trusted. If a sensor with the faul=
t
> +  condition later recovers, reading this attribute will return ``0`` ag=
ain.
> +
> +``alarm`` attributes
> +  Reading ``1`` instead of ``0`` as the ``alarm`` attribute for a senso=
r
> +  indicates that one of the following has occurred, depending on its ty=
pe:
> +
> +  - ``fan``: The fan has stalled or been disconnected while running.
> +  - ``temp``: The sensor reading has reached a critical threshold. The =
exact
> +    threshold is system-dependent.
> +  - ``intrusion``: The system's chassis has been opened.
> +
> +  After ``1`` is read from an ``alarm`` attribute, the attribute resets=
 itself
> +  and returns ``0`` on subsequent reads. As an exception, an
> +  ``intrusion[X]_alarm`` can only be manually reset by writing ``0`` to=
 it.
> +
> +``debugfs`` interface
> +---------------------
> +
> +.. warning:: The ``debugfs`` interface is only available when the kerne=
l is
> +             compiled with option ``CONFIG_DEBUG_FS``, and is subject t=
o
> +             change without notice at any time.
> +
> +The standard ``hwmon`` interface in ``sysfs`` exposes sensors of severa=
l
> +common types that are connected as of driver initialization. However, t=
here
> +are usually other sensors on the WMI side that do not meet these criter=
ia.
> +In addition, a number of system-dependent "platform events" used for ``=
alarm``
> +attributes may be present. A ``debugfs`` interface is therefore provide=
d for
> +read-only access to *all* HP WMI sensors and platform events on the sys=
tem.
> +
> +``/sys/kernel/debug/hp-wmi-sensors-[X]/sensor``
> +contains one numbered entry per sensor with the following attributes:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Name				Example
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +name                            ``CPU0 Fan``
> +description                     ``Reports CPU0 fan speed``
> +sensor_type                     ``12``
> +other_sensor_type               (an empty string)
> +operational_status              ``2``
> +current_state                   ``Normal``
> +possible_states                 ``Normal,Caution,Critical,Not Present``
> +base_units                      ``19``
> +unit_modifier                   ``0``
> +current_reading                 ``1008``
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +``/sys/kernel/debug/hp-wmi-sensors-[X]/platform_events``
> +contains one numbered entry per platform event with the following attri=
butes:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +Name				Example
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +name                            ``CPU0 Fan Stall``
> +description                     ``CPU0 Fan Speed``
> +source_namespace                ``root\wmi``
> +source_class                    ``HPBIOS_BIOSEvent``
> +category                        ``3``
> +possible_severity               ``25``
> +possible_status                 ``5``
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +
> +These represent the properties of the underlying ``HPBIOS_BIOSNumericSe=
nsor``
> +and ``HPBIOS_PlatformEvents`` WMI objects, which vary between systems. =
See
> +[#]_ for more details, including Managed Object Format (MOF) definition=
s.
> +
> +Known issues and limitations
> +----------------------------
> +
> +- If the existing ``hp-wmi`` driver for non-business-class HP systems i=
s
> +  already loaded, ``alarm`` attributes will be unavailable. This is bec=
ause
> +  the same WMI event GUID used by this driver for ``alarm`` attributes =
is
> +  used on those systems for e.g. laptop hotkeys.
> +- Dubious sensor hardware and inconsistent system WMI implementations h=
ave
> +  been observed to cause inaccurate readings and peculiar behavior, suc=
h as
> +  alarms failing to occur or occurring only once per boot.
> +- Only temperature, fan speed, and intrusion sensor types have been see=
n in
> +  the wild so far. Support for voltage and current sensors is therefore
> +  provisional.
> +- Although HP WMI sensors may claim to be of any type, any oddball sens=
or
> +  types unknown to hwmon will not be supported.
> +
> +References
> +----------
> +
> +.. [#] Hewlett-Packard Development Company, L.P.,
> +       "HP Client Management Interface Technical White Paper", 2005. [O=
nline].
> +       Available: https://h20331.www2.hp.com/hpsub/downloads/cmi_whitep=
aper.pdf
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.r=
st
> index f1fe75f596a5..f8f3c0bef6ed 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -77,6 +77,7 @@ Hardware Monitoring Kernel Drivers
>      gl518sm
>      gxp-fan-ctrl
>      hih6130
> +   hp-wmi-sensors
>      ibmaem
>      ibm-cffps
>      ibmpowernv
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c6545eb54104..237cbb40bd41 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9373,6 +9373,13 @@ L:	platform-driver-x86@vger.kernel.org
>   S:	Orphan
>   F:	drivers/platform/x86/hp/tc1100-wmi.c
>
> +HP WMI HARDWARE MONITOR DRIVER
> +M:	James Seo <james@equiv.tech>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/hwmon/hp-wmi-sensors.rst
> +F:	drivers/hwmon/hp-wmi-sensors.c
> +
>   HPET:	High Precision Event Timers driver
>   M:	Clemens Ladisch <clemens@ladisch.de>
>   S:	Maintained
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 5b3b76477b0e..e330f439f4a6 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -2399,6 +2399,18 @@ config SENSORS_ASUS_EC
>   	  This driver can also be built as a module. If so, the module
>   	  will be called asus_ec_sensors.
>
> +config SENSORS_HP_WMI
> +	tristate "HP WMI Sensors"
> +	depends on ACPI_WMI
> +	help
> +	  If you say yes here you get support for the ACPI hardware monitoring
> +	  interface found in HP (and some HP Compaq) business-class computers.
> +	  Available sensors vary between systems. Temperature and fan speed
> +	  sensors are the most common.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called hp_wmi_sensors.
> +
>   endif # ACPI
>
>   endif # HWMON
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 88712b5031c8..05cce16f37f6 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_SENSORS_ACPI_POWER) +=3D acpi_power_meter=
.o
>   obj-$(CONFIG_SENSORS_ATK0110)	+=3D asus_atk0110.o
>   obj-$(CONFIG_SENSORS_ASUS_EC)	+=3D asus-ec-sensors.o
>   obj-$(CONFIG_SENSORS_ASUS_WMI)	+=3D asus_wmi_sensors.o
> +obj-$(CONFIG_SENSORS_HP_WMI)	+=3D hp-wmi-sensors.o
>
>   # Native drivers
>   # asb100, then w83781d go first, as they can override other drivers' a=
ddresses.
> diff --git a/drivers/hwmon/hp-wmi-sensors.c b/drivers/hwmon/hp-wmi-senso=
rs.c
> new file mode 100644
> index 000000000000..f66d7599f802
> --- /dev/null
> +++ b/drivers/hwmon/hp-wmi-sensors.c
> @@ -0,0 +1,1883 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * hwmon driver for HP (and some HP Compaq) business-class computers th=
at
> + * report numeric sensor data via Windows Management Instrumentation (W=
MI).
> + *
> + * Copyright (C) 2023 James Seo <james@equiv.tech>
> + *
> + * References:
> + * [1] Hewlett-Packard Development Company, L.P.,
> + *     "HP Client Management Interface Technical White Paper", 2005. [O=
nline].
> + *     Available: https://h20331.www2.hp.com/hpsub/downloads/cmi_whitep=
aper.pdf
> + * [2] Hewlett-Packard Development Company, L.P.,
> + *     "HP Retail Manageability", 2012. [Online].
> + *     Available: http://h10032.www1.hp.com/ctg/Manual/c03291135.pdf
> + * [3] Linux Hardware Project, A. Ponomarenko et al.,
> + *     "linuxhw/ACPI - Collect ACPI table dumps", 2018. [Online].
> + *     Available: https://github.com/linuxhw/ACPI/
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/debugfs.h>
> +#include <linux/hwmon.h>
> +#include <linux/jiffies.h>
> +#include <linux/mutex.h>
> +#include <linux/units.h>
> +#include <linux/wmi.h>
> +
> +#define HP_WMI_EVENT_GUID		 "95F24279-4D7B-4334-9387-ACCDC67EF61C"
> +#define HP_WMI_NUMERIC_SENSOR_GUID	 "8F1F6435-9F42-42C8-BADC-0E9424F20C=
9A"
> +#define HP_WMI_PLATFORM_EVENTS_GUID	 "41227C2D-80E1-423F-8B8E-87E32755A=
0EB"
> +#define HP_WMI_PLATFORM_EVENTS_CLASS	 "HPBIOS_BIOSEvent"
> +#define HP_WMI_PLATFORM_EVENTS_NAMESPACE "root\\WMI"
> +
> +/* Patterns for recognizing sensors and matching events to channels. */
> +
> +#define HP_WMI_PATTERN_SYS_TEMP2	 "System Ambient Temperature"
> +#define HP_WMI_PATTERN_SYS_TEMP		 "Chassis Thermal Index"
> +#define HP_WMI_PATTERN_CPU_TEMP		 "CPU Thermal Index"
> +#define HP_WMI_PATTERN_CPU_TEMP2	 "CPU Temperature"
> +#define HP_WMI_PATTERN_TEMP_SENSOR	 "Thermal Index"
> +#define HP_WMI_PATTERN_TEMP_ALARM	 "Thermal Critical"
> +#define HP_WMI_PATTERN_INTRUSION_ALARM	 "Hood Intrusion"
> +#define HP_WMI_PATTERN_FAN_ALARM	 "Stall"
> +#define HP_WMI_PATTERN_TEMP		 "Temperature"
> +#define HP_WMI_PATTERN_CPU		 "CPU"
> +
> +/* These limits are arbitrary. The WMI implementation may vary by syste=
m. */
> +
> +#define HP_WMI_MAX_STR_SIZE		 128U
> +#define HP_WMI_MAX_PROPERTIES		 32U
> +#define HP_WMI_MAX_INSTANCES		 32U
> +
> +enum hp_wmi_type {
> +	HP_WMI_TYPE_OTHER			   =3D 1,
> +	HP_WMI_TYPE_TEMPERATURE			   =3D 2,
> +	HP_WMI_TYPE_VOLTAGE			   =3D 3,
> +	HP_WMI_TYPE_CURRENT			   =3D 4,
> +	HP_WMI_TYPE_AIR_FLOW			   =3D 12,
> +	HP_WMI_TYPE_INTRUSION			   =3D 0xabadb01, /* Custom. */
> +};
> +
> +enum hp_wmi_category {
> +	HP_WMI_CATEGORY_SENSOR			   =3D 3,
> +};
> +
> +enum hp_wmi_severity {
> +	HP_WMI_SEVERITY_UNKNOWN			   =3D 0,
> +	HP_WMI_SEVERITY_OK			   =3D 5,
> +	HP_WMI_SEVERITY_DEGRADED_WARNING	   =3D 10,
> +	HP_WMI_SEVERITY_MINOR_FAILURE		   =3D 15,
> +	HP_WMI_SEVERITY_MAJOR_FAILURE		   =3D 20,
> +	HP_WMI_SEVERITY_CRITICAL_FAILURE	   =3D 25,
> +	HP_WMI_SEVERITY_NON_RECOVERABLE_ERROR	   =3D 30,
> +};
> +
> +enum hp_wmi_status {
> +	HP_WMI_STATUS_OK			   =3D 2,
> +	HP_WMI_STATUS_DEGRADED			   =3D 3,
> +	HP_WMI_STATUS_STRESSED			   =3D 4,
> +	HP_WMI_STATUS_PREDICTIVE_FAILURE	   =3D 5,
> +	HP_WMI_STATUS_ERROR			   =3D 6,
> +	HP_WMI_STATUS_NON_RECOVERABLE_ERROR	   =3D 7,
> +	HP_WMI_STATUS_NO_CONTACT		   =3D 12,
> +	HP_WMI_STATUS_LOST_COMMUNICATION	   =3D 13,
> +	HP_WMI_STATUS_ABORTED			   =3D 14,
> +	HP_WMI_STATUS_SUPPORTING_ENTITY_IN_ERROR   =3D 16,
> +
> +	/* Occurs combined with one of "OK", "Degraded", and "Error" [1]. */
> +	HP_WMI_STATUS_COMPLETED			   =3D 17,
> +};
> +
> +enum hp_wmi_units {
> +	HP_WMI_UNITS_OTHER			   =3D 1,
> +	HP_WMI_UNITS_DEGREES_C			   =3D 2,
> +	HP_WMI_UNITS_DEGREES_F			   =3D 3,
> +	HP_WMI_UNITS_DEGREES_K			   =3D 4,
> +	HP_WMI_UNITS_VOLTS			   =3D 5,
> +	HP_WMI_UNITS_AMPS			   =3D 6,
> +	HP_WMI_UNITS_RPM			   =3D 19,
> +};
> +
> +enum hp_wmi_property {
> +	HP_WMI_PROPERTY_NAME			   =3D 0,
> +	HP_WMI_PROPERTY_DESCRIPTION		   =3D 1,
> +	HP_WMI_PROPERTY_SENSOR_TYPE		   =3D 2,
> +	HP_WMI_PROPERTY_OTHER_SENSOR_TYPE	   =3D 3,
> +	HP_WMI_PROPERTY_OPERATIONAL_STATUS	   =3D 4,
> +	HP_WMI_PROPERTY_CURRENT_STATE		   =3D 5,
> +	HP_WMI_PROPERTY_POSSIBLE_STATES		   =3D 6,
> +	HP_WMI_PROPERTY_BASE_UNITS		   =3D 7,
> +	HP_WMI_PROPERTY_UNIT_MODIFIER		   =3D 8,
> +	HP_WMI_PROPERTY_CURRENT_READING		   =3D 9,
> +};
> +
> +static const acpi_object_type hp_wmi_property_map[] =3D {
> +	[HP_WMI_PROPERTY_NAME]			   =3D ACPI_TYPE_STRING,
> +	[HP_WMI_PROPERTY_DESCRIPTION]		   =3D ACPI_TYPE_STRING,
> +	[HP_WMI_PROPERTY_SENSOR_TYPE]		   =3D ACPI_TYPE_INTEGER,
> +	[HP_WMI_PROPERTY_OTHER_SENSOR_TYPE]	   =3D ACPI_TYPE_STRING,
> +	[HP_WMI_PROPERTY_OPERATIONAL_STATUS]	   =3D ACPI_TYPE_INTEGER,
> +	[HP_WMI_PROPERTY_CURRENT_STATE]		   =3D ACPI_TYPE_STRING,
> +	[HP_WMI_PROPERTY_POSSIBLE_STATES]	   =3D ACPI_TYPE_STRING,
> +	[HP_WMI_PROPERTY_BASE_UNITS]		   =3D ACPI_TYPE_INTEGER,
> +	[HP_WMI_PROPERTY_UNIT_MODIFIER]		   =3D ACPI_TYPE_INTEGER,
> +	[HP_WMI_PROPERTY_CURRENT_READING]	   =3D ACPI_TYPE_INTEGER,
> +};
> +
> +enum hp_wmi_platform_events_property {
> +	HP_WMI_PLATFORM_EVENTS_PROPERTY_NAME		    =3D 0,
> +	HP_WMI_PLATFORM_EVENTS_PROPERTY_DESCRIPTION	    =3D 1,
> +	HP_WMI_PLATFORM_EVENTS_PROPERTY_SOURCE_NAMESPACE    =3D 2,
> +	HP_WMI_PLATFORM_EVENTS_PROPERTY_SOURCE_CLASS	    =3D 3,
> +	HP_WMI_PLATFORM_EVENTS_PROPERTY_CATEGORY	    =3D 4,
> +	HP_WMI_PLATFORM_EVENTS_PROPERTY_POSSIBLE_SEVERITY   =3D 5,
> +	HP_WMI_PLATFORM_EVENTS_PROPERTY_POSSIBLE_STATUS	    =3D 6,
> +};
> +
> +static const acpi_object_type hp_wmi_platform_events_property_map[] =3D=
 {
> +	[HP_WMI_PLATFORM_EVENTS_PROPERTY_NAME]		    =3D ACPI_TYPE_STRING,
> +	[HP_WMI_PLATFORM_EVENTS_PROPERTY_DESCRIPTION]	    =3D ACPI_TYPE_STRING=
,
> +	[HP_WMI_PLATFORM_EVENTS_PROPERTY_SOURCE_NAMESPACE]  =3D ACPI_TYPE_STRI=
NG,
> +	[HP_WMI_PLATFORM_EVENTS_PROPERTY_SOURCE_CLASS]	    =3D ACPI_TYPE_STRIN=
G,
> +	[HP_WMI_PLATFORM_EVENTS_PROPERTY_CATEGORY]	    =3D ACPI_TYPE_INTEGER,
> +	[HP_WMI_PLATFORM_EVENTS_PROPERTY_POSSIBLE_SEVERITY] =3D ACPI_TYPE_INTE=
GER,
> +	[HP_WMI_PLATFORM_EVENTS_PROPERTY_POSSIBLE_STATUS]   =3D ACPI_TYPE_INTE=
GER,
> +};
> +
> +enum hp_wmi_event_property {
> +	HP_WMI_EVENT_PROPERTY_NAME		   =3D 0,
> +	HP_WMI_EVENT_PROPERTY_DESCRIPTION	   =3D 1,
> +	HP_WMI_EVENT_PROPERTY_CATEGORY		   =3D 2,
> +	HP_WMI_EVENT_PROPERTY_SEVERITY		   =3D 3,
> +	HP_WMI_EVENT_PROPERTY_STATUS		   =3D 4,
> +};
> +
> +static const acpi_object_type hp_wmi_event_property_map[] =3D {
> +	[HP_WMI_EVENT_PROPERTY_NAME]		   =3D ACPI_TYPE_STRING,
> +	[HP_WMI_EVENT_PROPERTY_DESCRIPTION]	   =3D ACPI_TYPE_STRING,
> +	[HP_WMI_EVENT_PROPERTY_CATEGORY]	   =3D ACPI_TYPE_INTEGER,
> +	[HP_WMI_EVENT_PROPERTY_SEVERITY]	   =3D ACPI_TYPE_INTEGER,
> +	[HP_WMI_EVENT_PROPERTY_STATUS]		   =3D ACPI_TYPE_INTEGER,
> +};
> +
> +static const enum hwmon_sensor_types hp_wmi_hwmon_type_map[] =3D {
> +	[HP_WMI_TYPE_TEMPERATURE]		   =3D hwmon_temp,
> +	[HP_WMI_TYPE_VOLTAGE]			   =3D hwmon_in,
> +	[HP_WMI_TYPE_CURRENT]			   =3D hwmon_curr,
> +	[HP_WMI_TYPE_AIR_FLOW]			   =3D hwmon_fan,
> +};
> +
> +static const u32 hp_wmi_hwmon_attributes[hwmon_max] =3D {
> +	[hwmon_chip]	  =3D HWMON_C_REGISTER_TZ,
> +	[hwmon_temp]	  =3D HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_FAULT,
> +	[hwmon_in]	  =3D HWMON_I_INPUT | HWMON_I_LABEL,
> +	[hwmon_curr]	  =3D HWMON_C_INPUT | HWMON_C_LABEL,
> +	[hwmon_fan]	  =3D HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_FAULT,
> +	[hwmon_intrusion] =3D HWMON_INTRUSION_ALARM,
> +};
> +
> +/*
> + * struct hp_wmi_numeric_sensor - a HPBIOS_BIOSNumericSensor instance
> + *
> + * MOF definition [1]:
> + *
> + *   #pragma namespace("\\\\.\\root\\HP\\InstrumentedBIOS");
> + *
> + *   [abstract]
> + *   class HP_BIOSSensor
> + *   {
> + *     [read] string Name;
> + *     [read] string Description;
> + *     [read, ValueMap {"0","1","2","3","4","5","6","7","8","9",
> + *      "10","11","12"}, Values {"Unknown","Other","Temperature",
> + *      "Voltage","Current","Tachometer","Counter","Switch","Lock",
> + *      "Humidity","Smoke Detection","Presence","Air Flow"}]
> + *     uint32 SensorType;
> + *     [read] string OtherSensorType;
> + *     [read, ValueMap {"0","1","2","3","4","5","6","7","8","9",
> + *      "10","11","12","13","14","15","16","17","18","..",
> + *      "0x8000.."}, Values {"Unknown","Other","OK","Degraded",
> + *      "Stressed","Predictive Failure","Error",
> + *      "Non-Recoverable Error","Starting","Stopping","Stopped",
> + *      "In Service","No Contact","Lost Communication","Aborted",
> + *      "Dormant","Supporting Entity in Error","Completed",
> + *      "Power Mode","DMTF Reserved","Vendor Reserved"}]
> + *     uint32 OperationalStatus;
> + *     [read] string CurrentState;
> + *     [read] string PossibleStates[];
> + *   };
> + *
> + *   class HP_BIOSNumericSensor : HP_BIOSSensor
> + *   {
> + *     [read, ValueMap {"0","1","2","3","4","5","6","7","8","9",
> + *      "10","11","12","13","14","15","16","17","18","19","20",
> + *      "21","22","23","24","25","26","27","28","29","30","31",
> + *      "32","33","34","35","36","37","38","39","40","41","42",
> + *      "43","44","45","46","47","48","49","50","51","52","53",
> + *      "54","55","56","57","58","59","60","61","62","63","64",
> + *      "65"}, Values {"Unknown","Other","Degrees C","Degrees F",
> + *      "Degrees K","Volts","Amps","Watts","Joules","Coulombs",
> + *      "VA","Nits","Lumens","Lux","Candelas","kPa","PSI",
> + *      "Newtons","CFM","RPM","Hertz","Seconds","Minutes",
> + *      "Hours","Days","Weeks","Mils","Inches","Feet",
> + *      "Cubic Inches","Cubic Feet","Meters","Cubic Centimeters",
> + *      "Cubic Meters","Liters","Fluid Ounces","Radians",
> + *      "Steradians","Revolutions","Cycles","Gravities","Ounces",
> + *      "Pounds","Foot-Pounds","Ounce-Inches","Gauss","Gilberts",
> + *      "Henries","Farads","Ohms","Siemens","Moles","Becquerels",
> + *      "PPM (parts/million)","Decibels","DbA","DbC","Grays",
> + *      "Sieverts","Color Temperature Degrees K","Bits","Bytes",
> + *      "Words (data)","DoubleWords","QuadWords","Percentage"}]
> + *     uint32 BaseUnits;
> + *     [read] sint32 UnitModifier;
> + *     [read] uint32 CurrentReading;
> + *   };
> + *
> + *   class HPBIOS_BIOSNumericSensor : HP_BIOSNumericSensor
> + *   {
> + *   };
> + */
> +struct hp_wmi_numeric_sensor {
> +	const char *name;
> +	const char *description;
> +	u32 sensor_type;
> +	const char *other_sensor_type; /* Explains "Other" SensorType. */
> +	u32 operational_status;
> +	const char *current_state;
> +	const char **possible_states;  /* Count may vary. */
> +	u32 base_units;
> +	s32 unit_modifier;
> +	u32 current_reading;
> +
> +	u8 possible_states_count;
> +};
> +
> +/*
> + * struct hp_wmi_platform_events - a HPBIOS_PlatformEvents instance
> + *
> + * Instances of this object reveal the set of possible HPBIOS_BIOSEvent
> + * instances for the current system, but it may not always be present.
> + *
> + * MOF definition:
> + *
> + *   #pragma namespace("\\\\.\\root\\HP\\InstrumentedBIOS");
> + *
> + *   [abstract]
> + *   class HP_PlatformEvents
> + *   {
> + *     [read] string Name;
> + *     [read] string Description;
> + *     [read] string SourceNamespace;
> + *     [read] string SourceClass;
> + *     [read, ValueMap {"0","1","2","3","4",".."}, Values {
> + *      "Unknown","Configuration Change","Button Pressed",
> + *      "Sensor","BIOS Settings","Reserved"}]
> + *     uint32 Category;
> + *     [read, ValueMap{"0","5","10","15","20","25","30",".."},
> + *      Values{"Unknown","OK","Degraded/Warning","Minor Failure",
> + *      "Major Failure","Critical Failure","Non-recoverable Error",
> + *      "DMTF Reserved"}]
> + *     uint32 PossibleSeverity;
> + *     [read, ValueMap {"0","1","2","3","4","5","6","7","8","9",
> + *      "10","11","12","13","14","15","16","17","18","..",
> + *      "0x8000.."}, Values {"Unknown","Other","OK","Degraded",
> + *      "Stressed","Predictive Failure","Error",
> + *      "Non-Recoverable Error","Starting","Stopping","Stopped",
> + *      "In Service","No Contact","Lost Communication","Aborted",
> + *      "Dormant","Supporting Entity in Error","Completed",
> + *      "Power Mode","DMTF Reserved","Vendor Reserved"}]
> + *     uint32 PossibleStatus;
> + *   };
> + *
> + *   class HPBIOS_PlatformEvents : HP_PlatformEvents
> + *   {
> + *   };
> + */
> +struct hp_wmi_platform_events {
> +	const char *name;
> +	const char *description;
> +	const char *source_namespace;
> +	const char *source_class;
> +	u32 category;
> +	u32 possible_severity;
> +	u32 possible_status;
> +};
> +
> +/*
> + * struct hp_wmi_event - a HPBIOS_BIOSEvent instance
> + *
> + * MOF definition [1] (corrected below from original):
> + *
> + *   #pragma namespace("\\\\.\\root\\WMI");
> + *
> + *   class HP_BIOSEvent : WMIEvent
> + *   {
> + *     [read] string Name;
> + *     [read] string Description;
> + *     [read ValueMap {"0","1","2","3","4"}, Values {"Unknown",
> + *      "Configuration Change","Button Pressed","Sensor",
> + *      "BIOS Settings"}]
> + *     uint32 Category;
> + *     [read, ValueMap {"0","5","10","15","20","25","30"},
> + *      Values {"Unknown","OK","Degraded/Warning",
> + *      "Minor Failure","Major Failure","Critical Failure",
> + *      "Non-recoverable Error"}]
> + *     uint32 Severity;
> + *     [read, ValueMap {"0","1","2","3","4","5","6","7","8",
> + *      "9","10","11","12","13","14","15","16","17","18","..",
> + *      "0x8000.."}, Values {"Unknown","Other","OK","Degraded",
> + *      "Stressed","Predictive Failure","Error",
> + *      "Non-Recoverable Error","Starting","Stopping","Stopped",
> + *      "In Service","No Contact","Lost Communication","Aborted",
> + *      "Dormant","Supporting Entity in Error","Completed",
> + *      "Power Mode","DMTF Reserved","Vendor Reserved"}]
> + *     uint32 Status;
> + *   };
> + *
> + *   class HPBIOS_BIOSEvent : HP_BIOSEvent
> + *   {
> + *   };
> + */
> +struct hp_wmi_event {
> +	const char *name;
> +	const char *description;
> +	u32 category;
> +};
> +
> +/*
> + * struct hp_wmi_info - sensor info
> + * @nsensor: numeric sensor properties
> + * @instance: its WMI instance number
> + * @is_active: whether the following fields are valid
> + * @has_alarm: whether sensor has an alarm flag
> + * @alarm: alarm flag
> + * @type: its hwmon sensor type
> + * @cached_val: current sensor reading value, scaled for hwmon
> + * @last_updated: when these readings were last updated
> + */
> +struct hp_wmi_info {
> +	struct hp_wmi_numeric_sensor nsensor;
> +	u8 instance;
> +
> +	bool is_active;
> +	bool has_alarm;
> +	bool alarm;
> +	enum hwmon_sensor_types type;
> +	long cached_val;
> +	unsigned long last_updated; /* in jiffies */
> +
> +};
> +
> +/*
> + * struct hp_wmi_sensors - driver state
> + * @wdev: pointer to the parent WMI device
> + * @pevents: platform events structs for all platform events visible in=
 WMI
> + * @info: sensor info structs for all sensors visible in WMI
> + * @info_map: access info structs by hwmon type and channel number
> + * @count: count of all sensors visible in WMI
> + * @channel_count: count of hwmon channels by hwmon type
> + * @pevents_count: count of all platform events visible in WMI
> + * @has_intrusion: whether an intrusion sensor is present
> + * @intrusion: intrusion flag
> + * @lock: mutex to lock polling WMI and changes to driver state
> + */
> +struct hp_wmi_sensors {
> +	struct wmi_device *wdev;
> +	struct hp_wmi_info info[HP_WMI_MAX_INSTANCES];
> +	struct hp_wmi_info **info_map[hwmon_max];
> +	struct hp_wmi_platform_events pevents[HP_WMI_MAX_INSTANCES];
> +	u8 count;
> +	u8 channel_count[hwmon_max];
> +	u8 pevents_count;
> +	bool has_intrusion;
> +	bool intrusion;
> +
> +	struct mutex lock; /* lock polling WMI, driver state changes */
> +};
> +
> +/* hp_wmi_strdup - devm_kstrdup, but length-limited */
> +static char *hp_wmi_strdup(struct device *dev, const char *src)
> +{
> +	char *dst;
> +	size_t len;
> +
> +	len =3D strnlen(src, HP_WMI_MAX_STR_SIZE - 1);
> +
> +	dst =3D devm_kmalloc(dev, (len + 1) * sizeof(*dst), GFP_KERNEL);
> +	if (!dst)
> +		return NULL;
> +
> +	strscpy(dst, src, len + 1);
> +
> +	return dst;
> +}
> +
> +/*
> + * hp_wmi_get_wobj - poll WMI for a WMI object instance
> + * @guid: WMI object GUID
> + * @instance: WMI object instance number
> + *
> + * Returns a new WMI object instance on success, or NULL on error.
> + * Caller must kfree the result.
> + */
> +static union acpi_object *hp_wmi_get_wobj(const char *guid, u8 instance=
)
> +{
> +	struct acpi_buffer out =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +	acpi_status err;
> +
> +	err =3D wmi_query_block(guid, instance, &out);
> +	if (ACPI_FAILURE(err))
> +		return NULL;
> +
> +	return out.pointer;
> +}
> +
> +static int check_wobj(const union acpi_object *wobj,
> +		      const acpi_object_type property_map[], int last_prop)
> +{
> +	acpi_object_type type =3D wobj->type;
> +	acpi_object_type valid_type;
> +	union acpi_object *elements;
> +	u32 elem_count;
> +	int prop;
> +
> +	if (type !=3D ACPI_TYPE_PACKAGE)
> +		return -EINVAL;
> +
> +	elem_count =3D wobj->package.count;
> +	if (elem_count !=3D last_prop + 1)
> +		return -EINVAL;
> +
> +	elements =3D wobj->package.elements;
> +	for (prop =3D 0; prop <=3D last_prop; prop++) {
> +		type =3D elements[prop].type;
> +		valid_type =3D property_map[prop];
> +		if (type !=3D valid_type)
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int extract_acpi_value(struct device *dev, union acpi_object *el=
ement,
> +			      acpi_object_type type, u32 *value, char **string)
> +{
> +	switch (type) {
> +	case ACPI_TYPE_INTEGER:
> +		*value =3D element->integer.value;
> +		break;
> +
> +	case ACPI_TYPE_STRING:
> +		*string =3D hp_wmi_strdup(dev, strim(element->string.pointer));
> +		if (!*string)
> +			return -ENOMEM;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * check_numeric_sensor_wobj - validate a HPBIOS_BIOSNumericSensor inst=
ance
> + * @wobj: pointer to WMI object instance to check
> + * @possible_states_count: out pointer to count of possible states
> + *
> + * Returns 0 on success, or a negative error code on error.
> + */
> +static int check_numeric_sensor_wobj(const union acpi_object *wobj,
> +				     u8 *possible_states_count)
> +{
> +	acpi_object_type type =3D wobj->type;
> +	int prop =3D HP_WMI_PROPERTY_NAME;
> +	acpi_object_type valid_type;
> +	union acpi_object *elements;
> +	u32 elem_count;
> +	u8 count =3D 0;
> +	u32 i;
> +
> +	if (type !=3D ACPI_TYPE_PACKAGE)
> +		return -EINVAL;
> +
> +	elem_count =3D wobj->package.count;
> +	if (elem_count > HP_WMI_MAX_PROPERTIES)
> +		return -EINVAL;
> +
> +	elements =3D wobj->package.elements;
> +	for (i =3D 0; i < elem_count; i++, prop++) {
> +		if (prop > HP_WMI_PROPERTY_CURRENT_READING)
> +			return -EINVAL;
> +
> +		type =3D elements[i].type;
> +		valid_type =3D hp_wmi_property_map[prop];
> +		if (type !=3D valid_type)
> +			return -EINVAL;
> +
> +		/*
> +		 * elements is a variable-length array of ACPI objects, one for
> +		 * each property of the WMI object instance, except that the
> +		 * strs in PossibleStates[] are flattened into this array, and
> +		 * their count is found in the WMI BMOF. We don't decode the
> +		 * BMOF, so find the count by finding the next int.
> +		 */
> +
> +		if (prop =3D=3D HP_WMI_PROPERTY_CURRENT_STATE) {
> +			prop =3D HP_WMI_PROPERTY_POSSIBLE_STATES;
> +			valid_type =3D hp_wmi_property_map[prop];
> +			for (; i + 1 < elem_count; i++, count++) {
> +				type =3D elements[i + 1].type;
> +				if (type !=3D valid_type)
> +					break;
> +			}
> +		}
> +	}
> +
> +	if (!count || prop <=3D HP_WMI_PROPERTY_CURRENT_READING)
> +		return -EINVAL;
> +
> +	*possible_states_count =3D count;
> +
> +	return 0;
> +}
> +
> +static int
> +numeric_sensor_is_connected(const struct hp_wmi_numeric_sensor *nsensor=
)
> +{
> +	u32 operational_status =3D nsensor->operational_status;
> +
> +	return operational_status !=3D HP_WMI_STATUS_NO_CONTACT;
> +}
> +
> +static int numeric_sensor_has_fault(const struct hp_wmi_numeric_sensor =
*nsensor)
> +{
> +	u32 operational_status =3D nsensor->operational_status;
> +
> +	switch (operational_status) {
> +	case HP_WMI_STATUS_DEGRADED:
> +	case HP_WMI_STATUS_STRESSED:		/* e.g. Overload, overtemp. */
> +	case HP_WMI_STATUS_PREDICTIVE_FAILURE:	/* e.g. Fan removed. */
> +	case HP_WMI_STATUS_ERROR:
> +	case HP_WMI_STATUS_NON_RECOVERABLE_ERROR:
> +	case HP_WMI_STATUS_NO_CONTACT:
> +	case HP_WMI_STATUS_LOST_COMMUNICATION:
> +	case HP_WMI_STATUS_ABORTED:
> +	case HP_WMI_STATUS_SUPPORTING_ENTITY_IN_ERROR:
> +
> +	/* Assume combination by addition; bitwise OR doesn't make sense. */
> +	case HP_WMI_STATUS_COMPLETED + HP_WMI_STATUS_DEGRADED:
> +	case HP_WMI_STATUS_COMPLETED + HP_WMI_STATUS_ERROR:
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +/* scale_numeric_sensor - scale sensor reading for hwmon */
> +static long scale_numeric_sensor(const struct hp_wmi_numeric_sensor *ns=
ensor)
> +{
> +	u32 current_reading =3D nsensor->current_reading;
> +	s32 unit_modifier =3D nsensor->unit_modifier;
> +	u32 sensor_type =3D nsensor->sensor_type;
> +	u32 base_units =3D nsensor->base_units;
> +	s32 target_modifier;
> +	long val;
> +
> +	/* Fan readings are in RPM units; others are in milliunits. */
> +	target_modifier =3D sensor_type =3D=3D HP_WMI_TYPE_AIR_FLOW ? 0 : -3;
> +
> +	val =3D current_reading;
> +
> +	for (; unit_modifier < target_modifier; unit_modifier++)
> +		val =3D DIV_ROUND_CLOSEST(val, 10);
> +
> +	for (; unit_modifier > target_modifier; unit_modifier--) {
> +		if (val > LONG_MAX / 10) {
> +			val =3D LONG_MAX;
> +			break;
> +		}
> +		val *=3D 10;
> +	}
> +
> +	if (sensor_type =3D=3D HP_WMI_TYPE_TEMPERATURE) {
> +		switch (base_units) {
> +		case HP_WMI_UNITS_DEGREES_F:
> +			val -=3D MILLI * 32;
> +			val =3D val <=3D LONG_MAX / 5 ?
> +				      DIV_ROUND_CLOSEST(val * 5, 9) :
> +				      DIV_ROUND_CLOSEST(val, 9) * 5;
> +			break;
> +
> +		case HP_WMI_UNITS_DEGREES_K:
> +			val =3D milli_kelvin_to_millicelsius(val);
> +			break;
> +		}
> +	}
> +
> +	return val;
> +}
> +
> +/*
> + * classify_numeric_sensor - classify a numeric sensor
> + * @nsensor: pointer to numeric sensor struct
> + *
> + * Returns an enum hp_wmi_type value on success,
> + * or a negative value if the sensor type is unsupported.
> + */
> +static int classify_numeric_sensor(const struct hp_wmi_numeric_sensor *=
nsensor)
> +{
> +	u32 sensor_type =3D nsensor->sensor_type;
> +	u32 base_units =3D nsensor->base_units;
> +	const char *name =3D nsensor->name;
> +
> +	switch (sensor_type) {
> +	case HP_WMI_TYPE_TEMPERATURE:
> +		/*
> +		 * Some systems have sensors named "X Thermal Index" in "Other"
> +		 * units. Tested CPU sensor examples were found to be in =C2=B0C,
> +		 * albeit perhaps "differently" accurate; e.g. readings were
> +		 * reliably -6=C2=B0C vs. coretemp on a HP Compaq Elite 8300, and
> +		 * +8=C2=B0C on an EliteOne G1 800. But this is still within the
> +		 * realm of plausibility for cheaply implemented motherboard
> +		 * sensors, and chassis readings were about as expected.
> +		 */
> +		if ((base_units =3D=3D HP_WMI_UNITS_OTHER &&
> +		     strstr(name, HP_WMI_PATTERN_TEMP_SENSOR)) ||
> +		    base_units =3D=3D HP_WMI_UNITS_DEGREES_C ||
> +		    base_units =3D=3D HP_WMI_UNITS_DEGREES_F ||
> +		    base_units =3D=3D HP_WMI_UNITS_DEGREES_K)
> +			return HP_WMI_TYPE_TEMPERATURE;
> +		break;
> +
> +	case HP_WMI_TYPE_VOLTAGE:
> +		if (base_units =3D=3D HP_WMI_UNITS_VOLTS)
> +			return HP_WMI_TYPE_VOLTAGE;
> +		break;
> +
> +	case HP_WMI_TYPE_CURRENT:
> +		if (base_units =3D=3D HP_WMI_UNITS_AMPS)
> +			return HP_WMI_TYPE_CURRENT;
> +		break;
> +
> +	case HP_WMI_TYPE_AIR_FLOW:
> +		/*
> +		 * Strangely, HP considers fan RPM sensor type to be
> +		 * "Air Flow" instead of the more intuitive "Tachometer".
> +		 */
> +		if (base_units =3D=3D HP_WMI_UNITS_RPM)
> +			return HP_WMI_TYPE_AIR_FLOW;
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int
> +populate_numeric_sensor_from_wobj(struct device *dev,
> +				  struct hp_wmi_numeric_sensor *nsensor,
> +				  union acpi_object *wobj)
> +{
> +	const char **possible_states;
> +	union acpi_object *element;
> +	u8 possible_states_count;
> +	acpi_object_type type;
> +	char *string;
> +	u32 value;
> +	int prop;
> +	int err;
> +
> +	err =3D check_numeric_sensor_wobj(wobj, &possible_states_count);
> +	if (err)
> +		return err;
> +
> +	possible_states =3D devm_kcalloc(dev, possible_states_count,
> +				       sizeof(*possible_states),
> +				       GFP_KERNEL);
> +	if (!possible_states)
> +		return -ENOMEM;
> +
> +	element =3D wobj->package.elements;
> +	nsensor->possible_states =3D possible_states;
> +	nsensor->possible_states_count =3D possible_states_count;
> +
> +	for (prop =3D 0; prop <=3D HP_WMI_PROPERTY_CURRENT_READING; prop++) {
> +		type =3D hp_wmi_property_map[prop];
> +
> +		err =3D extract_acpi_value(dev, element, type, &value, &string);
> +		if (err)
> +			return err;
> +
> +		element++;
> +
> +		switch (prop) {
> +		case HP_WMI_PROPERTY_NAME:
> +			nsensor->name =3D string;
> +			break;
> +
> +		case HP_WMI_PROPERTY_DESCRIPTION:
> +			nsensor->description =3D string;
> +			break;
> +
> +		case HP_WMI_PROPERTY_SENSOR_TYPE:
> +			if (value > HP_WMI_TYPE_AIR_FLOW)
> +				return -EINVAL;
> +
> +			nsensor->sensor_type =3D value;
> +			break;
> +
> +		case HP_WMI_PROPERTY_OTHER_SENSOR_TYPE:
> +			nsensor->other_sensor_type =3D string;
> +			break;
> +
> +		case HP_WMI_PROPERTY_OPERATIONAL_STATUS:
> +			nsensor->operational_status =3D value;
> +			break;
> +
> +		case HP_WMI_PROPERTY_CURRENT_STATE:
> +			nsensor->current_state =3D string;
> +			break;
> +
> +		case HP_WMI_PROPERTY_POSSIBLE_STATES:
> +			*possible_states++ =3D string;
> +			if (--possible_states_count)
> +				prop--;
> +			break;
> +
> +		case HP_WMI_PROPERTY_BASE_UNITS:
> +			nsensor->base_units =3D value;
> +			break;
> +
> +		case HP_WMI_PROPERTY_UNIT_MODIFIER:
> +			/* UnitModifier is signed. */
> +			nsensor->unit_modifier =3D (s32)value;
> +			break;
> +
> +		case HP_WMI_PROPERTY_CURRENT_READING:
> +			nsensor->current_reading =3D value;
> +			break;
> +
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/* update_numeric_sensor_from_wobj - update fungible sensor properties =
*/
> +static void
> +update_numeric_sensor_from_wobj(struct device *dev,
> +				struct hp_wmi_numeric_sensor *nsensor,
> +				const union acpi_object *wobj)
> +{
> +	const union acpi_object *elements;
> +	const union acpi_object *element;
> +	const char *string;
> +	u8 offset;
> +
> +	elements =3D wobj->package.elements;
> +
> +	element =3D &elements[HP_WMI_PROPERTY_OPERATIONAL_STATUS];
> +	nsensor->operational_status =3D element->integer.value;
> +
> +	element =3D &elements[HP_WMI_PROPERTY_CURRENT_STATE];
> +	string =3D strim(element->string.pointer);
> +
> +	if (strcmp(string, nsensor->current_state)) {
> +		devm_kfree(dev, nsensor->current_state);
> +		nsensor->current_state =3D hp_wmi_strdup(dev, string);
> +	}
> +
> +	/* Offset reads into the elements array after PossibleStates[0]. */
> +	offset =3D nsensor->possible_states_count - 1;
> +
> +	element =3D &elements[HP_WMI_PROPERTY_UNIT_MODIFIER + offset];
> +	nsensor->unit_modifier =3D (s32)element->integer.value;
> +
> +	element =3D &elements[HP_WMI_PROPERTY_CURRENT_READING + offset];
> +	nsensor->current_reading =3D element->integer.value;
> +}
> +
> +/*
> + * check_platform_events_wobj - validate a HPBIOS_PlatformEvents instan=
ce
> + * @wobj: pointer to WMI object instance to check
> + *
> + * Returns 0 on success, or a negative error code on error.
> + */
> +static int check_platform_events_wobj(const union acpi_object *wobj)
> +{
> +	return check_wobj(wobj, hp_wmi_platform_events_property_map,
> +			  HP_WMI_PLATFORM_EVENTS_PROPERTY_POSSIBLE_STATUS);
> +}
> +
> +static int
> +populate_platform_events_from_wobj(struct device *dev,
> +				   struct hp_wmi_platform_events *pevents,
> +				   union acpi_object *wobj)
> +{
> +	int last_prop =3D HP_WMI_PLATFORM_EVENTS_PROPERTY_POSSIBLE_STATUS;
> +	int prop =3D HP_WMI_PLATFORM_EVENTS_PROPERTY_NAME;
> +	union acpi_object *element;
> +	acpi_object_type type;
> +	char *string;
> +	u32 value;
> +	int err;
> +
> +	err =3D check_platform_events_wobj(wobj);
> +	if (err)
> +		return err;
> +
> +	element =3D wobj->package.elements;
> +
> +	for (; prop <=3D last_prop; prop++, element++) {
> +		type =3D hp_wmi_platform_events_property_map[prop];
> +
> +		err =3D extract_acpi_value(dev, element, type, &value, &string);
> +		if (err)
> +			return err;
> +
> +		switch (prop) {
> +		case HP_WMI_PLATFORM_EVENTS_PROPERTY_NAME:
> +			pevents->name =3D string;
> +			break;
> +
> +		case HP_WMI_PLATFORM_EVENTS_PROPERTY_DESCRIPTION:
> +			pevents->description =3D string;
> +			break;
> +
> +		case HP_WMI_PLATFORM_EVENTS_PROPERTY_SOURCE_NAMESPACE:
> +			if (strcasecmp(HP_WMI_PLATFORM_EVENTS_NAMESPACE,
> +				       string))
> +				return -EINVAL;
> +
> +			pevents->source_namespace =3D string;
> +			break;
> +
> +		case HP_WMI_PLATFORM_EVENTS_PROPERTY_SOURCE_CLASS:
> +			if (strcasecmp(HP_WMI_PLATFORM_EVENTS_CLASS, string))
> +				return -EINVAL;
> +
> +			pevents->source_class =3D string;
> +			break;
> +
> +		case HP_WMI_PLATFORM_EVENTS_PROPERTY_CATEGORY:
> +			pevents->category =3D value;
> +			break;
> +
> +		case HP_WMI_PLATFORM_EVENTS_PROPERTY_POSSIBLE_SEVERITY:
> +			pevents->possible_severity =3D value;
> +			break;
> +
> +		case HP_WMI_PLATFORM_EVENTS_PROPERTY_POSSIBLE_STATUS:
> +			pevents->possible_status =3D value;
> +			break;
> +
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * check_event_wobj - validate a HPBIOS_BIOSEvent instance
> + * @wobj: pointer to WMI object instance to check
> + *
> + * Returns 0 on success, or a negative error code on error.
> + */
> +static int check_event_wobj(const union acpi_object *wobj)
> +{
> +	return check_wobj(wobj, hp_wmi_event_property_map,
> +			  HP_WMI_EVENT_PROPERTY_STATUS);
> +}
> +
> +static int populate_event_from_wobj(struct hp_wmi_event *event,
> +				    union acpi_object *wobj)
> +{
> +	int prop =3D HP_WMI_EVENT_PROPERTY_NAME;
> +	union acpi_object *element;
> +	int err;
> +
> +	err =3D check_event_wobj(wobj);
> +	if (err)
> +		return err;
> +
> +	element =3D wobj->package.elements;
> +
> +	/* Extracted strings are NOT device-managed copies. */
> +
> +	for (; prop <=3D HP_WMI_EVENT_PROPERTY_CATEGORY; prop++, element++) {
> +		switch (prop) {
> +		case HP_WMI_EVENT_PROPERTY_NAME:
> +			event->name =3D strim(element->string.pointer);
> +			break;
> +
> +		case HP_WMI_EVENT_PROPERTY_DESCRIPTION:
> +			event->description =3D strim(element->string.pointer);
> +			break;
> +
> +		case HP_WMI_EVENT_PROPERTY_CATEGORY:
> +			event->category =3D element->integer.value;
> +			break;
> +
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * classify_event - classify an event
> + * @name: event name
> + * @category: event category
> + *
> + * Classify instances of both HPBIOS_PlatformEvents and HPBIOS_BIOSEven=
t from
> + * property values. Recognition criteria are based on multiple ACPI dum=
ps [3].
> + *
> + * Returns an enum hp_wmi_type value on success,
> + * or a negative value if the event type is unsupported.
> + */
> +static int classify_event(const char *event_name, u32 category)
> +{
> +	if (category !=3D HP_WMI_CATEGORY_SENSOR)
> +		return -EINVAL;
> +
> +	/* Fan events have Name "X Stall". */
> +	if (strstr(event_name, HP_WMI_PATTERN_FAN_ALARM))
> +		return HP_WMI_TYPE_AIR_FLOW;
> +
> +	/* Intrusion events have Name "Hood Intrusion". */
> +	if (!strcmp(event_name, HP_WMI_PATTERN_INTRUSION_ALARM))
> +		return HP_WMI_TYPE_INTRUSION;
> +
> +	/*
> +	 * Temperature events have Name either "Thermal Caution" or
> +	 * "Thermal Critical". Deal only with "Thermal Critical" events.
> +	 *
> +	 * "Thermal Caution" events have Status "Stressed", informing us that
> +	 * the OperationalStatus of the related sensor has become "Stressed".
> +	 * However, this is already a fault condition that will clear itself
> +	 * when the sensor recovers, so we have no further interest in them.
> +	 */
> +	if (!strcmp(event_name, HP_WMI_PATTERN_TEMP_ALARM))
> +		return HP_WMI_TYPE_TEMPERATURE;
> +
> +	return -EINVAL;
> +}
> +
> +/*
> + * interpret_info - interpret sensor for hwmon
> + * @info: pointer to sensor info struct
> + *
> + * Should be called after the numeric sensor member has been updated.
> + */
> +static void interpret_info(struct hp_wmi_info *info)
> +{
> +	const struct hp_wmi_numeric_sensor *nsensor =3D &info->nsensor;
> +
> +	info->cached_val =3D scale_numeric_sensor(nsensor);
> +	info->last_updated =3D jiffies;
> +}
> +
> +/*
> + * hp_wmi_update_info - poll WMI to update sensor info
> + * @state: pointer to driver state
> + * @info: pointer to sensor info struct
> + *
> + * Returns 0 on success, or a negative error code on error.
> + */
> +static int hp_wmi_update_info(struct hp_wmi_sensors *state,
> +			      struct hp_wmi_info *info)
> +{
> +	struct hp_wmi_numeric_sensor *nsensor =3D &info->nsensor;
> +	struct device *dev =3D &state->wdev->dev;
> +	const union acpi_object *wobj;
> +	u8 instance =3D info->instance;
> +	int ret =3D 0;
> +
> +	if (time_after(jiffies, info->last_updated + HZ)) {
> +		mutex_lock(&state->lock);
> +
> +		wobj =3D hp_wmi_get_wobj(HP_WMI_NUMERIC_SENSOR_GUID, instance);
> +		if (!wobj) {
> +			ret =3D -EIO;
> +			goto out_unlock;
> +		}
> +
> +		update_numeric_sensor_from_wobj(dev, nsensor, wobj);
> +
> +		interpret_info(info);
> +
> +		kfree(wobj);
> +
> +out_unlock:
> +		mutex_unlock(&state->lock);
> +	}
> +
> +	return ret;
> +}
> +
> +#if CONFIG_DEBUG_FS
> +
> +static int basic_string_show(struct seq_file *seqf, void *ignored)
> +{
> +	const char *str =3D seqf->private;
> +
> +	seq_printf(seqf, "%s\n", str);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(basic_string);
> +
> +static int fungible_show(struct seq_file *seqf, enum hp_wmi_property pr=
op)
> +{
> +	struct hp_wmi_numeric_sensor *nsensor;
> +	struct hp_wmi_sensors *state;
> +	struct hp_wmi_info *info;
> +	int err;
> +
> +	switch (prop) {
> +	case HP_WMI_PROPERTY_OPERATIONAL_STATUS:
> +		nsensor =3D container_of(seqf->private,
> +				       struct hp_wmi_numeric_sensor,
> +				       operational_status);
> +		break;
> +
> +	case HP_WMI_PROPERTY_CURRENT_STATE:
> +		nsensor =3D container_of(seqf->private,
> +				       struct hp_wmi_numeric_sensor,
> +				       current_state);
> +		break;
> +
> +	case HP_WMI_PROPERTY_UNIT_MODIFIER:
> +		nsensor =3D container_of(seqf->private,
> +				       struct hp_wmi_numeric_sensor,
> +				       unit_modifier);
> +		break;
> +
> +	case HP_WMI_PROPERTY_CURRENT_READING:
> +		nsensor =3D container_of(seqf->private,
> +				       struct hp_wmi_numeric_sensor,
> +				       current_reading);
> +		break;
> +
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	info =3D container_of(nsensor, struct hp_wmi_info, nsensor);
> +	state =3D container_of(info, struct hp_wmi_sensors, info[info->instanc=
e]);
> +
> +	err =3D hp_wmi_update_info(state, info);
> +	if (err)
> +		return err;
> +
> +	switch (prop) {
> +	case HP_WMI_PROPERTY_OPERATIONAL_STATUS:
> +		seq_printf(seqf, "%u\n", nsensor->operational_status);
> +		break;
> +
> +	case HP_WMI_PROPERTY_CURRENT_STATE:
> +		seq_printf(seqf, "%s\n", nsensor->current_state);
> +		break;
> +
> +	case HP_WMI_PROPERTY_UNIT_MODIFIER:
> +		seq_printf(seqf, "%d\n", nsensor->unit_modifier);
> +		break;
> +
> +	case HP_WMI_PROPERTY_CURRENT_READING:
> +		seq_printf(seqf, "%u\n", nsensor->current_reading);
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int operational_status_show(struct seq_file *seqf, void *ignored=
)
> +{
> +	return fungible_show(seqf, HP_WMI_PROPERTY_OPERATIONAL_STATUS);
> +}
> +DEFINE_SHOW_ATTRIBUTE(operational_status);
> +
> +static int current_state_show(struct seq_file *seqf, void *ignored)
> +{
> +	return fungible_show(seqf, HP_WMI_PROPERTY_CURRENT_STATE);
> +}
> +DEFINE_SHOW_ATTRIBUTE(current_state);
> +
> +static int possible_states_show(struct seq_file *seqf, void *ignored)
> +{
> +	struct hp_wmi_numeric_sensor *nsensor =3D seqf->private;
> +	u8 i;
> +
> +	for (i =3D 0; i < nsensor->possible_states_count; i++)
> +		seq_printf(seqf, "%s%s", i ? "," : "",
> +			   nsensor->possible_states[i]);
> +
> +	seq_puts(seqf, "\n");
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(possible_states);
> +
> +static int unit_modifier_show(struct seq_file *seqf, void *ignored)
> +{
> +	return fungible_show(seqf, HP_WMI_PROPERTY_UNIT_MODIFIER);
> +}
> +DEFINE_SHOW_ATTRIBUTE(unit_modifier);
> +
> +static int current_reading_show(struct seq_file *seqf, void *ignored)
> +{
> +	return fungible_show(seqf, HP_WMI_PROPERTY_CURRENT_READING);
> +}
> +DEFINE_SHOW_ATTRIBUTE(current_reading);
> +
> +/* hp_wmi_devm_debugfs_remove - devm callback for debugfs cleanup */
> +static void hp_wmi_devm_debugfs_remove(void *res)
> +{
> +	debugfs_remove_recursive(res);
> +}
> +
> +/* hp_wmi_debugfs_init - create and populate debugfs directory tree */
> +static void hp_wmi_debugfs_init(struct hp_wmi_sensors *state)
> +{
> +	struct hp_wmi_platform_events *pevents =3D state->pevents;
> +	struct device *dev =3D &state->wdev->dev;
> +	struct hp_wmi_info *info =3D state->info;
> +	struct hp_wmi_numeric_sensor *nsensor;
> +	char buf[HP_WMI_MAX_STR_SIZE];
> +	struct dentry *debugfs;
> +	struct dentry *entries;
> +	struct dentry *dir;
> +	int err;
> +	u8 i;
> +
> +	/* dev_name() gives a not-very-friendly GUID for WMI devices. */
> +	scnprintf(buf, sizeof(buf), "hp-wmi-sensors-%u", dev->id);
> +
> +	debugfs =3D debugfs_create_dir(buf, NULL);
> +	if (IS_ERR(debugfs))
> +		return;
> +
> +	err =3D devm_add_action(dev, hp_wmi_devm_debugfs_remove, debugfs);
> +	if (err) {
> +		debugfs_remove(debugfs);
> +		return;
> +	}
> +
> +	entries =3D debugfs_create_dir("sensor", debugfs);
> +
> +	for (i =3D 0; i < state->count; i++, info++) {
> +		nsensor =3D &info->nsensor;
> +
> +		scnprintf(buf, sizeof(buf), "%u", i);
> +		dir =3D debugfs_create_dir(buf, entries);
> +
> +		debugfs_create_file("name", 0444, dir,
> +				    (void *)nsensor->name,
> +				    &basic_string_fops);
> +
> +		debugfs_create_file("description", 0444, dir,
> +				    (void *)nsensor->description,
> +				    &basic_string_fops);
> +
> +		debugfs_create_u32("sensor_type", 0444, dir,
> +				   &nsensor->sensor_type);
> +
> +		debugfs_create_file("other_sensor_type", 0444, dir,
> +				    (void *)nsensor->other_sensor_type,
> +				    &basic_string_fops);
> +
> +		debugfs_create_file("operational_status", 0444, dir,
> +				    &nsensor->operational_status,
> +				    &operational_status_fops);
> +
> +		debugfs_create_file("current_state", 0444, dir,
> +				    (void *)&nsensor->current_state,
> +				    &current_state_fops);
> +
> +		debugfs_create_file("possible_states", 0444, dir,
> +				    nsensor, &possible_states_fops);
> +
> +		debugfs_create_u32("base_units", 0444, dir,
> +				   &nsensor->base_units);
> +
> +		debugfs_create_file("unit_modifier", 0444, dir,
> +				    &nsensor->unit_modifier,
> +				    &unit_modifier_fops);
> +
> +		debugfs_create_file("current_reading", 0444, dir,
> +				    &nsensor->current_reading,
> +				    &current_reading_fops);
> +	}
> +
> +	entries =3D debugfs_create_dir("platform_events", debugfs);
> +
> +	for (i =3D 0; i < state->pevents_count; i++, pevents++) {
> +		scnprintf(buf, sizeof(buf), "%u", i);
> +		dir =3D debugfs_create_dir(buf, entries);
> +
> +		debugfs_create_file("name", 0444, dir,
> +				    (void *)pevents->name,
> +				    &basic_string_fops);
> +
> +		debugfs_create_file("description", 0444, dir,
> +				    (void *)pevents->description,
> +				    &basic_string_fops);
> +
> +		debugfs_create_file("source_namespace", 0444, dir,
> +				    (void *)pevents->source_namespace,
> +				    &basic_string_fops);
> +
> +		debugfs_create_file("source_class", 0444, dir,
> +				    (void *)pevents->source_class,
> +				    &basic_string_fops);
> +
> +		debugfs_create_u32("category", 0444, dir,
> +				   &pevents->category);
> +
> +		debugfs_create_u32("possible_severity", 0444, dir,
> +				   &pevents->possible_severity);
> +
> +		debugfs_create_u32("possible_status", 0444, dir,
> +				   &pevents->possible_status);
> +	}
> +}
> +
> +#else
> +
> +static void hp_wmi_debugfs_init(struct hp_wmi_sensors *state)
> +{
> +}
> +
> +#endif
> +
> +static umode_t hp_wmi_hwmon_is_visible(const void *drvdata,
> +				       enum hwmon_sensor_types type,
> +				       u32 attr, int channel)
> +{
> +	const struct hp_wmi_sensors *state =3D drvdata;
> +	const struct hp_wmi_info *info;
> +
> +	if (type =3D=3D hwmon_intrusion)
> +		return state->has_intrusion ? 0644 : 0;
> +
> +	if (!state->info_map[type] || !state->info_map[type][channel])
> +		return 0;
> +
> +	info =3D state->info_map[type][channel];
> +
> +	if ((type =3D=3D hwmon_temp && attr =3D=3D hwmon_temp_alarm) ||
> +	    (type =3D=3D hwmon_fan  && attr =3D=3D hwmon_fan_alarm))
> +		return info->has_alarm ? 0444 : 0;
> +
> +	return 0444;
> +}
> +
> +static int hp_wmi_hwmon_read(struct device *dev, enum hwmon_sensor_type=
s type,
> +			     u32 attr, int channel, long *val)
> +{
> +	struct hp_wmi_sensors *state =3D dev_get_drvdata(dev);
> +	const struct hp_wmi_numeric_sensor *nsensor;
> +	struct hp_wmi_info *info;
> +	int err;
> +
> +	if (type =3D=3D hwmon_intrusion) {
> +		*val =3D state->intrusion ? 1 : 0;
> +
> +		return 0;
> +	}
> +
> +	info =3D state->info_map[type][channel];
> +
> +	if ((type =3D=3D hwmon_temp && attr =3D=3D hwmon_temp_alarm) ||
> +	    (type =3D=3D hwmon_fan  && attr =3D=3D hwmon_fan_alarm)) {
> +		*val =3D info->alarm ? 1 : 0;
> +		info->alarm =3D false;
> +
> +		return 0;
> +	}
> +
> +	nsensor =3D &info->nsensor;
> +
> +	err =3D hp_wmi_update_info(state, info);
> +	if (err)
> +		return err;
> +
> +	if ((type =3D=3D hwmon_temp && attr =3D=3D hwmon_temp_fault) ||
> +	    (type =3D=3D hwmon_fan  && attr =3D=3D hwmon_fan_fault))
> +		*val =3D numeric_sensor_has_fault(nsensor);
> +	else
> +		*val =3D info->cached_val;
> +
> +	return 0;
> +}
> +
> +static int hp_wmi_hwmon_read_string(struct device *dev,
> +				    enum hwmon_sensor_types type, u32 attr,
> +				    int channel, const char **str)
> +{
> +	const struct hp_wmi_sensors *state =3D dev_get_drvdata(dev);
> +	const struct hp_wmi_info *info;
> +
> +	info =3D state->info_map[type][channel];
> +	*str =3D info->nsensor.name;
> +
> +	return 0;
> +}
> +
> +static int hp_wmi_hwmon_write(struct device *dev, enum hwmon_sensor_typ=
es type,
> +			      u32 attr, int channel, long val)
> +{
> +	struct hp_wmi_sensors *state =3D dev_get_drvdata(dev);
> +
> +	if (val || !state->intrusion)
> +		return -EOPNOTSUPP;
> +
> +	mutex_lock(&state->lock);
> +
> +	state->intrusion =3D false;
> +
> +	mutex_unlock(&state->lock);
> +
> +	return 0;
> +}
> +
> +static const struct hwmon_ops hp_wmi_hwmon_ops =3D {
> +	.is_visible  =3D hp_wmi_hwmon_is_visible,
> +	.read	     =3D hp_wmi_hwmon_read,
> +	.read_string =3D hp_wmi_hwmon_read_string,
> +	.write	     =3D hp_wmi_hwmon_write,
> +};
> +
> +static struct hwmon_chip_info hp_wmi_chip_info =3D {
> +	.ops         =3D &hp_wmi_hwmon_ops,
> +	.info        =3D NULL,
> +};
> +
> +static struct hp_wmi_info *match_fan_event(struct hp_wmi_sensors *state=
,
> +					   const char *event_description)
> +{
> +	struct hp_wmi_info **ptr_info =3D state->info_map[hwmon_fan];
> +	u8 fan_count =3D state->channel_count[hwmon_fan];
> +	struct hp_wmi_info *info;
> +	const char *name;
> +	u8 i;
> +
> +	/* Fan event has Description "X Speed". Sensor has name "X[ Speed]". *=
/
> +
> +	for (i =3D 0; i < fan_count; i++, ptr_info++) {
> +		info =3D *ptr_info;
> +		name =3D info->nsensor.name;
> +
> +		if (strstr(event_description, name))
> +			return info;
> +	}
> +
> +	return NULL;
> +}
> +
> +static u8 match_temp_events(struct hp_wmi_sensors *state,
> +			    const char *event_description,
> +			    struct hp_wmi_info *temp_info[])
> +{
> +	struct hp_wmi_info **ptr_info =3D state->info_map[hwmon_temp];
> +	u8 temp_count =3D state->channel_count[hwmon_temp];
> +	struct hp_wmi_info *info;
> +	const char *name;
> +	u8 count =3D 0;
> +	bool is_cpu;
> +	bool is_sys;
> +	u8 i;
> +
> +	/* Description either "CPU Thermal Index" or "Chassis Thermal Index". =
*/
> +
> +	is_cpu =3D !strcmp(event_description, HP_WMI_PATTERN_CPU_TEMP);
> +	is_sys =3D !strcmp(event_description, HP_WMI_PATTERN_SYS_TEMP);
> +	if (!is_cpu && !is_sys)
> +		return 0;
> +
> +	/*
> +	 * CPU event: Match one sensor with Name either "CPU Thermal Index" or
> +	 * "CPU Temperature", or multiple with Name(s) "CPU[#] Temperature".
> +	 *
> +	 * Chassis event: Match one sensor with Name either
> +	 * "Chassis Thermal Index" or "System Ambient Temperature".
> +	 */
> +
> +	for (i =3D 0; i < temp_count; i++, ptr_info++) {
> +		info =3D *ptr_info;
> +		name =3D info->nsensor.name;
> +
> +		if ((is_cpu && (!strcmp(name, HP_WMI_PATTERN_CPU_TEMP) ||
> +				!strcmp(name, HP_WMI_PATTERN_CPU_TEMP2))) ||
> +		    (is_sys && (!strcmp(name, HP_WMI_PATTERN_SYS_TEMP) ||
> +				!strcmp(name, HP_WMI_PATTERN_SYS_TEMP2)))) {
> +			temp_info[0] =3D info;
> +			return 1;
> +		}
> +
> +		if (is_cpu && (strstr(name, HP_WMI_PATTERN_CPU) &&
> +			       strstr(name, HP_WMI_PATTERN_TEMP)))
> +			temp_info[count++] =3D info;
> +	}
> +
> +	return count;
> +}
> +
> +/* hp_wmi_devm_debugfs_remove - devm callback for WMI event handler rem=
oval */
> +static void hp_wmi_devm_notify_remove(void *ignored)
> +{
> +	wmi_remove_notify_handler(HP_WMI_EVENT_GUID);
> +}
> +
> +/* hp_wmi_notify - WMI event notification handler */
> +static void hp_wmi_notify(u32 value, void *context)
> +{
> +	struct hp_wmi_info *temp_info[HP_WMI_MAX_INSTANCES] =3D {};
> +	struct acpi_buffer out =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +	struct hp_wmi_sensors *state =3D context;
> +	struct device *dev =3D &state->wdev->dev;
> +	struct hp_wmi_info *fan_info;
> +	struct hp_wmi_event event;
> +	union acpi_object *wobj;
> +	acpi_status err;
> +	int event_type;
> +	u8 count;
> +
> +	/*
> +	 * The following warning may occur in the kernel log:
> +	 *
> +	 *   ACPI Warning: \_SB.WMID._WED: Return type mismatch -
> +	 *     found Package, expected Integer/String/Buffer
> +	 *
> +	 * Non-business-class HP systems have the same WMI event GUID. Per the
> +	 * existing hp-wmi driver, the event data on those systems is indeed
> +	 * an ACPI_BUFFER containing a raw struct of 8 or 16 bytes. Because we
> +	 * validate the event data to ensure it is an ACPI_PACKAGE containing
> +	 * a HPBIOS_BIOSEvent instance, we need not concern ourselves.
> +	 */
> +
> +	mutex_lock(&state->lock);
> +
> +	err =3D wmi_get_event_data(value, &out);
> +	if (ACPI_FAILURE(err))
> +		goto out_unlock;
> +
> +	wobj =3D out.pointer;
> +
> +	err =3D populate_event_from_wobj(&event, wobj);
> +	if (err) {
> +		dev_warn(dev, "Bad event data (ACPI type %d)\n", wobj->type);
> +		goto out_free_wobj;
> +	}
> +
> +	event_type =3D classify_event(event.name, event.category);
> +	switch (event_type) {
> +	case HP_WMI_TYPE_AIR_FLOW:
> +		fan_info =3D match_fan_event(state, event.description);
> +		if (fan_info)
> +			fan_info->alarm =3D true;
> +		break;
> +
> +	case HP_WMI_TYPE_INTRUSION:
> +		state->intrusion =3D true;
> +		break;
> +
> +	case HP_WMI_TYPE_TEMPERATURE:
> +		count =3D match_temp_events(state, event.description, temp_info);
> +		while (count)
> +			temp_info[--count]->alarm =3D true;
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +out_free_wobj:
> +	kfree(wobj);
> +
> +out_unlock:
> +	mutex_unlock(&state->lock);
> +}
> +
> +static void init_platform_events(struct hp_wmi_sensors *state)
> +{
> +	struct hp_wmi_platform_events *pevents =3D state->pevents;
> +	struct device *dev =3D &state->wdev->dev;
> +	union acpi_object *wobj;
> +	int err;
> +	u8 i;
> +
> +	for (i =3D 0; i < HP_WMI_MAX_INSTANCES; i++, pevents++) {
> +		wobj =3D hp_wmi_get_wobj(HP_WMI_PLATFORM_EVENTS_GUID, i);
> +		if (!wobj)
> +			break;
> +
> +		err =3D populate_platform_events_from_wobj(dev, pevents, wobj);
> +
> +		kfree(wobj);
> +
> +		if (err)
> +			break;
> +	}

Hi,

the WMI driver core already knows how many instances of a given WMI object=
 are available.
Unfortunately, this information is currently unavailable to drivers. Would=
 it be convenient
for you to access this information? I could try to implement such a functi=
on if needed.

> +
> +	state->pevents_count =3D i;
> +
> +	dev_dbg(dev, "Found %u platform events\n", i);
> +}
> +
> +static int init_numeric_sensors(struct hp_wmi_sensors *state,
> +				struct hp_wmi_info *connected[], u8 *out_count)
> +{
> +	struct hp_wmi_info ***info_map =3D state->info_map;
> +	u8 *channel_count =3D state->channel_count;
> +	struct device *dev =3D &state->wdev->dev;
> +	struct hp_wmi_info *info =3D state->info;
> +	struct hp_wmi_numeric_sensor *nsensor;
> +	u8 type_index[hwmon_max] =3D {};
> +	enum hwmon_sensor_types type;
> +	union acpi_object *wobj;
> +	u8 type_count =3D 0;
> +	u8 count =3D 0;
> +	int wtype;
> +	int err;
> +	u8 c;
> +	u8 i;
> +
> +	for (i =3D 0; i < HP_WMI_MAX_INSTANCES; i++, info++) {

Same as above.

> +		wobj =3D hp_wmi_get_wobj(HP_WMI_NUMERIC_SENSOR_GUID, i);
> +		if (!wobj)
> +			break;
> +
> +		info->instance =3D i;
> +		nsensor =3D &info->nsensor;
> +
> +		err =3D populate_numeric_sensor_from_wobj(dev, nsensor, wobj);
> +		if (err)
> +			goto out_free_wobj;
> +
> +		if (!numeric_sensor_is_connected(nsensor))
> +			goto out_free_wobj;
> +
> +		wtype =3D classify_numeric_sensor(nsensor);
> +		if (wtype < 0)
> +			goto out_free_wobj;
> +
> +		type =3D hp_wmi_hwmon_type_map[wtype];
> +		if (!channel_count[type])
> +			type_count++;
> +		channel_count[type]++;
> +
> +		info->is_active =3D true;
> +		info->type =3D type;
> +
> +		interpret_info(info);
> +
> +		connected[count++] =3D info;
> +
> +out_free_wobj:
> +		kfree(wobj);
> +
> +		if (err)
> +			return err;
> +	}
> +
> +	dev_dbg(dev, "Found %u sensors (%u connected, %u types)\n",
> +		i, count, type_count);
> +
> +	state->count =3D i;
> +	if (!state->count)
> +		return -ENODATA;
> +
> +	for (i =3D 0; i < count; i++) {
> +		info =3D connected[i];
> +		type =3D info->type;
> +		c =3D type_index[type]++;
> +
> +		if (!info_map[type]) {
> +			info_map[type] =3D devm_kcalloc(dev, channel_count[type],
> +						      sizeof(*info_map),
> +						      GFP_KERNEL);
> +			if (!info_map[type])
> +				return -ENOMEM;
> +		}
> +
> +		info_map[type][c] =3D info;
> +	}
> +
> +	*out_count =3D count;
> +
> +	return 0;
> +}
> +
> +static bool find_event_attributes(struct hp_wmi_sensors *state)
> +{
> +	/*
> +	 * The existence of this HPBIOS_PlatformEvents instance:
> +	 *
> +	 *   {
> +	 *     Name =3D "Rear Chassis Fan0 Stall";
> +	 *     Description =3D "Rear Chassis Fan0 Speed";
> +	 *     Category =3D 3;           // "Sensor"
> +	 *     PossibleSeverity =3D 25;  // "Critical Failure"
> +	 *     PossibleStatus =3D 5;     // "Predictive Failure"
> +	 *     [...]
> +	 *   }
> +	 *
> +	 * means that this HPBIOS_BIOSEvent instance may occur:
> +	 *
> +	 *   {
> +	 *     Name =3D "Rear Chassis Fan0 Stall";
> +	 *     Description =3D "Rear Chassis Fan0 Speed";
> +	 *     Category =3D 3;           // "Sensor"
> +	 *     Severity =3D 25;          // "Critical Failure"
> +	 *     Status =3D 5;             // "Predictive Failure"
> +	 *   }
> +	 *
> +	 * After the event occurs (e.g. because the fan was unplugged),
> +	 * polling the related HPBIOS_BIOSNumericSensor instance gives:
> +	 *
> +	 *   {
> +	 *      Name =3D "Rear Chassis Fan0";
> +	 *      Description =3D "Reports rear chassis fan0 speed";
> +	 *      OperationalStatus =3D 5; // "Predictive Failure", was 3 ("OK")
> +	 *      CurrentReading =3D 0;
> +	 *      [...]
> +	 *   }
> +	 *
> +	 * In this example, the hwmon fan channel for "Rear Chassis Fan0"
> +	 * should support the alarm flag and have it be set if the related
> +	 * HPBIOS_BIOSEvent instance occurs.
> +	 *
> +	 * In addition to fan events, temperature (CPU/chassis) and intrusion
> +	 * events are relevant to hwmon [2]. Note that much information in [2]
> +	 * is unreliable; it is referenced in addition to ACPI dumps [3] merel=
y
> +	 * to support the conclusion that sensor and event names/descriptions
> +	 * are systematic enough to allow this driver to match them.
> +	 *
> +	 * Complications and limitations:
> +	 *
> +	 *   - Strings are freeform and may vary, cf. sensor Name "CPU0 Fan"
> +	 *     on a Z420 vs. "CPU Fan Speed" on an EliteOne 800 G1.
> +	 *   - Leading/trailing whitespace is a rare but real possibility [3].
> +	 *   - The HPBIOS_PlatformEvents object may not exist or its instances
> +	 *     may show that the system only has e.g. BIOS setting-related
> +	 *     events (cf. the ProBook 4540s and ProBook 470 G0 [3]).
> +	 */
> +
> +	struct hp_wmi_info *temp_info[HP_WMI_MAX_INSTANCES] =3D {};
> +	struct hp_wmi_platform_events *pevents =3D state->pevents;
> +	u8 pevents_count =3D state->pevents_count;
> +	const char *event_description;
> +	struct hp_wmi_info *fan_info;
> +	bool has_events =3D false;
> +	const char *event_name;
> +	u32 event_category;
> +	int event_type;
> +	u8 count;
> +	u8 i;
> +
> +	for (i =3D 0; i < pevents_count; i++, pevents++) {
> +		event_name =3D pevents->name;
> +		event_description =3D pevents->description;
> +		event_category =3D pevents->category;
> +
> +		event_type =3D classify_event(event_name, event_category);
> +		switch (event_type) {
> +		case HP_WMI_TYPE_AIR_FLOW:
> +			fan_info =3D match_fan_event(state, event_description);
> +			if (!fan_info)
> +				break;
> +
> +			fan_info->has_alarm =3D true;
> +			has_events =3D true;
> +			break;
> +
> +		case HP_WMI_TYPE_INTRUSION:
> +			state->has_intrusion =3D true;
> +			has_events =3D true;
> +			break;
> +
> +		case HP_WMI_TYPE_TEMPERATURE:
> +			count =3D match_temp_events(state, event_description,
> +						  temp_info);
> +			if (!count)
> +				break;
> +
> +			while (count)
> +				temp_info[--count]->has_alarm =3D true;
> +			has_events =3D true;
> +			break;
> +
> +		default:
> +			break;
> +		}
> +	}
> +
> +	return has_events;
> +}
> +
> +static int make_chip_info(struct hp_wmi_sensors *state, bool has_events=
)
> +{
> +	const struct hwmon_channel_info **ptr_channel_info;
> +	struct hp_wmi_info ***info_map =3D state->info_map;
> +	u8 *channel_count =3D state->channel_count;
> +	struct hwmon_channel_info *channel_info;
> +	struct device *dev =3D &state->wdev->dev;
> +	enum hwmon_sensor_types type;
> +	u8 type_count =3D 0;
> +	u32 *config;
> +	u32 attr;
> +	u8 count;
> +	u8 i;
> +
> +	if (channel_count[hwmon_temp])
> +		channel_count[hwmon_chip] =3D 1;
> +
> +	if (has_events && state->has_intrusion)
> +		channel_count[hwmon_intrusion] =3D 1;
> +
> +	for (type =3D hwmon_chip; type < hwmon_max; type++)
> +		type_count +=3D channel_count[type];
> +
> +	channel_info =3D devm_kcalloc(dev, type_count,
> +				    sizeof(*channel_info), GFP_KERNEL);
> +	if (!channel_info)
> +		return -ENOMEM;
> +
> +	ptr_channel_info =3D devm_kcalloc(dev, type_count + 1,
> +					sizeof(*ptr_channel_info), GFP_KERNEL);
> +	if (!ptr_channel_info)
> +		return -ENOMEM;
> +
> +	hp_wmi_chip_info.info =3D ptr_channel_info;
> +
> +	for (type =3D hwmon_chip; type < hwmon_max; type++) {
> +		count =3D channel_count[type];
> +		if (!count)
> +			continue;
> +
> +		config =3D devm_kcalloc(dev, count + 1,
> +				      sizeof(*config), GFP_KERNEL);
> +		if (!config)
> +			return -ENOMEM;
> +
> +		attr =3D hp_wmi_hwmon_attributes[type];
> +		channel_info->type =3D type;
> +		channel_info->config =3D config;
> +		memset32(config, attr, count);
> +
> +		*ptr_channel_info++ =3D channel_info++;
> +
> +		if (!has_events || (type !=3D hwmon_temp && type !=3D hwmon_fan))
> +			continue;
> +
> +		attr =3D type =3D=3D hwmon_temp ? HWMON_T_ALARM : HWMON_F_ALARM;
> +
> +		for (i =3D 0; i < count; i++)
> +			if (info_map[type][i]->has_alarm)
> +				config[i] |=3D attr;
> +	}
> +
> +	return 0;
> +}
> +
> +static bool add_event_handler(struct hp_wmi_sensors *state)
> +{
> +	struct device *dev =3D &state->wdev->dev;
> +	int err;
> +
> +	err =3D wmi_install_notify_handler(HP_WMI_EVENT_GUID,
> +					 hp_wmi_notify, state);

As a side note: the GUID-based interface for accessing WMI devices is depr=
ecated.
It has known problems handling WMI devices sharing GUIDs and/or notificati=
on IDs. However,
the modern bus-based WMI interface (currently) does not support such aggre=
gate devices well,
so i think using wmi_install_notify_handler() is still the best thing you =
can currently do.

> +	if (err) {
> +		dev_info(dev, "Failed to subscribe to WMI event\n");
> +		return false;
> +	}
> +
> +	err =3D devm_add_action(dev, hp_wmi_devm_notify_remove, NULL);
> +	if (err) {
> +		wmi_remove_notify_handler(HP_WMI_EVENT_GUID);
> +		return false;
> +	}

Maybe use devm_add_action_or_reset() here?

Armin Wolf

> +
> +	return true;
> +}
> +
> +static int hp_wmi_sensors_init(struct hp_wmi_sensors *state)
> +{
> +	struct hp_wmi_info *connected[HP_WMI_MAX_INSTANCES];
> +	struct device *dev =3D &state->wdev->dev;
> +	struct device *hwdev;
> +	bool has_events;
> +	u8 count;
> +	int err;
> +
> +	init_platform_events(state);
> +
> +	err =3D init_numeric_sensors(state, connected, &count);
> +	if (err)
> +		return err;
> +
> +	hp_wmi_debugfs_init(state);
> +
> +	if (!count)
> +		return 0; /* Not an error, but debugfs only. */
> +
> +	has_events =3D find_event_attributes(state);
> +
> +	/* Survive failure to install WMI event handler. */
> +	if (has_events && !add_event_handler(state))
> +		has_events =3D false;
> +
> +	err =3D make_chip_info(state, has_events);
> +	if (err)
> +		return err;
> +
> +	hwdev =3D devm_hwmon_device_register_with_info(dev, "hp_wmi_sensors",
> +						     state, &hp_wmi_chip_info,
> +						     NULL);
> +	return PTR_ERR_OR_ZERO(hwdev);
> +}
> +
> +static int hp_wmi_sensors_probe(struct wmi_device *wdev, const void *co=
ntext)
> +{
> +	struct device *dev =3D &wdev->dev;
> +	struct hp_wmi_sensors *state;
> +
> +	state =3D devm_kzalloc(dev, sizeof(*state), GFP_KERNEL);
> +	if (!state)
> +		return -ENOMEM;
> +
> +	state->wdev =3D wdev;
> +
> +	mutex_init(&state->lock);
> +
> +	dev_set_drvdata(dev, state);
> +
> +	return hp_wmi_sensors_init(state);
> +}
> +
> +static const struct wmi_device_id hp_wmi_sensors_id_table[] =3D {
> +	{ HP_WMI_NUMERIC_SENSOR_GUID, NULL },
> +	{},
> +};
> +
> +static struct wmi_driver hp_wmi_sensors_driver =3D {
> +	.driver   =3D { .name =3D "hp-wmi-sensors" },
> +	.id_table =3D hp_wmi_sensors_id_table,
> +	.probe    =3D hp_wmi_sensors_probe,
> +};
> +module_wmi_driver(hp_wmi_sensors_driver);
> +
> +MODULE_AUTHOR("James Seo <james@equiv.tech>");
> +MODULE_DESCRIPTION("HP WMI Sensors driver");
> +MODULE_LICENSE("GPL");
>
> base-commit: 457391b0380335d5e9a5babdec90ac53928b23b4
