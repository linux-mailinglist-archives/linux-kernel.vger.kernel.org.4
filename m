Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C05665722
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238368AbjAKJQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjAKJPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:15:36 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A95140B9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:12:29 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id ay40so10626700wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eZY9at94V7P9Q8ZmcTLckeYfqsa9rY4dut4aTvEClmo=;
        b=twfwFW4SzfZQSlglT1rzGB/JM5GiX+NnC0Sjqeo+j0cHLoNw/PxwBuXCtV43e8UNP7
         zM6oZ/ggYwOE1F2Xp6WBwp4i4u2IMVqKwLsE8CtSafCz0EMo91UMT82VEGRFa6m0WvGN
         u98Ro3rDWXqHCyftZk+LtQQ085e73sQDoxmJ267U/P4XWh03Gq6FZtsamq6juFRwTjxD
         yfpopjSA+Nmwb7nmhyy1bQm8NmE02GLi0u483oa89tQf/cylcLMk5E0uoMaZh3ydEeCH
         s1Bigfqp3H39oDsRcsa7smNSI+rUcpWW1Ja5SSB+phaNMrgxCGmdGI+l2tiyxp4a3kQk
         GX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eZY9at94V7P9Q8ZmcTLckeYfqsa9rY4dut4aTvEClmo=;
        b=0TpCs4YhLfkCLMrtSxWCZ2plrI9EnVMlzGH+35ZBFrOr3rsWOhyzU/5ZNStF+iVjQ4
         UGji1hcgIkd6VRo+5oIN2pLD2EdLJYQVCdOXImhfzjR+qwMY+fGsHJikHFGxmEaWt98w
         ZtgUKgCNZFnbrB03wv0k+KD1MztcvhArm4XWmqFse9BTVOacOUM63pWRDnWn5Z4hOjpf
         ZP3KJFqygHUEDlSFC0egcPGFEpSaMyrdOtcuW0s7nPzob2vCJ2Rz9ckDrK7utBQ5ySxo
         NlFgIo5rIOn+2CSyHDzRaOlmFBo3zpYjjFDDlT88xw2Mu7GUeXPCXh2qhQIISpvhJMo1
         p/wg==
X-Gm-Message-State: AFqh2krCm30wX+EojOj6DSO0RfA1JsnbjsoazbOAfeobiwgUGVrkDsUn
        tYJ0hC9zdu8tEJ1ei5g2MTvjCA==
X-Google-Smtp-Source: AMrXdXuGGYuouvjFkU04+BHPeCn1p1R2rZNNH//wli0EM9e/fMUnrTsSen06OWCuPV/zqNWJGDL2HA==
X-Received: by 2002:a05:600c:5114:b0:3d9:fa37:e42d with SMTP id o20-20020a05600c511400b003d9fa37e42dmr3596584wms.17.1673428347726;
        Wed, 11 Jan 2023 01:12:27 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h10-20020a1ccc0a000000b003d237d60318sm17928277wmb.2.2023.01.11.01.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 01:12:27 -0800 (PST)
Message-ID: <547ef944-be4d-365e-c639-91812286e42a@linaro.org>
Date:   Wed, 11 Jan 2023 10:12:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 4/7] arm64: dts: qcom: Add msm8939 SoC
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, djakov@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org,
        Jun Nie <jun.nie@linaro.org>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Max Chen <mchen@squareup.com>, Zac Crosby <zac@squareup.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Stephan Gerhold <stephan@gerhold.net>
References: <20230103010904.3201835-1-bryan.odonoghue@linaro.org>
 <20230103010904.3201835-5-bryan.odonoghue@linaro.org>
 <6e594438-843a-d03e-5276-d6316a9dc2c0@linaro.org>
 <88d66834-ca80-888b-e56e-7694e84b6eae@linaro.org>
 <411a1a02-568e-3695-0a24-0681fbe9f265@linaro.org>
 <bde66389-619b-771d-1956-43059f8e4d5a@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <bde66389-619b-771d-1956-43059f8e4d5a@linaro.org>
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

On 10/01/2023 14:42, Bryan O'Donoghue wrote:
> On 10/01/2023 13:24, Krzysztof Kozlowski wrote:
>> On 10/01/2023 14:14, Bryan O'Donoghue wrote:
>>> On 03/01/2023 09:14, Krzysztof Kozlowski wrote:
>>>> ../arch/arm64/boot/dts/qcom/msm8939.dtsi:1825.23-1842.5: Warning
>>>> (simple_bus_reg): /soc@0/mmc@7824000: simple-bus unit address format
>>>> error, expected "7824900
>>>
>>> For the record the driver consuming this dt entry requires the host regs
>>> to come first followed by the core
>>>
>>> sdhc_1: mmc@7824000 {
>>>           compatible = "qcom,msm8916-sdhci", "qcom,sdhci-msm-v4";
>>>           reg = <0x07824900 0x11c>, <0x07824000 0x800>;
>>>           reg-names = "hc", "core";
>>> }
>>>
>>> If I change this and the msm8916 to
>>
>> That's not the solution. The warning is saying that unit address does
>> not match your reg. You need to correct unit address.
>>
>> Best regards,
>> Krzysztof
>>
> 
> Is it not the case that the unit-address should match the first reg and 

As Konrad wrote, yes.

> that the first reg should also be the lowest address ?

I never heard such requirement, although it would be logical choice. In
this case your solution is to use the higher address as unit address.
apq8084, msm8226 and maybe more already do it.

You can also look at this that HC was made as the main IO address of a
device (if one can call something "main" here), thus it should be
expressed in unit address.

Best regards,
Krzysztof

