Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EB0615D9A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 09:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiKBIYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 04:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiKBIYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:24:19 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B691921804;
        Wed,  2 Nov 2022 01:24:17 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id p21so12010482plr.7;
        Wed, 02 Nov 2022 01:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3qcrKEGDyLpDf7q4E3q9Z/jt/4mPKl5O0OEp/Q/t0DI=;
        b=EC1ENipQ3SXX+JsQ63h/efqBYGgadaa6AD28R/0X8vcLnIdmANLmZPfBuDVg4qpdeP
         PX1Qhrid52glTAMYfLbUvRDr+sgEYiqNAC4E1QCspX+Jp428ZMT6/YMedJhBNQ2ay9E8
         azqX9cXi4GbqtkDWMjVs/o4i+2QAUzKTMLgxFvoE+Mpf534fQtjY/X9eV2VSQhmP4EsV
         Tgr8fEtCIRlXMcuDVCGVFXe4ZlFTvwynqFSdVJhgQNuQUfL1Dgy2QcauuP+lJtjfOy5Y
         WMfY+zthH8NCbrRD2RcqZdJHWG8Ea/r5N2oLqS6O8xTcLysYkp3HQLgKt+dgH8Cv70ic
         dqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qcrKEGDyLpDf7q4E3q9Z/jt/4mPKl5O0OEp/Q/t0DI=;
        b=jJYlzvhkK24fj/olZ8BWukAgVPcDWHE3ioPtAJcYkLzGqJ9PxEGOHYqUZ0GRzMPcDg
         bIs/i9V8rcUc/Lp+Oi2xR8liatOQ7dOS0895ZGAuhYz1nxoDx62VWnxy52OWEQ1/ASwU
         +AlXf/0hHdDoAi67hgBcMRcu8U5pyNFKztNCk355kYJ02YFYZcWTqG/MkujsxV2lXIEc
         RWB12WNValZhnC1+e9t3bQuhv96zSPVj1355LPuh2WpGp/Z9uXGj4O1DwSmeZI1eFlPg
         7+aIPk7jy3dDnLrO+qSl4VLkfjbo94nLIehXv9k7ZgbsWEy33YJx1YJTtbUj53RgECg6
         poTw==
X-Gm-Message-State: ACrzQf3MS54M1cX1nplUFWRHUTCaouwYllJ6NhEZLh0Zw8PA/wRnkl7B
        /LnaLydmJ3/FVuO1UTO9Gqw=
X-Google-Smtp-Source: AMsMyM6+zgCMoXzuHXA7hOnNKBLzC0ECexsJFwJaUEH7i6oeCi3tUn1Y59yF4X7Lln1p6xPj3M5suw==
X-Received: by 2002:a17:903:cd:b0:186:878e:3b08 with SMTP id x13-20020a17090300cd00b00186878e3b08mr23346141plc.93.1667377457157;
        Wed, 02 Nov 2022 01:24:17 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-55.three.co.id. [116.206.12.55])
        by smtp.gmail.com with ESMTPSA id k14-20020a170902d58e00b0017f59ebafe7sm7682220plh.212.2022.11.02.01.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 01:24:16 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 9226410415E; Wed,  2 Nov 2022 15:24:12 +0700 (WIB)
Date:   Wed, 2 Nov 2022 15:24:12 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Quan Nguyen <quan@os.amperecomputing.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Open Source Submission <patches@amperecomputing.com>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Phong Vo <phong@os.amperecomputing.com>,
        thang@os.amperecomputing.com, openbmc@lists.ozlabs.org
Subject: Re: [PATCH] docs: hwmon: (smpro-hwmon) Improve grammar and formatting
Message-ID: <Y2IpLCX8q2YdZ1ga@debian.me>
References: <20221102062103.3135417-1-quan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0eCsNjxAaGXgxyUG"
Content-Disposition: inline
In-Reply-To: <20221102062103.3135417-1-quan@os.amperecomputing.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0eCsNjxAaGXgxyUG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 02, 2022 at 01:21:03PM +0700, Quan Nguyen wrote:
> Improve documentation grammar and formatting for the
> Ampere(R)'s Altra(R) SMpro hwmon driver.
>=20
> Thanks Bagas for the changes in the link below.
>=20
> Link: https://lore.kernel.org/lkml/Y1aHiaZ1OpHZIzS9@google.com/T/#mfea216=
7b99384486a1b75d9304536015116c1821
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> ---
>  Documentation/hwmon/smpro-hwmon.rst | 111 ++++++++++++++--------------
>  1 file changed, 56 insertions(+), 55 deletions(-)
>=20
> diff --git a/Documentation/hwmon/smpro-hwmon.rst b/Documentation/hwmon/sm=
pro-hwmon.rst
> index 3a9b14dacf89..fb7b3665735b 100644
> --- a/Documentation/hwmon/smpro-hwmon.rst
> +++ b/Documentation/hwmon/smpro-hwmon.rst
> @@ -7,39 +7,39 @@ Supported chips:
> =20
>    * Ampere(R) Altra(R)
> =20
> -    Prefix: 'smpro'
> +    Prefix: ``smpro``
> =20
> -    Reference: Altra SoC BMC Interface Specification
> +    Reference: `Altra SoC BMC Interface Specification`
> =20
>  Author: Thu Nguyen <thu@os.amperecomputing.com>
> =20
>  Description
>  -----------
> -This driver supports hardware monitoring for Ampere(R) Altra(R) SoC's ba=
sed on the
> -SMpro co-processor (SMpro).
> -The following sensor types are supported by the driver:
> +The smpro-hwmon driver supports hardware monitoring for Ampere(R) Altra(=
R)
> +SoCs based on the SMpro co-processor (SMpro).  The following sensor metr=
ics
> +are supported by the driver:
> =20
>    * temperature
>    * voltage
>    * current
>    * power
> =20
> -The SMpro interface provides the registers to query the various sensors =
and
> +The interface provides the registers to query the various sensors and
>  their values which are then exported to userspace by this driver.
> =20
>  Usage Notes
>  -----------
> =20
> -SMpro hwmon driver creates at least two sysfs files for each sensor.
> +The driver creates at least two sysfs files for each sensor.
> =20
> -* File ``<sensor_type><idx>_label`` reports the sensor label.
> -* File ``<sensor_type><idx>_input`` returns the sensor value.
> +* ``<sensor_type><idx>_label`` reports the sensor label.
> +* ``<sensor_type><idx>_input`` returns the sensor value.
> =20
> -The sysfs files are allocated in the SMpro root fs folder.
> -There is one root folder for each SMpro instance.
> +The sysfs files are allocated in the SMpro rootfs folder, with one root
> +directory for each instance.
> =20
> -When the SoC is turned off, the driver will fail to read registers
> -and return -ENXIO.
> +When the SoC is turned off, the driver will fail to read registers and
> +return ``-ENXIO``.
> =20
>  Sysfs entries
>  -------------
> @@ -48,48 +48,49 @@ The following sysfs files are supported:
> =20
>  * Ampere(R) Altra(R):
> =20
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D   =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> -Name            Unit            Perm    Description
> -temp1_input     milli Celsius   RO      SoC temperature
> -temp2_input     milli Celsius   RO      Max temperature reported among S=
oC VRDs
> -temp2_crit      milli Celsius   RO      SoC VRD HOT Threshold temperature
> -temp3_input     milli Celsius   RO      Max temperature reported among D=
IMM VRDs
> -temp4_input     milli Celsius   RO      Max temperature reported among C=
ore VRDs
> -temp5_input     milli Celsius   RO      Temperature of DIMM0 on CH0
> -temp5_crit      milli Celsius   RO      MEM HOT Threshold for all DIMMs
> -temp6_input     milli Celsius   RO      Temperature of DIMM0 on CH1
> -temp6_crit      milli Celsius   RO      MEM HOT Threshold for all DIMMs
> -temp7_input     milli Celsius   RO      Temperature of DIMM0 on CH2
> -temp7_crit      milli Celsius   RO      MEM HOT Threshold for all DIMMs
> -temp8_input     milli Celsius   RO      Temperature of DIMM0 on CH3
> -temp8_crit      milli Celsius   RO      MEM HOT Threshold for all DIMMs
> -temp9_input     milli Celsius   RO      Temperature of DIMM0 on CH4
> -temp9_crit      milli Celsius   RO      MEM HOT Threshold for all DIMMs
> -temp10_input    milli Celsius   RO      Temperature of DIMM0 on CH5
> -temp10_crit     milli Celsius   RO      MEM HOT Threshold for all DIMMs
> -temp11_input    milli Celsius   RO      Temperature of DIMM0 on CH6
> -temp11_crit     milli Celsius   RO      MEM HOT Threshold for all DIMMs
> -temp12_input    milli Celsius   RO      Temperature of DIMM0 on CH7
> -temp12_crit     milli Celsius   RO      MEM HOT Threshold for all DIMMs
> -temp13_input    milli Celsius   RO      Max temperature reported among R=
CA VRDs
> -in0_input       milli Volts     RO      Core voltage
> -in1_input       milli Volts     RO      SoC voltage
> -in2_input       milli Volts     RO      DIMM VRD1 voltage
> -in3_input       milli Volts     RO      DIMM VRD2 voltage
> -in4_input       milli Volts     RO      RCA VRD voltage
> -cur1_input      milli Amperes   RO      Core VRD current
> -cur2_input      milli Amperes   RO      SoC VRD current
> -cur3_input      milli Amperes   RO      DIMM VRD1 current
> -cur4_input      milli Amperes   RO      DIMM VRD2 current
> -cur5_input      milli Amperes   RO      RCA VRD current
> -power1_input    micro Watts     RO      Core VRD power
> -power2_input    micro Watts     RO      SoC VRD power
> -power3_input    micro Watts     RO      DIMM VRD1 power
> -power4_input    micro Watts     RO      DIMM VRD2 power
> -power5_input    micro Watts     RO      RCA VRD power
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D   =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -Example::
> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +  Name            Unit           Perm    Description
> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +  temp1_input     millicelsius   RO      SoC temperature
> +  temp2_input     millicelsius   RO      Max temperature reported among =
SoC VRDs
> +  temp2_crit      millicelsius   RO      SoC VRD HOT Threshold temperatu=
re
> +  temp3_input     millicelsius   RO      Max temperature reported among =
DIMM VRDs
> +  temp4_input     millicelsius   RO      Max temperature reported among =
Core VRDs
> +  temp5_input     millicelsius   RO      Temperature of DIMM0 on CH0
> +  temp5_crit      millicelsius   RO      MEM HOT Threshold for all DIMMs
> +  temp6_input     millicelsius   RO      Temperature of DIMM0 on CH1
> +  temp6_crit      millicelsius   RO      MEM HOT Threshold for all DIMMs
> +  temp7_input     millicelsius   RO      Temperature of DIMM0 on CH2
> +  temp7_crit      millicelsius   RO      MEM HOT Threshold for all DIMMs
> +  temp8_input     millicelsius   RO      Temperature of DIMM0 on CH3
> +  temp8_crit      millicelsius   RO      MEM HOT Threshold for all DIMMs
> +  temp9_input     millicelsius   RO      Temperature of DIMM0 on CH4
> +  temp9_crit      millicelsius   RO      MEM HOT Threshold for all DIMMs
> +  temp10_input    millicelsius   RO      Temperature of DIMM0 on CH5
> +  temp10_crit     millicelsius   RO      MEM HOT Threshold for all DIMMs
> +  temp11_input    millicelsius   RO      Temperature of DIMM0 on CH6
> +  temp11_crit     millicelsius   RO      MEM HOT Threshold for all DIMMs
> +  temp12_input    millicelsius   RO      Temperature of DIMM0 on CH7
> +  temp12_crit     millicelsius   RO      MEM HOT Threshold for all DIMMs
> +  temp13_input    millicelsius   RO      Max temperature reported among =
RCA VRDs
> +  in0_input       millivolts     RO      Core voltage
> +  in1_input       millivolts     RO      SoC voltage
> +  in2_input       millivolts     RO      DIMM VRD1 voltage
> +  in3_input       millivolts     RO      DIMM VRD2 voltage
> +  in4_input       millivolts     RO      RCA VRD voltage
> +  cur1_input      milliamperes   RO      Core VRD current
> +  cur2_input      milliamperes   RO      SoC VRD current
> +  cur3_input      milliamperes   RO      DIMM VRD1 current
> +  cur4_input      milliamperes   RO      DIMM VRD2 current
> +  cur5_input      milliamperes   RO      RCA VRD current
> +  power1_input    microwatts     RO      Core VRD power
> +  power2_input    microwatts     RO      SoC VRD power
> +  power3_input    microwatts     RO      DIMM VRD1 power
> +  power4_input    microwatts     RO      DIMM VRD2 power
> +  power5_input    microwatts     RO      RCA VRD power
> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +  Example::
> =20
>      # cat in0_input
>      830

LGTM, thanks for picking this up.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--0eCsNjxAaGXgxyUG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY2IpJQAKCRD2uYlJVVFO
o8gLAP9kGFzFOEAUk6wdN1UEkPZDfWgdpqE2loJV9kw+9y3ZVQEAtA51q5/WW7RO
GpO23d72ZUpvB5t05nvAuUvzlZDIBQg=
=ITho
-----END PGP SIGNATURE-----

--0eCsNjxAaGXgxyUG--
