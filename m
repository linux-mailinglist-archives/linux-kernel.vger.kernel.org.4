Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8090372BE92
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjFLKPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbjFLKOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:14:06 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48085FD3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:55:40 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f74d6695e4so147709e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686563739; x=1689155739;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmXLNho23BSdPPEBQ4NrVTpZ2PrauMiCmKSCW3KEPJA=;
        b=q0CzFcHCql8LXeB7pImmmJvsZ2SmsaJJEGeME04ndnoizaqQoAnCd3t8CZGd6EINcT
         TGsyfGEApJMg8EX4bliWrDpPxxN9p7ofq72nQsQMaS2y/bql09jzH1UXuV+n+kKO+vMH
         mv1S23Yu1YZnFRzKAHpKA8abqdGH/K2iWRbRWtbcN5CXWlC6A1+I96CUO5BNTue+087c
         9+9+VjQN3iDId0KMXNvvzFN30owZnNPHuEhGIP0Ami2ka2qhnHihLhGybmvywMfjFa2B
         qXIGGzPyygu0wH8ZAKYV0R2cbdiTTAPnKRj5WnDMz9YO9PnzJVl9jCQZhEhflPYhAyxY
         T9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686563739; x=1689155739;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UmXLNho23BSdPPEBQ4NrVTpZ2PrauMiCmKSCW3KEPJA=;
        b=Rc7oF8lbCtZ+MElzc1PJk1jMBY4pwVpWGoC0LwhA0UjewYAdNTDR9bO2IKE53S5o4h
         oQhyFS+/VdfotLzaZWAPWey1wI9X+YvfL434K5BkPpPLXwCv85yMs85Pq4F9r2tdRx5F
         7vjqhsldOc2/dP5M7dfaPkC9RO8/nxZ7EjBNYXxRhdt5syvLEGpgEJs7KnbVpOuR+JJL
         +nmpEo/tDFWMquMOkiHhpBWmZGN9xi50bgivLNV7XbB3UkVAbiPLCEQ3na4aFfI4hGje
         37QaZhCTixi9FzxSGDvcxQWz/PAcAQJuYZ3LsmLompwUAudmmHhFOWjtmtbp/g8+Z67P
         D5Zg==
X-Gm-Message-State: AC+VfDxVeUAE+l1w6WxJ7WOOAb/k0oa3V/xU6OuqJHzDLpTijYtc0nh2
        nl2m4Q6lcpBCVMDQs1Ez73uuW/SP644vk8CAo6w=
X-Google-Smtp-Source: ACHHUZ7RmcJVp++i96A2jXiJNf87eZCqRgT6AY/Jc5xfZRphPnXw9ZoloI2QsCRvcxqRXUboViM4SA==
X-Received: by 2002:a05:6512:3111:b0:4f3:b18a:6494 with SMTP id n17-20020a056512311100b004f3b18a6494mr2764102lfb.22.1686563738823;
        Mon, 12 Jun 2023 02:55:38 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id i6-20020ac25226000000b004f62e388394sm1387807lfl.242.2023.06.12.02.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 02:55:38 -0700 (PDT)
Message-ID: <884bc3a8-8845-5659-943c-5c5638947e46@linaro.org>
Date:   Mon, 12 Jun 2023 11:55:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230610-topic-bwmon_opp-v1-1-65125d7493fc@linaro.org>
 <20230611014527.ezkgvtac5akrprdg@ripper>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH RFC] soc: qcom: icc-bwmon: Set default thresholds
 dynamically
In-Reply-To: <20230611014527.ezkgvtac5akrprdg@ripper>
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



On 11.06.2023 03:45, Bjorn Andersson wrote:
> On Sat, Jun 10, 2023 at 02:01:53PM +0200, Konrad Dybcio wrote:
>> Currently we use predefined threshold values. This works, but does not
>> really scale well, as they may differ between SoCs due to LPDDR generation
>> and/or DDR controller setup. All of the data we need for that is already
>> provided in the device tree, anyway.
>>
> 
> Per your own argument, the replaced values are just initial values and
> you should fairly quickly get some interrupt to start moving the
> threshold up or down. I don't think your argumentation expresses
> adequately why this "does not really scale well" and why your new values
> happens to work better.
E.g. the CPU bwmons have a default high threshold set to 4.8 Gbps, which
is very easy to achieve on LLCC<->DDR, but on older SoC where the bwmon
monitors CPU<->DDR, this is often near half of the max throughput.

> 
>> Change that to:
>> * 0 for low (as we've been doing up until now)
>> * BW_MIN/4 for mid
>> * BW_MIN for high
>>
>> The mid value is chosen for a "low enough" bw to nudge bwmon into
>> slowing down if the bw starts too high from the bootloader.
>>
> 
> As soon as we get the first interrupt, these values would be adjusted to
> the bandwidth of the surrounding opp pair. So why is the /4 needed in
> this initial state?
Hm, considering that just booting the kernel should be enough to trigger
an interrupt to go above FMIN, perhaps setting the mid value equal to
the high value could work as well? We're gonna receive an interrupt
in zones 2 and 3, but only the latter one will be considered.

Quick test on 8998 shows this could work!

Konrad
> 
>> The high value corresponds to the upper barrier which - when crossed -
>> raises an interrupt in the third zone, signaling a need for upping
>> the bw.
>>
>> This only changes the values programmed at probe time, as high and med
>> thresholds are updated at interrupt, based on the OPP table from DT.
>>
> 
> Your underlying reasoning, to remove the hard coded initial values,
> sounds very reasonable to me.
> 
> Regards,
> Bjorn
> 
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  drivers/soc/qcom/icc-bwmon.c | 28 +++++++---------------------
>>  1 file changed, 7 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
>> index 40068a285913..99cbdb3cf531 100644
>> --- a/drivers/soc/qcom/icc-bwmon.c
>> +++ b/drivers/soc/qcom/icc-bwmon.c
>> @@ -165,9 +165,6 @@ enum bwmon_fields {
>>  struct icc_bwmon_data {
>>  	unsigned int sample_ms;
>>  	unsigned int count_unit_kb; /* kbytes */
>> -	unsigned int default_highbw_kbps;
>> -	unsigned int default_medbw_kbps;
>> -	unsigned int default_lowbw_kbps;
>>  	u8 zone1_thres_count;
>>  	u8 zone3_thres_count;
>>  	unsigned int quirks;
>> @@ -564,20 +561,21 @@ static void bwmon_set_threshold(struct icc_bwmon *bwmon,
>>  static void bwmon_start(struct icc_bwmon *bwmon)
>>  {
>>  	const struct icc_bwmon_data *data = bwmon->data;
>> +	u32 bw_low = 0;
>>  	int window;
>>  
>> +	/* No need to check for errors, as this must have succeeded before. */
>> +	dev_pm_opp_find_bw_ceil(bwmon->dev, &bw_low, 0);
>> +
>>  	bwmon_clear_counters(bwmon, true);
>>  
>>  	window = mult_frac(bwmon->data->sample_ms, HW_TIMER_HZ, MSEC_PER_SEC);
>>  	/* Maximum sampling window: 0xffffff for v4 and 0xfffff for v5 */
>>  	regmap_field_write(bwmon->regs[F_SAMPLE_WINDOW], window);
>>  
>> -	bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_HIGH],
>> -			    data->default_highbw_kbps);
>> -	bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_MED],
>> -			    data->default_medbw_kbps);
>> -	bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_LOW],
>> -			    data->default_lowbw_kbps);
>> +	bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_HIGH], bw_low);
>> +	bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_MED], div_u64(bw_low, 4));
>> +	bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_LOW], 0);
>>  
>>  	regmap_field_write(bwmon->regs[F_THRESHOLD_COUNT_ZONE0],
>>  			   BWMON_THRESHOLD_COUNT_ZONE0_DEFAULT);
>> @@ -807,9 +805,6 @@ static int bwmon_remove(struct platform_device *pdev)
>>  static const struct icc_bwmon_data msm8998_bwmon_data = {
>>  	.sample_ms = 4,
>>  	.count_unit_kb = 1024,
>> -	.default_highbw_kbps = 4800 * 1024, /* 4.8 GBps */
>> -	.default_medbw_kbps = 512 * 1024, /* 512 MBps */
>> -	.default_lowbw_kbps = 0,
>>  	.zone1_thres_count = 16,
>>  	.zone3_thres_count = 1,
>>  	.quirks = BWMON_HAS_GLOBAL_IRQ,
>> @@ -822,9 +817,6 @@ static const struct icc_bwmon_data msm8998_bwmon_data = {
>>  static const struct icc_bwmon_data sdm845_cpu_bwmon_data = {
>>  	.sample_ms = 4,
>>  	.count_unit_kb = 64,
>> -	.default_highbw_kbps = 4800 * 1024, /* 4.8 GBps */
>> -	.default_medbw_kbps = 512 * 1024, /* 512 MBps */
>> -	.default_lowbw_kbps = 0,
>>  	.zone1_thres_count = 16,
>>  	.zone3_thres_count = 1,
>>  	.quirks = BWMON_HAS_GLOBAL_IRQ,
>> @@ -835,9 +827,6 @@ static const struct icc_bwmon_data sdm845_cpu_bwmon_data = {
>>  static const struct icc_bwmon_data sdm845_llcc_bwmon_data = {
>>  	.sample_ms = 4,
>>  	.count_unit_kb = 1024,
>> -	.default_highbw_kbps = 800 * 1024, /* 800 MBps */
>> -	.default_medbw_kbps = 256 * 1024, /* 256 MBps */
>> -	.default_lowbw_kbps = 0,
>>  	.zone1_thres_count = 16,
>>  	.zone3_thres_count = 1,
>>  	.regmap_fields = sdm845_llcc_bwmon_reg_fields,
>> @@ -847,9 +836,6 @@ static const struct icc_bwmon_data sdm845_llcc_bwmon_data = {
>>  static const struct icc_bwmon_data sc7280_llcc_bwmon_data = {
>>  	.sample_ms = 4,
>>  	.count_unit_kb = 64,
>> -	.default_highbw_kbps = 800 * 1024, /* 800 MBps */
>> -	.default_medbw_kbps = 256 * 1024, /* 256 MBps */
>> -	.default_lowbw_kbps = 0,
>>  	.zone1_thres_count = 16,
>>  	.zone3_thres_count = 1,
>>  	.quirks = BWMON_NEEDS_FORCE_CLEAR,
>>
>> ---
>> base-commit: 49dd846128d56199db2e3bcfca42d87fbc82b212
>> change-id: 20230610-topic-bwmon_opp-f995bbdd18bd
>>
>> Best regards,
>> -- 
>> Konrad Dybcio <konrad.dybcio@linaro.org>
>>
