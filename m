Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABD364E809
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 09:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiLPIRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 03:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiLPIRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 03:17:14 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595F42E9E3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 00:17:13 -0800 (PST)
Received: from [192.168.1.15] (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E574C505;
        Fri, 16 Dec 2022 09:17:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671178631;
        bh=zh8GNBuLhZA/Lc5zhOuN0iTHj7YG51sR9VyIpvmY9FI=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=Jwp7Vnza+X3ECKRjlYR80GyWnsPJ9OzGLdrhL1SK94pilnTtAQk70XnF5Q46dg2Ug
         iNOZSFCuV81euamZ+eOddzv0mMVN9DnpgnaliMIH+MdT0ajuXHXGn2GoGaCVpbsbNB
         IsMXenswsxUm+IQGr5URlsCOo7TaIfSN7e2OBU0o=
Message-ID: <a00527f5-8e76-958d-8d12-c2b815a200d7@ideasonboard.com>
Date:   Fri, 16 Dec 2022 10:17:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/tidss: Set max DMA segment size
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220823001634.11461-1-afd@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20220823001634.11461-1-afd@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2022 03:16, Andrew Davis wrote:
> We have no segment size limitations. Set to unlimited.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>   drivers/gpu/drm/tidss/tidss_dispc.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
> index dd3c6a606ae2..624545e4636c 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -2685,6 +2685,7 @@ int dispc_init(struct tidss_device *tidss)
>   		if (r)
>   			dev_warn(dev, "cannot set DMA masks to 48-bit\n");
>   	}
> +	dma_set_max_seg_size(dev, UINT_MAX);
>   
>   	dispc = devm_kzalloc(dev, sizeof(*dispc), GFP_KERNEL);
>   	if (!dispc)

Thanks, I'll apply to drm-misc.

  Tomi

