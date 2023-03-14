Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3686B9EC0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjCNSjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjCNSjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:39:01 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E4FB6911
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:38:34 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id r11so14276685edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678819077;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AuNgNT8D0EuAh1HyRh/9mY626Vq0K4RuneWS+CDoRGU=;
        b=Z7HmxYoFox3cYFH2X6pUtjUx/WnphBH2dLE5baDvxTm+8HmhZ51ONlfq1+vZizz00h
         MoqUdQkitikl3II9OovJ4SC3MFkTFAw46SGbkPz15Owf5BiDozeQi6p+8f2X38Cq76E7
         ElMQL463kCFMmYsVcz/MNnLTUiOizY4q/YfXVpNmJUQTUV50vj7E2uSLbW0e0vtrO7w+
         cpmAQJaoQ2fbNB28vatFWPR8oM9oLnenPp4BKV0GvkSPZPN08f+OdibGUcu50pUufVfY
         oFtfomlpuUB2xBSXPjQjskd1kssmf6ASvqK/W45Nhl4a1QjhmRPD1Sg3oNi0diUB9M/T
         ISjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678819077;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AuNgNT8D0EuAh1HyRh/9mY626Vq0K4RuneWS+CDoRGU=;
        b=K0kACnGkvn7yMfOF5E7KFTouwh2egie2aGfR4+e1hdG7ErPYRvx5WMQBNtH6HWF7Bv
         VDFpw3rQGSHMtGDKBS7tUQGxCBjE3BBVYE/b3aQE8a+IxOuyavIMBQEviWRmITPqjmkk
         8Gz9yRTcR9JL2Sha6xN7Ja6mxHA+FnaH3gCrSKEQIp8dH9aZtinniD6OKAkVoCQ4Ilvg
         tEKOK991ah/iFNCplNEPa/AqD17WZOIfKp88WCpPkD3LW2nw5Nr3gBfFErf/u+DIxrjk
         P91PJF/la9V/QKyen+9e0sQnOCmuBK95Fg1NaUFI/Lbg+n5O2jhxRHSzzMHyvpE54V/Z
         IDXA==
X-Gm-Message-State: AO0yUKXRPt3m0Q+GO1WqaYIOvgDrEqnVLBMftuzg9QQWzJFDOm6HeCnJ
        KLkB4H+P3iI5D1SObCsVahsFgQ==
X-Google-Smtp-Source: AK7set82bOBTZKdRnxAk1qFAzf9YFnq6NVKrvZuczwCT2pLIE3So1K51eTrLk738WixzMw0wwDDxJg==
X-Received: by 2002:a17:906:1b10:b0:870:baa6:6762 with SMTP id o16-20020a1709061b1000b00870baa66762mr3679366ejg.14.1678819076802;
        Tue, 14 Mar 2023 11:37:56 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:59be:4b3f:994b:e78c? ([2a02:810d:15c0:828:59be:4b3f:994b:e78c])
        by smtp.gmail.com with ESMTPSA id c20-20020a50f614000000b004d8d2735251sm1436152edn.43.2023.03.14.11.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 11:37:56 -0700 (PDT)
Message-ID: <7fc9a289-5317-6a40-73f1-b816083af8d1@linaro.org>
Date:   Tue, 14 Mar 2023 19:37:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] media: dt-bindings: ov2685: convert to dtschema
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh@kernel.org>, Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-media@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        phone-devel@vger.kernel.org
References: <20230206-ov2685-dtschema-v1-1-9e4da3474c10@z3ntu.xyz>
 <167572017056.1564123.13342855865502188090.robh@kernel.org>
 <aadd794f-8881-6ecf-4d9d-51a8a23fe4b2@linaro.org>
In-Reply-To: <aadd794f-8881-6ecf-4d9d-51a8a23fe4b2@linaro.org>
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

On 14/03/2023 19:37, Krzysztof Kozlowski wrote:
> On 06/02/2023 22:50, Rob Herring wrote:
>>
>> On Mon, 06 Feb 2023 21:23:16 +0100, Luca Weiss wrote:
>>> Convert the text-based dt-bindings to yaml.
>>>
>>> Changes from original txt:
>>> * Take wording for various properties from other yaml bindings, this
>>>   removes e.g. volt amount from schema since it isn't really relevant
>>>   and the datasheet is a better source.
>>> * Don't make reset-gpios a required property since it can be tied to
>>>   DOVDD instead.
>>>
>>> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
>>> ---
>>>  .../devicetree/bindings/media/i2c/ov2685.txt       |  41 ---------
>>>  .../devicetree/bindings/media/i2c/ovti,ov2685.yaml | 101 +++++++++++++++++++++
>>>  MAINTAINERS                                        |   1 +
>>>  3 files changed, 102 insertions(+), 41 deletions(-)
>>>
>>
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: camera@3c: 'clocks' is a required property
>> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: camera@3c: 'clock-names' is a required property
>> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: camera@3c: 'dvdd-supply' is a required property
>> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: camera@3c: 'avdd-supply' is a required property
>> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: camera@3c: 'dovdd-supply' is a required property
>> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
> 
> These are errors from the bindings, so they must be fixed. If you do not
> want to fix the rockchip bindings, just drop or replace the sensor in them.

Or one more: add some fake stubs. They do not matter anyway...

Best regards,
Krzysztof

