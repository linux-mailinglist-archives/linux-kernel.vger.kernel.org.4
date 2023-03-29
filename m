Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F366CD5FD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjC2JJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjC2JJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:09:44 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC521FCC;
        Wed, 29 Mar 2023 02:09:42 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id kc4so14281097plb.10;
        Wed, 29 Mar 2023 02:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680080981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WX0Lf5LGFdqWbC/ra4jNX89UpPA5rFly0rlv9bpAKjA=;
        b=XQ5HcOldITya5MZELl8ZXCK/dvsBWRo1s2CYeDEpqxEFZk/ajpMDdNQK9euhc4Crp5
         fB/iqXrHbHxYy1IDwXA8gUzqXcaPNid5oKfhC6/XkQr5bYgN0I5VvhcNZjQ6R/CR+TPP
         9VMBiYgudoCfhCeIQH/0QxUuPnhmc3X7Y90gzOcTRUjoErXnfzXAKJN1Tbpz1o2OTNEz
         PNrcEZ9e6hU5F8RjKFdByZ/FS8USB5LestYgsvxKEfAKqVmhWwYGXDtqWXAqyoABU1ry
         ZGTX5EvccOp0IqmXV89Fxba2/PgFp1VkHda+uGcOkVgXBMH97VUhLENKzuNSfJBcvQNf
         uTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680080981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WX0Lf5LGFdqWbC/ra4jNX89UpPA5rFly0rlv9bpAKjA=;
        b=7PeheZfQX25OptcGbHFJHs2Fb8Nc3bHtrETtRn/E9sE4Yj9QuxPiYSOcnRvOg/8EUT
         RdDgxbagN019npKdVAYqx8arfgesdwg7rRO+GgYufI6TSSpi/oA7x391QdQoHIQbq0fd
         FxLJOXahHNn3SxY3sgfagp/JUOhJw4NV30zCKt5HzS5TsVExn7PULBQoRTaX9UhJ+fpP
         elEv7IoZ7aTyJnmuxZYA0urMRN8BKs9eb51InW2pJv6oad2mBDyMShKDZzcxdsI8xGun
         Sn+ILc3jnpat2nrq6tsMoEiMhiSf6wa1U1PjYVbbUWfTn8B/LZLO/qsA+kyAYNn7jkjJ
         CjNg==
X-Gm-Message-State: AAQBX9deBsJGFsrravzCJH3WG5/CVipokrP1pX/xtIHopYOFVsDdx8Zh
        9uSLA8lJm2WNGNFEPb0llQU=
X-Google-Smtp-Source: AKy350bmUGQ9il6UtZ8dv5/gettbZTwcb0+UsBF45V94ajvfEsCmSOPss2tr31dDaV/HttV/WG5HZg==
X-Received: by 2002:a17:90a:4bca:b0:234:b4a7:2abd with SMTP id u10-20020a17090a4bca00b00234b4a72abdmr22031800pjl.12.1680080981371;
        Wed, 29 Mar 2023 02:09:41 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-15.three.co.id. [116.206.28.15])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902ee5500b0019aafc422fcsm22482389plo.240.2023.03.29.02.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 02:09:41 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 2B9EA1064B9; Wed, 29 Mar 2023 16:09:38 +0700 (WIB)
Date:   Wed, 29 Mar 2023 16:09:38 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jeffrey Kardatzke <jkardatzke@chromium.org>,
        op-tee@lists.trustedfirmware.org
Cc:     Jeffrey Kardatzke <jkardatzke@google.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12] tee: optee: Add SMC for loading OP-TEE image
Message-ID: <ZCQAUukSQlwXLRfP@debian.me>
References: <20230327093538.v12.1.I8e7f9b01d9ac940507d78e15368e200a6a69bedb@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MxOSWRWz2X7VZ/Ep"
Content-Disposition: inline
In-Reply-To: <20230327093538.v12.1.I8e7f9b01d9ac940507d78e15368e200a6a69bedb@changeid>
X-Spam-Status: No, score=1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MxOSWRWz2X7VZ/Ep
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 27, 2023 at 09:35:53AM -0700, Jeffrey Kardatzke wrote:
> Adds an SMC call that will pass an OP-TEE binary image to EL3 and
> instruct it to load it as the BL32 payload. This works in conjunction
> with a feature added to Trusted Firmware for ARMv8 and above
> architectures that supports this.
>=20
> The main purpose of this change is to facilitate updating the OP-TEE
> component on devices via a rootfs change rather than having to do a
> firmware update. Further details are linked to in the Kconfig file.
>=20
> Signed-off-by: Jeffrey Kardatzke <jkardatzke@chromium.org>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Jeffrey Kardatzke <jkardatzke@google.com>
> ---
>=20
> Changes in v12:
> - Fixed checkpatch strict issues
>=20
> Changes in v11:
> - Fixed typo in tee.rst documentation
>=20
> Changes in v10:
> - Fixed tee.rst documentation formatting
>=20
> Changes in v9:
> - Add CPU hotplug callback to init on all cores at startup
>=20
> Changes in v8:
> - Renamed params and fixed alignment issue
>=20
> Changes in v7:
> - Added documentation to Documentation/staging/tee.rst
>=20
> Changes in v6:
> - Expanded Kconfig documentation
>=20
> Changes in v5:
> - Renamed config option
> - Added runtime warning when config is used
>=20
> Changes in v4:
> - Update commit message
> - Added more documentation
> - Renamed config option, added ARM64 dependency
>=20
> Changes in v3:
> - Removed state tracking for driver reload
> - Check UID of service to verify it needs image load
>=20
> Changes in v2:
> - Fixed compile issue when feature is disabled
> - Addressed minor comments
> - Added state tracking for driver reload
>=20
>  Documentation/staging/tee.rst |  41 ++++++++++
>  drivers/tee/optee/Kconfig     |  17 +++++
>  drivers/tee/optee/optee_msg.h |  12 +++
>  drivers/tee/optee/optee_smc.h |  24 ++++++
>  drivers/tee/optee/smc_abi.c   | 137 ++++++++++++++++++++++++++++++++++
>  5 files changed, 231 insertions(+)
>=20
> diff --git a/Documentation/staging/tee.rst b/Documentation/staging/tee.rst
> index 498343c7ab08..b11e9053bc99 100644
> --- a/Documentation/staging/tee.rst
> +++ b/Documentation/staging/tee.rst
> @@ -214,6 +214,47 @@ call is done from the thread assisting the interrupt=
 handler. This is a
>  building block for OP-TEE OS in secure world to implement the top half a=
nd
>  bottom half style of device drivers.
> =20
> +OPTEE_INSECURE_LOAD_IMAGE Kconfig option
> +----------------------------------------
> +
> +The OPTEE_INSECURE_LOAD_IMAGE Kconfig option enables the ability to load=
 the
> +BL32 OP-TEE image from the kernel after the kernel boots, rather than lo=
ading
> +it from the firmware before the kernel boots. This also requires enablin=
g the
> +corresponding option in Trusted Firmware for Arm. The documentation there
> +explains the security threat associated with enabling this as well as
> +mitigations at the firmware and platform level.
> +https://trustedfirmware-a.readthedocs.io/en/latest/threat_model/threat_m=
odel.html

For consistency to the rest of doc, the reference link should be put
separately in "References" section:

---- >8 ----
diff --git a/Documentation/staging/tee.rst b/Documentation/staging/tee.rst
index b11e9053bc9934..97758855156aa6 100644
--- a/Documentation/staging/tee.rst
+++ b/Documentation/staging/tee.rst
@@ -220,10 +220,9 @@ OPTEE_INSECURE_LOAD_IMAGE Kconfig option
 The OPTEE_INSECURE_LOAD_IMAGE Kconfig option enables the ability to load t=
he
 BL32 OP-TEE image from the kernel after the kernel boots, rather than load=
ing
 it from the firmware before the kernel boots. This also requires enabling =
the
-corresponding option in Trusted Firmware for Arm. The documentation there
-explains the security threat associated with enabling this as well as
-mitigations at the firmware and platform level.
-https://trustedfirmware-a.readthedocs.io/en/latest/threat_model/threat_mod=
el.html
+corresponding option in Trusted Firmware for Arm. The Trusted Firmare
+documentation [8] explains the security threat associated with enabling th=
is as
+well as mitigations at the firmware and platform level.
=20
 There are additional attack vectors/mitigations for the kernel that should=
 be
 addressed when using this option.
@@ -350,3 +349,5 @@ References
 [6] include/linux/psp-tee.h
=20
 [7] drivers/tee/amdtee/amdtee_if.h
+
+[8] https://trustedfirmware-a.readthedocs.io/en/latest/threat_model/threat=
_model.html

> +
> +There are additional attack vectors/mitigations for the kernel that shou=
ld be
> +addressed when using this option.
> +
> +1. Boot chain security.
> +   Attack vector: Replace the OP-TEE OS image in the rootfs to gain cont=
rol of
> +   the system.
> +   Mitigation: There must be boot chain security that verifies the kerne=
l and
> +   rootfs, otherwise an attacker can modify the loaded OP-TEE binary by
> +   modifying it in the rootfs.
> +2. Alternate boot modes.
> +   Attack vector: Using an alternate boot mode (i.e. recovery mode), the=
 OP-TEE
> +   driver isn't loaded, leaving the SMC hole open.
> +   Mitigation: If there are alternate methods of booting the device, suc=
h as a
> +   recovery mode, it should be ensured that the same mitigations are app=
lied in
> +   that mode.
> +3. Attacks prior to SMC invocation.
> +   Attack vector: Code that is executed prior to issuing the SMC call to=
 load
> +   OP-TEE can be exploited to then load an alternate OS image.
> +   Mitigation: The OP-TEE driver must be loaded before any potential att=
ack
> +   vectors are opened up. This should include mounting of any modifiable
> +   filesystems, opening of network ports or communicating with external =
devices
> +   (e.g. USB).
> +4. Blocking SMC call to load OP-TEE.
> +   Attack vector: Prevent the driver from being probed, so the SMC call =
to load
> +   OP-TEE isn't executed when desired, leaving it open to being executed=
 later
> +   and loading a modified OS.
> +   Mitigation: It is recommended to build the OP-TEE driver as an includ=
ed
> +   driver rather than a module to prevent exploits that may cause the mo=
dule to
> +   not be loaded.
> +

I think attack vectors and mitigations can be sub bullets:

---- >8 ----
diff --git a/Documentation/staging/tee.rst b/Documentation/staging/tee.rst
index 97758855156aa6..b17eb9772230db 100644
--- a/Documentation/staging/tee.rst
+++ b/Documentation/staging/tee.rst
@@ -228,31 +228,41 @@ There are additional attack vectors/mitigations for t=
he kernel that should be
 addressed when using this option.
=20
 1. Boot chain security.
-   Attack vector: Replace the OP-TEE OS image in the rootfs to gain contro=
l of
-   the system.
-   Mitigation: There must be boot chain security that verifies the kernel =
and
-   rootfs, otherwise an attacker can modify the loaded OP-TEE binary by
-   modifying it in the rootfs.
+
+   * Attack vector: Replace the OP-TEE OS image in the rootfs to gain cont=
rol of
+     the system.
+
+   * Mitigation: There must be boot chain security that verifies the kerne=
l and
+     rootfs, otherwise an attacker can modify the loaded OP-TEE binary by
+     modifying it in the rootfs.
 2. Alternate boot modes.
-   Attack vector: Using an alternate boot mode (i.e. recovery mode), the O=
P-TEE
-   driver isn't loaded, leaving the SMC hole open.
-   Mitigation: If there are alternate methods of booting the device, such =
as a
-   recovery mode, it should be ensured that the same mitigations are appli=
ed in
-   that mode.
+
+   * Attack vector: Using an alternate boot mode (i.e. recovery mode), the
+     OP-TEE driver isn't loaded, leaving the SMC hole open.
+
+   * Mitigation: If there are alternate methods of booting the device, suc=
h as
+     a recovery mode, it should be ensured that the same mitigations are
+     applied in that mode.
+
 3. Attacks prior to SMC invocation.
-   Attack vector: Code that is executed prior to issuing the SMC call to l=
oad
-   OP-TEE can be exploited to then load an alternate OS image.
-   Mitigation: The OP-TEE driver must be loaded before any potential attack
-   vectors are opened up. This should include mounting of any modifiable
-   filesystems, opening of network ports or communicating with external de=
vices
-   (e.g. USB).
+
+   * Attack vector: Code that is executed prior to issuing the SMC call to=
 load
+     OP-TEE can be exploited to then load an alternate OS image.
+
+   * Mitigation: The OP-TEE driver must be loaded before any potential att=
ack
+     vectors are opened up. This should include mounting of any modifiable
+     filesystems, opening of network ports or communicating with external
+     devices (e.g. USB).
+
 4. Blocking SMC call to load OP-TEE.
-   Attack vector: Prevent the driver from being probed, so the SMC call to=
 load
-   OP-TEE isn't executed when desired, leaving it open to being executed l=
ater
-   and loading a modified OS.
-   Mitigation: It is recommended to build the OP-TEE driver as an included
-   driver rather than a module to prevent exploits that may cause the modu=
le to
-   not be loaded.
+
+   * Attack vector: Prevent the driver from being probed, so the SMC call =
to
+     load OP-TEE isn't executed when desired, leaving it open to being exe=
cuted
+     later and loading a modified OS.
+
+   * Mitigation: It is recommended to build the OP-TEE driver as builtin
+     driver rather than as a module to prevent exploits that may cause the
+     module to not be loaded.
=20
 AMD-TEE driver
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Or due to tabular nature of additional attacks list above, reST tables
should fit.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--MxOSWRWz2X7VZ/Ep
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZCQATgAKCRD2uYlJVVFO
o41aAQCAs2tatAtShAXDFJ3K+G5VE/mgoIg0QjBX/MAZFy7fgAD/cl+sFphWGzsO
YokNGRdF5yiATUz4Fx+EgIvaq7OHqgw=
=IlQx
-----END PGP SIGNATURE-----

--MxOSWRWz2X7VZ/Ep--
