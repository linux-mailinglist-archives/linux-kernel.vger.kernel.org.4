Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D3B648D1C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 05:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiLJEQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 23:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiLJEPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 23:15:54 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507FA750B8;
        Fri,  9 Dec 2022 20:15:53 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 65so5046249pfx.9;
        Fri, 09 Dec 2022 20:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ozEVuMBsrz2fGpZPaf5TBc56Rb5hAzeIeLY45YAmjg=;
        b=qBuyZR9xJuqckUAwIQgashHsDw96Aw3Jld/uVlEvbCsfcLt46kL96bojo8qKgzJZtK
         FygLn59+S6HBFyAz6rV5sxdMykV3+DwsLnQb03+ohkhmmhJthTwX/6v2orYRqHQCtGgD
         9ANAMJ/CC+ocvoN5WiGy2CWKEjV/EEZn4dKGLD5bzOsfN0CZpQhbrvwd5iND2vqfFaq6
         7DxKT/IpCfoPsI4ey/RRAb0T72Dpdwq4xL50pZq0sLv0K4ndk9K1KYaKzalDPvNV2wq6
         dWB0wi+d54AycCMonGVteTXR7X3BymFAWaUwk7YpRWJzqBAMdVWYdLOfSsPFOHbXpB3C
         CIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ozEVuMBsrz2fGpZPaf5TBc56Rb5hAzeIeLY45YAmjg=;
        b=xVBBji3+crHkl5gRxj/aUzKHNTYEqtasurYdEqH5myOg2CDE58mnYkae5JnOfCXCI7
         JwfShkar+3oolzQZ5tE+saHK+Nrv0izasJ9Pv3EzqhJ5cwBzC/l4S9T0y2LAk+t9Oj5f
         vpOQ/H4V/BAUxwpw4zUxW7miE58qerF/ttZOp31BUo+8cGn9CvxO+wwIhBfb1NcGSmM7
         cvBT/ccOaLTrnfxysqV9axp/mbEiUIcyyDEIMqh+h0Lurs/urTcCdrfANhRIJQqanIog
         EICl8XHdnZaO3rN645bfLaMda5BQP9P9hKxtOcO5Tnj/pSEaIdBBcgZVq3J8EVy0Gj9N
         Fx9w==
X-Gm-Message-State: ANoB5plYjRUPGXDsNgcnxO+hLiR1LOTYq16LUyqCr3ZFjQQ5TazghnBF
        CloWaGc5T21fFwLEpJtf9p4=
X-Google-Smtp-Source: AA0mqf6INOrKloviSF3T6uZisghveh/vGMlmOCeTTviA5Pj5gFIHDKQkWAafIbmnMBVlQbMX9yDAAQ==
X-Received: by 2002:a62:de04:0:b0:577:3885:9d43 with SMTP id h4-20020a62de04000000b0057738859d43mr8063841pfg.18.1670645752742;
        Fri, 09 Dec 2022 20:15:52 -0800 (PST)
Received: from debian.me (subs02-180-214-232-76.three.co.id. [180.214.232.76])
        by smtp.gmail.com with ESMTPSA id x28-20020aa78f1c000000b0056bc5ad4862sm1926655pfr.28.2022.12.09.20.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 20:15:52 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 0FB8510463F; Sat, 10 Dec 2022 11:15:48 +0700 (WIB)
Date:   Sat, 10 Dec 2022 11:15:48 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     axboe@kernel.dk, corbet@lwn.net, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/21] documentation, blkfilter: Block Device
 Filtering Mechanism
Message-ID: <Y5QH9FdUvgZ7A8cu@debian.me>
References: <20221209142331.26395-1-sergei.shtepa@veeam.com>
 <20221209142331.26395-2-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="djxDLq4t0gK1VZM2"
Content-Disposition: inline
In-Reply-To: <20221209142331.26395-2-sergei.shtepa@veeam.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--djxDLq4t0gK1VZM2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 09, 2022 at 03:23:11PM +0100, Sergei Shtepa wrote:
> The document contains:
> * Describes the purpose of the mechanism
> * A little historical background on the capabilities of handling I/O
>   units of the Linux kernel
> * Brief description of the design
> * Reference to interface description
>=20

The patch subject should be "Documentation: document block device
filtering"

Also, write the patch description in imperative mood.

> diff --git a/Documentation/block/blkfilter.rst b/Documentation/block/blkf=
ilter.rst
> new file mode 100644
> index 000000000000..3482e16c1964
> --- /dev/null
> +++ b/Documentation/block/blkfilter.rst
> @@ -0,0 +1,50 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +Block Device Filtering Mechanism
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The block device filtering mechanism is an API that allows to attach blo=
ck
> +device filters. Block device filters allow perform additional processing
> +for I/O units.
> +
> +Introduction
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The idea of handling I/O units on block devices is not new. Back in the
> +2.6 kernel, there was an undocumented possibility of handling I/O units
> +by substituting the make_request_fn() function, which belonged to the
> +request_queue structure. But no kernel module used this feature, and it
> +was eliminated in the 5.10 kernel.
> +
> +The block device filtering mechanism returns the ability to handle I/O u=
nits.
> +It is possible to safely attach filter to a block device "on the fly" wi=
thout
> +changing the structure of block devices.
> +
> +It supports attaching one filter to one block device, because there is o=
nly
> +one filter implementation in the kernel.
> +See Documentation/block/blksnap.rst.
> +
> +Design
> +=3D=3D=3D=3D=3D=3D
> +
> +The block device filtering mechanism provides functions for attaching and
> +detaching the filter. The filter is a structure with a reference counter
> +and callback functions.
> +
> +The submit_bio_cb() callback function is called for each I/O unit for a =
block
> +device, providing I/O unit filtering. Depending on the result of filteri=
ng
> +the I/O unit, it can either be passed for subsequent processing by the b=
lock
> +layer, or skipped.
> +
> +The reference counter allows to control the filter lifetime. When the re=
ference
> +count is reduced to zero, the release_cb() callback function is called to
> +release the filter. This allows the filter to be released when the block
> +device is disconnected.
> +
> +Interface description
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +.. kernel-doc:: include/linux/blkdev.h
> +	:functions: bdev_filter_operations bdev_filter bdev_filter_init bdev_fi=
lter_get bdev_filter_put
> +.. kernel-doc:: block/bdev.c
> +	:functions: bdev_filter_attach bdev_filter_detach

What about the wording below instead?

---- >8 ----
diff --git a/Documentation/block/blkfilter.rst b/Documentation/block/blkfil=
ter.rst
index 3482e16c1964e6..fe2a4151c38fde 100644
--- a/Documentation/block/blkfilter.rst
+++ b/Documentation/block/blkfilter.rst
@@ -5,7 +5,7 @@ Block Device Filtering Mechanism
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
=20
 The block device filtering mechanism is an API that allows to attach block
-device filters. Block device filters allow perform additional processing
+device filters. Block device filters allow performing additional processing
 for I/O units.
=20
 Introduction
@@ -14,16 +14,16 @@ Introduction
 The idea of handling I/O units on block devices is not new. Back in the
 2.6 kernel, there was an undocumented possibility of handling I/O units
 by substituting the make_request_fn() function, which belonged to the
-request_queue structure. But no kernel module used this feature, and it
-was eliminated in the 5.10 kernel.
+request_queue structure. But no kernel module used this feature, which was
+the reason why it was removed in the 5.10 kernel.
=20
-The block device filtering mechanism returns the ability to handle I/O uni=
ts.
-It is possible to safely attach filter to a block device "on the fly" with=
out
+With block device filtering, the ability to handling I/O units is back. It=
 is
+now possible to safely attaching filter to a block device "on the fly" wit=
hout
 changing the structure of block devices.
=20
-It supports attaching one filter to one block device, because there is only
-one filter implementation in the kernel.
-See Documentation/block/blksnap.rst.
+It supports attaching a filter to a block device, due to there is only
+one filter implementation in the kernel. See Documentation/block/blksnap.r=
st
+for details.
=20
 Design
 =3D=3D=3D=3D=3D=3D
@@ -33,9 +33,9 @@ detaching the filter. The filter is a structure with a re=
ference counter
 and callback functions.
=20
 The submit_bio_cb() callback function is called for each I/O unit for a bl=
ock
-device, providing I/O unit filtering. Depending on the result of filtering
-the I/O unit, it can either be passed for subsequent processing by the blo=
ck
-layer, or skipped.
+device, providing I/O unit filtering. Depending on filtering result, it can
+either be passed for subsequent processing by the block
+layer, or be skipped.
=20
 The reference counter allows to control the filter lifetime. When the refe=
rence
 count is reduced to zero, the release_cb() callback function is called to

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--djxDLq4t0gK1VZM2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY5QH7gAKCRD2uYlJVVFO
ozyBAP4y2s2pM1cq93OuuJUSPvRd1Qz1ElJR2eNrN63nSWIPtgD/U3JNGKJ3bzNp
6SMFiHhd6OvERXUaW7U/TJ2hkKacrgc=
=yUM4
-----END PGP SIGNATURE-----

--djxDLq4t0gK1VZM2--
