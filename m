Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818C96FF48E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238340AbjEKOgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238041AbjEKOgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:36:22 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAD711B6C
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 07:35:51 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so79988322a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 07:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683815749; x=1686407749;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iOXRRdgVUBc+UmzsHGXf7yN0Z8AdVArYJOeUqt52Z8s=;
        b=o0F8r04z7dsrDucISA3J82RCw6niaUS+pJJAo7xmwkX1Ccb2bb7lZh+rOQUT007bZB
         fai6JrkbPIP8blc4RZFn3ULrYraWHLrmM1VMbLMXsVuEk7qSCAy96CgPth2sKDo7YhTQ
         6J0RF+czetA5vQiEDH5hxnUnylDJdfLHp2/ALawr09gZtS0b/+rmnJ0tn2Nq1x0FYKTI
         rpv+X9nDIHggw3HBPcSN5rFkdNrPGh35kWZCBz1/06XbsleRsRUQxva7vTkJf+spfvXK
         pcinklyEzsi4E+bTSg4edNRmOfW4G97/qFCau4msJybzZXshktravNR9kfIUHdlvMr3r
         UGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683815749; x=1686407749;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iOXRRdgVUBc+UmzsHGXf7yN0Z8AdVArYJOeUqt52Z8s=;
        b=NJEieA25Dlz1VireUNRqBTYrsZEqvyiTymgUhgXHtiiQeyiDzZepvQQzScVgfoC9j+
         oz2nI2VWhZ0muMwbU+WTDXGcpkXwvCZmB8/XzDj+c2NSJ5KcBo9YTuI/OU7cPoKm8573
         9slGeiA9DE0gcyBrQr5iFUHVaXMoe5JfIi7J//+66ySZ8+nuYoUk2BKStgqBw/qAaa0o
         yYiDtPTPj56oy/5AHPlbFiNvfNeGp9Czs4W2QcAEU8aL+Ny6yRWVYCfPKJ8vkBNENJjq
         t+0cK7zKWnOuYZnHsXFAgV+9wXd6kGPi9D740XcrWM3gH71HU52E4VsOJ/cfAd0ZziIA
         xJhA==
X-Gm-Message-State: AC+VfDzMCpgDMOrfVBxz7dv4nPg86yHhcmYN4t5DLBgUbmU5D7byyQFy
        FTA0HirJec5rWQsSFyEuDLuddA==
X-Google-Smtp-Source: ACHHUZ6RTe5WgSrqyhZeO20u+ewTN7JFmjPjzgfVPZltFPXUrBhP6CUUeKSFP4dzoOQj6ch8B7Xf7w==
X-Received: by 2002:a17:906:da8c:b0:94a:653b:ba41 with SMTP id xh12-20020a170906da8c00b0094a653bba41mr5166642ejb.15.1683815749483;
        Thu, 11 May 2023 07:35:49 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d7cd:1be6:f89d:7218? ([2a02:810d:15c0:828:d7cd:1be6:f89d:7218])
        by smtp.gmail.com with ESMTPSA id h8-20020a1709060f4800b009600ce4fb53sm4045550ejj.37.2023.05.11.07.35.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 07:35:48 -0700 (PDT)
Message-ID: <ca7a8499-0ac9-43d3-45ab-c974b1a2a564@linaro.org>
Date:   Thu, 11 May 2023 16:35:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: defconfig: enable TYPEC_QCOM_PMIC
Content-Language: en-US
To:     neil.armstrong@linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230511135503.198538-1-krzysztof.kozlowski@linaro.org>
 <016ab311-cc66-b1c7-4099-f63e8f3644b8@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <016ab311-cc66-b1c7-4099-f63e8f3644b8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2023 16:14, Neil Armstrong wrote:
> On 11/05/2023 15:55, Krzysztof Kozlowski wrote:
>> Enable CONFIG_TYPEC_QCOM_PMIC necessary for full USB Type-C support on
>> Qualcomm QRD8550 and MT8550 boards.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   arch/arm64/configs/defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index a24609e14d50..8b6407d2059d 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -991,6 +991,7 @@ CONFIG_TYPEC_TCPCI=m
>>   CONFIG_TYPEC_FUSB302=m
>>   CONFIG_TYPEC_TPS6598X=m
>>   CONFIG_TYPEC_HD3SS3220=m
>> +CONFIG_TYPEC_QCOM_PMIC=m
>>   CONFIG_TYPEC_UCSI=m
>>   CONFIG_UCSI_CCG=m
>>   CONFIG_TYPEC_MUX_GPIO_SBU=m
> 
> This driver isn't used on SM8550, only CONFIG_TYPEC_UCSI is needed.

Indeed, apparently I messed something with config while looking for
other options. Patch can be skipped, the driver has no users in upstream
(and bindings are still missing :( ).

Best regards,
Krzysztof

