Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040DF6ECB22
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 13:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjDXLQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 07:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDXLQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 07:16:47 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276A330D5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 04:16:46 -0700 (PDT)
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mx1.riseup.net (Postfix) with ESMTPS id 4Q4jJF2qC1zDqPv;
        Mon, 24 Apr 2023 11:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1682335005; bh=9PyrAd2emcEb7E0sv0ZfE/I+7D43xNrD7rumUp6r68I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sEBjk+C9GVjh0iQLb2yT6rnMVyR5BrF+hCsmGcq581zSExdCTgbkuoNin8Y51rvlk
         mSAgcLC1I21X/E55FP7zVmhg/Gnd7RusQMGE01PbXPU/jeYJj5pSo/4RsKvaUBIRP9
         3UFYU+Z8yvMxpzJGfdOxwh6XYDdN1hKgxEWYKdYA=
X-Riseup-User-ID: 678DA1CC7131AB175392FD4C789BE3F85A386801FA2D3B237D515B53B6153B02
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4Q4jJ90NrGzFrxG;
        Mon, 24 Apr 2023 11:16:40 +0000 (UTC)
Message-ID: <55b8a1bf-e41e-16f9-8377-90e4a94d6436@riseup.net>
Date:   Mon, 24 Apr 2023 08:16:39 -0300
MIME-Version: 1.0
Subject: Re: [PATCH 1/5] drm/bridge: anx7625: Drop of_gpio header
Content-Language: en-US
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
References: <20220812205746.609107-1-mairacanal@riseup.net>
 <20220812205746.609107-2-mairacanal@riseup.net>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <20220812205746.609107-2-mairacanal@riseup.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/22 17:57, Maíra Canal wrote:
> This driver includes the deprecated OF GPIO header <linux/of_gpio.h>
> yet fail to use symbols from it, so drop the include.
> 
> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Robert Foss <robert.foss@linaro.org>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Signed-off-by: Maíra Canal <mairacanal@riseup.net>

Applied to drm/drm-misc (drm-misc-next).

Best Regards,
- Maíra Canal

> ---
>   drivers/gpu/drm/bridge/analogix/anx7625.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index 79fc7a50b497..d7d4ca1c8b30 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -17,7 +17,6 @@
>   #include <linux/types.h>
>   #include <linux/workqueue.h>
>   
> -#include <linux/of_gpio.h>
>   #include <linux/of_graph.h>
>   #include <linux/of_platform.h>
>   
