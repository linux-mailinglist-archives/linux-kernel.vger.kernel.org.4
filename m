Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6421D6B046B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjCHKdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjCHKct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:32:49 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97CBB95D5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:31:56 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id j11so44197429edq.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 02:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678271515;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5fGIZnLIFi80hX7HHpoCzBcvuUsXk3QpRs3UM2gL+lo=;
        b=gaQALzwpvcbL7KPjaDCk/STd4S5aL7hRPMVMHnoSgsnqWzXFVM8O2mTRBeM87QN8d6
         3RwBwl5RZ2MBa9OEXFWpjKDF+zDVQffKtQ6PfH57Vet14nyHXuigr6dcLcAKvp1yJjc1
         wCI/EZ8n9413H3OBa+1dgCXU7yKmY2+Lmu9ymbGXr+TD690DwPjGa59/zWr1WP9n1O9U
         7CpbJKPhs0YNMeuRt17ycKlbvX07jNubQabi33ykwGWV0XlibhYTmCGf2mJeT5V8DvGg
         tzaN7OEUUfhdPShfmhdoFsQPChx8m7hxGojLvgGstBPHGj9wVnYtdZGs7y2VOAoAemQH
         6HwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678271515;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5fGIZnLIFi80hX7HHpoCzBcvuUsXk3QpRs3UM2gL+lo=;
        b=HypDvYsLzamGG4C8Zi+3qmOuZfwQTuWUTAKto8bnnZAeHO69+TclpQCWrUYqFcyolt
         Sbml/jlAAmwCccolN3VDhNRXgnbMw1hibo1dz18nj3SZ203Eu7qn81Ma5qt3FEyOUPjq
         zTqjGUXnSIE6236lXA4Cjm+9lk1Hv5ymtlTU/uGfP+G7pqgU4sVc+YIFbuMZndICwl/z
         6cKmHrrBWhB2a5hQK7deaxo0a8f0NchJrWGci3vcdKjXmWJScdVLphcb+qxzEgh+bYNa
         csaXppPu2+RxsovRy3+L2z0K0yctPQVSfddXd9GmfoW3kMxYQuhxQE6fAGWc2w9sjguw
         tVmg==
X-Gm-Message-State: AO0yUKVRn8vjSCODc2yVW+dZkFlJUjm9VtW6j5Q3+8BfaCEQEFBBUfWA
        L7w2bhd4FLP5d8kTTbhszjhk8A==
X-Google-Smtp-Source: AK7set/CYrEyIuSLyDDUXZR3jqT/vTu4yPfKXeDaChxuxkK9rk3kb6SHstIlWaN87B5ITGrT/52o2g==
X-Received: by 2002:a17:906:8a64:b0:88d:d76d:8527 with SMTP id hy4-20020a1709068a6400b0088dd76d8527mr15589278ejc.47.1678271515159;
        Wed, 08 Mar 2023 02:31:55 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:ff33:9b14:bdd2:a3da? ([2a02:810d:15c0:828:ff33:9b14:bdd2:a3da])
        by smtp.gmail.com with ESMTPSA id h10-20020a170906718a00b008c33ebac259sm7284857ejk.127.2023.03.08.02.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 02:31:54 -0800 (PST)
Message-ID: <dcf2b583-4b42-85b7-4de4-fb0b5011af5e@linaro.org>
Date:   Wed, 8 Mar 2023 11:31:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/6] dt-bindings: memory-controllers: mediatek,smi-larb:
 add mt8365
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20230207-iommu-support-v1-0-4f0c81fd52c1@baylibre.com>
 <20230207-iommu-support-v1-2-4f0c81fd52c1@baylibre.com>
 <4dba4db2-60da-02fe-6237-c5893fdf2e14@linaro.org>
In-Reply-To: <4dba4db2-60da-02fe-6237-c5893fdf2e14@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 11:30, Krzysztof Kozlowski wrote:
> On 07/03/2023 14:46, Alexandre Mergnat wrote:
>> Add binding description for mediatek,mt8365-smi-larb
>>
>> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
>> ---
>>  .../devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml     | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
>> index 5f4ac3609887..aee7f6cf1300 100644
>> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
>> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
>> @@ -34,6 +34,10 @@ properties:
>>            - const: mediatek,mt7623-smi-larb
>>            - const: mediatek,mt2701-smi-larb
>>  
>> +      - items:
>> +          - const: mediatek,mt8365-smi-larb
>> +          - const: mediatek,mt8186-smi-larb
> 
> You need to fix the allOf:if. It expects single item, so you need to add
> contains like for mt2701.

Wait, this was about common. LARB looks ok, but double check.

Best regards,
Krzysztof

