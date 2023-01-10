Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0606641AD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbjAJNZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbjAJNYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:24:53 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08325C1D5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:24:20 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d17so11732478wrs.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5KF8jpppYbRFUGNHfa7KqVlDw5P17to42GzO64PO2As=;
        b=Op5oyVcnMSMlL0/zhW4HSiNBwRPb0PdDBgIaSGWMoTC/wWp4cNdhh1ikYvYIMt2ZFd
         C5Ee5eCCMm/PCZEo5D/Do8wo4wiMYeC72AiFx7/Ds+JYH0aU85pMd2i6onxgZl4YR/LH
         W7myKdYREVFt9sOzRWE08/ILuL+HoURl4IrT6UWmOYmxeWt4KKItmLY/hGFV6+O1wsmS
         CIu0R0qhywHZYV8H233u3OLHj81dJ66UWcelFekcsUEvsnT0PIglbJSlTgTZdEukrm2V
         duMWywfjATEH+O/Ur9/XYW7ZEm3q23P/erLpZvfNve4iDq178vOkD8nnKQRoxe6d/xYl
         Qqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5KF8jpppYbRFUGNHfa7KqVlDw5P17to42GzO64PO2As=;
        b=1NU01vZJYMqKfsrpl6OBg4eFZSqZdPWpHhFcCGio8A+e68cB5g/UQds46VIed2CZHp
         kuync0X7Nn0VfaGl7KigEC7bk5eisKAETOpQEeaW7KZEkFfY6/Mig1Hpjjv2rRoHTvcJ
         PFI8BbbpcvM4bBdeH/bseK6l6wOlbmv77fsFK/9bcSGnCJlv8hf/HLa/sV43KIpeuzFM
         h/rg/bkmHzCGnh0N0n3SwsonVo+LeLvc38RTkRcZaDGkFmzDWklw5hZ11IBBswaKLcnT
         jmpiBxvRofQ7293mrl0CntCgoKO/mvbAkbEjd7d6UgAci0irNAVyR8lQ49c6ajePVcpA
         PMpQ==
X-Gm-Message-State: AFqh2kp08L1poDbLKqU3q6MWblwfwXbtCm8nRqOIB/ATDWdUF+iFuH7N
        cQq1AW61on5+r8wb8ZhvKn9pfw==
X-Google-Smtp-Source: AMrXdXsbddnCQ0vxrAZ8txOAw6kZgvXWY0YIKbMspGnAlO/JWdtL9LmA1Ldq58jnbSAV+FIetKmEpQ==
X-Received: by 2002:adf:ed0e:0:b0:2bb:eb1d:bbac with SMTP id a14-20020adfed0e000000b002bbeb1dbbacmr5889291wro.12.1673357056435;
        Tue, 10 Jan 2023 05:24:16 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k2-20020a5d5182000000b00236545edc91sm11337070wrv.76.2023.01.10.05.24.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 05:24:15 -0800 (PST)
Message-ID: <411a1a02-568e-3695-0a24-0681fbe9f265@linaro.org>
Date:   Tue, 10 Jan 2023 14:24:13 +0100
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <88d66834-ca80-888b-e56e-7694e84b6eae@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2023 14:14, Bryan O'Donoghue wrote:
> On 03/01/2023 09:14, Krzysztof Kozlowski wrote:
>> ../arch/arm64/boot/dts/qcom/msm8939.dtsi:1825.23-1842.5: Warning
>> (simple_bus_reg): /soc@0/mmc@7824000: simple-bus unit address format
>> error, expected "7824900
> 
> For the record the driver consuming this dt entry requires the host regs 
> to come first followed by the core
> 
> sdhc_1: mmc@7824000 {
>          compatible = "qcom,msm8916-sdhci", "qcom,sdhci-msm-v4";
>          reg = <0x07824900 0x11c>, <0x07824000 0x800>;
>          reg-names = "hc", "core";
> }
> 
> If I change this and the msm8916 to

That's not the solution. The warning is saying that unit address does
not match your reg. You need to correct unit address.

Best regards,
Krzysztof

