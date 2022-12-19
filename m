Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2597C650EA7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 16:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiLSPbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 10:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiLSPbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 10:31:37 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BAF63F5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 07:31:32 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id a19so9534332ljk.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 07:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S0DqKnIuSvbhL/BeaLxzkheTI1hi556Lt0X0PfWna4w=;
        b=gNAHP4f8oU+uSmknP1M4YQ+rOhfHavFCiNsIKK4QBSyFBStmpUhhvFHAaE3M/KGf9F
         3+T6yq/BY82gvlN6fPCqMfxNHcC2MlclJl2FYHbxT2baqfQaQgJirm+xMYWdROvamdgt
         z2w0lbFLLTQKPcpF4cG7gj288vACuKFP1ICfTEAKZjELgLLh1ciFwQgYGhpGCzn8cvpp
         iGKLjn2OQaxBtg20cn39EW+Lm8xYmcUzJpaorPYVWbLz8+IofEFi06JmJoEkIh3SfhgI
         ZEdkpol0s7PUdwHWkpNB3yeN6Xt4IrbUkmMWQiaKZdM+vzblx7QxmAiaKwsui3CmB/ap
         BYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S0DqKnIuSvbhL/BeaLxzkheTI1hi556Lt0X0PfWna4w=;
        b=JLbVOfX8WqZtZLeyM+K+8taR+cPezv0HisbQ7HQAZeKGhL/sVBEyVM+6D41V5pDulS
         PaKQ4HfC1cm//+tzsoio6uTpYnSuK+yOqwOr3y2dW1mcQXtG0y02s793AiiEA7q3oj0I
         FES0bPXtopoNwJaiya2/e8eGPAWtsw5Ur4CFpxedbBbRfcp+Wb5zFkLruTlMEDwbdW4B
         iCuKIRnI42H0UTmJQ/mllLGMhhE7T5WQ5UqedPFdLorUMa3Bdf5GJrzs7emivYWAzUMo
         Gis7O/Lq+t20lb5FGDWTQxxFuXwoUK/qAB+hCZ/RYINsSm1VdvOn0Gy7gp6n04T8CVjj
         DIKA==
X-Gm-Message-State: ANoB5pmOR1tIVjhS9T7aJMjYQWDj/snOcp3WTI+S8xI3BySjNNh5O6YV
        bziusBqmHs7QrK5usMGP4fyMsYYe6iNS5Z65
X-Google-Smtp-Source: AA0mqf62K7RiXYrDz+81q5ivGgJyq7Z3xcHpva+5wqa9zeOtJavBk8Qd1E204B2w/riWMJO5tFNuzw==
X-Received: by 2002:a05:651c:2203:b0:277:81a3:f6e0 with SMTP id y3-20020a05651c220300b0027781a3f6e0mr13923805ljq.19.1671463889352;
        Mon, 19 Dec 2022 07:31:29 -0800 (PST)
Received: from [192.168.0.20] (088156141227.dynamic-2-waw-k-3-1-0.vectranet.pl. [88.156.141.227])
        by smtp.gmail.com with ESMTPSA id bf33-20020a2eaa21000000b002770e6c620bsm764964ljb.106.2022.12.19.07.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 07:31:28 -0800 (PST)
Message-ID: <270ba2bf-6141-724c-7406-0e27503b21bd@linaro.org>
Date:   Mon, 19 Dec 2022 16:31:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 1/8] dt-bindings: arm: mediatek: mmsys: Add support for
 MT8195 VPPSYS
Content-Language: en-US
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Moudy Ho <moudy.ho@mediatek.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221207094921.15450-1-moudy.ho@mediatek.com>
 <20221207094921.15450-2-moudy.ho@mediatek.com>
 <CAL_JsqKdaVmGKSwR0yiYGKc6Kp6jki632GA6CBOOjGzUmvSRWA@mail.gmail.com>
 <ba8ce731-2d9c-901f-e208-deafe589b723@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ba8ce731-2d9c-901f-e208-deafe589b723@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2022 16:17, Matthias Brugger wrote:
> 
> 
> On 19/12/2022 14:44, Rob Herring wrote:
>> On Wed, Dec 7, 2022 at 3:49 AM Moudy Ho <moudy.ho@mediatek.com> wrote:
>>>
>>> For MT8195, VPPSYS0 and VPPSYS1 are 2 display pipes with
>>> hardware differences in power domains, clocks and subsystem counts,
>>> which should be determined by compatible names.
>>>
>>> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>   .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml     | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> This landed in today's linux-next causing the following binding
>> warnings. Is this a fix? Only fixes for 6.2 should be added during the
>> merge window.
>>
> 
> No it's not a fix, it's queued for the next -rc phase. I didn't know of the 
> limitation of linux-next only allowing fixes in the merge window.

Stephen asks for it every time. Now it is in separate email:

https://lore.kernel.org/linux-next/20221213120359.47fc3cad@canb.auug.org.au/

Previously it was in each linux-next announcement:
https://lore.kernel.org/linux-next/20220527164940.6ef5b25e@canb.auug.org.au/

> 
> Actually the patch is wrong. It shouldn't include "mediatek,mt8195-mmsys" as 
> fallback for mediatek,mt8195-vppsys[0,1].
> 
> I'll revert the whole series from v6.2-tmp/dts64 and v6.2-tmp/soc

Thanks. Please, drop all material for next cycle from linux-next.

Best regards,
Krzysztof

