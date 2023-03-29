Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD5D6CD3D4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjC2H7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjC2H7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:59:01 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD9F210D
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 00:59:00 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id bi9so19008065lfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 00:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680076739;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JhUeJU6e4h9PitXkQe9MfipgTdaNoe9G7C662XIORfM=;
        b=NlS/k/gyKOpyGz4+n2dMHIv5Jyl5X0BUWman6JDHpG5pL/V9m3XN7KqKkZcQiYffYF
         pYZwXz//KXBnXxhR+VP2YV4/VGQNt8AoW/Ar+WrbuzXfCS4cx9REG/xdtmcxDtFqpvtI
         UPcxSLbU/vsMu4bKc8gLObJSZbeA9I+siU4PlXG5JKdKbfwnTdy4k1tK8d5J+sjYH8l0
         klNL9UxtSg5IQKr6I1C2wu3s+ik9ffYX8NBI/KD2nPyyLAB8Pwi5zqOxLQnpMI6CjuEK
         VFfBufv+QdE1Ul/x+Qdw2CeP0Rm287S584hTA6bS6ft0+Un03enQEJu29BzO65tKlw8f
         dwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680076739;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JhUeJU6e4h9PitXkQe9MfipgTdaNoe9G7C662XIORfM=;
        b=N6Io9Dg/MRMPhT5yM+M8qm69WfLrz4TMjkk05Ue81f1ZRhTDiWV4fRz5QmzoBx6Jws
         SkSMw8/Glkd+qrqW6wM80muBwl/DdHhXX86Y2iNsKlQ2+qmDJRVZ1xBf3N8InaiaV+Am
         sgKhnJvei4QC6V1ab/lXPvUg3PkC2CgfibAolq4f4DoLxlTST2v5Wf4xzh03WSNpi0ll
         9I7Gsee3d+AjysvOtcD8GvAWc5ALLqj6Ms/N0Ak0S7YYTACImDxSGgZM1+Myd9OGRBq1
         hkHPWvRoaqYngzJJn2k1AnCRHAjf7hr/LQclHYQyK5Nuk3UlHbsB3myQvm46jIA5Cf+s
         ptQw==
X-Gm-Message-State: AAQBX9djWzieShT3y2kY3tI1oSuLlK/F/9ctdifImrOPkah6AXSAwecj
        rF3sUyPXDmYCEFdUdftsFFJNvQ==
X-Google-Smtp-Source: AKy350b+22Kn5HHx0uKk+5FJ3GJSg9tKTqXFD4BKu62/Z2qhoT6gF4mFK69Es0wrx/7N5SnIZDK8DA==
X-Received: by 2002:ac2:4859:0:b0:4e8:487a:7c34 with SMTP id 25-20020ac24859000000b004e8487a7c34mr5663278lfy.12.1680076738773;
        Wed, 29 Mar 2023 00:58:58 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id m19-20020a195213000000b004eaf393dc46sm3194558lfb.249.2023.03.29.00.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 00:58:58 -0700 (PDT)
Message-ID: <3fbb78e9-a450-3741-070b-2caedbaa47a5@linaro.org>
Date:   Wed, 29 Mar 2023 09:58:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: mediatek: deprecate custom
 drive strength property
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230327-cleanup-pinctrl-binding-v1-0-b695e32e4f2e@baylibre.com>
 <20230327-cleanup-pinctrl-binding-v1-1-b695e32e4f2e@baylibre.com>
 <334089fd-f0e8-bf63-5100-d8632c478ccc@collabora.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <334089fd-f0e8-bf63-5100-d8632c478ccc@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2023 15:41, AngeloGioacchino Del Regno wrote:
> Il 28/03/23 15:06, Alexandre Mergnat ha scritto:
>> Deprecate mediatek,drive-strength-adv which shall not exist, that was an
>> unnecessary property that leaked upstream from downstream kernels and
>> there's no reason to use it.
>>
>> The generic property drive-strength-microamp should be used instead.
>>
>> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
>> ---
>>   .../devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml      | 8 ++++++--
>>   .../devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml      | 6 +++++-
>>   2 files changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml
>> index c30cd0d010dd..b82a066b91ec 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml
>> +++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml
> 
> Thanks for doing MT8183!!!
> 
>> @@ -110,8 +110,13 @@ patternProperties:
>>             drive-strength:
> 
> ..snip..
> 
>> diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
>> index 4b96884a1afc..347f533776ba 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
>> +++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
>> @@ -91,8 +91,13 @@ patternProperties:
>>   
>>             input-schmitt-disable: true
>>   
>> +          drive-strength-microamp:
>> +            enum: [125, 250, 500, 1000]
>> +
>>             mediatek,drive-strength-adv:
>> +            deprecated: true
> 
> In the case of MT8365, since there's *no* devicetree using this property, *at all*,
> I think you can even just entirely remove this block, as that should not be
> considered an ABI breakage in that case.
> 
> Krzysztof, can you please confirm?

If it is defined as ABI in a released kernel, then should be rather
deprecated.

Best regards,
Krzysztof

