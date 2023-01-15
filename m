Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9923266B39B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 20:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjAOTQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 14:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjAOTQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 14:16:27 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC93C125B2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 11:16:25 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id ud5so63525264ejc.4
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 11:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R1KYEjzsfB0r5L+lets4QzbwQ5qDbW3Ig0EpGysGDyw=;
        b=LfgGJccGja73lIwSv1samKvRHDsszVjEt5CdeFvJ2sgIVyeMtS48IOD4ve08l4YDmL
         S4CVxOKQnMWupaHJLiRtIHKfH4c/k2eHt2vRIByDAwAz209ggDeWBWHy1+E+NRy3K8se
         TMGwSaEmRKFAGyolGf+ANCktSFjXgPmpmooBjYTFRIPgb0SXFqNdK0d140dzXN40/fwK
         16JqXI8WjBFDVPU5LQyRaqW6YyDJKvR1tq9lQiihyOKH8HZ/pr4W7Wi1HPjmcqUAtbnv
         XspnltwiNnGkvgy3FbzcU7Yn9TT6hrDcd9CG80UppHH07vQw8rNt+BvYadFJ5B9OAwok
         Q/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R1KYEjzsfB0r5L+lets4QzbwQ5qDbW3Ig0EpGysGDyw=;
        b=q2FaKuRKbzDHXhEbB1avCf9GCtyWOVaq/e+qNZ7Z8RFGcR8IaUT3gOxGd0UHkHy8IH
         xBHSXy1sZ6IPkkyXTIiPurSN+cBUaRc9u+mrEgzangrAzGnOw+PbFfKmOKPZ+eMIXazD
         0mPsNr7pl2NX/xP3n1znYM4OX+yP2rs3shxpc9hnnzrZWAZBuQIL0hwU/McAcQM7VTCe
         CyqHQsCsYO8k9VXBnZOGymRv4j7HB7XvxHANccZHIj6fLAasM9ma9L27kiKBLeuJPYGc
         +CDv+2ok2WpJJrw3uxYukAXlQjSPTD9plP+NUxXYD53wnsHxcnr+9mfNDIsok+G3akVK
         DlUw==
X-Gm-Message-State: AFqh2krPC/2cgdFVkVgEXrYtn1AVnU7navKcZJi/7kGWFhSazIvq3jyh
        /yw1Y84D8Iwq1ZkDWpDl5DmzS3lWjQ3DvJiO
X-Google-Smtp-Source: AMrXdXssByycNWYnhzUI9FZz5exMX/TXGfSxhC59jDzU9JLIekHgxxy8wWJLQFYxjKmI8wuo6IaLyw==
X-Received: by 2002:a17:906:49cd:b0:7c0:f684:9092 with SMTP id w13-20020a17090649cd00b007c0f6849092mr71806335ejv.37.1673810184540;
        Sun, 15 Jan 2023 11:16:24 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id et14-20020a056402378e00b00497d8613532sm9874685edb.5.2023.01.15.11.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jan 2023 11:16:23 -0800 (PST)
Message-ID: <d570c775-158c-26e1-94d8-de3dc4d5370e@linaro.org>
Date:   Sun, 15 Jan 2023 20:16:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/5] dt-bindings: mfd: adi,max77541.yaml Add MAX77541
 bindings
Content-Language: en-US
To:     "Sahin, Okan" <Okan.Sahin@analog.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:MAXIM MAX77541 PMIC MFD DRIVER" 
        <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20221226223839.103460-1-okan.sahin@analog.com>
 <20221226223839.103460-3-okan.sahin@analog.com>
 <88ba15e1-ee03-bd61-fc7d-d00c8c6ae72e@linaro.org>
 <MN2PR03MB51689EC83FF462C5CE903567E7C09@MN2PR03MB5168.namprd03.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <MN2PR03MB51689EC83FF462C5CE903567E7C09@MN2PR03MB5168.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/01/2023 18:40, Sahin, Okan wrote:
> Hi Krzysztof,
> 
> Thank you for your feedback and efforts. I apologize for some missing points of v2 patch. I tried to do my best. I will be more careful to fix all feedback before sending new patch so I want to ask a few things before sending v3 patch

Please wrap lines in your email.

(...)

>>> +
>>> +  adc:
>>> +    type: object
>>> +    additionalProperties: false
>>> +    properties:
>>> +      compatible:
>>> +        const: adi,max77541-adc
>>
>> This is a friendly reminder during the review process.
>>
>> It seems my previous comments were not fully addressed. Maybe my feedback
>> got lost between the quotes, maybe you just forgot to apply it.
>> Please go back to the previous discussion and either implement all requested
>> changes or keep discussing them.
>>
>> Thank you.
> Honestly, I don't quite understand what you're suggesting regarding the adc part. I thought I should add the adc as an object since it is in the mfd device. Do I need to remove this part?

What is unclear in my comment from v1? Yes, you need to remove it
because it useless. There is no need for a node consisting of only
compatible. Your driver does not need the DT node at all to do its job.

Best regards,
Krzysztof

