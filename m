Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0185EC39C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbiI0NGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbiI0NGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:06:08 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D37155433
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:06:07 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so15498782pjq.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:from:to:cc:subject:date;
        bh=tVImipPJ55LLlj3hxov+6J9Uas9BlzTbH/QBaoiYcnE=;
        b=AeFiLZSELiOLu0C/WY7j3qNn2XbPtZX/1DfSK5wxjFb2rqwPO7CvvZtAFF5v6/7J26
         ahCqqp2F9wNI5OYX7qy/ObhCyFoh9fcBwqqwDTOmQ3Szz628RGrS+W9AFjoVJocXlWki
         VC0GYuee8hoFp6tnnZjb+BQvkFkX4acVrRZQaXEcy3Crna/0t54Jbazxa/CYEy/0/zFu
         2lndzQwEpvpkb26lSSoBm5VVsMti9KIfqB8rnh9R4Sn70IUDgJCGjP5FzkG0xZM/8Ujz
         ktOS6zIlcVHVVfda96Denge0ZrYEMhecJgtt3RQnWSFrUZInrw19D5HLdT/lXGWs6zAx
         AlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:x-gm-message-state:from:to:cc:subject:date;
        bh=tVImipPJ55LLlj3hxov+6J9Uas9BlzTbH/QBaoiYcnE=;
        b=UgPvwh5BktNXZJ6gabRKRon5PHAjJKNThrm5grR9Bl+GQMiFWnNvH4UdLIDhqECxqE
         p4T2MMt0tZyIAUe/wz3q7abbrnn4Dik2+RKpUo9DiyIPkYmSWeUgsF26DwkMvel9A1OV
         PCwOMdSFYSY9IO8I/J2TLaAnm9aC49BcWtrvziqTACLjZ645Mgi1S/NuRrDbbNx519MY
         z/Oz7TjItg1OfHbqtEKzwk7DjrP7ptvelCCfHT1xAmiXMDyKfd0oxy/3+SNViwaHv9ZH
         57bjpFLANsXi3eRkXi27x59PyApn8PAnFngk7jWa1tdmd1Fk+AH0owW0jSO+rcCFHBcs
         WhrQ==
X-Gm-Message-State: ACrzQf1MJJJAy5160xnHbsOh8O0I9Ca92aoUtuC8yRD0fwRmYhtCBtFu
        LcJFbVUazg6N0E4SRhkSb0lL0nYuIE8TSu+ZiPGQBA==
X-Google-Smtp-Source: AMsMyM6iYfFfRkY7ZCfN7iH6SfIok108DtV5xTUiUrfRhR4EUYS3wDXnryle8l6ZhFGMR+ScZmNr7PCxr1+tKvPRj2I=
X-Received: by 2002:a17:90b:2643:b0:205:bd0d:bdff with SMTP id
 pa3-20020a17090b264300b00205bd0dbdffmr4399905pjb.99.1664283966835; Tue, 27
 Sep 2022 06:06:06 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Sep 2022 06:06:06 -0700
From:   Guillaume Ranquet <granquet@baylibre.com>
User-Agent: meli 0.7.2
References: <20220919-v1-0-4844816c9808@baylibre.com> <20220919-v1-5-4844816c9808@baylibre.com>
 <32c4822a-a094-5fa3-c2af-e515bf897937@collabora.com>
In-Reply-To: <32c4822a-a094-5fa3-c2af-e515bf897937@collabora.com>
MIME-Version: 1.0
Date:   Tue, 27 Sep 2022 06:06:06 -0700
Message-ID: <CABnWg9vsd7Lk4kR4j-XrgJXAX+sEd3J+oz3hFc4sEuCGRRy8qw@mail.gmail.com>
Subject: Re: [PATCH v1 05/17] drm/mediatek: hdmi: use a syscon/regmap instead
 of iomem
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Pablo Sun <pablo.sun@mediatek.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sep 2022 12:18, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>Il 19/09/22 18:56, Guillaume Ranquet ha scritto:
>> To prepare support for newer chips that need to share their address
>> range with a dedicated ddc driver, move to a syscon.
>>
>> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
>>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
>> index 3196189429bc..5cd05d4fe1a9 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
>
>..snip..
>
>> @@ -1428,7 +1413,6 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi,
>>   	struct device_node *cec_np, *remote, *i2c_np;
>>   	struct platform_device *cec_pdev;
>>   	struct regmap *regmap;
>> -	struct resource *mem;
>>   	int ret;
>>
>>   	ret = mtk_hdmi_get_all_clk(hdmi, np);
>> @@ -1474,8 +1458,7 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi,
>>   	}
>>   	hdmi->sys_regmap = regmap;
>>
>> -	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -	hdmi->regs = devm_ioremap_resource(dev, mem);
>> +	hdmi->regs = syscon_node_to_regmap(dev->of_node);
>
>Nack. You're breaking ABI, this will force everyone to add syscon to devicetree,
>hence this breaks retrocompatibility with old devicetrees.
>
>Hint: not here, device_node_to_regmap()

Hi Angelo,

I'm sorry, I didn't think device tree retro compatibility was a thing.

I'll drop the requirement for the module to be a syscon.
Thx for the hint.

Thx,
Guillaume.

>
>Regards,
>Angelo
>
>>   	if (IS_ERR(hdmi->regs)) {
>>   		ret = PTR_ERR(hdmi->regs);
>>   		goto put_device;
>
>
