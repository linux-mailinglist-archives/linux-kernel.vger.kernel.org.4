Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A470E6404DE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 11:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbiLBKj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 05:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiLBKj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:39:28 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48BFCB232
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 02:39:26 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id g12so6787485lfh.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 02:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ef557i72aMQlngP0CR0TyvH/ZX7gYwQJNFizHVtrS8s=;
        b=ek+L0K7Nla/F75a0wpr2UxYvBlS35TOSE8Y4aOZSPRGN+orKx3eaQmegEynNl4VcZc
         rQ8hj2UGt2g+Nd2cUGE5/A9iur4qvaD58k9HH0c85RQ38SpLWG190z/TfK+OB5CB28XE
         6Ob8d3L7p+39h8slyCLdErS2iDCLPk0DvJBMvVO8sj5XfZtOcrQ0eaUueB0S2HErbJsh
         greR/NkPNQEjF5eTng5Na28Rn765Kz0qPJPk0BDWr3DpXxThA8iClKOsotMR5x6WXPf2
         EJE8QX0vt5BCeAScVGIzjA9cuOsmysGD8Vd/Jsjnf8MoU3Jq1UtS8FMrQzF7oPvvZ8Yx
         EQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ef557i72aMQlngP0CR0TyvH/ZX7gYwQJNFizHVtrS8s=;
        b=iAyVVeB+jdImjqHy8jtD8/7/PSmGohzBh5UxtHqUa4VlRTZBJbzGCQ7SxRfqxZpN/e
         a5Ty7HAsn5/8T6cRtin6R13EEv64ycTNVCxl0LnyWtT2BjuPp5WFMxTl+vQIS/OwRXWl
         5/qlBuoU5nU14autppoNaXoedVvXfkSYJfANG409wY4/0KrBGwMex07CBWjJgxcd8bc/
         lFIvAnSbVAjbvXTdoEteEtTwL6nWBt2rzluvswcCrQzltLzbo1gC8NgYMnAmSp1MzH7f
         7tB4epVTk/HoOjfbG8J7MiUYUy59kiSKf6cvtATd4AzWeQhRViM+W9nq5//+PWuPU1ra
         bWXg==
X-Gm-Message-State: ANoB5pknQxebpGm1kfD+mTfBq+Nw3DremWqm+b/cfA7tGEPdAD7Pz+G2
        9lwcqjf0iELrzznTflVIn1IJDA==
X-Google-Smtp-Source: AA0mqf5CiqJzkOnZgB2HygNfmbp7IoLeH7ChCoKN+8ZqGkL7yeYNWcM7WmVgmTfPsS+E7EtfU93Idg==
X-Received: by 2002:a19:dc08:0:b0:4b4:6460:24d with SMTP id t8-20020a19dc08000000b004b46460024dmr22964505lfg.386.1669977564984;
        Fri, 02 Dec 2022 02:39:24 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v5-20020ac258e5000000b00492ea54beeasm972470lfo.306.2022.12.02.02.39.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 02:39:23 -0800 (PST)
Message-ID: <cea3cdd4-3d36-1439-b211-047091c05a0f@linaro.org>
Date:   Fri, 2 Dec 2022 11:39:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v8 01/11] dt-bindings: clock: meson: add A1 PLL clock
 controller bindings
Content-Language: en-US
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, sboyd@kernel.org, khilman@baylibre.com,
        kernel@sberdevices.ru, robh+dt@kernel.org,
        martin.blumenstingl@googlemail.com,
        linux-arm-kernel@lists.infradead.org, jian.hu@amlogic.com,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-amlogic@lists.infradead.org, jbrunet@baylibre.com,
        rockosov@gmail.com, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, neil.armstrong@linaro.org
References: <20221201225703.6507-1-ddrokosov@sberdevices.ru>
 <20221201225703.6507-2-ddrokosov@sberdevices.ru>
 <166995398251.2089685.16059995540663317860.robh@kernel.org>
 <20221202095124.4ecpfqhtzf34lwbf@CAB-WSD-L081021>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221202095124.4ecpfqhtzf34lwbf@CAB-WSD-L081021>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2022 10:51, Dmitry Rokosov wrote:
> On Thu, Dec 01, 2022 at 10:10:04PM -0600, Rob Herring wrote:
>>
>> On Fri, 02 Dec 2022 01:56:53 +0300, Dmitry Rokosov wrote:
>>> From: Jian Hu <jian.hu@amlogic.com>
>>>
>>> Add the documentation to support Amlogic A1 PLL clock driver,
>>> and add A1 PLL clock controller bindings.
>>>
>>> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
>>> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
>>> ---
>>>  .../bindings/clock/amlogic,a1-pll-clkc.yaml   | 52 +++++++++++++++++++
>>>  include/dt-bindings/clock/a1-pll-clkc.h       | 16 ++++++
>>>  2 files changed, 68 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
>>>  create mode 100644 include/dt-bindings/clock/a1-pll-clkc.h
>>>
>>
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>
>> yamllint warnings/errors:
>> ./Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml:26:6: [warning] wrong indentation: expected 6 but found 5 (indentation)
>>
>> dtschema/dtc warnings/errors:
>> ./Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml: $id: relative path/filename doesn't match actual path or filename
>> 	expected: http://devicetree.org/schemas/clock/amlogic,a1-pll-clkc.yaml#
>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.example.dtb: pll-clock-controller@7c80: reg: [[0, 31872], [0, 396]] is too long
>> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
>>
>> doc reference errors (make refcheckdocs):
>>
>> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221201225703.6507-2-ddrokosov@sberdevices.ru
>>
>> The base for the series is generally the latest rc1. A different dependency
>> should be noted in *this* patch.
>>
>> If you already ran 'make dt_binding_check' and didn't see the above
>> error(s), then make sure 'yamllint' is installed and dt-schema is up to
>> date:
>>
>> pip3 install dtschema --upgrade
>>
>> Please check and re-submit after running the above command yourself. Note
>> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
>> your schema. However, it must be unset to test all examples with your schema.
>>
> 
> Please find all fixes of above warnings and errors in the my patch
> located at the link:
> 
> https://lore.kernel.org/linux-amlogic/20221201225703.6507-9-ddrokosov@sberdevices.ru/

Why? This patch here is broken and it should be fixed. Don't apply
broken patches...

Best regards,
Krzysztof

