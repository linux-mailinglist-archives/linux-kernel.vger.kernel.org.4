Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD0E640598
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 12:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbiLBLQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 06:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiLBLQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 06:16:28 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B782D20AE
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 03:16:27 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id f21so6032730lfm.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 03:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BiSfLTl0PMvNNjl+HsepmgENg8ShUkFOSLdhB9Xo4Ak=;
        b=voKPCwh0grJWEj8uf/S3XZfKzLt6qIETqimibcK1G98MSfCjBX56q9aPKIdwCGnoCm
         P81AtH7H1aoEz0HpKUIxyRr37AiCfO34VDMW8+t8dzDchhmlBEeGWJqJDDUiFYTTnSIN
         gIUF5KZxFSkR5c0zp42WRnG8ty5Z7zT77tNl9OkQWWrgYRGq84WmrN9n9JTyJ15UKmfy
         hnPniS5yR8C6c5bdoEPrdFJEl1ML6IE2FtiUwD+AOL5VWu+toxENiKow23YDDITwTavl
         oT+4AAn3M+LdmEKOyg7mxe6TJzy/BW4011mq/Gf+YDHWjSx2G+CKzZLSQkumbH+UB+mU
         sbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BiSfLTl0PMvNNjl+HsepmgENg8ShUkFOSLdhB9Xo4Ak=;
        b=ki5Z3PDttVxpOXM4IWejxva7m1RXhIuLMhIueNw5fYdtne4UabbdSKnI+8t5EXRN7K
         Ffds26pdUkEhgG5yL9mYS8PxdfASj3PzFpGVEWNtWR+dhaTLe+l6rNSWKY4Cm8VBRcwR
         GK+7L05vzBeZjBexutN65pcSq9JfAJWOvptOcUlBpmr33mc1KagM5IkHtd6v3WO6GDYB
         rZGQXK383sGNUpv/IulpmVP348rCexP+Luv/SkUrS4Lf6/5C20Bgabzg+xRHJBWF97XU
         OSMpTSiaPxrKjMgFiy4JOfHQX62bP/eEndbY6k1HXOE7HtYjMQlsnawlxUkxreYSZTe3
         TXBQ==
X-Gm-Message-State: ANoB5pnMEH9x/SK4qW8s+FIVeAwD20ItPHpQkH/mj6ICkjTzmV1o7KwS
        OdvsZ/Y1TXeNCxIJVbOWfHkXQw==
X-Google-Smtp-Source: AA0mqf4oe/AnY6kz8dPDDe/OkcmzaFVXmcv7PdLGNMtmCdDy3++4yPPS1jhwg934DtAlqaBIL6uPKg==
X-Received: by 2002:a05:6512:3b12:b0:4b4:686b:4f7 with SMTP id f18-20020a0565123b1200b004b4686b04f7mr16762624lfv.256.1669979785967;
        Fri, 02 Dec 2022 03:16:25 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d11-20020ac2544b000000b004946bb30469sm983426lfn.82.2022.12.02.03.16.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 03:16:24 -0800 (PST)
Message-ID: <b425da35-c189-aabb-65b9-f956945d7b08@linaro.org>
Date:   Fri, 2 Dec 2022 12:16:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v8 01/11] dt-bindings: clock: meson: add A1 PLL clock
 controller bindings
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, sboyd@kernel.org, khilman@baylibre.com,
        kernel@sberdevices.ru, robh+dt@kernel.org,
        martin.blumenstingl@googlemail.com,
        linux-arm-kernel@lists.infradead.org, jian.hu@amlogic.com,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-amlogic@lists.infradead.org, rockosov@gmail.com,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        neil.armstrong@linaro.org
References: <20221201225703.6507-1-ddrokosov@sberdevices.ru>
 <20221201225703.6507-2-ddrokosov@sberdevices.ru>
 <166995398251.2089685.16059995540663317860.robh@kernel.org>
 <20221202095124.4ecpfqhtzf34lwbf@CAB-WSD-L081021>
 <cea3cdd4-3d36-1439-b211-047091c05a0f@linaro.org>
 <1jfsdy83h3.fsf@starbuckisacylon.baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1jfsdy83h3.fsf@starbuckisacylon.baylibre.com>
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

On 02/12/2022 12:04, Jerome Brunet wrote:
> 
> On Fri 02 Dec 2022 at 11:39, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 02/12/2022 10:51, Dmitry Rokosov wrote:
>>> On Thu, Dec 01, 2022 at 10:10:04PM -0600, Rob Herring wrote:
>>>>
>>>> On Fri, 02 Dec 2022 01:56:53 +0300, Dmitry Rokosov wrote:
>>>>> From: Jian Hu <jian.hu@amlogic.com>
>>>>>
>>>>> Add the documentation to support Amlogic A1 PLL clock driver,
>>>>> and add A1 PLL clock controller bindings.
>>>>>
>>>>> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
>>>>> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
>>>>> ---
>>>>>  .../bindings/clock/amlogic,a1-pll-clkc.yaml   | 52 +++++++++++++++++++
>>>>>  include/dt-bindings/clock/a1-pll-clkc.h       | 16 ++++++
>>>>>  2 files changed, 68 insertions(+)
>>>>>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
>>>>>  create mode 100644 include/dt-bindings/clock/a1-pll-clkc.h
>>>>>
>>>>
>>>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>>>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>>>
>>>> yamllint warnings/errors:
>>>> ./Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml:26:6: [warning] wrong indentation: expected 6 but found 5 (indentation)
>>>>
>>>> dtschema/dtc warnings/errors:
>>>> ./Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml: $id: relative path/filename doesn't match actual path or filename
>>>> 	expected: http://devicetree.org/schemas/clock/amlogic,a1-pll-clkc.yaml#
>>>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.example.dtb: pll-clock-controller@7c80: reg: [[0, 31872], [0, 396]] is too long
>>>> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
>>>>
>>>> doc reference errors (make refcheckdocs):
>>>>
>>>> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221201225703.6507-2-ddrokosov@sberdevices.ru
>>>>
>>>> The base for the series is generally the latest rc1. A different dependency
>>>> should be noted in *this* patch.
>>>>
>>>> If you already ran 'make dt_binding_check' and didn't see the above
>>>> error(s), then make sure 'yamllint' is installed and dt-schema is up to
>>>> date:
>>>>
>>>> pip3 install dtschema --upgrade
>>>>
>>>> Please check and re-submit after running the above command yourself. Note
>>>> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
>>>> your schema. However, it must be unset to test all examples with your schema.
>>>>
>>>
>>> Please find all fixes of above warnings and errors in the my patch
>>> located at the link:
>>>
>>> https://lore.kernel.org/linux-amlogic/20221201225703.6507-9-ddrokosov@sberdevices.ru/
>>
>> Why? This patch here is broken and it should be fixed. Don't apply
>> broken patches...
> 
> Dmitry is ressurecting a series that is several years old and not his to
> begin with.
> 
> He was unsure about take the code of somebody else.
> To be fair, he even asked for advice on IRC about to proceed.
> 
> Dmitry, as you may have guessed, for next revision, please fix Jian Hu
> original patches in place, not with fixup patches.
> 
> If your fixes are minor (not complete rewrite), please keep the original
> author and add your SoB

We never take intentionally wrong patches, e.g. code which does not even
compile, and immediately fix it in next patch.

Can you imagine adding such drivers? Which are broken in the commit they
are added?

So the patchset is old or abandoned, take ownership, add co-developed
etc. Just don't add known broken code.

Best regards,
Krzysztof

