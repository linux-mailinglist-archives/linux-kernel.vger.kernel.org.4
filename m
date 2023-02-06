Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C6168BF1F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjBFOAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjBFN7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:59:42 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8199610276
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 05:59:06 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id bg26so8762094wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 05:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kmZDJq0SVi7o7GpUbRWGne1AHgVWFMKAaDLTM0ZOuQY=;
        b=GKAlZbdZ5o8dd4xNv5sQhEUmXw46o/8ZihIJSG+EbKM3a1yBlxoXMogJ+ZJ+LDamZH
         sI3SfqfMQbpkwHyP82X8s+hvqDFfF0IZ179Egm2OUKo8QPf1duVvP/IHvTNgFHdHYuh8
         oGN4a7V6c8x/vi6kSKuBRuVvYkObxNWVglI8p9cqGe2skS5+SYX/VafotK1NtWxjEL6U
         i4WBs2cdveHO6Rn+9udeBrowwEZeI6g0eGIobja1seZWxEaN0z/lTNbnIN9IBq93yo6r
         CVigonBy0dhds6lfgagMtvPe0Gj9NbxVAMk9hPSGEtgsZIsl3snU/H5TOV/YPfpApKFW
         3QeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kmZDJq0SVi7o7GpUbRWGne1AHgVWFMKAaDLTM0ZOuQY=;
        b=kx3V8M2cruvIPzBTzgwJEXuEMyLFMC54KTg9NBls0/qeRj6KxlLpuD9bj8IxLmPG1g
         5B3AuafO8anBomL9eaRZ7uNt5hBmflPcyBENA1kOz+lqIY6rmcFEiC2h/LRvCLbuqaQM
         8QjVRcj/Fy29RzxAf5EtLkKVSmXpJoyOfBXa+AaHzCjPQm+zvtle8gQSTwUDduHVqvAt
         Mk8jc08dTZlPzQknsTv+F/kqs1pl1otdRdrCNRyKxwTTmG57Xr0mdQXkSnYhtCRvmVWU
         tbxldlFNlsvqLaLZhOMhyrJEhXZG/yocJWyEEFaqNZWNDnrj/NhsxuTiTdD70DioovW7
         nJQg==
X-Gm-Message-State: AO0yUKUCnPWpAPYK0HE00DuPAgKcdXWv7SOq6oeR/h9gngvsOf4cdZA4
        YgCKUEkFEdQeeikdf0IkaNS9jA==
X-Google-Smtp-Source: AK7set/Iam36gM+BJU/GVk2rHJ/ucybrKhiA43okIGYj6Q2JzX3C/6LFMAyW+tNoFA0LvDZUsSVYCg==
X-Received: by 2002:a05:600c:310b:b0:3df:e730:42fc with SMTP id g11-20020a05600c310b00b003dfe73042fcmr7977884wmo.13.1675691945108;
        Mon, 06 Feb 2023 05:59:05 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:f03f:3ced:a369:d884? ([2a01:e0a:982:cbb0:f03f:3ced:a369:d884])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c4fce00b003dc1a525f22sm11603244wmq.25.2023.02.06.05.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 05:59:04 -0800 (PST)
Message-ID: <89d74151-08b1-74b2-455a-ddb3db6cc4cf@linaro.org>
Date:   Mon, 6 Feb 2023 14:59:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] remoteproc: qcom_q6v5_pas: enable sm8550 adsp & cdsp
 autoboot
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230206-topic-sm8550-upstream-fix-remoteproc-autoboot-v1-1-11445a0c27c6@linaro.org>
 <48ac2e20-d80c-c842-3766-b5df30053270@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <48ac2e20-d80c-c842-3766-b5df30053270@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/2023 14:54, Konrad Dybcio wrote:
> 
> 
> On 6.02.2023 14:53, Neil Armstrong wrote:
>> Set the SM8550 adsp & cdsp auto_boot to true to match the behavior
>> of the previous platforms.
>>
>> Fixes: 7eddedc97563 ("remoteproc: qcom_q6v5_pas: add sm8550 adsp, cdsp & mpss compatible & data")
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Konrad
>>   drivers/remoteproc/qcom_q6v5_pas.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
>> index 4e1d9b08def4..90c5612a3045 100644
>> --- a/drivers/remoteproc/qcom_q6v5_pas.c
>> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
>> @@ -1108,7 +1108,7 @@ static const struct adsp_data sm8550_adsp_resource = {
>>   	.pas_id = 1,
>>   	.dtb_pas_id = 0x24,
>>   	.minidump_id = 5,
>> -	.auto_boot = false,
>> +	.auto_boot = true,
>>   	.proxy_pd_names = (char*[]){
>>   		"lcx",
>>   		"lmx",
>> @@ -1127,7 +1127,7 @@ static const struct adsp_data sm8550_cdsp_resource = {
>>   	.pas_id = 18,
>>   	.dtb_pas_id = 0x25,
>>   	.minidump_id = 7,
>> -	.auto_boot = false,
>> +	.auto_boot = true,
>>   	.proxy_pd_names = (char*[]){
>>   		"cx",
>>   		"mxc",
>>
>> ---
>> base-commit: ea4dabbb4ad7eb52632a2ca0b8f89f0ea7c55dcf
>> change-id: 20230206-topic-sm8550-upstream-fix-remoteproc-autoboot-5c7effcf197c
> P.S not sure if you wanted to send that to lkml

It's part of what b4 sends, there's nothing secret

Neil

>>
>> Best regards,

