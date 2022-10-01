Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850995F1C42
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 14:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiJAM5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 08:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJAM5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 08:57:03 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53FAC42;
        Sat,  1 Oct 2022 05:57:01 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id g130so5900715pfb.8;
        Sat, 01 Oct 2022 05:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=xatWhQa95sEQO9lHaRBN6xgiRD2Ax+LJWAymSlu3FTI=;
        b=f90Cbc68SIIqA/cuWVfRsXTuaXeX3shlX5tOIMTNj3FX8Qbe0TOQGojKuJTxdVf9Y+
         L1zM7ob1s5uLVTBx3lGwXjnBKu/Lx0OOKjzwTL6QeMphqcFnjNGi46rH0QTNZ9taC5qB
         N+ZdAjIBIcd7ng3Op+mXY3FxSBxTC6ogbgdv2jCo6Gwc3VkwxmT15Z8mVPbA3eb3Y2LI
         qexqUXgu6jN19wFllni2LMsAPcXqBLxxgz0lZtAMGNnpMCAe9BS5F7zjCFfESapWxfWi
         99ANv2A8ApagUsVGGSnck8c6ym9O9sqCN8gRFX1QljmYaRqjUuSLI9TNne0BAgXsNv0j
         9Zuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=xatWhQa95sEQO9lHaRBN6xgiRD2Ax+LJWAymSlu3FTI=;
        b=SP+ZfN7wRPiVxfUnLeHT0CtRuzShslwP6Vy4Utr0/3MSLheXqSGM7IAReXV4COWC73
         PAeKHFycnFCap3n1Ld58x4t/1l5+lHNIvg/aEvOw1sWRyarbno9g+a0Q864TnYtwEimd
         mAoqZT/Jmczhb+OI9w3XwKmaFsuKIgKLSL1WXziGq6OugmKoQF7LLnFd7KJjbEiSxWT2
         85UTcTyxi2XtfD4IeiWIsQjH/Owf+Xb+t4JPvj9mhch5f9n/WagfS3HUGWoy0fwVN+NS
         JDOvV0U7MAg6QoXkS3pnMxn9lc4wZUpkMoS/HV5yl7c/N7sCZFsRFbANUeQuAuSAkVl+
         0upQ==
X-Gm-Message-State: ACrzQf1hLXDdPYnpx4frlyjxDp7yDYnSHvl2S0C4owQLYp/9jq3n3Rom
        7b7xMi7Qt9ozDw5O5dlVHsh4DT8elTcmjQ==
X-Google-Smtp-Source: AMsMyM7RNjg+R3+deXal5waqx+1MgTrOaPQCG2T1snqREO1uIQhuOc7EZq8q4vp/2QSN4axmpLA2SA==
X-Received: by 2002:a63:a61:0:b0:43c:9d3b:9c8f with SMTP id z33-20020a630a61000000b0043c9d3b9c8fmr11590165pgk.228.1664629021203;
        Sat, 01 Oct 2022 05:57:01 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-9.three.co.id. [180.214.232.9])
        by smtp.gmail.com with ESMTPSA id t126-20020a625f84000000b00540e1117c98sm3639598pfb.122.2022.10.01.05.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 05:57:00 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 2AEAD1039FA; Sat,  1 Oct 2022 19:56:57 +0700 (WIB)
Date:   Sat, 1 Oct 2022 19:56:56 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Quan Nguyen <quan@os.amperecomputing.com>
Cc:     macro@orcam.me.uk, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thu Nguyen <thu@os.amperecomputing.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        thang@os.amperecomputing.com
Subject: Re: [PATCH v9 2/9] docs: hwmon: (smpro-hwmon) Add documentation
Message-ID: <Yzg5GM97kM6/Hw82@debian.me>
References: <20220929094321.770125-1-quan@os.amperecomputing.com>
 <20220929094321.770125-3-quan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="75JGspy+0gCiqm39"
Content-Disposition: inline
In-Reply-To: <20220929094321.770125-3-quan@os.amperecomputing.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--75JGspy+0gCiqm39
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 29, 2022 at 04:43:14PM +0700, Quan Nguyen wrote:
> diff --git a/Documentation/hwmon/smpro-hwmon.rst b/Documentation/hwmon/sm=
pro-hwmon.rst
> new file mode 100644
> index 000000000000..3a9b14dacf89
> --- /dev/null
> +++ b/Documentation/hwmon/smpro-hwmon.rst
> @@ -0,0 +1,101 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +Kernel driver Ampere(R)'s Altra(R) SMpro hwmon
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Supported chips:
> +
> +  * Ampere(R) Altra(R)
> +
> +    Prefix: 'smpro'
> +
> +    Reference: Altra SoC BMC Interface Specification
> +
> +Author: Thu Nguyen <thu@os.amperecomputing.com>
> +
> +Description
> +-----------
> +This driver supports hardware monitoring for Ampere(R) Altra(R) SoC's ba=
sed on the
> +SMpro co-processor (SMpro).
> +The following sensor types are supported by the driver:
> +
> +  * temperature
> +  * voltage
> +  * current
> +  * power
> +
> +The SMpro interface provides the registers to query the various sensors =
and
> +their values which are then exported to userspace by this driver.
> +
> +Usage Notes
> +-----------
> +
> +SMpro hwmon driver creates at least two sysfs files for each sensor.
> +
> +* File ``<sensor_type><idx>_label`` reports the sensor label.
> +* File ``<sensor_type><idx>_input`` returns the sensor value.
> +
> +The sysfs files are allocated in the SMpro root fs folder.
> +There is one root folder for each SMpro instance.
> +
> +When the SoC is turned off, the driver will fail to read registers
> +and return -ENXIO.
> +
> +Sysfs entries
> +-------------
> +
> +The following sysfs files are supported:
> +
> +* Ampere(R) Altra(R):
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D   =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +Name            Unit            Perm    Description
> +temp1_input     milli Celsius   RO      SoC temperature
> +temp2_input     milli Celsius   RO      Max temperature reported among S=
oC VRDs
> +temp2_crit      milli Celsius   RO      SoC VRD HOT Threshold temperature
> +temp3_input     milli Celsius   RO      Max temperature reported among D=
IMM VRDs
> +temp4_input     milli Celsius   RO      Max temperature reported among C=
ore VRDs
> +temp5_input     milli Celsius   RO      Temperature of DIMM0 on CH0
> +temp5_crit      milli Celsius   RO      MEM HOT Threshold for all DIMMs
> +temp6_input     milli Celsius   RO      Temperature of DIMM0 on CH1
> +temp6_crit      milli Celsius   RO      MEM HOT Threshold for all DIMMs
> +temp7_input     milli Celsius   RO      Temperature of DIMM0 on CH2
> +temp7_crit      milli Celsius   RO      MEM HOT Threshold for all DIMMs
> +temp8_input     milli Celsius   RO      Temperature of DIMM0 on CH3
> +temp8_crit      milli Celsius   RO      MEM HOT Threshold for all DIMMs
> +temp9_input     milli Celsius   RO      Temperature of DIMM0 on CH4
> +temp9_crit      milli Celsius   RO      MEM HOT Threshold for all DIMMs
> +temp10_input    milli Celsius   RO      Temperature of DIMM0 on CH5
> +temp10_crit     milli Celsius   RO      MEM HOT Threshold for all DIMMs
> +temp11_input    milli Celsius   RO      Temperature of DIMM0 on CH6
> +temp11_crit     milli Celsius   RO      MEM HOT Threshold for all DIMMs
> +temp12_input    milli Celsius   RO      Temperature of DIMM0 on CH7
> +temp12_crit     milli Celsius   RO      MEM HOT Threshold for all DIMMs
> +temp13_input    milli Celsius   RO      Max temperature reported among R=
CA VRDs
> +in0_input       milli Volts     RO      Core voltage
> +in1_input       milli Volts     RO      SoC voltage
> +in2_input       milli Volts     RO      DIMM VRD1 voltage
> +in3_input       milli Volts     RO      DIMM VRD2 voltage
> +in4_input       milli Volts     RO      RCA VRD voltage
> +cur1_input      milli Amperes   RO      Core VRD current
> +cur2_input      milli Amperes   RO      SoC VRD current
> +cur3_input      milli Amperes   RO      DIMM VRD1 current
> +cur4_input      milli Amperes   RO      DIMM VRD2 current
> +cur5_input      milli Amperes   RO      RCA VRD current
> +power1_input    micro Watts     RO      Core VRD power
> +power2_input    micro Watts     RO      SoC VRD power
> +power3_input    micro Watts     RO      DIMM VRD1 power
> +power4_input    micro Watts     RO      DIMM VRD2 power
> +power5_input    micro Watts     RO      RCA VRD power
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D   =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Example::
> +
> +    # cat in0_input
> +    830
> +    # cat temp1_input
> +    37000
> +    # cat curr1_input
> +    9000
> +    # cat power5_input
> +    19500000
=20
The documentation above can be improved (both grammar and formatting):

---- >8 ----

diff --git a/Documentation/hwmon/smpro-hwmon.rst b/Documentation/hwmon/smpr=
o-hwmon.rst
index 3a9b14dacf8975..fb7b3665735bba 100644
--- a/Documentation/hwmon/smpro-hwmon.rst
+++ b/Documentation/hwmon/smpro-hwmon.rst
@@ -7,39 +7,39 @@ Supported chips:
=20
   * Ampere(R) Altra(R)
=20
-    Prefix: 'smpro'
+    Prefix: ``smpro``
=20
-    Reference: Altra SoC BMC Interface Specification
+    Reference: `Altra SoC BMC Interface Specification`
=20
 Author: Thu Nguyen <thu@os.amperecomputing.com>
=20
 Description
 -----------
-This driver supports hardware monitoring for Ampere(R) Altra(R) SoC's base=
d on the
-SMpro co-processor (SMpro).
-The following sensor types are supported by the driver:
+The smpro-hwmon driver supports hardware monitoring for Ampere(R) Altra(R)
+SoCs based on the SMpro co-processor (SMpro).  The following sensor metrics
+are supported by the driver:
=20
   * temperature
   * voltage
   * current
   * power
=20
-The SMpro interface provides the registers to query the various sensors and
+The interface provides the registers to query the various sensors and
 their values which are then exported to userspace by this driver.
=20
 Usage Notes
 -----------
=20
-SMpro hwmon driver creates at least two sysfs files for each sensor.
+The driver creates at least two sysfs files for each sensor.
=20
-* File ``<sensor_type><idx>_label`` reports the sensor label.
-* File ``<sensor_type><idx>_input`` returns the sensor value.
+* ``<sensor_type><idx>_label`` reports the sensor label.
+* ``<sensor_type><idx>_input`` returns the sensor value.
=20
-The sysfs files are allocated in the SMpro root fs folder.
-There is one root folder for each SMpro instance.
+The sysfs files are allocated in the SMpro rootfs folder, with one root
+directory for each instance.
=20
-When the SoC is turned off, the driver will fail to read registers
-and return -ENXIO.
+When the SoC is turned off, the driver will fail to read registers and
+return ``-ENXIO``.
=20
 Sysfs entries
 -------------
@@ -48,48 +48,49 @@ The following sysfs files are supported:
=20
 * Ampere(R) Altra(R):
=20
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D   =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
-Name            Unit            Perm    Description
-temp1_input     milli Celsius   RO      SoC temperature
-temp2_input     milli Celsius   RO      Max temperature reported among SoC=
 VRDs
-temp2_crit      milli Celsius   RO      SoC VRD HOT Threshold temperature
-temp3_input     milli Celsius   RO      Max temperature reported among DIM=
M VRDs
-temp4_input     milli Celsius   RO      Max temperature reported among Cor=
e VRDs
-temp5_input     milli Celsius   RO      Temperature of DIMM0 on CH0
-temp5_crit      milli Celsius   RO      MEM HOT Threshold for all DIMMs
-temp6_input     milli Celsius   RO      Temperature of DIMM0 on CH1
-temp6_crit      milli Celsius   RO      MEM HOT Threshold for all DIMMs
-temp7_input     milli Celsius   RO      Temperature of DIMM0 on CH2
-temp7_crit      milli Celsius   RO      MEM HOT Threshold for all DIMMs
-temp8_input     milli Celsius   RO      Temperature of DIMM0 on CH3
-temp8_crit      milli Celsius   RO      MEM HOT Threshold for all DIMMs
-temp9_input     milli Celsius   RO      Temperature of DIMM0 on CH4
-temp9_crit      milli Celsius   RO      MEM HOT Threshold for all DIMMs
-temp10_input    milli Celsius   RO      Temperature of DIMM0 on CH5
-temp10_crit     milli Celsius   RO      MEM HOT Threshold for all DIMMs
-temp11_input    milli Celsius   RO      Temperature of DIMM0 on CH6
-temp11_crit     milli Celsius   RO      MEM HOT Threshold for all DIMMs
-temp12_input    milli Celsius   RO      Temperature of DIMM0 on CH7
-temp12_crit     milli Celsius   RO      MEM HOT Threshold for all DIMMs
-temp13_input    milli Celsius   RO      Max temperature reported among RCA=
 VRDs
-in0_input       milli Volts     RO      Core voltage
-in1_input       milli Volts     RO      SoC voltage
-in2_input       milli Volts     RO      DIMM VRD1 voltage
-in3_input       milli Volts     RO      DIMM VRD2 voltage
-in4_input       milli Volts     RO      RCA VRD voltage
-cur1_input      milli Amperes   RO      Core VRD current
-cur2_input      milli Amperes   RO      SoC VRD current
-cur3_input      milli Amperes   RO      DIMM VRD1 current
-cur4_input      milli Amperes   RO      DIMM VRD2 current
-cur5_input      milli Amperes   RO      RCA VRD current
-power1_input    micro Watts     RO      Core VRD power
-power2_input    micro Watts     RO      SoC VRD power
-power3_input    micro Watts     RO      DIMM VRD1 power
-power4_input    micro Watts     RO      DIMM VRD2 power
-power5_input    micro Watts     RO      RCA VRD power
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D   =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
+  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
+  Name            Unit           Perm    Description
+  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
+  temp1_input     millicelsius   RO      SoC temperature
+  temp2_input     millicelsius   RO      Max temperature reported among So=
C VRDs
+  temp2_crit      millicelsius   RO      SoC VRD HOT Threshold temperature
+  temp3_input     millicelsius   RO      Max temperature reported among DI=
MM VRDs
+  temp4_input     millicelsius   RO      Max temperature reported among Co=
re VRDs
+  temp5_input     millicelsius   RO      Temperature of DIMM0 on CH0
+  temp5_crit      millicelsius   RO      MEM HOT Threshold for all DIMMs
+  temp6_input     millicelsius   RO      Temperature of DIMM0 on CH1
+  temp6_crit      millicelsius   RO      MEM HOT Threshold for all DIMMs
+  temp7_input     millicelsius   RO      Temperature of DIMM0 on CH2
+  temp7_crit      millicelsius   RO      MEM HOT Threshold for all DIMMs
+  temp8_input     millicelsius   RO      Temperature of DIMM0 on CH3
+  temp8_crit      millicelsius   RO      MEM HOT Threshold for all DIMMs
+  temp9_input     millicelsius   RO      Temperature of DIMM0 on CH4
+  temp9_crit      millicelsius   RO      MEM HOT Threshold for all DIMMs
+  temp10_input    millicelsius   RO      Temperature of DIMM0 on CH5
+  temp10_crit     millicelsius   RO      MEM HOT Threshold for all DIMMs
+  temp11_input    millicelsius   RO      Temperature of DIMM0 on CH6
+  temp11_crit     millicelsius   RO      MEM HOT Threshold for all DIMMs
+  temp12_input    millicelsius   RO      Temperature of DIMM0 on CH7
+  temp12_crit     millicelsius   RO      MEM HOT Threshold for all DIMMs
+  temp13_input    millicelsius   RO      Max temperature reported among RC=
A VRDs
+  in0_input       millivolts     RO      Core voltage
+  in1_input       millivolts     RO      SoC voltage
+  in2_input       millivolts     RO      DIMM VRD1 voltage
+  in3_input       millivolts     RO      DIMM VRD2 voltage
+  in4_input       millivolts     RO      RCA VRD voltage
+  cur1_input      milliamperes   RO      Core VRD current
+  cur2_input      milliamperes   RO      SoC VRD current
+  cur3_input      milliamperes   RO      DIMM VRD1 current
+  cur4_input      milliamperes   RO      DIMM VRD2 current
+  cur5_input      milliamperes   RO      RCA VRD current
+  power1_input    microwatts     RO      Core VRD power
+  power2_input    microwatts     RO      SoC VRD power
+  power3_input    microwatts     RO      DIMM VRD1 power
+  power4_input    microwatts     RO      DIMM VRD2 power
+  power5_input    microwatts     RO      RCA VRD power
+  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
=20
-Example::
+  Example::
=20
     # cat in0_input
     830

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--75JGspy+0gCiqm39
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYzg5EwAKCRD2uYlJVVFO
o5dfAP96/iL331XtGwg9sJvCVECx5KZKRZ6Naxp3gwt5uSvvngD9Eh+gCcwfjayp
8RYXNCo9Nd8HQHoZErC6CABhOYt1KAU=
=9E6T
-----END PGP SIGNATURE-----

--75JGspy+0gCiqm39--
