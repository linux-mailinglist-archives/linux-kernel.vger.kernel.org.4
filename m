Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3E06C125B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjCTMxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjCTMwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:52:45 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8139E6A47;
        Mon, 20 Mar 2023 05:51:16 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32KCp2fu000304;
        Mon, 20 Mar 2023 07:51:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679316662;
        bh=9yj/sSLEFScvZN4SMkKA20b3bGP1XpPkx/aHTkcoFCo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=BVG1BOkzCW2K3fnBQSV/5bXr9PmH2BybS8CpejKI65wlGP3DgwbT3KCYhUG1TjVil
         QOHsMDoJFqeg666DNQlpK3HtcItZIrUeInzACEFsQY/B6qRHxe/ScztAHaMJzvTtLV
         emLIZYR+R/wxdFFr55+fuu4hfwLZML+1IwF7/kNw=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32KCp23u081617
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Mar 2023 07:51:02 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 20
 Mar 2023 07:51:01 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 20 Mar 2023 07:51:02 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32KCp07D015535;
        Mon, 20 Mar 2023 07:51:01 -0500
Date:   Mon, 20 Mar 2023 18:21:03 +0530
From:   Jai Luthra <j-luthra@ti.com>
To:     Vaishnav Achath <vaishnav.a@ti.com>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <mripard@kernel.org>, <mchehab@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <laurent.pinchart@ideasonboard.com>,
        <sakari.ailus@linux.intel.com>, <tomi.valkeinen@ideasonboard.com>,
        <linux-kernel@vger.kernel.org>, <bparrot@ti.com>,
        <niklas.soderlund+renesas@ragnatech.se>, <devarsht@ti.com>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <vigneshr@ti.com>,
        <nm@ti.com>, <martyn.welch@collabora.com>
Subject: Re: [PATCH v7 10/13] media: ti: Add CSI2RX support for J721E
Message-ID: <20230320125103.sw463k4xzgnysgo3@uda0497096>
References: <20230314115516.667-1-vaishnav.a@ti.com>
 <20230314115516.667-11-vaishnav.a@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xmlq6vdtjzrg2y6d"
Content-Disposition: inline
In-Reply-To: <20230314115516.667-11-vaishnav.a@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--xmlq6vdtjzrg2y6d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Vaishnav,

Thanks for the series.

On Mar 14, 2023 at 17:25:13 +0530, Vaishnav Achath wrote:
> From: Pratyush Yadav <p.yadav@ti.com>
>=20
> TI's J721E uses the Cadence CSI2RX and DPHY peripherals to facilitate
> capture over a CSI-2 bus.
>=20
> The Cadence CSI2RX IP acts as a bridge between the TI specific parts and
> the CSI-2 protocol parts. TI then has a wrapper on top of this bridge
> called the SHIM layer. It takes in data from stream 0, repacks it, and
> sends it to memory over PSI-L DMA.
>=20
> This driver acts as the "front end" to V4L2 client applications. It
> implements the required ioctls and buffer operations, passes the
> necessary calls on to the bridge, programs the SHIM layer, and performs
> DMA via the dmaengine API to finally return the data to a buffer
> supplied by the application.
>=20
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> ---
[...]
> diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c=20
> b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
> new file mode 100644
> index 000000000000..0c8dad049f5b
> --- /dev/null
> +++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
> @@ -0,0 +1,1022 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * TI CSI2 RX driver.
> + *
> + * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.co=
m/
> + *
> + * Author: Pratyush Yadav <p.yadav@ti.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/dmaengine.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +
> +#include <media/mipi-csi2.h>
> +#include <media/v4l2-device.h>
> +#include <media/v4l2-ioctl.h>
> +#include <media/videobuf2-dma-contig.h>
> +
> +#define TI_CSI2RX_MODULE_NAME		"j721e-csi2rx"
> +
> +#define SHIM_CNTL			0x10
> +#define SHIM_CNTL_PIX_RST		BIT(0)
> +
> +#define SHIM_DMACNTX			0x20
> +#define SHIM_DMACNTX_EN			BIT(31)
> +#define SHIM_DMACNTX_YUV422		GENMASK(27, 26)
> +#define SHIM_DMACNTX_FMT		GENMASK(5, 0)
> +#define SHIM_DMACNTX_UYVY		0
> +#define SHIM_DMACNTX_VYUY		1
> +#define SHIM_DMACNTX_YUYV		2
> +#define SHIM_DMACNTX_YVYU		3
> +
> +#define SHIM_PSI_CFG0			0x24
> +#define SHIM_PSI_CFG0_SRC_TAG		GENMASK(15, 0)
> +#define SHIM_PSI_CFG0_DST_TAG		GENMASK(31, 15)

This should be GENMASK(31, 16) instead.

> +
> +#define PSIL_WORD_SIZE_BYTES		16
> +/*
[...]

Thanks,
Jai

--xmlq6vdtjzrg2y6d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmQYVrQACgkQQ96R+SSa
cUVuRBAAxtn1Z+pOBmlQ6rCENKCZcZWAQ6CFObHjfHXnjpQnIeY9pACDuYuUv+Ls
s5rBNMWpXJv8/1vyesCMTsDgfOeJ37E3GiylvG9KuP0nFqTApzubbxydI5zs14rF
nkkXBSJ4PtoEhEKi8pcFwAWtL0uAx0fX860oXxMTuLhJS1PGZAYfrW5oAgjhlspY
cDEPJH14KwPfJ38TnMP5llMFbvnxpBUCV+203LBeZMzIziS21OuxYk/5uVHHaJTF
JNBhGbYMDZUX7dD2T1vWhHvmZ9XTeRrEdLDflMRVVUndxyI13Eg3k9RvVh5c6yhq
raAwCSk7KXoAwvX5ZV+Djd+7hHkitxbmb3GRM1Yf1x6bZgovAWfZv4xJZkKG0RBz
/Xk+t7Zeqyoxmj7T6hOqGYnm/pNgxKqlNfOEPH4MLV+P+y7J9iIYdi1QgsqwGv/r
xdkJft3b0IGtqKCwNK22d0+Lxvqr2zDniiJMj2li/KkX/gtVTFQE7t1p9gcD4EhM
aQUwFDW0Q0y3oSQWbSanCgVAM4Ns4V1pYqbLQw2p1fuvofbs37bEAYkvrMgv+rEf
FZPzT30rqBrHhFCKQz8fCMJuHq+2hE7+7SFv6KePD5wBsfhaA7xrk9Zxg5PFGRIo
FlgL6j62yUhwExElJ3yNx8HlvGNoxFPFZZGHQb9FV2aYWfYAHh4=
=7zFN
-----END PGP SIGNATURE-----

--xmlq6vdtjzrg2y6d--
