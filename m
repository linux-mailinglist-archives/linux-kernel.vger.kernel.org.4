Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FA25BBCD2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 11:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiIRJcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 05:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIRJcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 05:32:09 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D0A20BD1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 02:32:07 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x27so9029572lfu.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 02:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=jRfTWemLr6NthIORn54hYU2A7/v8x5DzAcs7HxCHtt0=;
        b=HlQfxtbd4p2nTCd2bPVs6NsfI6/NyeGnjwrBFoVcpxotPfhSAArkhB95zEL3SJtwWH
         nKbU4i7D1uWa0VIcmsocgNOI5j8nLCBZeesbCENXDcF1i6MGeEqbcwLCu72DtueKZqsm
         jtkIvLKRSDVLwnehbuBQeENj+01OD3cTC/GTvlQ8NWhUTKnIKSq3joVtgXqUBWsU35eG
         8GAyHNqI66NlF1adLSwmfxgrsIDk6gpy6BeEZJES5OgsCf1ltuAFyYbOI/UrGoY/Wy2S
         Lvc2yBC6CQFbYwovKYL5FZiGyHbyy5C9XdT0VYvSIocFky8Z5TafaSdfv0sqLpGilJBS
         08Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=jRfTWemLr6NthIORn54hYU2A7/v8x5DzAcs7HxCHtt0=;
        b=KzmazlW7nMB530ius1squoytXccOCtObSHZaLZvL7a+5t2NZF9PPCaFf/ERgzirlGq
         ThBlQTCEa4OzbAZq5xnV83Ao2FWOvcVnE+AyujHiCzilVr8JY1yB24WBadVrhEf2xYSf
         U4VCO8Mxu1dqOR9J1CFM+YQWVbdf1mU/irIrUCOUiaDadydNsKI0R70k+Xq3szcOvKJD
         UTcfJ7XoSUWVvW8j3jo0ol+6sG7R3fx1QNunxaIhuk7Ngy4GvQhoXUptHp8uF62AlwNW
         QihPkNoJjP6MBIa9X5Uu4y7iz1t6imxLV9w+rveqGVMn+w0h7tATihWNKX4l2gdMDptm
         EzZw==
X-Gm-Message-State: ACrzQf3+N5w8uzeWusvQpuLwBmSOdHVvUSlJG83jIepYhg0kr/654sSK
        FoMl7gz6r71W5pZN889Sk+dWdA==
X-Google-Smtp-Source: AMsMyM6LutjsjtgHTG/aA+H1yVQ7fmKsKsJ2x+CnLGCMnrdlR7RpV6+ZVk1d7/e5+0oAOutW6nNuGg==
X-Received: by 2002:a19:7619:0:b0:49f:6cd7:45c2 with SMTP id c25-20020a197619000000b0049f6cd745c2mr1769336lff.7.1663493525421;
        Sun, 18 Sep 2022 02:32:05 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id b20-20020a2ebc14000000b0026c15d60ad1sm78103ljf.132.2022.09.18.02.32.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 02:32:04 -0700 (PDT)
Message-ID: <17cacc6f-173f-ad6c-9056-1b17635c984d@linaro.org>
Date:   Sun, 18 Sep 2022 10:31:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/6] dt-bindings: arm: mediatek: mmsys: change
 compatible for MT8195
Content-Language: en-US
To:     Jason-JH Lin <jason-jh.lin@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220915161817.10307-1-jason-jh.lin@mediatek.com>
 <20220915161817.10307-2-jason-jh.lin@mediatek.com>
 <e6921ed7-a14c-aadb-abd4-1e7ee0a63be9@gmail.com>
 <f30bd382eb8923256d6f39342ec7832774c0f547.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f30bd382eb8923256d6f39342ec7832774c0f547.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/2022 04:34, Jason-JH Lin wrote:
> Hi Matthias,
> 
> Thanks for the review.
> 
> On Fri, 2022-09-16 at 00:05 +0200, Matthias Brugger wrote:
>>
>> On 15/09/2022 18:18, Jason-JH.Lin wrote:
>>> For previous MediaTek SoCs, such as MT8173, there are 2 display HW
>>> pipelines binding to 1 mmsys with the same power domain, the same
>>> clock driver and the same mediatek-drm driver.
>>>
>>> For MT8195, VDOSYS0 and VDOSYS1 are 2 display HW pipelines binding
>>> to
>>> 2 different power domains, different clock drivers and different
>>> mediatek-drm drivers.
>>>
>>> Moreover, Hardware pipeline of VDOSYS0 has these components: COLOR,
>>> CCORR, AAL, GAMMA, DITHER. They are related to the PQ (Picture
>>> Quality)
>>> and they makes VDOSYS0 supports PQ function while they are not
>>> including in VDOSYS1.
>>>
>>> Hardware pipeline of VDOSYS1 has the component ETHDR (HDR related
>>> component). It makes VDOSYS1 supports the HDR function while it's
>>> not
>>> including in VDOSYS0.
>>>
>>> To summarize0:
>>> Only VDOSYS0 can support PQ adjustment.
>>> Only VDOSYS1 can support HDR adjustment.
>>>
>>> Therefore, we need to separate these two different mmsys hardwares
>>> to
>>> 2 different compatibles for MT8195.
>>>
>>> Fixes: 81c5a41d10b9 ("dt-bindings: arm: mediatek: mmsys: add mt8195
>>> SoC binding")
>>> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
>>> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
>>> ---
>>>   .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml        |
>>> 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yam
>>> l
>>> b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yam
>>> l
>>> index 6ad023eec193..0e267428eaa6 100644
>>> ---
>>> a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yam
>>> l
>>> +++
>>> b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yam
>>> l
>>> @@ -31,7 +31,7 @@ properties:
>>>                 - mediatek,mt8183-mmsys
>>>                 - mediatek,mt8186-mmsys
>>>                 - mediatek,mt8192-mmsys
>>> -              - mediatek,mt8195-mmsys
>>> +              - mediatek,mt8195-vdosys0
>>
>> Nack, we miss the fallback compatible, as I already said twice.
>>
>> Regards,
>> Matthias
> 
> I'm sorry this happened again.
> I'll keep the compatible "mediatek,mt8195-mmsys" at next version.
> 
> The patch "dt-bindings: arm: mediatek: mmsys: remove the unused
> compatible for mt8195" should be sent after accepting the vdosys1
> series, right?

I don't think there will be no such patch...

You need to add a bindings change which will accept device nodes like:
foo {
  compatible = "mediatek,mt8195-vdosys0", "mediatek,mt8195-mmsys";

}

Example-schema shows how to do it.

Best regards,
Krzysztof
