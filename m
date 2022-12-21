Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CA8652BFD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 05:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiLUECQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 23:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiLUECN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 23:02:13 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B30B13DD4;
        Tue, 20 Dec 2022 20:02:12 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id o8-20020a17090a9f8800b00223de0364beso879103pjp.4;
        Tue, 20 Dec 2022 20:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d9skzcMqbtck7zeDrhArO3NT59qMeIn4qeXyo+A2838=;
        b=GoNWVSAhRUDsH6UFui56Vg0q0rYDE4FSKMAT0U5dPjQrIQzNdTwwvGj4yg9hwTO0CT
         5rE7dZ/SBgAmATDfmvaxU9Zt9exkpK3fcCA2YcrIlvkwd7mYbEToZP4z8iZuzA7iRHDS
         NgNe5cMcKYJIu3oEvV1WhYbFg/b6wMGJnN9NnS2xDRBGDA24LQzLO1QFMQj7R2vonKEg
         ciyMgA4Z8VUGRIYj1Z5sU2OOpK3jFOKCM6YRrZkt+jno6WuMTbdDCd0JZJEv/lJP2Rel
         NMCdqmYeoS/4CPtnMp1aIwnfJ4ZtGku/JKBs/o/IdxWpwdPYZGLetI+csXq0uTEIPmEy
         4sUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9skzcMqbtck7zeDrhArO3NT59qMeIn4qeXyo+A2838=;
        b=HLIPdOgoblwTkXylz5ME45bnpW0gRKthGejJYfWGCs+Qou9fTx4uYplg4HtcU878JG
         s8ea3VVZEney/VZRKKAU6xVP+FbiSV3GxuJsIHq/zLM62WZPb8XOr22mshBjnfdYVbQD
         xgZxF6TBzU0Dybi1AnYaycmXE+NbtV1JAT4hTMU4iOAAjc5oHRhYjo5cVlw+E4YeZsom
         iSideR8CcfQTroUcStPvlLLLSQXJZT8sGj9bU8TsPKaItSj3zQo0cZ1h5GvrS2lP/Jfx
         sGi5Iu1FyXgFrEUocZz8UYTrWthrAVzfSNN1V5ealXJ6iYMcpCEkJj0rY09UlI/ZDke3
         FLyQ==
X-Gm-Message-State: AFqh2kr8/hXs8u+d9O5y9q7VdlIV6w0o9wC5r0GJYBfXZ8nVtYpXmiCp
        p5u6ohCcG7omKYRpuu7OuBY=
X-Google-Smtp-Source: AMrXdXvveVZhAyS8I/wF4nTGzldy02cLhtXAryRTJ56zc5etopPXtDjxy+8P/cQcIF+g+X4VUYGc6A==
X-Received: by 2002:a05:6a20:6699:b0:af:b771:1d01 with SMTP id o25-20020a056a20669900b000afb7711d01mr761379pzh.49.1671595331815;
        Tue, 20 Dec 2022 20:02:11 -0800 (PST)
Received: from debian.me (subs28-116-206-12-57.three.co.id. [116.206.12.57])
        by smtp.gmail.com with ESMTPSA id a5-20020a170902710500b0017f7628cbddsm2123862pll.30.2022.12.20.20.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 20:02:11 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 97DCA100064; Wed, 21 Dec 2022 11:02:08 +0700 (WIB)
Date:   Wed, 21 Dec 2022 11:02:08 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Junhao He <hejunhao3@huawei.com>
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org,
        jonathan.cameron@huawei.com, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, lpieralisi@kernel.org,
        linuxarm@huawei.com, yangyicong@huawei.com, liuqi6124@gmail.com,
        f.fangjian@huawei.com, shenyang39@huawei.com,
        prime.zeng@hisilicon.com
Subject: Re: [PATCH v15 2/2] Documentation: Add document for UltraSoc SMB
 driver
Message-ID: <Y6KFQIk8rbMIglBO@debian.me>
References: <20221220092945.30722-1-hejunhao3@huawei.com>
 <20221220092945.30722-3-hejunhao3@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gWpaJsbJoxLyMRhG"
Content-Disposition: inline
In-Reply-To: <20221220092945.30722-3-hejunhao3@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gWpaJsbJoxLyMRhG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 20, 2022 at 05:29:45PM +0800, Junhao He wrote:
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-ultra_=
smb b/Documentation/ABI/testing/sysfs-bus-coresight-devices-ultra_smb
> new file mode 100644
> index 000000000000..f6526882c627
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-ultra_smb
> @@ -0,0 +1,31 @@
> +What:		/sys/bus/coresight/devices/ultra_smb<N>/enable_sink
> +Date:		December 2022
> +KernelVersion:	6.2
> +Contact:	Junhao He <hejunhao3@huawei.com>
> +Description:	(RW) Add/remove a SMB device from a trace path. There can be
> +		multiple sources for a single SMB device.
> +
> +What:		/sys/bus/coresight/devices/ultra_smb<N>/mgmt/buf_size
> +Date:		December 2022
> +KernelVersion:	6.2
> +Contact:	Junhao He <hejunhao3@huawei.com>
> +Description:	(Read) Shows the buffer size of each UltraSoc SMB device.
> +
> +What:		/sys/bus/coresight/devices/ultra_smb<N>/mgmt/buf_status
> +Date:		December 2022
> +KernelVersion:	6.2
> +Contact:	Junhao He <hejunhao3@huawei.com>
> +Description:	(Read) Shows the value held by UltraSoc SMB status register.
> +		BIT(0) is zero means buffer is empty.
> +
> +What:		/sys/bus/coresight/devices/ultra_smb<N>/mgmt/read_pos
> +Date:		December 2022
> +KernelVersion:	6.2
> +Contact:	Junhao He <hejunhao3@huawei.com>
> +Description:	(Read) Shows the value held by UltraSoc SMB Read Pointer re=
gister.
> +
> +What:		/sys/bus/coresight/devices/ultra_smb<N>/mgmt/write_pos
> +Date:		December 2022
> +KernelVersion:	6.2
> +Contact:	Junhao He <hejunhao3@huawei.com>
> +Description:	(Read) Shows the value held by UltraSoc SMB Write Pointer r=
egister.

s/Read/RO/ and s/value held by/value of/

> diff --git a/Documentation/trace/coresight/ultrasoc-smb.rst b/Documentati=
on/trace/coresight/ultrasoc-smb.rst
> new file mode 100644
> index 000000000000..056dd120e14c
> --- /dev/null
> +++ b/Documentation/trace/coresight/ultrasoc-smb.rst
> @@ -0,0 +1,83 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +UltraSoc - HW Assisted Tracing on SoC
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +   :Author:   Qi Liu <liuqi115@huawei.com>
> +   :Date:     December 2022
> +
> +Introduction
> +------------
> +
> +UltraSoc SMB is a per SCCL (Super CPU Cluster) hardware. It provides a
> +way to buffer and store CPU trace messages in a region of shared system
> +memory. The device acts as a coresight sink device and the
> +corresponding trace generators (ETM) are attached as source devices.
> +
> +Sysfs files and directories
> +---------------------------
> +
> +The SMB devices appear on the existing coresight bus alongside other
> +devices::
> +
> +	$# ls /sys/bus/coresight/devices/
> +	ultra_smb0   ultra_smb1   ultra_smb2   ultra_smb3
> +
> +The ``ultra_smb<N>`` names SMB device associated with SCCL.::
> +
> +	$# ls /sys/bus/coresight/devices/ultra_smb0
> +	enable_sink   mgmt
> +	$# ls /sys/bus/coresight/devices/ultra_smb0/mgmt
> +	buf_size  buf_status  read_pos  write_pos
> +
> +Key file items are:
> +
> +   * ``read_pos``: Shows the value on the read pointer register.
> +   * ``write_pos``: Shows the value on the write pointer register.
> +   * ``buf_status``: Shows the value on the status register.
> +     BIT(0) is zero value which means the buffer is empty.
> +   * ``buf_size``: Shows the buffer size of each device.
> +
> +Firmware Bindings
> +-----------------
> +
> +The device is only supported with ACPI. Its binding describes device
> +identifier, resource information and graph structure.
> +
> +The device is identified as ACPI HID "HISI03A1". Device resources are al=
located
> +using the _CRS method. Each device must present two base address; the fi=
rst one
> +is the configuration base address of the device, the second one is the 3=
2-bit
> +base address of shared system memory.
> +
> +Example::
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

This doc LGTM, thanks.

For this doc,

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--gWpaJsbJoxLyMRhG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY6KFQAAKCRD2uYlJVVFO
ow1wAQDFWt3fu2nr0v0ewY7DfkD7+xZqVxk2CBKg2MiWMDayZQEArvFvJIzaSQ2v
fO5NYQKcDOA6BN5dF0qXxSLoEUDzaQ8=
=azdo
-----END PGP SIGNATURE-----

--gWpaJsbJoxLyMRhG--
