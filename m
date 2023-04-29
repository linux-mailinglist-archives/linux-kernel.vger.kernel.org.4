Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88CC6F2715
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 00:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjD2Wzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 18:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjD2Wzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 18:55:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8864C1A2;
        Sat, 29 Apr 2023 15:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1682808927; i=w_armin@gmx.de;
        bh=O7T6MqzGwzfkORnnXEU9Ca1L9XPKFA5dEiWReOnhImk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=BxjGcdvQQC9Qjx3wb4Ad3lvsVEc1dN4+NXY616VRa2OD+0pk2iT3VCJuDaRp2pdIT
         5SeO1nkDzTd0a9+l8cYX1XxGnBNhh/GTOyqlOm0ZDNxE3qx+mGGJQ8hn3ElSH7Af0j
         8YXuU0mMaZTveGI4IfWH+lU5fG1x5QMlatuFrPul+r2nza12HeqkLUfDjlymVdfJlo
         pIPzydVv8FPrpuwzOqUZOeAmJ5y8uGa3ozk1xKVbWQBLkqYolxrcYzt9+PKHmah80t
         bd5UFv2n4Fw3idj/wMvq0tZh+ZVZKupkTI2aF8qpNEZrwwKsEoHSPdBxCd3MpN5CT8
         nVDLNoWewEYXA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Md6Mj-1qSEUW2xF5-00aHoN; Sun, 30 Apr 2023 00:55:27 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     corbet@lwn.net, platform-driver-x86@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] platform/x86: dell-ddv: Add documentation
Date:   Sun, 30 Apr 2023 00:55:24 +0200
Message-Id: <20230429225525.10507-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pZUwOFjf6yFsgNpFxeZikCjOoIo8eNo/sm9b+narfc+DkvfYjaJ
 +GD4XB5p01d9+NNGgu1Z9cZSI4xKNMoDUZKEVjNa6VPr1P+hThZ+NlmdTh4vC8UBC0qdo0T
 p5luMVdRstxqX8fXn3xoo1sMQHV12d9ou1TPsaSktCBa+DO1h+3pAtr3P+wk5/vbv85aWlm
 6g08Iq6MyRqIdh7PDjINQ==
UI-OutboundReport: notjunk:1;M01:P0:fkys7buEuJk=;rO1VP2ROclAwbzWENQQHb2Kr00B
 BOmpi6tgPgflGTaVOzUhe6Wf4Cs4CHoCK1sJHZxDfxUt7nhsi2fUu0xsplwWvxAV6C26oP8tN
 kii9Kw1G2ju/eaVqx9zhlWPf3NqpTVPtHEBSoCwat5sohr2TdOJQOzTQTiMKbF5grQQJu3ZXN
 2kXgXVzhV/PO3bH4FIjBLSHgI0IE8xUg/uk6D8dnevlpzBAffkcNO2oL0bFxvj1Qxw7jK6Dlg
 0dZbCkim9TpvUAuGf5vUxQ/pyWTPPZCJQOwhA87rvpEcpj0MPP9J9PfenglUEdkyhIsKvOspE
 yFwhJB3wogVvvyRc1hBgWsmoSrL4kJBC9gXQSg9UHdfx0X7IoCLUEVlcUeZHAlkJXfJs9RMYG
 cnTaVFvTzW7GhlS3rkI2KP7gbQcwbMEp6pq44MBztHpIH+TipQj01nPC4vtd6+5IhwCgmhaO3
 vHJNQLoD1xx+yEZ3tIe5g3wYq+I7104Q0H38sC0Um0BMIq/vdvyok9877QqIXNVYd/kfq5d1B
 rsXCLcYVw8Iy7JyBBcs2wHdItQbqONaz6w33oLCUkotfkFPQB8zcAAVqVMYs95WSMGyaG5tqa
 gauBX+tmie1ULlI7w7GaZL4DOn9vYQdi9CqT8vTK+k2RpspLKgrAIpI/RL97+JDjYx+8LBbA+
 DIh0WDylpYVwYLSy25IKdmL3LXApGf0PqNIxDXfIHCwsQ9kZ5W25XnzN9YHvzvsM/axx9t6t4
 7ZFYCFCPnbGEN003hSMPk4igK0uTKqBLCVch5h/+kqLgXmP6EnSZnPVEblAl4nTj9ov+IhC3U
 kZk6HcpppRFwZ5CLZwivSk7Ew3VKeYmE8VvraTyeNgscS4BmlP7LIUUYw0pjvsbFpPKsBeRyj
 kC2qaQzK5CpdXmy3rn8E7W3IwITMtaDFN/a2WAbzaX9PLcOxJYx4AgTUVR0CEH52yN4nd5sqa
 KRP2T0alCsCenhKw0aLXBWsL2f8=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WMI interface used by the dell-wmi-ddv driver contains
many methods which are currently unused, making it difficult
to document these inside the drivers source code.
Create the necessary documentation based on current knowledge
so that all details of the WMI interface are written down for
later use.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/wmi/devices/dell-wmi-ddv.rst | 294 +++++++++++++++++++++
 MAINTAINERS                                |   1 +
 2 files changed, 295 insertions(+)
 create mode 100644 Documentation/wmi/devices/dell-wmi-ddv.rst

diff --git a/Documentation/wmi/devices/dell-wmi-ddv.rst b/Documentation/wm=
i/devices/dell-wmi-ddv.rst
new file mode 100644
index 000000000000..3fc6ee3e9f9b
=2D-- /dev/null
+++ b/Documentation/wmi/devices/dell-wmi-ddv.rst
@@ -0,0 +1,294 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Dell DDV WMI interface driver (dell-wmi-ddv)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Introduction
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Many Dell notebooks made after ~2020 support a WMI-based interface for
+retrieving various system data like battery temperature, ePPID, diagostic=
 data
+and fan/thermal sensor data.
+
+This interface is likely used by the `Dell Data Vault` software on Window=
s,
+so it was called `DDV`. Currently the ``dell-wmi-ddv`` driver supports
+version 2 and 3 of the interface, with support for new interface versions
+easily added.
+
+.. warning:: The interface is regarded as internal by Dell, so no vendor
+             documentation is available. All knowledge was thus obtained =
by
+             trial-and-error, please keep that in mind.
+
+Dell ePPID (electronic Piece Part Identification)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+
+The Dell ePPID is used to uniquely identify components in Dell machines,
+including batteries. It has a form similar to `CC-PPPPPP-MMMMM-YMD-SSSS-F=
FF`
+and contains the following information:
+
+* Country code of origin (CC).
+* Part number with the first character being a filling number (PPPPPP).
+* Manufacture Identification (MMMMM).
+* Manufacturing Year/Month/Date (YMD) in base 36, with Y being the last d=
igit
+  of the year.
+* Manufacture Sequence Number (SSSS).
+* Optional Firmware Version/Revision (FFF).
+
+The `eppidtool <https://pypi.org/project/eppidtool>`_ python utility can =
be used
+to decode and display this information.
+
+All information regarding the Dell ePPID was gathered using Dell support
+documentation and `this website <https://telcontar.net/KBK/Dell/date_code=
s>`_.
+
+WMI interface description
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+
+The WMI interface description can be decoded from the embedded binary MOF=
 (bmof)
+data using the `bmfdec <https://github.com/pali/bmfdec>`_ utility:
+
+::
+
+ [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"), Description("WM=
I Function"), guid("{8A42EA14-4F2A-FD45-6422-0087F7A7E608}")]
+ class DDVWmiMethodFunction {
+   [key, read] string InstanceName;
+   [read] boolean Active;
+
+   [WmiMethodId(1), Implemented, read, write, Description("Return Battery=
 Design Capacity.")] void BatteryDesignCapacity([in] uint32 arg2, [out] ui=
nt32 argr);
+   [WmiMethodId(2), Implemented, read, write, Description("Return Battery=
 Full Charge Capacity.")] void BatteryFullChargeCapacity([in] uint32 arg2,=
 [out] uint32 argr);
+   [WmiMethodId(3), Implemented, read, write, Description("Return Battery=
 Manufacture Name.")] void BatteryManufactureName([in] uint32 arg2, [out] =
string argr);
+   [WmiMethodId(4), Implemented, read, write, Description("Return Battery=
 Manufacture Date.")] void BatteryManufactureDate([in] uint32 arg2, [out] =
uint32 argr);
+   [WmiMethodId(5), Implemented, read, write, Description("Return Battery=
 Serial Number.")] void BatterySerialNumber([in] uint32 arg2, [out] uint32=
 argr);
+   [WmiMethodId(6), Implemented, read, write, Description("Return Battery=
 Chemistry Value.")] void BatteryChemistryValue([in] uint32 arg2, [out] st=
ring argr);
+   [WmiMethodId(7), Implemented, read, write, Description("Return Battery=
 Temperature.")] void BatteryTemperature([in] uint32 arg2, [out] uint32 ar=
gr);
+   [WmiMethodId(8), Implemented, read, write, Description("Return Battery=
 Current.")] void BatteryCurrent([in] uint32 arg2, [out] uint32 argr);
+   [WmiMethodId(9), Implemented, read, write, Description("Return Battery=
 Voltage.")] void BatteryVoltage([in] uint32 arg2, [out] uint32 argr);
+   [WmiMethodId(10), Implemented, read, write, Description("Return Batter=
y Manufacture Access(MA code).")] void BatteryManufactureAceess([in] uint3=
2 arg2, [out] uint32 argr);
+   [WmiMethodId(11), Implemented, read, write, Description("Return Batter=
y Relative State-Of-Charge.")] void BatteryRelativeStateOfCharge([in] uint=
32 arg2, [out] uint32 argr);
+   [WmiMethodId(12), Implemented, read, write, Description("Return Batter=
y Cycle Count")] void BatteryCycleCount([in] uint32 arg2, [out] uint32 arg=
r);
+   [WmiMethodId(13), Implemented, read, write, Description("Return Batter=
y ePPID")] void BatteryePPID([in] uint32 arg2, [out] string argr);
+   [WmiMethodId(14), Implemented, read, write, Description("Return Batter=
y Raw Analytics Start")] void BatteryeRawAnalyticsStart([in] uint32 arg2, =
[out] uint32 argr);
+   [WmiMethodId(15), Implemented, read, write, Description("Return Batter=
y Raw Analytics")] void BatteryeRawAnalytics([in] uint32 arg2, [out] uint3=
2 RawSize, [out, WmiSizeIs("RawSize") : ToInstance] uint8 RawData[]);
+   [WmiMethodId(16), Implemented, read, write, Description("Return Batter=
y Design Voltage.")] void BatteryDesignVoltage([in] uint32 arg2, [out] uin=
t32 argr);
+   [WmiMethodId(17), Implemented, read, write, Description("Return Batter=
y Raw Analytics A Block")] void BatteryeRawAnalyticsABlock([in] uint32 arg=
2, [out] uint32 RawSize, [out, WmiSizeIs("RawSize") : ToInstance] uint8 Ra=
wData[]);
+   [WmiMethodId(18), Implemented, read, write, Description("Return Versio=
n.")] void ReturnVersion([in] uint32 arg2, [out] uint32 argr);
+   [WmiMethodId(32), Implemented, read, write, Description("Return Fan Se=
nsor Information")] void FanSensorInformation([in] uint32 arg2, [out] uint=
32 RawSize, [out, WmiSizeIs("RawSize") : ToInstance] uint8 RawData[]);
+   [WmiMethodId(34), Implemented, read, write, Description("Return Therma=
l Sensor Information")] void ThermalSensorInformation([in] uint32 arg2, [o=
ut] uint32 RawSize, [out, WmiSizeIs("RawSize") : ToInstance] uint8 RawData=
[]);
+ };
+
+Each WMI method takes an ACPI buffer containing a 32-bit index as input a=
rgument,
+with the first 8 bit being used to specify the battery when using battery=
-related
+WMI methods. Other WMI methods may ignore this argument or interpret it
+differently. The WMI method output format varies:
+
+* if the function has only a single output, then an ACPI object
+  of the corresponding type is returned
+* if the function has multiple outputs, when an ACPI package
+  containing the outputs in the same order is returned
+
+The format of the output should be thoroughly checked, since many methods=
 can
+return malformed data in case of an error.
+
+The data format of many battery-related methods seems to be based on the
+`Smart Battery Data Specification`, so unknown battery-related methods ar=
e
+likely to follow this standard in some way.
+
+WMI method GetBatteryDesignCapacity()
+-------------------------------------
+
+Returns the design capacity of the battery in mAh as an u16.
+
+WMI method BatteryFullCharge()
+------------------------------
+
+Returns the full charge capacity of the battery in mAh as an u16.
+
+WMI method BatteryManufactureName()
+-----------------------------------
+
+Returns the manufacture name of the battery as an ASCII string.
+
+WMI method BatteryManufactureDate()
+-----------------------------------
+
+Returns the manufacture date of the battery as an u16.
+The date is encoded in the following manner:
+
+- bits 0 to 4 contain the manufacture day.
+- bits 5 to 8 contain the manufacture month.
+- bits 9 to 15 contain the manufacture year biased by 1980.
+
+.. note::
+   The data format needs to be verified on more machines.
+
+WMI method BatterySerialNumber()
+--------------------------------
+
+Returns the serial number of the battery as an u16.
+
+WMI method BatteryChemistryValue()
+----------------------------------
+
+Returns the chemistry of the battery as an ASCII string.
+Known values are:
+
+- "Li-I" for Li-Ion
+
+WMI method BatteryTemperature()
+-------------------------------
+
+Returns the temperature of the battery in tenth degree kelvin as an u16.
+
+WMI method BatteryCurrent()
+---------------------------
+
+Returns the current flow of the battery in mA as an s16.
+Negative values indicate discharging.
+
+WMI method BatteryVoltage()
+---------------------------
+
+Returns the voltage flow of the battery in mV as an u16.
+
+WMI method BatteryManufactureAccess()
+-------------------------------------
+
+Returns a manufacture-defined value as an u16.
+
+WMI method BatteryRelativeStateOfCharge()
+-----------------------------------------
+
+Returns the capacity of the battery in percent as an u16.
+
+WMI method BatteryCycleCount()
+------------------------------
+
+Returns the cycle count of the battery as an u16.
+
+WMI method BatteryePPID()
+-------------------------
+
+Returns the ePPID of the battery as an ASCII string.
+
+WMI method BatteryeRawAnalyticsStart()
+--------------------------------------
+
+Performs an analysis of the battery and returns a status code:
+
+- ``0x0``: Success
+- ``0x1``: Interface not supported
+- ``0xfffffffe``: Error/Timeout
+
+.. note::
+   The meaning of this method is still largely unknown.
+
+WMI method BatteryeRawAnalytics()
+---------------------------------
+
+Returns a buffer usually containg 12 blocks of analytics data.
+Those blocks contain:
+- block number starting with 0 (u8)
+- 31 bytes of unknown data
+
+.. note::
+   The meaning of this method is still largely unknown.
+
+WMI method BatteryDesignVoltage()
+---------------------------------
+
+Returns the design voltage of the battery in mV as an u16.
+
+WMI method BatteryeRawAnalyticsABlock()
+---------------------------------------
+
+Returns a single block of analytics data, with the second byte
+of the index being used for selecting the block number.
+
+*Supported since WMI interface version 3!*
+
+.. note::
+   The meaning of this method is still largely unknown.
+
+WMI method ReturnVersion()
+--------------------------
+
+Returns the WMI interface version as an u32.
+
+WMI method FanSensorInformation()
+---------------------------------
+
+Returns a buffer containg fan sensor entries, terminated
+with a single ``0xff``.
+Those entries contain:
+
+- fan type (u8)
+- fan speed in RPM (little endian u16)
+
+WMI method ThermalSensorInformation()
+-------------------------------------
+
+Returns a buffer containing thermal sensor entries, terminated
+with a single ``0xff``.
+Those entries contain:
+
+- thermal type (u8)
+- current temperature (s8)
+- min. temperature (s8)
+- max. temperature (s8)
+- unknown field (u8)
+
+.. note::
+   Find out what the meaning of the last byte is.
+
+ACPI battery matching algorithm
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
+
+The algorithm used to match ACPI batteries to indices is based on informa=
tion
+which was found inside the logging messages of the OEM software.
+
+Basically for each new ACPI battery, the serial numbers of the batteries =
behind
+indices 1 till 3 are compared with the serial number of the ACPI battery.
+Since the serial number of the ACPI battery can either be encoded as a no=
rmal
+integer or as a hexadecimal value, both cases need to be checked. The fir=
st
+index with a matching serial number is then selected.
+
+A serial number of 0 indicates that the corresponding index is not associ=
ated
+with an actual battery, or that the associated battery is not present.
+
+Some machines like the Dell Inspiron 3505 only support a single battery a=
nd thus
+ignore the battery index. Because of this the driver depends on the ACPI =
battery
+hook mechanism to discover batteries.
+
+.. note::
+   The ACPI battery matching algorithm currently used inside the driver i=
s
+   outdated and does not match the algorithm described above. The reasons=
 for
+   this are differences in the handling of the ToHexString() ACPI opcode =
between
+   Linux and Windows, which distorts the serial number of ACPI batteries =
on many
+   machines. Until this issue is resolved, the driver cannot use the abov=
e
+   algorithm.
+
+Reverse-Engineering the DDV WMI interface
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+1. Find a supported Dell notebook, usually made after ~2020.
+2. Dump the ACPI tables and search for the WMI device (usually called "AD=
DV").
+3. Decode the corresponding bmof data and look at the ASL code.
+4. Try to deduce the meaning of a certain WMI method by comparing the con=
trol
+   flow with other ACPI methods (_BIX or _BIF for battery related methods
+   for example).
+5. Use the built-in UEFI diagostics to view sensor types/values for fan/t=
hermal
+   related methods (sometimes overwriting static ACPI data fields can be =
used
+   to test different sensor type values, since on some machines this data=
 is
+   not reinitialized upon a warm reset).
+
+Alternatively:
+
+1. Load the ``dell-wmi-ddv`` driver, use the ``force`` module param
+   if necessary.
+2. Use the debugfs interface to access the raw fan/thermal sensor buffer =
data.
+3. Compare the data with the built-in UEFI diagnostics.
+
+In case the DDV WMI interface version available on your Dell notebook is =
not
+supported or you are seeing unknown fan/thermal sensors, please submit a
+bugreport on `bugzilla <https://bugzilla.kernel.org>`_ so they can be add=
ed
+to the ``dell-wmi-ddv`` driver.
diff --git a/MAINTAINERS b/MAINTAINERS
index 4d5b1f6d77f6..66e4eabaf972 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5804,6 +5804,7 @@ M:	Armin Wolf <W_Armin@gmx.de>
 S:	Maintained
 F:	Documentation/ABI/testing/debugfs-dell-wmi-ddv
 F:	Documentation/ABI/testing/sysfs-platform-dell-wmi-ddv
+F:	Documentation/wmi/devices/dell-wmi-ddv.rst
 F:	drivers/platform/x86/dell/dell-wmi-ddv.c

 DELL WMI SYSMAN DRIVER
=2D-
2.30.2

