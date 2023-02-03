Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B926898EA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 13:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbjBCMfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 07:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbjBCMfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 07:35:20 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A26A1ADD2
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 04:35:12 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso5901804wmp.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 04:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0fS5h/6A8JqyaZ0AF5IugOshgaAjg1/k1ZgrK3n4WYo=;
        b=nUBWefrCTlVLguPtGahCXnxqTOLdmiJzegJUWs0kasPrEsNLjwP+xhBI8rwLu62YOz
         YLJ2lwCeVM3efZlThlK8v3QdFbRv/E/qrPoS+rUPSvxh5pjLUI8p9MKBMMTcZ638RcPI
         ZnVBxYsnVYQFBcMjg9FbFX6+GAkFL3ZlKHSpIwQKTMW2NmmxyaBTqXQwG0qu7GqUFzbl
         Ev7kHMaj2z0lbTObcZPnSwMBvl/3YYSOtetdMoLkUl8A2+9v11OskQEtg2ALkmrmRTK0
         BZtDjBx/HaH5KKFlCVqP+UmJgtyfRM/3qcVZnqVUWC692BmA913f3nLl0FVEXJiY3cGN
         dd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0fS5h/6A8JqyaZ0AF5IugOshgaAjg1/k1ZgrK3n4WYo=;
        b=zfVHxeBvk/49o5ik7QNsIpPV6VAKpHcxZmZnbzpW5MQIHF5MyHFGuI5+DGtNAxh3J3
         DXks4Hgm22PiL5IGQqkNlQk5MA+ZHUtyzimxIv/7gVx76rOEiBm71ezXRp3YJrDnQqxQ
         TGmj58X5BAST/YjFsM9XpOFPcg2YllQXUFMXsb9n3N23buuoXvvKvaVU7zCBICp4S8fD
         7Ci5t2D1w9pTyBKZd8uglaQUPzYeQpbU4TrgHrBKG7hguT5qP1Ot9S1UfYoUwQtSeeOY
         7rPbK1A0Vki41XCVhxW7NbFnHkl25eFQ5C+TmTgEQM5mDmzV8navPbeIrEp4SH6+zInr
         FiLw==
X-Gm-Message-State: AO0yUKXxx60cK9LIRq7eTyJOCt1uqxCNzRYFDMVkxZyK9kfBVgYp196H
        UBiQoF3qAbbcDqG6RgLQ5gUUEg==
X-Google-Smtp-Source: AK7set9n7hhpjyjI6s+IRKBEa3a9h5wmUDUXkS1L5NWrawy7DRPpdQZxuiMzFiz08oatXJozgCxUDw==
X-Received: by 2002:a05:600c:1c16:b0:3de:c612:df56 with SMTP id j22-20020a05600c1c1600b003dec612df56mr9134223wms.15.1675427710851;
        Fri, 03 Feb 2023 04:35:10 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k10-20020a7bc30a000000b003dfee43863fsm265822wmj.26.2023.02.03.04.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 04:35:10 -0800 (PST)
Message-ID: <bcfb143d-1d1b-590b-ac7d-7624f9069708@linaro.org>
Date:   Fri, 3 Feb 2023 13:35:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 1/3] dt-bindings: reset: syscon-reboot: Add priority
 property
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220820102925.29476-1-pali@kernel.org>
 <20221226114513.4569-1-pali@kernel.org>
 <20230122112744.vdfho4mzpgm6oucm@pali>
 <20230203121610.zung35qrozvoauz6@mercury.elektranox.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230203121610.zung35qrozvoauz6@mercury.elektranox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2023 13:16, Sebastian Reichel wrote:
> Hi,
> 
> On Sun, Jan 22, 2023 at 12:27:44PM +0100, Pali Rohár wrote:
>> On Monday 26 December 2022 12:45:11 Pali Rohár wrote:
>>> This new optional priority property allows to specify custom priority level
>>> of reset device. Prior this change priority level was hardcoded to 192 and
>>> not possible to specify or change. Specifying other value is needed for
>>> some boards. Default level when not specified stays at 192 as before.
>>>
>>> Signed-off-by: Pali Rohár <pali@kernel.org>
>>
>> Reminder: Any plan how to handle these patches?
> 
> Please don't top-post :) Sorry, I'm a bit slow with processing
> patches this cycle. Technically this was also throwing a DT
> warning reported by the bot, so I expected a new version. Anyways,
> I fixed the DT warning myself and applied patches 1-2.

Everyone was expecting new version, so that checks pass. We should not
take known-broken code, because then the duty to check for other errors
is on you Sebastian. :)

Best regards,
Krzysztof

