Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B7873B625
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 13:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjFWL3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 07:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjFWL3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 07:29:48 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E353213C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 04:29:46 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f8fcaa31c7so8085215e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 04:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687519785; x=1690111785;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GwLc2J0o+y5k6wlRVJRO3JHyqT4XLHI9Q44A1K2LKY0=;
        b=zvDJX6vY/uiWXlyfmlBjjf6R7Br40yyDfeI1GUAFj0tGhAX42GnYu0AXt9p50h58Yy
         wljtBAy/FjDNNHNSMqFmkK4HdulH3oOl7+iNC22mh35B4dm1inWC66i/gQ6ifYK0r0m8
         DsyM/+DLmC/9Qo6T4cQM0ubF2YLJoQxK5aiaLaJVq9SDQTUWEDBb0oHR3s97MGkkqJm+
         VTvGxO3UCOHOI4nIsHxxXjxeNwmTf4dbvXKDAPDSeewQfPycGNrGwFaRtplSSSO0DtWm
         yQDj4lfAMr+QX/YfbODPOZaFvndAWGQeDeyobrJEia/Kh1+jbw13QfhiGI22kwnr5KDp
         A8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687519785; x=1690111785;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GwLc2J0o+y5k6wlRVJRO3JHyqT4XLHI9Q44A1K2LKY0=;
        b=VB1dKAOhEPz6hIe9syONKa/utOJbAZlYRbMaJhUoFtTjjGakz3rM52pzHKu5xKv32U
         IBCcm8+1+Sk/BGrYa5o2BPdWClorFjg7lLK818fhKJNERXmbhGneZ9pMxiGB3v0HwEll
         lmkEPy6RUMJ/pQg3uOi9guuEEGgcigFtsupdoe/crs1pZ6htqAINky5KztxWKgyV9kkL
         qCuTyK7CStxpVLMo6TrNp9vvLWXNZIlxdOJm4+M2LVz11QhIQxDreA0rEqxoHW172Zla
         HH+eb71FgujM4JRxJSjvpT9NcfIipD6QO6Vk/7uq0P1pCpcTzTur1ZwwhITCNbuXz6cE
         SNZg==
X-Gm-Message-State: AC+VfDzNCnOtaVqrMhei2YynldJnCGxLcnQ/gfTiloCbMS93NcG/M5a6
        bap2Vy7uMMgPcCo3Kj8UdlHKmA==
X-Google-Smtp-Source: ACHHUZ5aPtUZFe/KKL/C7n1SGLSR1IlxyOoKC4gu0sd+mBCMxwwyM4tC0jICO/cIs2AZ1uae8JQDBg==
X-Received: by 2002:a05:600c:24a:b0:3f9:b06:a3f6 with SMTP id 10-20020a05600c024a00b003f90b06a3f6mr17252877wmj.24.1687519784873;
        Fri, 23 Jun 2023 04:29:44 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id y17-20020a1c4b11000000b003f9b24cf881sm2103050wma.16.2023.06.23.04.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 04:29:44 -0700 (PDT)
Message-ID: <2f1d4e6b-bf03-25d1-dac2-83e0dbd5734f@baylibre.com>
Date:   Fri, 23 Jun 2023 13:29:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm: mediatek: mtk_dsi: Fix NO_EOT_PACKET
 settings/handling
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, jitao.shi@mediatek.com, ck.hu@mediatek.com,
        shaoming.chen@mediatek.com, yt.shen@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230523104234.7849-1-angelogioacchino.delregno@collabora.com>
 <735623c5-3eeb-bda3-db87-2b33d9ad3446@collabora.com>
Content-Language: en-US
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <735623c5-3eeb-bda3-db87-2b33d9ad3446@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/06/2023 11:47, AngeloGioacchino Del Regno wrote:
> Il 23/05/23 12:42, AngeloGioacchino Del Regno ha scritto:
>> Due to the initial confusion about MIPI_DSI_MODE_EOT_PACKET, properly
>> renamed to MIPI_DSI_MODE_NO_EOT_PACKET, reflecting its actual meaning,
>> both the DSI_TXRX_CON register setting for bit (HSTX_)DIS_EOT and the
>> later calculation for horizontal sync-active (HSA), back (HBP) and
>> front (HFP) porches got incorrect due to the logic being inverted.
>>
>> This means that a number of settings were wrong because....:
>>   - DSI_TXRX_CON register setting: bit (HSTX_)DIS_EOT should be
>>     set in order to disable the End of Transmission packet;
>>   - Horizontal Sync and Back/Front porches: The delta used to
>>     calculate all of HSA, HBP and HFP should account for the
>>     additional EOT packet.
>>
>> Before this change...
>>   - Bit (HSTX_)DIS_EOT was being set when EOT packet was enabled;
>>   - For HSA/HBP/HFP delta... all three were wrong, as words were
>>     added when EOT disabled, instead of when EOT packet enabled!
>>
>> Invert the logic around flag MIPI_DSI_MODE_NO_EOT_PACKET in the
>> MediaTek DSI driver to fix the aforementioned issues.
>>
>> Fixes: 8b2b99fd7931 ("drm/mediatek: dsi: Fine tune the line time 
>> caused by EOTp")
>> Fixes: 2d52bfba09d1 ("drm/mediatek: add non-continuous clock mode and 
>> EOT packet control")
>> Signed-off-by: AngeloGioacchino Del Regno 
>> <angelogioacchino.delregno@collabora.com>
> 
> Gentle ping for an important fix.
> 
> Regards,
> Angelo
> 
>> ---
>>   drivers/gpu/drm/mediatek/mtk_dsi.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c 
>> b/drivers/gpu/drm/mediatek/mtk_dsi.c
>> index 7d5250351193..b0ab38e59db9 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
>> @@ -407,7 +407,7 @@ static void mtk_dsi_rxtx_control(struct mtk_dsi *dsi)
>>       if (dsi->mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS)
>>           tmp_reg |= HSTX_CKLP_EN;
>> -    if (!(dsi->mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET))
>> +    if (dsi->mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET)
>>           tmp_reg |= DIS_EOT;
>>       writel(tmp_reg, dsi->regs + DSI_TXRX_CTRL);
>> @@ -484,7 +484,7 @@ static void mtk_dsi_config_vdo_timing(struct 
>> mtk_dsi *dsi)
>>                 timing->da_hs_zero + timing->da_hs_exit + 3;
>>       delta = dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST ? 18 : 12;
>> -    delta += dsi->mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET ? 2 : 0;
>> +    delta += dsi->mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET ? 0 : 2;
>>       horizontal_frontporch_byte = vm->hfront_porch * dsi_tmp_buf_bpp;
>>       horizontal_front_back_byte = horizontal_frontporch_byte + 
>> horizontal_backporch_byte;
> 
> 

Sounds logic

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre
