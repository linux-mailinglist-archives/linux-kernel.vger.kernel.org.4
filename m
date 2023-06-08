Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AE5727EFC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236350AbjFHLk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236342AbjFHLjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:39:40 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE712728
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 04:39:33 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-977ed383b8aso93659566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 04:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686224372; x=1688816372;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xqR4Cl4Oo+rFOH+Sj3ml0n4meYZgvylOhYiYI8g6ow8=;
        b=fNh6Fmwm2YHAPIHwAdlcjDwjrjjCabjXApKTw4f1jhc/TcUV5nXOqWN8HjWJwlcOJf
         vTTbIKlNpb5meuz04hanIifHDPLQAeyxuQQHCLhBrfhnFKslc0m+Dfu6l/7CDaLBenGV
         zjiwKAmFc5zAyr5KJlTXWgnM+vmZ/WmH+PMlZ4Tzus6X5Sy6HrJXYUVjUk/pP4q2zUh8
         As06JTdEVZ2Fr2RLIwDoxnMeycQhPt9HLj/bhZMRuq58sdYfixTFIkDJdSL/xHjC1/NX
         9AxRxI2zvgxLRb9huFms2x335RT69oTKOO8vbGd2ArYwWpsWqqMnJiuOhiGn7b3o3jH7
         dMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686224372; x=1688816372;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xqR4Cl4Oo+rFOH+Sj3ml0n4meYZgvylOhYiYI8g6ow8=;
        b=aMh9hRbolvIeq14tWBcYpUdNLPgRC7L8mgPEokvAWJuKC/sZgvyszGEl9IftZR6z8S
         e5okfFlSQkiIZYLfCQraL/TaK3cITg6tFC65YFgzjEaoTWLMpBgDeno1BbfmZ8WOyo+a
         Q8nacLxYujsiDY2p3mxrJJdiD8emAJIEMsJecFYFMe8wYqpkzFuw+qMOqlqvABojUVv2
         3bC70cDnw1Te8clag6eHZSSWc/sPbjX5wTsPmJySJUzNyajhfqsEqK70YdI8Xkivf1io
         jhfe+V3yTOITuZGpr5IC7UN+Kw0BZIP+FfJSl28I4utV4i3MHS5BPjJskbyGkk/PoWeA
         0pjQ==
X-Gm-Message-State: AC+VfDx79z1JMpMhvtxrHzycNZSHe1vx8flLC+oJkz99Xrgr1MXJCrP1
        UQjYWV1MkNkTYpPhmFnh02YWDA==
X-Google-Smtp-Source: ACHHUZ7Th7ms72bKEB7ZtHp2Yh/u7BnpHPOwK6btJqOe7BpFZDp6faRJ02BvsNxVIHPLbCYoCQTLjQ==
X-Received: by 2002:a17:907:94d6:b0:96f:905e:6117 with SMTP id dn22-20020a17090794d600b0096f905e6117mr9214973ejc.56.1686224372459;
        Thu, 08 Jun 2023 04:39:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id bv15-20020a170906b1cf00b009596e7e0dbasm577799ejb.162.2023.06.08.04.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 04:39:32 -0700 (PDT)
Message-ID: <9435791f-98cb-19f0-f959-8624990959ba@linaro.org>
Date:   Thu, 8 Jun 2023 13:39:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/2] dt-bindings: reset: convert the xlnx,zynqmp-reset.txt
 to yaml
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>,
        "Mehta, Piyush" <piyush.mehta@amd.com>,
        Rob Herring <robh@kernel.org>
Cc:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "Paladugu, Siva Durga Prasad" <siva.durga.prasad.paladugu@amd.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "nava.manne@xilinx.com" <nava.manne@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>
References: <20230607065121.2265076-1-piyush.mehta@amd.com>
 <20230607065121.2265076-2-piyush.mehta@amd.com>
 <168612336438.2153757.6000360498539992409.robh@kernel.org>
 <MN2PR12MB4333E0628E2E67652E80067A8850A@MN2PR12MB4333.namprd12.prod.outlook.com>
 <55b59833-d070-f576-9d85-047175d9722c@linaro.org>
 <b1c80077-7509-883d-cfd1-fb3c0b0449d6@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b1c80077-7509-883d-cfd1-fb3c0b0449d6@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2023 13:34, Michal Simek wrote:
> 
> 
> On 6/8/23 13:29, Krzysztof Kozlowski wrote:
>> On 08/06/2023 12:55, Mehta, Piyush wrote:
>>> Hello,
>>>
>>>> -----Original Message-----
>>>> From: Rob Herring <robh@kernel.org>
>>>> Sent: Wednesday, June 7, 2023 1:06 PM
>>>> To: Mehta, Piyush <piyush.mehta@amd.com>
>>>> Cc: p.zabel@pengutronix.de; Paladugu, Siva Durga Prasad
>>>> <siva.durga.prasad.paladugu@amd.com>; michal.simek@xilinx.com;
>>>> nava.manne@xilinx.com; devicetree@vger.kernel.org; linux-
>>>> kernel@vger.kernel.org; linux-usb@vger.kernel.org; conor+dt@kernel.org;
>>>> krzysztof.kozlowski+dt@linaro.org; robh+dt@kernel.org; Simek, Michal
>>>> <michal.simek@amd.com>; git (AMD-Xilinx) <git@amd.com>
>>>> Subject: Re: [PATCH 1/2] dt-bindings: reset: convert the xlnx,zynqmp-reset.txt
>>>> to yaml
>>>>
>>>>
>>>> On Wed, 07 Jun 2023 12:21:20 +0530, Piyush Mehta wrote:
>>>>> Convert the binding to DT schema format. It also updates the
>>>>> reset-controller description.
>>>>>
>>>>> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
>>>>> ---
>>>>> Note:
>>>>> The 1/2 patch introduced a warning related to the dt binding check,
>>>>> which was subsequently fixed in the 2/2 patch. This warning is a
>>>>> conversion warning due to a dependency on firmware dt binding.
>>>>>
>>>>> Warning:
>>>>>    DTC_CHK
>>>>> Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.example.dtb
>>>>>
>>>> /scratch/piyushm/torvalds/linux/Documentation/devicetree/bindings/reset/xln
>>>> x,zynqmp-reset.example.dtb: zynqmp-firmware: 'reset-controller' does not
>>>> match any of the regexes: 'pinctrl-[0-9]+'
>>>>> 	From schema:
>>>>> /scratch/piyushm/torvalds/linux/Documentation/devicetree/bindings/firm
>>>>> ware/xilinx/xlnx,zynqmp-firmware.yaml
>>>>>
>>>>> Please suggest to me, if it's fine to make a single patch instead of
>>>>> the separate patch 1/2 and 2/2.
>>>>> ---
>>>>>   .../bindings/reset/xlnx,zynqmp-reset.txt      | 55 ---------------
>>>>>   .../bindings/reset/xlnx,zynqmp-reset.yaml     | 67 +++++++++++++++++++
>>>>>   2 files changed, 67 insertions(+), 55 deletions(-)  delete mode
>>>>> 100644 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
>>>>>   create mode 100644
>>>>> Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml
>>>>>
>>>>
>>>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>>>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>>>
>>>> yamllint warnings/errors:
>>>>
>>>> dtschema/dtc warnings/errors:
>>>> /builds/robherring/dt-review-
>>>> ci/linux/Documentation/devicetree/bindings/reset/xlnx,zynqmp-
>>>> reset.example.dtb: zynqmp-firmware: 'reset-controller' does not match any of
>>>> the regexes: 'pinctrl-[0-9]+'
>>>> 	From schema: /builds/robherring/dt-review-
>>>> ci/linux/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-
>>>> firmware.yaml
>>>>
>>>> doc reference errors (make refcheckdocs):
>>>>
>>>> See https://patchwork.ozlabs.org/project/devicetree-
>>>> bindings/patch/20230607065121.2265076-2-piyush.mehta@amd.com
>>>>
>>>> The base for the series is generally the latest rc1. A different dependency
>>>> should be noted in *this* patch.
>>>>
>>>> If you already ran 'make dt_binding_check' and didn't see the above error(s),
>>>> then make sure 'yamllint' is installed and dt-schema is up to
>>>> date:
>>>>
>>>> pip3 install dtschema --upgrade
>>>>
>>>> Please check and re-submit after running the above command yourself. Note
>>>> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
>>>> your schema. However, it must be unset to test all examples with your schema.
>>>
>>> This dt_binding warning is known to us and is captured in commit description notes and to resolve it, we need to apply 2/2.
>>
>> So your patchset has broken bisectability. You need to fix it. If the
>> warning was known, then I am surprised that you sent broken patchset.
> 
> The first patch is conversion from txt yaml without any additional changes 
> because in past we heart that we shouldn't really do other things in it. That's 
> why 2 patches where made. No really issue to squashed them together.

We always shared feedback that conversion should do only conversion, but
a correct one. Conversion cannot introduce errors or warnings in the
bindings. It can introduce warnings in DTS, but not in the bindings.
This was also communicated several times.

If pure-conversion results in non-bisectable patchset then:
1. either conversion should come with changes,
2. or conversion is done a bit wrong or could be done differently like
here. You really do not need unrelated pieces of DTS in reset controller
code. Drop them.

Best regards,
Krzysztof

