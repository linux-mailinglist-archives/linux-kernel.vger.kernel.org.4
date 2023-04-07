Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646446DAEE5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 16:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239077AbjDGOkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 10:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjDGOkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 10:40:21 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF198F
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 07:40:19 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id p34so24143772wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 07:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680878418; x=1683470418;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9cH7jELgJCXu/RRISlpcug386tFiALgZQ6ITifiCmrQ=;
        b=aj+RfnVjkR+cWy1ftcRXiKAugpLJS2h680OOCRjrq3gkvR91QYKptTzamm76EWbj5d
         FGfGD1bLI84Yl07AE5os/1N8Ximz7b8wKpZi3Pyh7AERMwZQyvC8VQSmYlHOgUsjhH38
         nBteZRn3WKC6h8ds9NBYKUJzUkqFO6dmKe3sryaVBZhJk3qjzfq/TtpdKGkrgYJxvK/7
         V6WhOeoLxSxxTymTL1Eq/HoI02fsDhhupGCVtfop3YqeraRFeOmC4Xlim+D+B4HgXfY9
         1PusmjanfwHSPXWjR58/Js5lHxbr4LyhhDjuW8Z5/Lf58j+3BQyB2ltQX1D5d6s345hd
         n36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680878418; x=1683470418;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9cH7jELgJCXu/RRISlpcug386tFiALgZQ6ITifiCmrQ=;
        b=Tq2rpCsvVWkka1gBkl0tdjB7rsBzcBlw3AbAublzsH9XLI4SEGW/7OHR4znt9kHoEh
         uXDEr3G+BffwQnmFP4hGXt1daJnl/BYFMAnCXj/157hQ7phpCBAcWzMBo+1uPP2vy0QO
         EItH1bq9lRLjGMSEdAx1QV8XuDqwcYSTSqyNXvIdm15WeBQrYZ5l6Sxds16PFBiHFdKR
         /NRWuVZiQ9Yz9F1jizJTbV0aZe3suFRCW0S86PAPJFrZvvDuXpOvulnnIDhqcnFwCZ88
         c64ooNdDg6gRbTsDSiOaI9O3MApsMVG2M8+VBHHkFkmXvu0R57+ytw3rMAp57+rbbBWd
         /rAQ==
X-Gm-Message-State: AAQBX9dnKDXTEXFREoCAyKlC0upiHjgMKdyTP96kMn34wewXsq91Xeaj
        Klz+0xzSCqv/WVvWR9g2V0HEnw==
X-Google-Smtp-Source: AKy350aHDxXpozWYR420g8dzLnTqXcG9nzS5zG/r1/ISiuBOsA4YBwyK7Ojw0m7k4W7g+0ZVwpZDLw==
X-Received: by 2002:a7b:ce10:0:b0:3ef:6ae7:8994 with SMTP id m16-20020a7bce10000000b003ef6ae78994mr1583180wmc.22.1680878417896;
        Fri, 07 Apr 2023 07:40:17 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c4ec600b003edc4788fa0sm8784116wmq.2.2023.04.07.07.40.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 07:40:17 -0700 (PDT)
Message-ID: <7eb4c0b9-a00e-8de5-65dd-7a44c0ec2c3a@baylibre.com>
Date:   Fri, 7 Apr 2023 16:40:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] soc: mediatek: Kconfig: Add MTK_CMDQ dependency to
 MTK_MMSYS
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, matthias.bgg@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20230403093304.276418-1-angelogioacchino.delregno@collabora.com>
Content-Language: en-US
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230403093304.276418-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2023 11:33, AngeloGioacchino Del Regno wrote:
> The mtk-mmsys and mutex drivers do have a dependency on MTK_CMDQ,
> even though both can work with *or* without it: since CMDQ support
> can be enabled either as module or as built-in, it is necessary to
> add a depends rule in Kconfig, so that we disallow building both
> mtk-mmsys and mtk-mutex as built-in if mtk-cmdq-helper is built as
> a module, otherwise obvious linker issues appear.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
> 
> This has no Fixes tag because the commit that can produce the issue that gets
> prevented in this commit is already in the maintainer's tree.
> 
>   drivers/soc/mediatek/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> index d6b83a5508ca..a88cf04fc803 100644
> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig
> @@ -76,6 +76,7 @@ config MTK_MMSYS
>   	tristate "MediaTek MMSYS Support"
>   	default ARCH_MEDIATEK
>   	depends on HAS_IOMEM
> +	depends on MTK_CMDQ || MTK_CMDQ=n
>   	help
>   	  Say yes here to add support for the MediaTek Multimedia
>   	  Subsystem (MMSYS).

Hi Angelo

I guess it should also be done for DRM_MEDIATEK, if I refer to the lsmod 
result:

Module                  Size  Used by
mtk_cmdq_helper        20480  1 mediatek_drm
mtk_cmdq_mailbox       20480  1 mtk_cmdq_helper

Or is it maybe enough to protect the call of the dependent driver with 
IS_REACHABLE or IS_ENABLED helpers ?

What do you think ?

Regards,
Alexandre

