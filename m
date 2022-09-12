Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B775B6454
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 01:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiILXrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 19:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiILXrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 19:47:06 -0400
X-Greylist: delayed 2400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 12 Sep 2022 16:47:04 PDT
Received: from 9.mo582.mail-out.ovh.net (9.mo582.mail-out.ovh.net [87.98.171.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F1B13FB9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 16:47:03 -0700 (PDT)
Received: from player750.ha.ovh.net (unknown [10.110.208.220])
        by mo582.mail-out.ovh.net (Postfix) with ESMTP id 0E31721AFD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 22:27:08 +0000 (UTC)
Received: from etezian.org (bbcs-175-223.cust.wingo.ch [178.238.175.223])
        (Authenticated sender: andi@etezian.org)
        by player750.ha.ovh.net (Postfix) with ESMTPSA id 4B5682E6847BB;
        Mon, 12 Sep 2022 22:26:39 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-95G0013efd0b66-a73e-45c9-bb98-e25c7815fbbb,
                    3B4E35B332874A0F69C0154FD1AC24ACCE6C8C6C) smtp.auth=andi@etezian.org
X-OVh-ClientIp: 178.238.175.223
Date:   Tue, 13 Sep 2022 00:26:36 +0200
From:   Andi Shyti <andi@etezian.org>
To:     Smitha T Murthy <smitha.t@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, stanimir.varbanov@linaro.org,
        dillon.minfei@gmail.com, david.plowman@raspberrypi.com,
        mark.rutland@arm.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        andi@etezian.org, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com, aakarsh.jain@samsung.com
Subject: Re: [Patch v2 04/15] media: s5p-mfc: Add initial support for MFCv12
Message-ID: <Yx+yHPFhLbaaSCAw@intel.intel>
References: <20220907064715.55778-1-smitha.t@samsung.com>
 <CGME20220907063328epcas5p12c01eb755e3ddfa4fdaee8e4c3bc9527@epcas5p1.samsung.com>
 <20220907064715.55778-5-smitha.t@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907064715.55778-5-smitha.t@samsung.com>
X-Ovh-Tracer-Id: 12842858766094371346
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfedufedgudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnughiucfuhhihthhiuceorghnughisegvthgviihirghnrdhorhhgqeenucggtffrrghtthgvrhhnpeejgfelgeekieffjeegveeuvdehgeelveetveejudffvedvleehvdefleehudelueenucfkpheptddrtddrtddrtddpudejkedrvdefkedrudejhedrvddvfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeehtddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegrnhguihesvghtvgiiihgrnhdrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekvd
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Smitha,

just a fast look here

[...]

> +/* Encoder buffer size for MFCv12 */
> +#define ENC_V120_BASE_SIZE(x, y) \
> +	(((x + 3) * (y + 3) * 8) \
> +	+ (((y * 64) + 2304) * (x + 7) / 8))

do we need any overflow control here?

[...]

>  #define MFC_V7_BIT	BIT(2)
>  #define MFC_V8_BIT	BIT(3)
>  #define MFC_V10_BIT	BIT(5)
> +#define MFC_V12_BIT	BIT(7)
>  
>  #define MFC_V5PLUS_BITS		(MFC_V5_BIT | MFC_V6_BIT | MFC_V7_BIT | \
> -					MFC_V8_BIT | MFC_V10_BIT)
> +					MFC_V8_BIT | MFC_V10_BIT | MFC_V12_BIT)
>  #define MFC_V6PLUS_BITS		(MFC_V6_BIT | MFC_V7_BIT | MFC_V8_BIT | \
> -					MFC_V10_BIT)
> -#define MFC_V7PLUS_BITS		(MFC_V7_BIT | MFC_V8_BIT | MFC_V10_BIT)
> +					MFC_V10_BIT | MFC_V12_BIT)
> +#define MFC_V7PLUS_BITS		(MFC_V7_BIT | MFC_V8_BIT | MFC_V10_BIT | \
> +					MFC_V12_BIT)

why not MFC_V10PLUS_BITS ?

[...]

> @@ -146,7 +146,7 @@ static struct s5p_mfc_fmt formats[] = {
>  		.codec_mode	= S5P_FIMV_CODEC_HEVC_DEC,
>  		.type		= MFC_FMT_DEC,
>  		.num_planes	= 1,
> -		.versions	= MFC_V10_BIT,
> +		.versions	= MFC_V10_BIT | MFC_V12_BIT,

we could just yse MFC_V10PLUS_BITS here

[...]

> +		if (IS_MFCV12(dev)) {
> +			lcu_width = S5P_MFC_LCU_WIDTH(ctx->img_width);
> +			lcu_height = S5P_MFC_LCU_HEIGHT(ctx->img_height);
> +			if (ctx->codec_mode == S5P_FIMV_CODEC_HEVC_ENC &&
> +								ctx->is_10bit) {
> +				ctx->luma_dpb_size =
> +					width64 * height32 +
> +					ALIGN(DIV_ROUND_UP(lcu_width * 32, 4),
> +							16) * height32 + 128;
> +				if (ctx->is_422) {
> +					ctx->chroma_dpb_size =
> +						ctx->luma_dpb_size;
> +				} else {
> +					ctx->chroma_dpb_size =
> +						width64 * height32 / 2 +
> +						ALIGN(DIV_ROUND_UP(lcu_width *
> +						32, 4), 16) * height32 / 2 + 128;
> +				}

You don't need the brackets here.

> +			} else if (ctx->codec_mode == S5P_FIMV_CODEC_VP9_ENC &&
> +					ctx->is_10bit) {
> +				ctx->luma_dpb_size =
> +					ALIGN(ctx->img_width * 2, 128) *
> +					height32 + 64;
> +				ctx->chroma_dpb_size =
> +					ALIGN(ctx->img_width * 2, 128) *
> +					height32 / 2 + 64;
> +			} else {
> +				ctx->luma_dpb_size =
> +					width64 * height32 + 64;
> +				if (ctx->is_422) {
> +					ctx->chroma_dpb_size =
> +						ctx->luma_dpb_size;
> +				} else {
> +					ctx->chroma_dpb_size =
> +						width64 * height32 / 2 + 64;
> +				}

You don't need the brackets here.

[...]

Andi
