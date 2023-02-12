Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394856938D6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 17:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjBLQtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 11:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBLQt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 11:49:29 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBC1CA14
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 08:49:28 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id o15so6671970wrc.9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 08:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZnS4iLImKmiTIdzXmWB3mlY5ELz3gODOBAHtDoLlpJM=;
        b=jDoFaQ/F6/s6UHGEjotvBiIuxeO/FLAf+VEfFotdqX6oSJct1NBvqSsubU9ngKBO3A
         g9AtMPkwZF587GXmQqeo9QJeB1qhkurZk5QYRpkNy+unjo5AKlaIf4nDQnxKt17iFaH+
         J/MW+VAdlUOfSzMhevvYsRfhe+gx4NiU2kdhFYD0gCcIzqesQPOunBJRFFIBM27h4nnm
         AF1N1WxB4W+d+5eLbfoGqVMpvyn4a/HJZtNOFmHxt4ccp3Zvtfisnvi2igopaPUNicot
         yR0vvxpI1NnFvjRbs8cXvliFnxlvV3QzqcuqOAhtSz02dtp8ScwLl2sUgP4izdg8g7wN
         PsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnS4iLImKmiTIdzXmWB3mlY5ELz3gODOBAHtDoLlpJM=;
        b=AdkOic/urcmsd6Ecs5vEPL2G5TWkVaYj/4EJ+IekSzwEXLZEScEO+zxXOayLD8rZxx
         Jvltb4+TZAFGb2fGIdjOGES5JCchrmdh9kUyJryBUdBTjAYgv3LAt57JUsPnCk32+H1m
         JdYDj6iGxW4GtS41Uk7yNlkVA4NND2DC5RQmYxx89iIv6iMjDIWPam6SLqSiJFRtHASm
         dD8VHK0xOOOhuV2JaatsDQJK56CplR51f/By7SLZ/TS4oJenzjuHymbgc5WX5CuznY3b
         B7rrCcOqfnwyQ8+57JBPWq9Bnjh/LQOIu/WmXEIh650pfHFDkUHnHvj5FQ/B/gXwXKIn
         j/2w==
X-Gm-Message-State: AO0yUKV08rpMP+ffakeFN0RsxHo7SqtqDg3kNueL03c7Xw/Hm5Ibz9ii
        Y9z9L2GRWozesK2VX6nk6/dkdw==
X-Google-Smtp-Source: AK7set88aCei6vnBNOV2QXqcVkJ5r8KDylRaGG8E5BpKpWgRkqU4cc6De4SZ7KiEtbrezvcOIDepmQ==
X-Received: by 2002:a5d:5003:0:b0:2c5:5312:e81b with SMTP id e3-20020a5d5003000000b002c55312e81bmr2317627wrt.28.1676220567199;
        Sun, 12 Feb 2023 08:49:27 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id n18-20020a5d4012000000b002b57bae7174sm8730955wrp.5.2023.02.12.08.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Feb 2023 08:49:26 -0800 (PST)
Message-ID: <2b6bc14b-20df-b61e-6464-61ebb11f24f0@linaro.org>
Date:   Sun, 12 Feb 2023 16:49:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v5 2/5] arm64: dts: qcom: Add msm8939 SoC
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org, Jun Nie <jun.nie@linaro.org>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Max Chen <mchen@squareup.com>, Zac Crosby <zac@squareup.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>
References: <20230206012336.2130341-1-bryan.odonoghue@linaro.org>
 <20230206012336.2130341-3-bryan.odonoghue@linaro.org>
 <Y+T5cF4d667RhrJp@gerhold.net>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <Y+T5cF4d667RhrJp@gerhold.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2023 13:47, Stephan Gerhold wrote:
>> +			frame@b021000 {
>> +				reg = <0x0b021000 0x1000>,
>> +				      <0x0b022000 0x1000>;
>> +				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
>> +					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
>> +				frame-number = <0>;
>> +			};
> These timer interrupts are still wrong like mentioned in v3:
> https://lore.kernel.org/linux-arm-msm/Y8fC%2FGCHfENQmBNC@gerhold.net/
> 

Hmm.

This is a copy/paste error from 8916 which I guess we never see in our 
production system, since we use LPM to get to do idle

---
bod
