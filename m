Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D042A72AB4E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 14:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbjFJMDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 08:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234557AbjFJMDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 08:03:03 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC5E3ABD
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 05:02:52 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f62cf9755eso3226889e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 05:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686398570; x=1688990570;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YP04juwH6QsIro0gJJ9bi5HgAez8WGn8mU98dvHUvQg=;
        b=CcRHxEXgiTwc+PYn9Llo/yxr97FPUqbsSW4FuutmZrR3jVrTAbkdAn6lSX+R/xTS0A
         KdGsYl9YgqPUFt5SOmSnVPuAE/86dDNoenUZo9e7Kzicf2Jf4Z2ru++9EK/yr+hqkVHW
         OP30HeyExZP5DWXnMlLLiTK2U7KJByiFaDnr0logkvp8MnPH1MYnGjHLAlcoYUmwMd7r
         qX29vlk4g6H3qr6oVdVSdNqcFoS10GNbxmdFUav5tkuF+CgWpSXmPmpjiy3IPQD/ajN8
         8OujXUpbvR5BQbY8z3tsBx+vENWK2Ac/HLnSRJiKVdv8WCY3RZXQeSUT5aMC68G2kEwV
         hk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686398570; x=1688990570;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YP04juwH6QsIro0gJJ9bi5HgAez8WGn8mU98dvHUvQg=;
        b=RRm1ylB2uwa+ecUQMHTzFzacixARB0a7ju/Y95nRhSXkfa87q09ro6AiwJXl7P07ME
         7jGuNskKeg/GS+QiTHlhMGA5FTUWdN6ttqwq1DyGOglVkoUqMstpaLDE9XUxYPoDlfZi
         RkFhDZIW25hwpS5ogs9WQzgmiRRAPvEFe2txn563Dg7g0DBN7Sf6ONaXKPv1ze9DEK2g
         EL2OE6RjFvd8GtM2Pbb1hnD7cknihqyWD6WiZWcsHBZw8Mk5VBvLNz32NEV9uy/SPe5y
         dYc3gqz5I0ZbDfN+izUGOSyx6hzHkZ02tEeFJ7nvMXPyj1OQ39v9+2Oj5HVlbREqwaCO
         /McQ==
X-Gm-Message-State: AC+VfDzASv7n3lIo+xZ+6a+mmf+JDtQVv89/nyDR6W4vr1XSZqR1VBXP
        qHDeoax3RswrvPKbUNfyPxCopA==
X-Google-Smtp-Source: ACHHUZ6pj+o3A99Jy7j0V8pRQSX0ROOOKiXkS08JHyjTDlFxdylQuF40zbIyqI50Sx8pej42ndRSAA==
X-Received: by 2002:a19:8c52:0:b0:4ed:cc6d:61fe with SMTP id i18-20020a198c52000000b004edcc6d61femr1963893lfj.24.1686398569818;
        Sat, 10 Jun 2023 05:02:49 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id d29-20020ac25edd000000b004e83fbba141sm135641lfq.164.2023.06.10.05.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jun 2023 05:02:49 -0700 (PDT)
Message-ID: <22aa4744-7167-11fe-b21e-0b0af07f51c3@linaro.org>
Date:   Sat, 10 Jun 2023 14:02:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH RFC] soc: qcom: icc-bwmon: Set default thresholds
 dynamically
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230610-topic-bwmon_opp-v1-1-65125d7493fc@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230610-topic-bwmon_opp-v1-1-65125d7493fc@linaro.org>
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



On 10.06.2023 14:01, Konrad Dybcio wrote:
> Currently we use predefined threshold values. This works, but does not
> really scale well, as they may differ between SoCs due to LPDDR generation
> and/or DDR controller setup. All of the data we need for that is already
> provided in the device tree, anyway.
> 
> Change that to:
> * 0 for low (as we've been doing up until now)
> * BW_MIN/4 for mid
> * BW_MIN for high
> 
> The mid value is chosen for a "low enough" bw to nudge bwmon into
> slowing down if the bw starts too high from the bootloader.
> 
> The high value corresponds to the upper barrier which - when crossed -
> raises an interrupt in the third zone, signaling a need for upping
> the bw.
> 
> This only changes the values programmed at probe time, as high and med
> thresholds are updated at interrupt, based on the OPP table from DT.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
I think I hit a b4 bug and it didn't send this notice..:

Depends on: https://lore.kernel.org/linux-arm-msm/d403e841-7a86-1f07-c634-1990902826f1@linaro.org/

Konrad
>  drivers/soc/qcom/icc-bwmon.c | 28 +++++++---------------------
>  1 file changed, 7 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
> index 40068a285913..99cbdb3cf531 100644
> --- a/drivers/soc/qcom/icc-bwmon.c
> +++ b/drivers/soc/qcom/icc-bwmon.c
> @@ -165,9 +165,6 @@ enum bwmon_fields {
>  struct icc_bwmon_data {
>  	unsigned int sample_ms;
>  	unsigned int count_unit_kb; /* kbytes */
> -	unsigned int default_highbw_kbps;
> -	unsigned int default_medbw_kbps;
> -	unsigned int default_lowbw_kbps;
>  	u8 zone1_thres_count;
>  	u8 zone3_thres_count;
>  	unsigned int quirks;
> @@ -564,20 +561,21 @@ static void bwmon_set_threshold(struct icc_bwmon *bwmon,
>  static void bwmon_start(struct icc_bwmon *bwmon)
>  {
>  	const struct icc_bwmon_data *data = bwmon->data;
> +	u32 bw_low = 0;
>  	int window;
>  
> +	/* No need to check for errors, as this must have succeeded before. */
> +	dev_pm_opp_find_bw_ceil(bwmon->dev, &bw_low, 0);
> +
>  	bwmon_clear_counters(bwmon, true);
>  
>  	window = mult_frac(bwmon->data->sample_ms, HW_TIMER_HZ, MSEC_PER_SEC);
>  	/* Maximum sampling window: 0xffffff for v4 and 0xfffff for v5 */
>  	regmap_field_write(bwmon->regs[F_SAMPLE_WINDOW], window);
>  
> -	bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_HIGH],
> -			    data->default_highbw_kbps);
> -	bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_MED],
> -			    data->default_medbw_kbps);
> -	bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_LOW],
> -			    data->default_lowbw_kbps);
> +	bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_HIGH], bw_low);
> +	bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_MED], div_u64(bw_low, 4));
> +	bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_LOW], 0);
>  
>  	regmap_field_write(bwmon->regs[F_THRESHOLD_COUNT_ZONE0],
>  			   BWMON_THRESHOLD_COUNT_ZONE0_DEFAULT);
> @@ -807,9 +805,6 @@ static int bwmon_remove(struct platform_device *pdev)
>  static const struct icc_bwmon_data msm8998_bwmon_data = {
>  	.sample_ms = 4,
>  	.count_unit_kb = 1024,
> -	.default_highbw_kbps = 4800 * 1024, /* 4.8 GBps */
> -	.default_medbw_kbps = 512 * 1024, /* 512 MBps */
> -	.default_lowbw_kbps = 0,
>  	.zone1_thres_count = 16,
>  	.zone3_thres_count = 1,
>  	.quirks = BWMON_HAS_GLOBAL_IRQ,
> @@ -822,9 +817,6 @@ static const struct icc_bwmon_data msm8998_bwmon_data = {
>  static const struct icc_bwmon_data sdm845_cpu_bwmon_data = {
>  	.sample_ms = 4,
>  	.count_unit_kb = 64,
> -	.default_highbw_kbps = 4800 * 1024, /* 4.8 GBps */
> -	.default_medbw_kbps = 512 * 1024, /* 512 MBps */
> -	.default_lowbw_kbps = 0,
>  	.zone1_thres_count = 16,
>  	.zone3_thres_count = 1,
>  	.quirks = BWMON_HAS_GLOBAL_IRQ,
> @@ -835,9 +827,6 @@ static const struct icc_bwmon_data sdm845_cpu_bwmon_data = {
>  static const struct icc_bwmon_data sdm845_llcc_bwmon_data = {
>  	.sample_ms = 4,
>  	.count_unit_kb = 1024,
> -	.default_highbw_kbps = 800 * 1024, /* 800 MBps */
> -	.default_medbw_kbps = 256 * 1024, /* 256 MBps */
> -	.default_lowbw_kbps = 0,
>  	.zone1_thres_count = 16,
>  	.zone3_thres_count = 1,
>  	.regmap_fields = sdm845_llcc_bwmon_reg_fields,
> @@ -847,9 +836,6 @@ static const struct icc_bwmon_data sdm845_llcc_bwmon_data = {
>  static const struct icc_bwmon_data sc7280_llcc_bwmon_data = {
>  	.sample_ms = 4,
>  	.count_unit_kb = 64,
> -	.default_highbw_kbps = 800 * 1024, /* 800 MBps */
> -	.default_medbw_kbps = 256 * 1024, /* 256 MBps */
> -	.default_lowbw_kbps = 0,
>  	.zone1_thres_count = 16,
>  	.zone3_thres_count = 1,
>  	.quirks = BWMON_NEEDS_FORCE_CLEAR,
> 
> ---
> base-commit: 49dd846128d56199db2e3bcfca42d87fbc82b212
> change-id: 20230610-topic-bwmon_opp-f995bbdd18bd
> 
> Best regards,
