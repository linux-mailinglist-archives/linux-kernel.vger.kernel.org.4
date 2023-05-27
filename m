Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E6F7135CC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 18:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjE0Qsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 12:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjE0Qsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 12:48:35 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A4EBB
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 09:48:32 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f4b384c09fso2122915e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 09:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685206111; x=1687798111;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T6rAaidgfhu4LJ/9WLpglx2aFfzxycQ5nHQBVSzrKzU=;
        b=Jxy99EooV3oHM9GDBQV7S+OdsS+4pp14Mp5FoDHTse/a6McfcG2gxqJHw4IMrMQ+57
         QfYFrglJnreJGjQD/T4OImtHWYJVN3lYoe9bHdY0pTQ7hSDuYetfL6q2kk3p0N36Zi3b
         51oCw2lCKFTiPymV/kqOu951Qsl7T8zkYglghKVE6HCbuXqoCRoC5pwmKg/hYVw2bsci
         CWSGc3KwS660nTiJgOjrUBgwLeFlEGkKm6hBdaWwmTQjJIU1bPyi839qWnoDmvNY7TFB
         6pqFtsSUWwiERAJbyyi22MuzjulItvAbIwRSl5u4ZN0Ab7IZ08ifegN40LTaxvDMczXV
         DzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685206111; x=1687798111;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T6rAaidgfhu4LJ/9WLpglx2aFfzxycQ5nHQBVSzrKzU=;
        b=il6/r1Em4XZcfGU0Qc6fwxfatSdTOGrbSxUBOToIScAEAocRUJMj8Mt2J4BSWKQFTl
         vecypBlNGOD5CxJob9XfYVfFrj5ooPoxys3AmFYfey6RlDrmkb14PKZtbkcCUVVgtYPc
         qF3NKWrA2h/xE/cdQxGae9WpdWiTFgcZE/wHzoMyrTXMzhDoRJlx3Gca1/5x1b0Yf3Ed
         vTZuydZUc2eqs+VQl14krA78rytX8OHSGthL+ril3ifIzQVM6e82OYxZSf1/2s6bJXVk
         eTtrPCzyH6MBhT1GgeeAKmLopxQ7uQqZY06PpyVAgccm0dGftlPlLV6gYvyakvtNXeKF
         Z6Ng==
X-Gm-Message-State: AC+VfDzdoV56yQUI+52PzXErClRko3lfVZZ4hU7/oEaAF+VligImlM2g
        V5Gh84LIJddFH6i2FJgKMwOvjg==
X-Google-Smtp-Source: ACHHUZ7qmVREHbrmpTvboz+uVUuwjkFjM+MQdm/aETeh+HLW8R3WSw3JpWtJkCIWRQ155pAvdk+AbA==
X-Received: by 2002:ac2:4a86:0:b0:4f4:b41c:a8c1 with SMTP id l6-20020ac24a86000000b004f4b41ca8c1mr1793758lfp.69.1685206110871;
        Sat, 27 May 2023 09:48:30 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id m25-20020ac24ad9000000b004f391369ccbsm1198856lfp.55.2023.05.27.09.48.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 May 2023 09:48:30 -0700 (PDT)
Message-ID: <aeaef3fd-3347-1843-4038-fb6b6d52d266@linaro.org>
Date:   Sat, 27 May 2023 18:48:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 12/17] media: venus: firmware: Correct IS_V6() checks
Content-Language: en-US
To:     Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Hans Verkuil <hans.verkuil@cisco.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
References: <20230228-topic-venus-v3-0-6092ae43b58f@linaro.org>
 <20230228-topic-venus-v3-12-6092ae43b58f@linaro.org>
 <76f0d91e-eff0-3044-fd99-9371a9ce0cb3@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <76f0d91e-eff0-3044-fd99-9371a9ce0cb3@quicinc.com>
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



On 26.05.2023 09:03, Dikshita Agarwal wrote:
> 
> 
> On 5/18/2023 2:44 AM, Konrad Dybcio wrote:
>> Most of these checks should have checked for TZ presence (or well,
>> absence), as we shouldn't really be doing things that the black box
>> does for us on non-CrOS platforms.
>>
>> The IS_V6() check in venus_shutdown_no_tz() should have checked
>> whether the core version is IRIS2_1 (so, SC7280). Correct that.
>>
>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  drivers/media/platform/qcom/venus/firmware.c | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
>> index 572b649c56f3..ceb917f2e0d4 100644
>> --- a/drivers/media/platform/qcom/venus/firmware.c
>> +++ b/drivers/media/platform/qcom/venus/firmware.c
>> @@ -29,7 +29,11 @@ static void venus_reset_cpu(struct venus_core *core)
>>  	u32 fw_size = core->fw.mapped_mem_size;
>>  	void __iomem *wrapper_base;
>>  
>> -	if (IS_V6(core))
>> +	/*
>> +	 * When there's no Qualcomm TZ (like on Chromebooks), the OS is
>> +	 * responsible for bringing up the hardware instead.
>> +	 */
>> +	if (!core->use_tz)
>>  		wrapper_base = core->wrapper_tz_base;
>>  	else
>>  		wrapper_base = core->wrapper_base;
> this is invoked only for platforms not using TZ.
> The version checks are kept to differentiate between different TZ base offset.
> wrapper base offset for V6 (IRIS2_1) is calculated as
> 	wrapper_base = core->wrapper_tz_base
> while for others (non V6) wrapper base is calculated as
> 	wrapper_base = core->wrapper_base;
OK I see, this patch is bad indeed..

The IS_V6 should be IRIS2_1 as you mentioned, I'll do that instead.

We should however think about whether assuming every SC7180/SC7280
doesn't use TZ (reminder: not all SC7[12]80 are Chromebooks, there are
quite a lot of WoA laptops with WP firmware that has PAS), but that's
a problem that we may discuss separately.

Konrad
> 
> so this change in not correct.
> V6 check can be replaced with VPU version(IRIS2_1) check.
> 
>> @@ -41,7 +45,7 @@ static void venus_reset_cpu(struct venus_core *core)
>>  	writel(fw_size, wrapper_base + WRAPPER_NONPIX_START_ADDR);
>>  	writel(fw_size, wrapper_base + WRAPPER_NONPIX_END_ADDR);
>>  
>> -	if (IS_V6(core)) {
>> +	if (!core->use_tz) {
>>  		/* Bring XTSS out of reset */
>>  		writel(0, wrapper_base + WRAPPER_TZ_XTSS_SW_RESET);
>>  	} else {
>> @@ -67,7 +71,7 @@ int venus_set_hw_state(struct venus_core *core, bool resume)
>>  	if (resume) {
>>  		venus_reset_cpu(core);
>>  	} else {
>> -		if (IS_V6(core))
>> +		if (!core->use_tz)
>>  			writel(WRAPPER_XTSS_SW_RESET_BIT,
>>  			       core->wrapper_tz_base + WRAPPER_TZ_XTSS_SW_RESET);
>>  		else
> 
> this part of the code will only be executed for non TZ platform.
> for TZ based platforms it will return few instructions earlier in the same API.
> Again, version checks are kept to differentiate between different TZ base
> offset. V6 check can be replaced with VPU version(IRIS2_1) check.
> 
> Thanks,
> Dikshita
>> @@ -179,7 +183,7 @@ static int venus_shutdown_no_tz(struct venus_core *core)
>>  	void __iomem *wrapper_base = core->wrapper_base;
>>  	void __iomem *wrapper_tz_base = core->wrapper_tz_base;
>>  
>> -	if (IS_V6(core)) {
>> +	if (IS_IRIS2_1(core)) {
>>  		/* Assert the reset to XTSS */
>>  		reg = readl(wrapper_tz_base + WRAPPER_TZ_XTSS_SW_RESET);
>>  		reg |= WRAPPER_XTSS_SW_RESET_BIT;
>>
> 
> 
> 
> 
> 
