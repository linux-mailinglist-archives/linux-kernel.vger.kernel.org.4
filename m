Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4066281B9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 14:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbiKNN5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 08:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiKNN5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:57:34 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CB425E81;
        Mon, 14 Nov 2022 05:57:33 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id h193so10287864pgc.10;
        Mon, 14 Nov 2022 05:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8MC3h3qKaAq/POnx65xnRJ3C4NU/+8KjvTe7E05rjRU=;
        b=UHnHc6SNEKeAoxVofC95gqomBI8THBwyUZaxrtaJ7vtzBNyJZCaP/rJd1gemcrs+bX
         1Rx/j7wYW4hFH9SrofOJS4Un2ZqfmmPP2c370T/zhmystqj3VPKQPtqGBKTd8VsEBqzO
         6UZSpBFEU42oFz+rCUxKCEtyVKFn5lk5Ox9MXGi71tKv+g8jEARCUHcsgRrIF+aoX/tk
         Gmc96awJeQ+w3/i5fqXL/t4061UivqhfZUDqlnIYUskZt24+UKXqNyNS/aQ3jWU2kSgD
         ol+x6Ho3RXm1+AaenYR3aKen6xItOgW8ersfvjEccPS3ujQs2YtInUvmXYLUnhDMxurr
         ZABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MC3h3qKaAq/POnx65xnRJ3C4NU/+8KjvTe7E05rjRU=;
        b=i0wVtmYS+is9bDhH95FsainJ3/Aj890uAyhU35uaU6QJjzqVQgFTcRFzLFJ492XJgM
         plk0i2t/+dbUu4U2oqjwmsaCXuxAzzelkntqAwFcMxjnMs7XzeqNIJQNXqGl0bCdWoRR
         Mcugl+dcIKiGnrjDS3QHldxRRn2l0YkhbfIr70d6Y488zr3EYWIUjFRYbDJwreZdaTrU
         nKQ9h1UqFracS7VRJbNSvZxeXLPxkVqWAmHx7PvGdPvDhtbE55aYhDWeluIz/cl9m7ZA
         AbpVaQcEkARql0bXwD2+z0SvlvZvkBIRzbYU2lDxkgwwlxERaqHIDSAdrrRMdcTxE5IK
         E+fw==
X-Gm-Message-State: ANoB5pl1mb4DRKZMOROgw96SC0nbu3ck1yrME666egLRU72YxrsVZjvU
        N0FEUQpy50iDXnNbTw0Pdnc=
X-Google-Smtp-Source: AA0mqf7scsGfCFUG7z2vXhK08/UVTuUCikOxvkq4nKtJtqN0mEbylzyx0c4URy3Xe1lzIvuCleSO3A==
X-Received: by 2002:a63:d0b:0:b0:438:a750:99b7 with SMTP id c11-20020a630d0b000000b00438a75099b7mr11652778pgl.605.1668434252783;
        Mon, 14 Nov 2022 05:57:32 -0800 (PST)
Received: from debian.me (subs02-180-214-232-86.three.co.id. [180.214.232.86])
        by smtp.gmail.com with ESMTPSA id i7-20020a170902c94700b00186dcc37e17sm7510781pla.210.2022.11.14.05.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 05:57:32 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 5F833103ED3; Mon, 14 Nov 2022 20:57:29 +0700 (WIB)
Date:   Mon, 14 Nov 2022 20:57:29 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Junhao He <hejunhao3@huawei.com>
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org,
        jonathan.cameron@huawei.com, john.garry@huawei.com,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        lpieralisi@kernel.org, linuxarm@huawei.com, yangyicong@huawei.com,
        liuqi115@huawei.com, f.fangjian@huawei.com,
        prime.zeng@hisilicon.com
Subject: Re: [PATCH v13 2/2] Documentation: Add document for UltraSoc SMB
 drivers
Message-ID: <Y3JJSfVoatl5yKlm@debian.me>
References: <20221114090316.63157-1-hejunhao3@huawei.com>
 <20221114090316.63157-3-hejunhao3@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EIcrB5LfjrdPKhUG"
Content-Disposition: inline
In-Reply-To: <20221114090316.63157-3-hejunhao3@huawei.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EIcrB5LfjrdPKhUG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 14, 2022 at 05:03:16PM +0800, Junhao He wrote:
> diff --git a/Documentation/trace/coresight/ultrasoc-smb.rst b/Documentati=
on/trace/coresight/ultrasoc-smb.rst
> new file mode 100644
> index 000000000000..b7fe3f5c7f53
> --- /dev/null
> +++ b/Documentation/trace/coresight/ultrasoc-smb.rst
> @@ -0,0 +1,82 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +UltraSoc - HW Assisted Tracing on SoC
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +   :Author:   Qi Liu <liuqi115@huawei.com>
> +   :Date:     March 2022
> +
> +Introduction
> +------------
> +
> +UltraSoc SMB is a per SCCL(Super CPU Cluster) hardware, and it provides a
> +way to buffer and store CPU trace messages in a region of shared system
> +memory. SMB is plugged as a coresight sink device and the corresponding
> +trace generators (ETM) are plugged in as source devices.
> +
> +Sysfs files and directories
> +---------------------------
> +
> +The SMB devices appear on the existing coresight bus alongside the other
> +coresight devices::
> +
> +	$# ls /sys/bus/coresight/devices/
> +	ultra_smb0   ultra_smb1   ultra_smb2   ultra_smb3
> +
> +The ``ultra_smb<N>`` named SMB associated with SCCL.::
> +
> +	$# ls /sys/bus/coresight/devices/ultra_smb0
> +	enable_sink   mgmt
> +	$# ls /sys/bus/coresight/devices/ultra_smb0/mgmt
> +	buf_size  buf_status  read_pos  write_pos
> +
> +*Key file items are:-*
> +   * ``read_pos``: Shows the value held by UltraSoc SMB Read Pointer reg=
ister.
> +   * ``write_pos``: Shows the value held by UltraSoc SMB Write Pointer r=
egister.
> +   * ``buf_status``: Shows the value held by UltraSoc SMB status registe=
r.
> +		     BIT(0) is zero means buffer is empty.
> +   * ``buf_size``: Shows the buffer size of each UltraSoc SMB device.

The key list above doesn't look right, so I have applied the fixup:

---- >8 ----

diff --git a/Documentation/trace/coresight/ultrasoc-smb.rst b/Documentation=
/trace/coresight/ultrasoc-smb.rst
index b7fe3f5c7f53f7..5d0fa1a76b04d1 100644
--- a/Documentation/trace/coresight/ultrasoc-smb.rst
+++ b/Documentation/trace/coresight/ultrasoc-smb.rst
@@ -30,11 +30,12 @@ The ``ultra_smb<N>`` named SMB associated with SCCL.::
 	$# ls /sys/bus/coresight/devices/ultra_smb0/mgmt
 	buf_size  buf_status  read_pos  write_pos
=20
-*Key file items are:-*
+Key file items are:
+
    * ``read_pos``: Shows the value held by UltraSoc SMB Read Pointer regis=
ter.
    * ``write_pos``: Shows the value held by UltraSoc SMB Write Pointer reg=
ister.
    * ``buf_status``: Shows the value held by UltraSoc SMB status register.
-		     BIT(0) is zero means buffer is empty.
+     BIT(0) is zero means buffer is empty.
    * ``buf_size``: Shows the buffer size of each UltraSoc SMB device.
=20
 Firmware Bindings

> +
> +Firmware Bindings
> +---------------------------
> +
> +SMB device is only supported with ACPI, and ACPI binding of SMB device
> +describes SMB device indentifier, resource information and graph structu=
re.
> +
> +SMB is identified by ACPI HID "HISI03A1", resource of device is declared=
 using
> +the _CRS method. Each SMB must present two base address, the first one i=
s the
> +configuration base address of SMB device, the second one is the 32bits b=
ase
> +address of shared system memory.
> +
> +examples::
> +
> +    Device(USMB) {                                               \
> +      Name(_HID, "HISI03A1")                                     \
> +      Name(_CRS, ResourceTemplate() {                            \
> +          QWordMemory (ResourceConsumer, , MinFixed, MaxFixed, NonCachea=
ble, \
> +		       ReadWrite, 0x0, 0x95100000, 0x951FFFFF, 0x0, 0x100000) \
> +          QWordMemory (ResourceConsumer, , MinFixed, MaxFixed, Cacheable=
, \
> +		       ReadWrite, 0x0, 0x50000000, 0x53FFFFFF, 0x0, 0x4000000) \
> +      })                                                         \
> +      Name(_DSD, Package() {                                     \
> +        ToUUID("ab02a46b-74c7-45a2-bd68-f7d344ef2153"),          \
> +	/* Use CoreSight Graph ACPI bindings to describe connections topology */
> +        Package() {                                              \
> +          0,                                                     \
> +          1,                                                     \
> +          Package() {                                            \
> +            1,                                                   \
> +            ToUUID("3ecbc8b6-1d0e-4fb3-8107-e627f805c6cd"),      \
> +            8,                                                   \
> +            Package() {0x8, 0, \_SB.S00.SL11.CL28.F008, 0},       \
> +            Package() {0x9, 0, \_SB.S00.SL11.CL29.F009, 0},       \
> +            Package() {0xa, 0, \_SB.S00.SL11.CL2A.F010, 0},       \
> +            Package() {0xb, 0, \_SB.S00.SL11.CL2B.F011, 0},       \
> +            Package() {0xc, 0, \_SB.S00.SL11.CL2C.F012, 0},       \
> +            Package() {0xd, 0, \_SB.S00.SL11.CL2D.F013, 0},       \
> +            Package() {0xe, 0, \_SB.S00.SL11.CL2E.F014, 0},       \
> +            Package() {0xf, 0, \_SB.S00.SL11.CL2F.F015, 0},       \
> +          }                                                      \
> +        }                                                        \
> +      })                                                         \
> +    }

The rest of wordings also read a rather weird. What about below instead?

---- >8 ----=20

diff --git a/Documentation/trace/coresight/ultrasoc-smb.rst b/Documentation=
/trace/coresight/ultrasoc-smb.rst
index 5d0fa1a76b04d1..eee32cbf90d2ea 100644
--- a/Documentation/trace/coresight/ultrasoc-smb.rst
+++ b/Documentation/trace/coresight/ultrasoc-smb.rst
@@ -9,21 +9,21 @@ UltraSoc - HW Assisted Tracing on SoC
 Introduction
 ------------
=20
-UltraSoc SMB is a per SCCL(Super CPU Cluster) hardware, and it provides a
+UltraSoc SMB is a per SCCL (Super CPU Cluster) hardware. It provides a
 way to buffer and store CPU trace messages in a region of shared system
-memory. SMB is plugged as a coresight sink device and the corresponding
-trace generators (ETM) are plugged in as source devices.
+memory. The device acts as a coresight sink device and the
+corresponding trace generators (ETM) are attached as source devices.
=20
 Sysfs files and directories
 ---------------------------
=20
-The SMB devices appear on the existing coresight bus alongside the other
-coresight devices::
+The SMB devices appear on the existing coresight bus alongside other
+devices::
=20
 	$# ls /sys/bus/coresight/devices/
 	ultra_smb0   ultra_smb1   ultra_smb2   ultra_smb3
=20
-The ``ultra_smb<N>`` named SMB associated with SCCL.::
+The ``ultra_smb<N>`` names SMB device associated with SCCL.::
=20
 	$# ls /sys/bus/coresight/devices/ultra_smb0
 	enable_sink   mgmt
@@ -32,24 +32,23 @@ The ``ultra_smb<N>`` named SMB associated with SCCL.::
=20
 Key file items are:
=20
-   * ``read_pos``: Shows the value held by UltraSoc SMB Read Pointer regis=
ter.
-   * ``write_pos``: Shows the value held by UltraSoc SMB Write Pointer reg=
ister.
-   * ``buf_status``: Shows the value held by UltraSoc SMB status register.
-     BIT(0) is zero means buffer is empty.
-   * ``buf_size``: Shows the buffer size of each UltraSoc SMB device.
+   * ``read_pos``: Shows the value on the read pointer register.
+   * ``write_pos``: Shows the value on the write pointer register.
+   * ``buf_status``: Shows the value on the status register.
+     BIT(0) is zero value which means the buffer is empty.
+   * ``buf_size``: Shows the buffer size of each device.
=20
 Firmware Bindings
----------------------------
+-----------------
=20
-SMB device is only supported with ACPI, and ACPI binding of SMB device
-describes SMB device indentifier, resource information and graph structure.
+The device is only supported with ACPI. Its binding describes device
+identifier, resource information and graph structure.
=20
-SMB is identified by ACPI HID "HISI03A1", resource of device is declared u=
sing
-the _CRS method. Each SMB must present two base address, the first one is =
the
-configuration base address of SMB device, the second one is the 32bits base
-address of shared system memory.
+The device is identified as ACPI HID "HISI03A1". Device resources are allo=
cated
+using the _CRS method. Each device must present two base address; the firs=
t one is the configuration base address of the device, the second one is th=
e 32-bit
+base address of shared system memory.
=20
-examples::
+Example::
=20
     Device(USMB) {                                               \
       Name(_HID, "HISI03A1")                                     \

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--EIcrB5LfjrdPKhUG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY3JJRQAKCRD2uYlJVVFO
o59oAQCu05hsQT4RBR3HOXLdqbkEwDeu51isPmeDh7K3Uj02+wD8C8hED7b8KiCo
LOcau2nKAJfOME0U/UmiiQuRk2RiFQM=
=nCZV
-----END PGP SIGNATURE-----

--EIcrB5LfjrdPKhUG--
