Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEAB6E1E6F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjDNIfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjDNIex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:34:53 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2727AB4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 01:34:51 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-504ecfdf6b6so2467544a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 01:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681461289; x=1684053289;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MBhd+vki+l/y35U/QxrHM0V6qWO53SJzOsxvHiS3VI4=;
        b=IkuwrlTZ7zhdSP0BuUPKvyREuOd14Kbfh+OkUBnZYPh19M/pPTs1AehNACOKrDUdOG
         mS4MITBjLL7awLODadt0N7TgsMQrt20z+ehY4MsckGyU/ZLfEpRUMjJ6zZJFFo1pUHm+
         DaOoGRLicugjTWnlVrxNhWHsxHKyfybWO7o1a5FbdhVsF2XFWdtON7SqlBPMawhF3wMn
         FgcSDitIhYEKTfb/ee7KSmy9bA+543T+wqlwInRxiSu8cwOxfZjhq57bAYdmU3dSXrxH
         nEIwLbiwZWKYu1v4zqBLmdoTxBkfuWIR5SYBNxNo67kvqzNok8hvxQXzZI/WpPM9sHD9
         aXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681461289; x=1684053289;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MBhd+vki+l/y35U/QxrHM0V6qWO53SJzOsxvHiS3VI4=;
        b=Eb+mlCEYw5G1xNVO8zLp7dfV/zuzkANo5j5kIDSMb/127Dfs6sty6lW8v4wm3hMiml
         E1SR+A/u1had1jbL/x8tx9qL1hhH0GHwp1j0qXblODuVVWmf1INdUcT6F6PZRnxnm0NL
         qOFcXodbdJBySwhG70czgA5ELEs/tTgWPWZFAtPofpKTqEQrZQ3UV+H/H9fwch7uQmt1
         V4IUoqH3N71jRphSM+Ru3ajKMJOLAX4TxKFCR1A1X+sqZhjfXXGzyUtMVVLQnrWhgikL
         5Zl2BCQMHfH20J14GSfg5SuztMWbdeV/U8j0bdDsncGy4DExookNjNPG0jRh785rjCTY
         Aakg==
X-Gm-Message-State: AAQBX9fYUs6vg2O9G/8FxBRM/9KFXlRQ2uQZurNP/PGyd6b9HrhkIgFc
        Pf+X3poAZEpmBkaxoRgqVHfgRQ==
X-Google-Smtp-Source: AKy350b+AJCpD5JSQDbMuD6wVN5frKxcfCROijIG1NiaMj6S2xAmFKa5BnZL7BAyt/fgf8Mo/weUUQ==
X-Received: by 2002:aa7:d50f:0:b0:504:80f8:f6b2 with SMTP id y15-20020aa7d50f000000b0050480f8f6b2mr4795583edq.25.1681461289674;
        Fri, 14 Apr 2023 01:34:49 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:8a60:6b0f:105a:eefb? ([2a02:810d:15c0:828:8a60:6b0f:105a:eefb])
        by smtp.gmail.com with ESMTPSA id j23-20020aa7de97000000b0050432d2b443sm1883036edv.48.2023.04.14.01.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 01:34:49 -0700 (PDT)
Message-ID: <f8a4fd52-52b6-dded-c8b7-864be549e2ad@linaro.org>
Date:   Fri, 14 Apr 2023 10:34:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 01/27] dt-bindings: pwm: Add compatible for MediaTek
 MT6795
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, chunfeng.yun@mediatek.com,
        vkoul@kernel.org, kishon@kernel.org, thierry.reding@gmail.com,
        chunkuang.hu@kernel.org, ck.hu@mediatek.com,
        jitao.shi@mediatek.com, xinlei.lee@mediatek.com,
        houlong.wei@mediatek.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@collabora.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
 <20230412112739.160376-2-angelogioacchino.delregno@collabora.com>
 <aaeeb18d-f8e8-d6c1-1272-e5b797554b9e@linaro.org>
 <20230414083019.cpomx37tax4ibe5u@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230414083019.cpomx37tax4ibe5u@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 10:30, Uwe Kleine-König wrote:
> On Fri, Apr 14, 2023 at 10:21:05AM +0200, Krzysztof Kozlowski wrote:
>> On 12/04/2023 13:27, AngeloGioacchino Del Regno wrote:
>>> Add a compatible string for MediaTek Helio X10 MT6795's display PWM
>>> block: this is the same as MT8173.
>>>
>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>> ---
>>>  Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
>>> index 0088bc8e7c54..153e146df7d4 100644
>>> --- a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
>>> +++ b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
>>> @@ -22,7 +22,9 @@ properties:
>>>            - mediatek,mt8173-disp-pwm
>>>            - mediatek,mt8183-disp-pwm
>>>        - items:
>>> -          - const: mediatek,mt8167-disp-pwm
>>> +          - enum:
>>> +              - mediatek,mt6795-disp-pwm
>>> +              - mediatek,mt8167-disp-pwm
>>
>> This does not look correct. You do not add compatible, you replace
>> breaking all mt8167-disp-pwm. At least it looks like this from context.
> 
> I thought the old semantic to be:
> 
> 	"mediatek,mt8167-disp-pwm"
> 
> and the new
> 
> 	"mediatek,mt6795-disp-pwm" or "mediatek,mt8167-disp-pwm"
> 
> . What am I missing?

The new is ok for mt6795 but it is not valid for mt8167.

Best regards,
Krzysztof

