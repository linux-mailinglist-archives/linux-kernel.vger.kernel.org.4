Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA5861F672
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbiKGOoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiKGOoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:44:01 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2DA63B4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:44:00 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id u2so16612787ljl.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 06:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i0O2rk5E0cL+fm306yvacQlome9MWqlkSl0PtbnJ/Fk=;
        b=KGd9O5AMOGZXp+tE3f0j+hwAkW+8r8XE9RmQsXGMLtLEL+k0tlrOTlc9x3z6DY60pT
         hoRXvYOeD/Og/ka1ZIfwjHVVwiYkMECBdxL+qr6sOmlcw2M4myVgfy3mUcsg34OUY9JJ
         q2lBidE2ZbHrX8DY8H34jBlgMAfqbaTK5gWDjPBKRDyH0O/aQ5nkMbT7YyKZ1J3wKPKE
         g2HXUzVU7qAK/Wi5p4uk8UO+C3/OrXQtIeJ+BKMBSvKfMctlvCZ9EjPETJgknfSh0Eme
         qzAIsFJwkk2g1boA0NctS759r6L3DUzwJ6BMZO1g8SlxiYVglENC/U8KI+IphbjhOzQm
         oWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0O2rk5E0cL+fm306yvacQlome9MWqlkSl0PtbnJ/Fk=;
        b=4Elo3eUqbztJvI9clm15Qdd2PMIZWK6bmIoY4L+H+iepuCnXYiNB+fhdpjB9wxh2Gr
         QjE3+eZMFrGcIcHIFTgjZctEgMj1B3U1btfelAJYKE45MjhxTFr4LSKctQvY6AHuCHOi
         0YYCo1AY2yhghT6E6VUmJLfP3lYTJaA4dAY6edNB/btU00CXaUFsUuJ+DlczlX8ArOt1
         gIPGDMkm/4iebBLp4QpIQHn70VSIX90IhyP5ukYctY44+a5cBSzpX2jNRuZBRfLY5t6j
         VFn/TIXvtzReqNVBJrveMjDZryUTzqc4Mvpdi2azhVK1gF3Fzb53MWTGFiZwciuCIFvP
         Otnw==
X-Gm-Message-State: ACrzQf2tTkk59wWzS+mFXnIhTfQXHHumZWGbg0GVfh5ptaASeBQJRZVJ
        5KhpqikCq6FlDtbErDHdBez6LH9pLBzBjC9p2dOyeg==
X-Google-Smtp-Source: AMsMyM6xHORFjhVs0PnFDG1Q5hbXYVz1Gde1fVXPnnjTrXUg8FmzxrTbBpDXilPPBRiYEYQWH0D3yvUDzcEPlfT2y8I=
X-Received: by 2002:a2e:2e0c:0:b0:277:75bb:429e with SMTP id
 u12-20020a2e2e0c000000b0027775bb429emr9673388lju.314.1667832238908; Mon, 07
 Nov 2022 06:43:58 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 7 Nov 2022 14:43:58 +0000
From:   Guillaume Ranquet <granquet@baylibre.com>
User-Agent: meli 0.7.2
References: <20220919-v3-0-a803f2660127@baylibre.com> <20220919-v3-3-a803f2660127@baylibre.com>
 <05183178-32cb-98c0-4fcb-d5e78874e6c4@collabora.com>
In-Reply-To: <05183178-32cb-98c0-4fcb-d5e78874e6c4@collabora.com>
MIME-Version: 1.0
Date:   Mon, 7 Nov 2022 14:43:58 +0000
Message-ID: <CABnWg9sZ29jnCbCjtJ-tLWn2s1JYjFVEEGkau72WJyukHWU9=Q@mail.gmail.com>
Subject: Re: [PATCH v3 03/12] drm/mediatek: hdmi: use a regmap instead of iomem
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Jitao shi <jitao.shi@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, CK Hu <ck.hu@mediatek.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, stuart.lee@mediatek.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        mac.shen@mediatek.com, linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Nov 2022 12:20, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>Il 04/11/22 15:09, Guillaume Ranquet ha scritto:
>> To prepare support for newer chips that need to share their address
>> range with a dedicated ddc driver, use a regmap.
>>
>> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
>> ---
>>   drivers/gpu/drm/mediatek/mtk_hdmi.c | 43 +++++++++++--------------------------
>>   1 file changed, 13 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
>> index 4c80b6896dc3..9b02b30a193a 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
>> @@ -171,7 +171,7 @@ struct mtk_hdmi {
>>   	u32 ibias_up;
>>   	struct regmap *sys_regmap;
>>   	unsigned int sys_offset;
>> -	void __iomem *regs;
>> +	struct regmap *regs;
>>   	enum hdmi_colorspace csp;
>>   	struct hdmi_audio_param aud_param;
>>   	bool audio_enable;
>> @@ -187,44 +187,29 @@ static inline struct mtk_hdmi *hdmi_ctx_from_bridge(struct drm_bridge *b)
>>   	return container_of(b, struct mtk_hdmi, bridge);
>>   }
>>
>> -static u32 mtk_hdmi_read(struct mtk_hdmi *hdmi, u32 offset)
>> +static int mtk_hdmi_read(struct mtk_hdmi *hdmi, u32 offset, u32 *val)
>>   {
>> -	return readl(hdmi->regs + offset);
>> +	return regmap_read(hdmi->regs, offset, val);
>>   }
>>
>>   static void mtk_hdmi_write(struct mtk_hdmi *hdmi, u32 offset, u32 val)
>>   {
>> -	writel(val, hdmi->regs + offset);
>> +	regmap_write(hdmi->regs, offset, val);
>>   }
>>
>>   static void mtk_hdmi_clear_bits(struct mtk_hdmi *hdmi, u32 offset, u32 bits)
>
>You don't need these functions anymore, as these are now simply wrapping
>regmap calls, hence these don't contain any "real" logic anymore.
>
>Please remove them and use the regmap API directly.
>
>Thanks,
>Angelo
>

Agree with that, my intent was to minimize the change size so that it
would be easy to review.

My mistake, I'll remove the wrappers.

Thx,
Guillaume.
