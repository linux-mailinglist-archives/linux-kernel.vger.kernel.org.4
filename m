Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A9B72ADC2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 19:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjFJRcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 13:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjFJRcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 13:32:45 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A3D3592
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 10:32:43 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f61d79b0f2so3564614e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 10:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686418361; x=1689010361;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JQu74s25ls9POighIl7gZ03lsKq9gsf4hCEdE8861u4=;
        b=nZAoJPlghX8fHGZ2URg9nVNifyfbCmnejJNvLSdSBllT21r4GR1OSYI2YQGasHTY7x
         nA5MwxciKOdezEW9mpu2GSrpednLSVGFa5JlZKCY62fGLCkbSYllK2RzZYla0etllMzw
         F4O1kuuIYgdBOSp5P+kjgT1F2IAAOvYFiLRPVKLvs/b6WxT7K2SXDmRjwM0efcsGK7QY
         o0XFTiJmEQEHXhjQWhAR4TOyigszh3W9klvcYZDh1PoEci/dlPKYnLoL3r7l7nasD/f7
         9TEZTpaVO8/ykxWWh6LmfwbUP3bmCBzboxuG4ZxkVVvWrCQsCs+j/spaYjF7J3trJc2R
         gAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686418361; x=1689010361;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQu74s25ls9POighIl7gZ03lsKq9gsf4hCEdE8861u4=;
        b=QTBhvMvOeO1e/6+HtMdBt4Orthg0lDBbmFPI6Sz2l0uSdCQd/Af1Qy/wrNPbTBzKAu
         l1StI7d+uS/2fvMfxKhJPKz2/e7k2mPGHGLzdVB6W6AkHfiipCzQUD8cR/+S+upRHptQ
         AuUsepRRsmJWUEQ/odyAYBxX8TxeqofurhlhDqGo1+jxA5gw8IHuxLLBD8TNP1gvnAmZ
         jNh8BoGxF7SE4MW88syhMmW7+3YxdCdgtsR73/TyXRAeuj77OWrp71KnxqkFWwImrd0l
         y+QLNW/erjBf5vOlIfRljsptntlavT9NnLqS73WPgEU8PCbFFaU42jhQhxw/V2piSPZK
         jXRA==
X-Gm-Message-State: AC+VfDxgw9RFmS+Y0jDsGZPXmJqqHhg5fBbH9T8BjGlajezzAuqpQB09
        nRZA+ZVT+hR7m/PDINHuiXgidgATLC/6DB+dbHI=
X-Google-Smtp-Source: ACHHUZ7PaJwtk9smGoBBSgqKJRBS2J08L8u2bZpNESImgXR/YzVX0FobRP4HHzOkjavRye3LxXGbzw==
X-Received: by 2002:a19:ab12:0:b0:4f3:bbfe:db4e with SMTP id u18-20020a19ab12000000b004f3bbfedb4emr2228022lfe.56.1686418361393;
        Sat, 10 Jun 2023 10:32:41 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id k12-20020ac2456c000000b004f37c22b410sm905925lfm.67.2023.06.10.10.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jun 2023 10:32:41 -0700 (PDT)
Message-ID: <af9364df-df56-f267-0369-83395d620c0f@linaro.org>
Date:   Sat, 10 Jun 2023 19:32:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH RFC] soc: qcom: icc-bwmon: Set default thresholds
 dynamically
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230610-topic-bwmon_opp-v1-1-65125d7493fc@linaro.org>
 <22aa4744-7167-11fe-b21e-0b0af07f51c3@linaro.org>
In-Reply-To: <22aa4744-7167-11fe-b21e-0b0af07f51c3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.06.2023 14:02, Konrad Dybcio wrote:
> 
> 
> On 10.06.2023 14:01, Konrad Dybcio wrote:
>> Currently we use predefined threshold values. This works, but does not
>> really scale well, as they may differ between SoCs due to LPDDR generation
>> and/or DDR controller setup. All of the data we need for that is already
>> provided in the device tree, anyway.
>>
>> Change that to:
>> * 0 for low (as we've been doing up until now)
>> * BW_MIN/4 for mid
>> * BW_MIN for high
>>
>> The mid value is chosen for a "low enough" bw to nudge bwmon into
>> slowing down if the bw starts too high from the bootloader.
>>
>> The high value corresponds to the upper barrier which - when crossed -
>> raises an interrupt in the third zone, signaling a need for upping
>> the bw.
>>
>> This only changes the values programmed at probe time, as high and med
>> thresholds are updated at interrupt, based on the OPP table from DT.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
> I think I hit a b4 bug and it didn't send this notice..:
> 
> Depends on: https://lore.kernel.org/linux-arm-msm/d403e841-7a86-1f07-c634-1990902826f1@linaro.org/
> 
> Konrad
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
Giving it a spin on more platforms, div4 seems to be.. too harsh for some?

MSM8998 boots fine if I divide it by 2, but crashes when I divide by 4..

Note sure what to make out of it..

Konrad
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
