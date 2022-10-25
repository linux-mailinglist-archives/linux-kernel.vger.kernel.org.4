Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045AA60CD43
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbiJYNSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbiJYNSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:18:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443CCDFB7E;
        Tue, 25 Oct 2022 06:18:30 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4D4936602254;
        Tue, 25 Oct 2022 14:18:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666703909;
        bh=NzM0Ii6N1Q/ccnjjm2mgQk1R6bvLWfp7+zNhfLnkSFY=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=FZsm3+ApOIIPxWAprErRprh9iRzwFNhy4t0GpgZDnMSDdunxAkJ+IPv+QEysK8vBP
         jlPfGgrbVCsADH5torBhxZhYyJrRmq08+6dDKiR0noMKtniwkHnbhoL1vsGO65uL6S
         zbrVWYLLZJc8F4KpzUOiiwCPEbwcLCnlypUTCgub98QB3UQrobFMiLpWWDA3RpJBRl
         Pg1enL10eRunfZ96DbWSKLYk1+/lIhxvwDKYn0Z/kG+q2spqpimzdgi4zoNdw8ZY1g
         xnnh5YZRK0S0pkGM7dpldoa1cqGeIrF46Q+mxDEZPAaHfEt3AWMdRzuoXd+FEXYl5I
         +gU4H1PjaFwlQ==
Message-ID: <8a8f7c818688bda7c75d2f4fb5f8f0d6f89cb965.camel@collabora.com>
Subject: Re: [PATCH v10 3/5] media: Documentation: aspeed-video: Add user
 documentation for the aspeed-video driver
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Jammy Huang <jammy_huang@aspeedtech.com>, eajames@linux.ibm.com,
        mchehab@kernel.org, joel@jms.id.au, andrew@aj.id.au,
        hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
        xavier.roumegue@oss.nxp.com, ezequiel@vanguardiasur.com.ar,
        stanimir.varbanov@linaro.org, sakari.ailus@linux.intel.com,
        ming.qian@nxp.com, andrzej.p@collabora.com,
        linux-media@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Tue, 25 Oct 2022 09:18:16 -0400
In-Reply-To: <20221025090203.5623-4-jammy_huang@aspeedtech.com>
References: <20221025090203.5623-1-jammy_huang@aspeedtech.com>
         <20221025090203.5623-4-jammy_huang@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jammy,

thanks for the addition.

Le mardi 25 octobre 2022 =C3=A0 17:02 +0800, Jammy Huang a =C3=A9crit=C2=A0=
:
> Add user documentation for the aspeed-video driver.
>=20
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> ---
> v10:
>   - new
> ---
>  .../media/drivers/aspeed-video.rst            | 61 +++++++++++++++++++
>  .../userspace-api/media/drivers/index.rst     |  1 +
>  2 files changed, 62 insertions(+)
>  create mode 100644 Documentation/userspace-api/media/drivers/aspeed-vide=
o.rst
>=20
> diff --git a/Documentation/userspace-api/media/drivers/aspeed-video.rst b=
/Documentation/userspace-api/media/drivers/aspeed-video.rst
> new file mode 100644
> index 000000000000..798a2588b175
> --- /dev/null
> +++ b/Documentation/userspace-api/media/drivers/aspeed-video.rst
> @@ -0,0 +1,61 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. include:: <isonum.txt>
> +
> +ASPEED video driver
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +ASPEED Video Engine found on AST2400/2500/2600 SoC supports high perform=
ance
> +video compressions with a wide range of video quality and compression ra=
tio
> +options. The adopted compressing algorithm is a modified JPEG algorithm.
> +
> +There are 2 types of compressions in this IP.
> +
> +* JPEG JFIF standard mode: for single frame and management compression
> +* ASPEED proprietary mode: for multi-frame and differential compression.
> +  Support 2-pass (high quality) video compression scheme (Patent pending=
 by
> +  ASPEED). Provide visually lossless video compression quality or to red=
uce
> +  the network average loading under intranet KVM applications.

I think some of the information disclosed in the following quote could be
summarized. Notably the part about the extra buffers.

   Aspeed JPEG Format requires an additional buffer, called bcd, to store
   the information about which macro block in the new frame is different
   from the previous one.
  =20
   To have bcd correctly working, we need to swap the buffers for src0/1 to
   make src1 refer to previous frame and src0 to the coming new frame.
  =20
But before I push you this route, have you considered using a dedicated pix=
el
format instead ? Here's my thinking, the output of the JPEG encoder is no l=
onger
"compatible" (or at least won't yield the expected images) if used with a n=
ormal
JPEG decoder. By differentiating these two as dedicated formats, you will o=
nly need
1 vendor control, and you avoid the potential risk of software bugs mixing =
them up.
Also note that there is other JPEG based vendor formats that exist in V4L2.

Let me know what do you think ?

Nicolas

> +
> +More details on the ASPEED video hardware operations can be found in
> +*chapter 6.2.16 KVM Video Driver* of SDK_User_Guide which available on
> +AspeedTech-BMC/openbmc/releases.
> +
> +The ASPEED video driver implements the following driver-specific control=
:
> +
> +``V4L2_CID_ASPEED_HQ_MODE``
> +-------------------------------
> +    Enable/Disable ASPEED's High quality mode. This is a private control
> +    that can be used to enable high quality for aspeed proprietary mode.
> +
> +.. flat-table::
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 4
> +
> +    * - ``(0)``
> +      - ASPEED HQ mode is disabled.
> +    * - ``(1)``
> +      - ASPEED HQ mode is enabled.
> +
> +``V4L2_CID_ASPEED_HQ_JPEG_QUALITY``
> +-------------------------------
> +    Define the quality of ASPEED's High quality mode. This is a private =
control
> +    that can be used to decide compression quality if High quality mode =
enabled
> +    . Higher the value, better the quality and bigger the size.
> +
> +.. flat-table::
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 4
> +
> +    * - ``(1)``
> +      - minimum
> +    * - ``(12)``
> +      - maximum
> +    * - ``(1)``
> +      - step
> +    * - ``(1)``
> +      - default
> +
> +**Copyright** |copy| 2022 ASPEED Technology Inc.
> diff --git a/Documentation/userspace-api/media/drivers/index.rst b/Docume=
ntation/userspace-api/media/drivers/index.rst
> index 32f82aed47d9..46a494e00b72 100644
> --- a/Documentation/userspace-api/media/drivers/index.rst
> +++ b/Documentation/userspace-api/media/drivers/index.rst
> @@ -31,6 +31,7 @@ For more details see the file COPYING in the source dis=
tribution of Linux.
>  	:maxdepth: 5
>  	:numbered:
> =20
> +	aspeed-video
>  	ccs
>  	cx2341x-uapi
>  	dw100

