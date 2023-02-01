Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF056866CF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjBAN0o convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 1 Feb 2023 08:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjBAN0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:26:42 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E211D469A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 05:26:41 -0800 (PST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1pND8G-0004gk-MX; Wed, 01 Feb 2023 14:26:36 +0100
Message-ID: <b3fe19c040de21da220164955fdd679f9c17d80c.camel@pengutronix.de>
Subject: Re: [PATCH v5 7/7] drm/etnaviv: add HWDB entry for
 VIPNano-QI.7120.0055
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     italonicola@collabora.com,
        "moderated list:DRM DRIVERS FOR VIVANTE GPU IP" 
        <etnaviv@lists.freedesktop.org>,
        "open list:DRM DRIVERS FOR VIVANTE GPU IP" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@gmail.com>
Date:   Wed, 01 Feb 2023 14:26:34 +0100
In-Reply-To: <20221201103026.53234-8-tomeu.vizoso@collabora.com>
References: <20221201103026.53234-1-tomeu.vizoso@collabora.com>
         <20221201103026.53234-8-tomeu.vizoso@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomeu,

Am Donnerstag, dem 01.12.2022 um 11:30 +0100 schrieb Tomeu Vizoso:
> This is a compute-only module marketed towards AI and vision
> acceleration. This particular version can be found on the Amlogic A311D
> SoC.
> 
> The feature bits are taken from the Khadas downstream kernel driver
> 6.4.4.3.310723AAA.
> 
I just noticed that you seem to have dropped the nn_core_count property
from this HWDB entry when reworking the series according to my
feedback. I assume that you are fine with me fixing this up in the
etnaviv tree by using the hunk from your previous patch "[PATCH v4 6/7]
drm/etnaviv: Add nn_core_count to chip feature struct".

If you see any issue with that, please let me know.

Regards,
Lucas

> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 31 ++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
> index 44df273a5aae..66b8ad6c7d26 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
> @@ -134,6 +134,37 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
>  		.minor_features10 = 0x90044250,
>  		.minor_features11 = 0x00000024,
>  	},
> +	{
> +		.model = 0x8000,
> +		.revision = 0x7120,
> +		.product_id = 0x45080009,
> +		.customer_id = 0x88,
> +		.eco_id = 0,
> +		.stream_count = 8,
> +		.register_max = 64,
> +		.thread_count = 256,
> +		.shader_core_count = 1,
> +		.vertex_cache_size = 16,
> +		.vertex_output_buffer_size = 1024,
> +		.pixel_pipes = 1,
> +		.instruction_count = 512,
> +		.num_constants = 320,
> +		.buffer_size = 0,
> +		.varyings_count = 16,
> +		.features = 0xe0287cac,
> +		.minor_features0 = 0xc1799eff,
> +		.minor_features1 = 0xfefbfadb,
> +		.minor_features2 = 0xeb9d6fbf,
> +		.minor_features3 = 0xedfffced,
> +		.minor_features4 = 0xd30dafc7,
> +		.minor_features5 = 0x7b5ac333,
> +		.minor_features6 = 0xfc8ee200,
> +		.minor_features7 = 0x03fffa6f,
> +		.minor_features8 = 0x00fe0ef0,
> +		.minor_features9 = 0x0088003c,
> +		.minor_features10 = 0x108048c0,
> +		.minor_features11 = 0x00000010,
> +	},
>  };
>  
>  bool etnaviv_fill_identity_from_hwdb(struct etnaviv_gpu *gpu)

