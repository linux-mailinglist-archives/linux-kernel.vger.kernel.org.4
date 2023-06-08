Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60212727EB7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbjFHL3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbjFHL3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:29:32 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A16D2709
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 04:29:30 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9768fd99c0cso335889166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 04:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686223769; x=1688815769;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=onxhXy/B3JaBIheRaBcu5GB2qIrwCPqePPD/9cziBFo=;
        b=s3HV8OuEuup+OUIbJ5k4zyOUACR6Ln/qHhqYIRPuj9saN1HZYYTvGPIf7KeD92Y32w
         tArH2SG9wsGi8fJUHZyi+A8MymlkWOi+7ut9qlsEGFkzpnPXfAtmtz2RB5mhkmV6lIeZ
         cuw93ltGyLAdJZAIIVu0O9oVtvT5zJIuqqcyll4DH9wI8GYZCfonSn6FjAUeXl8MinpQ
         qgtuoFEqxAwnwovqPCp75vNqwXJmf39EpVe6wWGQsXQ6nPn0U4kK7h3JkhotRNPoTXOu
         c5PPBkvrHFtGu34YiMkqlvMeRhDC0/pDaPY+L6hpWgLYa0P++rUhWHAdarhwXBOhCAaF
         ypYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686223769; x=1688815769;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=onxhXy/B3JaBIheRaBcu5GB2qIrwCPqePPD/9cziBFo=;
        b=HX2ZD6AtoyX5uKxPbXR9V8kQHdcbzzOCHOTBRakhR7sRU5csZVqYNF/tZoPcysDoAZ
         71WMTdNMrkYXBQrB7t9pMQSdIEMrsUgUq/fO/9R92yMjILEC6qtNJC2EdKN+/yoCIOLX
         SaSlAqSF1tmctoUlf4R0xiGOIIgM9uD09/k3odaxuEgI90pNNle8Il1uMFuaZgFwnVVb
         wjxoynyrn+uVhkONdN5/WJa4fQOZZf75YxD27Z56egelXjQTS/8zakbDq90AGFzwLjLL
         i2uKe1yeMpWj/fFrm7sqcQqIvxB3eOD/sRtAbME5WeOgUhXlgkeqJdf/ddE5yZul22Yg
         81zg==
X-Gm-Message-State: AC+VfDzX1awHbMS/rl4DVtXdXW37xkPgaAHCid45UjzcH0bRW22eTot7
        5ScLEgshW+7E7B/IT/JjWZh0hQ==
X-Google-Smtp-Source: ACHHUZ4lxiQ8JILFOmcDga5RplGQDFOtntTdA4bXHBvYEPRfybd9BQhQ9QGU/yYHSxR6das7Cb86Dg==
X-Received: by 2002:a17:907:160b:b0:977:d660:c5aa with SMTP id hb11-20020a170907160b00b00977d660c5aamr1742048ejc.31.1686223768778;
        Thu, 08 Jun 2023 04:29:28 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id h12-20020a1709066d8c00b009745482c5b7sm574674ejt.94.2023.06.08.04.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 04:29:28 -0700 (PDT)
Message-ID: <55b59833-d070-f576-9d85-047175d9722c@linaro.org>
Date:   Thu, 8 Jun 2023 13:29:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/2] dt-bindings: reset: convert the xlnx,zynqmp-reset.txt
 to yaml
Content-Language: en-US
To:     "Mehta, Piyush" <piyush.mehta@amd.com>,
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
        "Simek, Michal" <michal.simek@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>
References: <20230607065121.2265076-1-piyush.mehta@amd.com>
 <20230607065121.2265076-2-piyush.mehta@amd.com>
 <168612336438.2153757.6000360498539992409.robh@kernel.org>
 <MN2PR12MB4333E0628E2E67652E80067A8850A@MN2PR12MB4333.namprd12.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <MN2PR12MB4333E0628E2E67652E80067A8850A@MN2PR12MB4333.namprd12.prod.outlook.com>
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

On 08/06/2023 12:55, Mehta, Piyush wrote:
> Hello,
> 
>> -----Original Message-----
>> From: Rob Herring <robh@kernel.org>
>> Sent: Wednesday, June 7, 2023 1:06 PM
>> To: Mehta, Piyush <piyush.mehta@amd.com>
>> Cc: p.zabel@pengutronix.de; Paladugu, Siva Durga Prasad
>> <siva.durga.prasad.paladugu@amd.com>; michal.simek@xilinx.com;
>> nava.manne@xilinx.com; devicetree@vger.kernel.org; linux-
>> kernel@vger.kernel.org; linux-usb@vger.kernel.org; conor+dt@kernel.org;
>> krzysztof.kozlowski+dt@linaro.org; robh+dt@kernel.org; Simek, Michal
>> <michal.simek@amd.com>; git (AMD-Xilinx) <git@amd.com>
>> Subject: Re: [PATCH 1/2] dt-bindings: reset: convert the xlnx,zynqmp-reset.txt
>> to yaml
>>
>>
>> On Wed, 07 Jun 2023 12:21:20 +0530, Piyush Mehta wrote:
>>> Convert the binding to DT schema format. It also updates the
>>> reset-controller description.
>>>
>>> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
>>> ---
>>> Note:
>>> The 1/2 patch introduced a warning related to the dt binding check,
>>> which was subsequently fixed in the 2/2 patch. This warning is a
>>> conversion warning due to a dependency on firmware dt binding.
>>>
>>> Warning:
>>>   DTC_CHK
>>> Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.example.dtb
>>>
>> /scratch/piyushm/torvalds/linux/Documentation/devicetree/bindings/reset/xln
>> x,zynqmp-reset.example.dtb: zynqmp-firmware: 'reset-controller' does not
>> match any of the regexes: 'pinctrl-[0-9]+'
>>> 	From schema:
>>> /scratch/piyushm/torvalds/linux/Documentation/devicetree/bindings/firm
>>> ware/xilinx/xlnx,zynqmp-firmware.yaml
>>>
>>> Please suggest to me, if it's fine to make a single patch instead of
>>> the separate patch 1/2 and 2/2.
>>> ---
>>>  .../bindings/reset/xlnx,zynqmp-reset.txt      | 55 ---------------
>>>  .../bindings/reset/xlnx,zynqmp-reset.yaml     | 67 +++++++++++++++++++
>>>  2 files changed, 67 insertions(+), 55 deletions(-)  delete mode
>>> 100644 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
>>>  create mode 100644
>>> Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml
>>>
>>
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> /builds/robherring/dt-review-
>> ci/linux/Documentation/devicetree/bindings/reset/xlnx,zynqmp-
>> reset.example.dtb: zynqmp-firmware: 'reset-controller' does not match any of
>> the regexes: 'pinctrl-[0-9]+'
>> 	From schema: /builds/robherring/dt-review-
>> ci/linux/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-
>> firmware.yaml
>>
>> doc reference errors (make refcheckdocs):
>>
>> See https://patchwork.ozlabs.org/project/devicetree-
>> bindings/patch/20230607065121.2265076-2-piyush.mehta@amd.com
>>
>> The base for the series is generally the latest rc1. A different dependency
>> should be noted in *this* patch.
>>
>> If you already ran 'make dt_binding_check' and didn't see the above error(s),
>> then make sure 'yamllint' is installed and dt-schema is up to
>> date:
>>
>> pip3 install dtschema --upgrade
>>
>> Please check and re-submit after running the above command yourself. Note
>> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
>> your schema. However, it must be unset to test all examples with your schema.
> 
> This dt_binding warning is known to us and is captured in commit description notes and to resolve it, we need to apply 2/2.

So your patchset has broken bisectability. You need to fix it. If the
warning was known, then I am surprised that you sent broken patchset.

> I want to take DT maintainer opinion if we should keep the fix in 2/2 or merge it in 1/2.

Just avoid the warning. Anyway you need only one complete example, right?

Best regards,
Krzysztof

