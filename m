Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCC36F996D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 17:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjEGPkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 11:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjEGPkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 11:40:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009CD100EA;
        Sun,  7 May 2023 08:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1683474029; i=w_armin@gmx.de;
        bh=EwdOwjJ55NwLoW9mWM8F1boYqxl4BhZ04Anu8oclTb0=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=lv782cMyhqd+FDeEANYsqjYCA3Mo32rkCJdrORjAAzvaG/MNVKFKi7Nka6R/mZrsF
         7pSeni67gv9l4P6NIP3wGOei3YsxBToyWEQwxd+HFYQvOSNQWyYAhXLFxhnwUSaBRU
         UuoNveRyEpMmRQMkgtyX/ogsxL9f4W3A97/8Bj8aWRKVW0wh5+I6DY52hAFyKgwGro
         vZ6U51tahECYmyysk/0fHb0XYe98c5CzYaKAV5SqTyfh4PiSTlGM32TwIDGS+IO/u2
         7WZbnvRFxcfpFqIz/8z2LR+Icew9DKyrMAyYNlZWwtbWoYuOXqZMTlr6QCch8ru+jU
         fJ/g8cATmhRmQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDQeU-1q2rUZ1JzS-00AUoo; Sun, 07
 May 2023 17:40:29 +0200
Subject: Re: [PATCH 1/2] platform/x86: dell-ddv: Add documentation
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     corbet@lwn.net, platform-driver-x86@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230429225525.10507-1-W_Armin@gmx.de>
Message-ID: <61dc570b-b9e5-3ba4-bc3f-b0ea61891efc@gmx.de>
Date:   Sun, 7 May 2023 17:40:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20230429225525.10507-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:sBHhj3CJaqSzkO92p9sRu40tUS8aLNIZJyhPkXUbB7de5yPfuSd
 ud5Y0XcIj6wmCk5NsLxvlDTgpTJN2TVp9pybfvX/gFalt4uCeRHysYkvaqsD05mCAEDU6pn
 85le5IjOMUVixt/TWEEsndntAbVthLLbkzJ9IW5xbeBJd8UpWPxSvf0s53NyPyD2jaU6fb7
 cU5W1ANpfvEmWxJaiprbQ==
UI-OutboundReport: notjunk:1;M01:P0:hv9cVqyc6fo=;lYwDMg6YolFbMbuaf+O1JVBerXA
 3WRQG1QXKgjSjRTUpdB7w4+b8CdHFYS66J7WS1Z5UQt+NQkCtHBYRIbv+Yn/6wI8g9EBXAYp8
 aOrINzKwnEvY0Wv8mw0hplc8OJU1Q5+QSPmm7iHEKNgC+GEOiw3/yoErrpil0mu3UqjYwenOq
 z6V1DQSVr8EACQZC0u2ajQja2CX8Urlb8xnSKNGDrO2mLM3AvpppIQNNVlLaFSRpdTBsz0KTy
 yaG+IRjuK97CtI7vV/CbrGdERubzJ2p626fzHVun3IJ0+J/xeChn+Egr3yzZE75/jWcBQaktJ
 b5OBwaK2kuFnu9rdOcbCNyuS3pf2OAFJzDIpDOS60w9d3ce30V+FswTflPmaCbuSvY+W2KwRf
 PuZDjA5B+++k+yCNblzp8wvm7L/agCtFe0uHNnaytKwtwBJulhri8uUPttedqLCj7FzAvR4Sw
 xQYkcg8KIPOOBhI60vJaxe8r5Vool35GEqvdWm7Ja0XPzP/BC0EJ2Qpd2FUz/iNWdtRoOe0tm
 BGQEpnQIhnTHLVptkLJidUAaF58t4BzCG3iWA8sRQODSFAkH8wtYthl2yLhBkSN1C3vYQQS2s
 bQuZOJ8opmude7E7SfR8I/aSOgxeYYzpe10L5TY6XDLvyzWQmtZgT5KOp442Um2/1F91Ef8T9
 Iz+n1CMdpXIheBTNB7GuaKVVX5uZk4mnu2HvcVfuetJyWMF4tseRhjJEFuIaQt93IMesVySGQ
 5s9U3ShwGEUu35cbfYJfCKSrVzYOrGAjar6U37+CeBJ4dJkXd99JTQK5LdVbtf+KKcFYVWJ1g
 0SbiR/6bkWLeX0xltGemfyThsUkFrD/lPDrAvguVdPULlGLxX59ZI4dn7L9bDfyI3E+g/T3EA
 WDqdp5B/Q/KKfV3zh9HA8zY6cgPsZrGu+cC5i5z4po2k5JLBN6Llaor5omGco/X0iRtuit6Cs
 dPFI4IxHiVXI3kM/lnMkoARZZDc=
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 30.04.23 um 00:55 schrieb Armin Wolf:

> The WMI interface used by the dell-wmi-ddv driver contains
> many methods which are currently unused, making it difficult
> to document these inside the drivers source code.
> Create the necessary documentation based on current knowledge
> so that all details of the WMI interface are written down for
> later use.
>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>   Documentation/wmi/devices/dell-wmi-ddv.rst | 294 +++++++++++++++++++++
>   MAINTAINERS                                |   1 +
>   2 files changed, 295 insertions(+)
>   create mode 100644 Documentation/wmi/devices/dell-wmi-ddv.rst
>
> diff --git a/Documentation/wmi/devices/dell-wmi-ddv.rst b/Documentation/wmi/devices/dell-wmi-ddv.rst
> new file mode 100644
> index 000000000000..3fc6ee3e9f9b
> --- /dev/null
> +++ b/Documentation/wmi/devices/dell-wmi-ddv.rst
> @@ -0,0 +1,294 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +============================================
> +Dell DDV WMI interface driver (dell-wmi-ddv)
> +============================================
> +
> +Introduction
> +============
> +
> +Many Dell notebooks made after ~2020 support a WMI-based interface for
> +retrieving various system data like battery temperature, ePPID, diagostic data
> +and fan/thermal sensor data.
> +
> +This interface is likely used by the `Dell Data Vault` software on Windows,
> +so it was called `DDV`. Currently the ``dell-wmi-ddv`` driver supports
> +version 2 and 3 of the interface, with support for new interface versions
> +easily added.
> +
> +.. warning:: The interface is regarded as internal by Dell, so no vendor
> +             documentation is available. All knowledge was thus obtained by
> +             trial-and-error, please keep that in mind.
> +
> +Dell ePPID (electronic Piece Part Identification)
> +=================================================
> +
> +The Dell ePPID is used to uniquely identify components in Dell machines,
> +including batteries. It has a form similar to `CC-PPPPPP-MMMMM-YMD-SSSS-FFF`
> +and contains the following information:
> +
> +* Country code of origin (CC).
> +* Part number with the first character being a filling number (PPPPPP).
> +* Manufacture Identification (MMMMM).
> +* Manufacturing Year/Month/Date (YMD) in base 36, with Y being the last digit
> +  of the year.
> +* Manufacture Sequence Number (SSSS).
> +* Optional Firmware Version/Revision (FFF).
> +
> +The `eppidtool <https://pypi.org/project/eppidtool>`_ python utility can be used
> +to decode and display this information.
> +
> +All information regarding the Dell ePPID was gathered using Dell support
> +documentation and `this website <https://telcontar.net/KBK/Dell/date_codes>`_.
> +
> +WMI interface description
> +=========================
> +
> +The WMI interface description can be decoded from the embedded binary MOF (bmof)
> +data using the `bmfdec <https://github.com/pali/bmfdec>`_ utility:
> +
> +::
> +
> + [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"), Description("WMI Function"), guid("{8A42EA14-4F2A-FD45-6422-0087F7A7E608}")]
> + class DDVWmiMethodFunction {
> +   [key, read] string InstanceName;
> +   [read] boolean Active;
> +
> +   [WmiMethodId(1), Implemented, read, write, Description("Return Battery Design Capacity.")] void BatteryDesignCapacity([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(2), Implemented, read, write, Description("Return Battery Full Charge Capacity.")] void BatteryFullChargeCapacity([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(3), Implemented, read, write, Description("Return Battery Manufacture Name.")] void BatteryManufactureName([in] uint32 arg2, [out] string argr);
> +   [WmiMethodId(4), Implemented, read, write, Description("Return Battery Manufacture Date.")] void BatteryManufactureDate([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(5), Implemented, read, write, Description("Return Battery Serial Number.")] void BatterySerialNumber([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(6), Implemented, read, write, Description("Return Battery Chemistry Value.")] void BatteryChemistryValue([in] uint32 arg2, [out] string argr);
> +   [WmiMethodId(7), Implemented, read, write, Description("Return Battery Temperature.")] void BatteryTemperature([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(8), Implemented, read, write, Description("Return Battery Current.")] void BatteryCurrent([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(9), Implemented, read, write, Description("Return Battery Voltage.")] void BatteryVoltage([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(10), Implemented, read, write, Description("Return Battery Manufacture Access(MA code).")] void BatteryManufactureAceess([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(11), Implemented, read, write, Description("Return Battery Relative State-Of-Charge.")] void BatteryRelativeStateOfCharge([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(12), Implemented, read, write, Description("Return Battery Cycle Count")] void BatteryCycleCount([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(13), Implemented, read, write, Description("Return Battery ePPID")] void BatteryePPID([in] uint32 arg2, [out] string argr);
> +   [WmiMethodId(14), Implemented, read, write, Description("Return Battery Raw Analytics Start")] void BatteryeRawAnalyticsStart([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(15), Implemented, read, write, Description("Return Battery Raw Analytics")] void BatteryeRawAnalytics([in] uint32 arg2, [out] uint32 RawSize, [out, WmiSizeIs("RawSize") : ToInstance] uint8 RawData[]);
> +   [WmiMethodId(16), Implemented, read, write, Description("Return Battery Design Voltage.")] void BatteryDesignVoltage([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(17), Implemented, read, write, Description("Return Battery Raw Analytics A Block")] void BatteryeRawAnalyticsABlock([in] uint32 arg2, [out] uint32 RawSize, [out, WmiSizeIs("RawSize") : ToInstance] uint8 RawData[]);
> +   [WmiMethodId(18), Implemented, read, write, Description("Return Version.")] void ReturnVersion([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(32), Implemented, read, write, Description("Return Fan Sensor Information")] void FanSensorInformation([in] uint32 arg2, [out] uint32 RawSize, [out, WmiSizeIs("RawSize") : ToInstance] uint8 RawData[]);
> +   [WmiMethodId(34), Implemented, read, write, Description("Return Thermal Sensor Information")] void ThermalSensorInformation([in] uint32 arg2, [out] uint32 RawSize, [out, WmiSizeIs("RawSize") : ToInstance] uint8 RawData[]);
> + };
> +
> +Each WMI method takes an ACPI buffer containing a 32-bit index as input argument,
> +with the first 8 bit being used to specify the battery when using battery-related
> +WMI methods. Other WMI methods may ignore this argument or interpret it
> +differently. The WMI method output format varies:
> +
> +* if the function has only a single output, then an ACPI object
> +  of the corresponding type is returned
> +* if the function has multiple outputs, when an ACPI package
> +  containing the outputs in the same order is returned
> +
> +The format of the output should be thoroughly checked, since many methods can
> +return malformed data in case of an error.
> +
> +The data format of many battery-related methods seems to be based on the
> +`Smart Battery Data Specification`, so unknown battery-related methods are
> +likely to follow this standard in some way.
> +
> +WMI method GetBatteryDesignCapacity()
> +-------------------------------------
> +
> +Returns the design capacity of the battery in mAh as an u16.
> +
> +WMI method BatteryFullCharge()
> +------------------------------
> +
> +Returns the full charge capacity of the battery in mAh as an u16.
> +
> +WMI method BatteryManufactureName()
> +-----------------------------------
> +
> +Returns the manufacture name of the battery as an ASCII string.
> +
> +WMI method BatteryManufactureDate()
> +-----------------------------------
> +
> +Returns the manufacture date of the battery as an u16.
> +The date is encoded in the following manner:
> +
> +- bits 0 to 4 contain the manufacture day.
> +- bits 5 to 8 contain the manufacture month.
> +- bits 9 to 15 contain the manufacture year biased by 1980.
> +
> +.. note::
> +   The data format needs to be verified on more machines.
> +
> +WMI method BatterySerialNumber()
> +--------------------------------
> +
> +Returns the serial number of the battery as an u16.
> +
> +WMI method BatteryChemistryValue()
> +----------------------------------
> +
> +Returns the chemistry of the battery as an ASCII string.
> +Known values are:
> +
> +- "Li-I" for Li-Ion
> +
> +WMI method BatteryTemperature()
> +-------------------------------
> +
> +Returns the temperature of the battery in tenth degree kelvin as an u16.
> +
> +WMI method BatteryCurrent()
> +---------------------------
> +
> +Returns the current flow of the battery in mA as an s16.
> +Negative values indicate discharging.
> +
> +WMI method BatteryVoltage()
> +---------------------------
> +
> +Returns the voltage flow of the battery in mV as an u16.
> +
> +WMI method BatteryManufactureAccess()
> +-------------------------------------
> +
> +Returns a manufacture-defined value as an u16.
> +
> +WMI method BatteryRelativeStateOfCharge()
> +-----------------------------------------
> +
> +Returns the capacity of the battery in percent as an u16.
> +
> +WMI method BatteryCycleCount()
> +------------------------------
> +
> +Returns the cycle count of the battery as an u16.
> +
> +WMI method BatteryePPID()
> +-------------------------
> +
> +Returns the ePPID of the battery as an ASCII string.
> +
> +WMI method BatteryeRawAnalyticsStart()
> +--------------------------------------
> +
> +Performs an analysis of the battery and returns a status code:
> +
> +- ``0x0``: Success
> +- ``0x1``: Interface not supported
> +- ``0xfffffffe``: Error/Timeout
> +
> +.. note::
> +   The meaning of this method is still largely unknown.
> +
> +WMI method BatteryeRawAnalytics()
> +---------------------------------
> +
> +Returns a buffer usually containg 12 blocks of analytics data.
> +Those blocks contain:
> +- block number starting with 0 (u8)
> +- 31 bytes of unknown data
> +
> +.. note::
> +   The meaning of this method is still largely unknown.
> +
> +WMI method BatteryDesignVoltage()
> +---------------------------------
> +
> +Returns the design voltage of the battery in mV as an u16.
> +
> +WMI method BatteryeRawAnalyticsABlock()
> +---------------------------------------
> +
> +Returns a single block of analytics data, with the second byte
> +of the index being used for selecting the block number.
> +
> +*Supported since WMI interface version 3!*
> +
> +.. note::
> +   The meaning of this method is still largely unknown.
> +
> +WMI method ReturnVersion()
> +--------------------------
> +
> +Returns the WMI interface version as an u32.
> +
> +WMI method FanSensorInformation()
> +---------------------------------
> +
> +Returns a buffer containg fan sensor entries, terminated
> +with a single ``0xff``.
> +Those entries contain:
> +
> +- fan type (u8)
> +- fan speed in RPM (little endian u16)
> +
> +WMI method ThermalSensorInformation()
> +-------------------------------------
> +
> +Returns a buffer containing thermal sensor entries, terminated
> +with a single ``0xff``.
> +Those entries contain:
> +
> +- thermal type (u8)
> +- current temperature (s8)
> +- min. temperature (s8)
> +- max. temperature (s8)
> +- unknown field (u8)
> +
> +.. note::
> +   Find out what the meaning of the last byte is.
> +
> +ACPI battery matching algorithm
> +===============================
> +
> +The algorithm used to match ACPI batteries to indices is based on information
> +which was found inside the logging messages of the OEM software.
> +
> +Basically for each new ACPI battery, the serial numbers of the batteries behind
> +indices 1 till 3 are compared with the serial number of the ACPI battery.
> +Since the serial number of the ACPI battery can either be encoded as a normal
> +integer or as a hexadecimal value, both cases need to be checked. The first
> +index with a matching serial number is then selected.
> +
> +A serial number of 0 indicates that the corresponding index is not associated
> +with an actual battery, or that the associated battery is not present.
> +
> +Some machines like the Dell Inspiron 3505 only support a single battery and thus
> +ignore the battery index. Because of this the driver depends on the ACPI battery
> +hook mechanism to discover batteries.
> +
> +.. note::
> +   The ACPI battery matching algorithm currently used inside the driver is
> +   outdated and does not match the algorithm described above. The reasons for
> +   this are differences in the handling of the ToHexString() ACPI opcode between
> +   Linux and Windows, which distorts the serial number of ACPI batteries on many
> +   machines. Until this issue is resolved, the driver cannot use the above
> +   algorithm.
> +
> +Reverse-Engineering the DDV WMI interface
> +=========================================
> +
> +1. Find a supported Dell notebook, usually made after ~2020.
> +2. Dump the ACPI tables and search for the WMI device (usually called "ADDV").
> +3. Decode the corresponding bmof data and look at the ASL code.
> +4. Try to deduce the meaning of a certain WMI method by comparing the control
> +   flow with other ACPI methods (_BIX or _BIF for battery related methods
> +   for example).
> +5. Use the built-in UEFI diagostics to view sensor types/values for fan/thermal
> +   related methods (sometimes overwriting static ACPI data fields can be used
> +   to test different sensor type values, since on some machines this data is
> +   not reinitialized upon a warm reset).
> +
> +Alternatively:
> +
> +1. Load the ``dell-wmi-ddv`` driver, use the ``force`` module param
> +   if necessary.
> +2. Use the debugfs interface to access the raw fan/thermal sensor buffer data.
> +3. Compare the data with the built-in UEFI diagnostics.
> +
> +In case the DDV WMI interface version available on your Dell notebook is not
> +supported or you are seeing unknown fan/thermal sensors, please submit a
> +bugreport on `bugzilla <https://bugzilla.kernel.org>`_ so they can be added
> +to the ``dell-wmi-ddv`` driver.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4d5b1f6d77f6..66e4eabaf972 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5804,6 +5804,7 @@ M:	Armin Wolf <W_Armin@gmx.de>
>   S:	Maintained
>   F:	Documentation/ABI/testing/debugfs-dell-wmi-ddv
>   F:	Documentation/ABI/testing/sysfs-platform-dell-wmi-ddv
> +F:	Documentation/wmi/devices/dell-wmi-ddv.rst
>   F:	drivers/platform/x86/dell/dell-wmi-ddv.c
>
>   DELL WMI SYSMAN DRIVER
> --
> 2.30.2
>
Any thoughts on this series?

Armin Wolf

