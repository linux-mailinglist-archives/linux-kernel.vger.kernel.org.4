Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD6B714D69
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 17:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjE2PwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 11:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjE2PwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 11:52:12 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9685CCF
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 08:52:08 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2af1ae3a21fso36203161fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 08:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685375527; x=1687967527;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8tUMB0Arnzo+AT6kHbEoV+hUDFUyJsBQnoR//IWQPk0=;
        b=zLJpM1yMjM2jEAg0xkg0V82BM3gYCiuGXjeuQ8uqNFyeQVrsITa4s8pt9F1M9dX6em
         amqHOwBzdrsB9VXJA7v/TwwrVxCTAPI9Gslc++AZQHeTOdDNbdZGE02FLVtRFE11DTn2
         hR4KzEi4lK8dtAzVas2g3yifVoMEYxzHA6aOONQLjxWvmE4S1Pjqyamflerau4RpA3Yz
         CtL1N86ytP6cnAA8HHiR36cQbXLNkaqocalSIrnGZ+0P5QKWwzdHv6r8rVSy7NjbJXnA
         wPsBcrl7jgMx1qedXQ3MK4OzyCUFEzeYwEJUxF7b52QZYLvLZJMW5hOjtyzBHg5phOoJ
         I6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685375527; x=1687967527;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8tUMB0Arnzo+AT6kHbEoV+hUDFUyJsBQnoR//IWQPk0=;
        b=ZOXLmy3BB0OocTFhPoXxvkUpLTPjaikHsLGgq8XijDluHjGW9xsnn4DAAXj0ooSHbU
         oHNri+xsI6JPF+ZE26w8ryD9j4O7JM0HULOppcuPxi1k9o4gSVqUOy7I9kHXBQ6ruOPI
         0Llv04hdZJnUocHardkvhsYgwhNkIPiZeF0P5INghdZImtC5HU1LHnKgFD+r66ct8z9X
         ZXwQMS4KXeiiThre1FaKKzngizNTsFFb11Tw5841XsdQYA3jR/XiNWjpdv8EZueAtwDX
         YKD/r3hKKFTQaXdDHFykXXLTKEz5iERzEPJBgv6oTiBNkkdVN1r7B04/aRXJe+qkAOPA
         oqNw==
X-Gm-Message-State: AC+VfDyVWdIGRnFyXenrE8SgdYqW5zwZm+4FwEfHCbuDTJnjJODesmn9
        X1+LFHUoym6r8GCJpL0TXtu3mQ==
X-Google-Smtp-Source: ACHHUZ5Sor6FiO6samNwLAYbLWo/qtqeEXMfZrh8dSM0s5uirIT3Xz1m8W509FWOUhQqW3Q1sLIurw==
X-Received: by 2002:a2e:a3d2:0:b0:2b0:4e69:c174 with SMTP id w18-20020a2ea3d2000000b002b04e69c174mr4797267lje.31.1685375526856;
        Mon, 29 May 2023 08:52:06 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id l7-20020a2eb687000000b002a774fb7923sm2489707ljo.45.2023.05.29.08.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 08:52:06 -0700 (PDT)
Message-ID: <76daf752-d050-b283-89b4-19ca57ac62ee@linaro.org>
Date:   Mon, 29 May 2023 17:52:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 4/6] arm64: dts: qcom: msm8916/39: Clean up MDSS labels
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230525-msm8916-labels-v1-0-bec0f5fb46fb@gerhold.net>
 <20230525-msm8916-labels-v1-4-bec0f5fb46fb@gerhold.net>
 <6f1954e6-e98d-6911-8721-c50082bfb1d7@linaro.org>
 <ZHS-HSgaBxMXiKy9@gerhold.net>
 <17f31258-bc38-245f-532f-fdaa1ee8ad33@linaro.org>
 <343e2e95-17ee-f5e3-61e9-7e0b793859a6@linaro.org>
 <ZHTFOZFxq-JgLP-p@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZHTFOZFxq-JgLP-p@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29.05.2023 17:31, Stephan Gerhold wrote:
> On Mon, May 29, 2023 at 04:26:09PM +0100, Bryan O'Donoghue wrote:
>> On 29/05/2023 16:24, Bryan O'Donoghue wrote:
>>> On 29/05/2023 16:00, Stephan Gerhold wrote:
>>>> Do you mean update the examples in the yaml bindings
>>>
>>> Yep.
>>>
>>> grep dsi0_out Documentation/* -r | grep qcom
>>> grep dsi0_in Documentation/* -r | grep qcom
>>>
>>> Consider splitting this patch out and fixing up[1] Documentation/* and
>>> arch/arm/boot/dts/*.dts[i] , arch/arm64/boot/dts/qcom/*.dts[i]
>>>
>>> We may as well be consistent everywhere.
>>>
>>> ---
>>> bod
>>
>>
>> [1] In a standalone series
>>
> 
> Right I will check this and try to adjust the documentation and/or the
> other SoCs in a separate series.
Agreed, bindings don't really care about labels but they set examples.

I'd really appreciate if you could take care of that, Stephan.

 I would still prefer to apply it for
> 8916/8939 as part of this series since I have some unrelated follow-up
> changes that would just cause unnecessary conflicts for Bjorn otherwise.
> 
> We already have most newer SoCs using the naming convention in this
> patch so it definitely does not make the existing situation any worse. :)
Definitely!

Konrad
> 
> Thanks,
> Stephan
