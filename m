Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0872A69BA76
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 15:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjBROnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 09:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBROnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 09:43:10 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217AE11EA3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 06:43:09 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id x18so1262926lfu.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 06:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j2JtiIeMM5Qh7iLDivPLXKMhSL89uXXNjq1NEQuV8jk=;
        b=TL550rJ2WUTkJQApdGZxJYx2k0C2IEqJi18fOaA8Hx8I/EWgP/bxd9nGslORT4S21X
         /uAnjvrCtWo2KvZCLPFnV9z6nxD0jvP0YN4YWzk7QTGI3bSEIiwbHv5UHxq8ESF2pqzo
         hHTci8FedD9t1RHPfGG9PQ5vbPpwO8RjzjRW8niogDENiw5Jx/C1SnWY2hrhXboncsAX
         HzR62k7v9gPaKQTL7kmtI6xIOofGL58xQYpWQUdvqzbq7jdxDaWb1Gzf2+Ui/gdDuC1G
         DPlQ8QrlZeH7xUXaPxyX5zarJiC/6ZVyttqxoPVZeADotLBv9CZu2da5dvM2HhC8yiP3
         V0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j2JtiIeMM5Qh7iLDivPLXKMhSL89uXXNjq1NEQuV8jk=;
        b=dgEpFLyuASefYOejG6M/j4wyUM1TP6a5ZSOSelfxsXCM+WuNA4ViXHVfeYgfL+GwDF
         bVW2HBj/+Il2XGo74gJ+z6JJB2lXeL9cuVgy+AZxyoUN+0LUKNyLP/902FFxQpbJR6jv
         6gxqOiSaNu3JPjGGCCf1z+9PyQQaerH6co/nROB//LFu3DhTwtttPbSSEiW5oYbIImZm
         E9ZfGl96dR7NugMh8/EV/cJllAQqMcP0bxuH7MGBpFuDdtRVlpopSFVWWSX/V3ZelItJ
         X7pt7q+mFyp84GJcDTqSVwGcIll667Wf/BQO/XVvi6DCzk+RF9W/JScxBTgOj21/OoAA
         iFLg==
X-Gm-Message-State: AO0yUKX5XzJbaKCp22TxHoyl90YY4CAP66UCfC7cuQyp4X18Q+lXFf4Z
        WlQyFH0g9KBNUwyWKlb4EDWLIg==
X-Google-Smtp-Source: AK7set+V1E1rfexjJzv31gH7TIO/LMx7j7Jn+1yQaAAni3f8RJ6w4leZoh0yHDq5ObHKz9IRr3Z6Jg==
X-Received: by 2002:ac2:5dea:0:b0:4db:56e:427c with SMTP id z10-20020ac25dea000000b004db056e427cmr981242lfq.56.1676731387362;
        Sat, 18 Feb 2023 06:43:07 -0800 (PST)
Received: from [192.168.1.101] (abxh184.neoplus.adsl.tpnet.pl. [83.9.1.184])
        by smtp.gmail.com with ESMTPSA id w10-20020a05651204ca00b004b5ab5e904esm998922lfq.306.2023.02.18.06.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Feb 2023 06:43:06 -0800 (PST)
Message-ID: <d71e8a18-8a09-c722-d9dd-b2d48615828f@linaro.org>
Date:   Sat, 18 Feb 2023 15:43:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 4/4] cpufreq: qcom-nvmem: make qcom_cpufreq_get_msm_id()
 return the SoC ID
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, ilia.lin@kernel.org,
        agross@kernel.org, andersson@kernel.org, rafael@kernel.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230121112947.53433-1-robimarko@gmail.com>
 <20230121112947.53433-4-robimarko@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230121112947.53433-4-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.01.2023 12:29, Robert Marko wrote:
> Currently, qcom_cpufreq_get_msm_id() does not simply return the SoC ID
> after getting it via SMEM call but instead uses an enum to encode the
> matched SMEM ID to 2 variants of MSM8996 which are then used in
> qcom_cpufreq_kryo_name_version() to set the supported version.
> 
> This prevents qcom_cpufreq_get_msm_id() from being universal and its doing
> more than its name suggests, so lets make it just return the SoC ID
> directly which allows matching directly on the SoC ID and removes the need
> for msm8996_version enum which simplifies the driver.
> It also allows reusing the qcom_cpufreq_get_msm_id() for new SoC-s.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 44 ++++++++--------------------
>  1 file changed, 12 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index da55d2e1925a..9deaf9521d6d 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -32,12 +32,6 @@
>  
>  #include <dt-bindings/arm/qcom,ids.h>
>  
> -enum _msm8996_version {
> -	MSM8996_V3,
> -	MSM8996_SG,
> -	NUM_OF_MSM8996_VERSIONS,
> -};
> -
>  struct qcom_cpufreq_drv;
>  
>  struct qcom_cpufreq_match_data {
> @@ -134,30 +128,16 @@ static void get_krait_bin_format_b(struct device *cpu_dev,
>  	dev_dbg(cpu_dev, "PVS version: %d\n", *pvs_ver);
>  }
>  
> -static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
> +static int qcom_cpufreq_get_msm_id(void)
This should be u32 as info->id is __le32

And please export this function from socinfo, it'll come in
useful for other drivers!

Konrad
>  {
>  	size_t len;
>  	struct socinfo *info;
> -	enum _msm8996_version version;
>  
>  	info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID, &len);
>  	if (IS_ERR(info))
> -		return NUM_OF_MSM8996_VERSIONS;
> +		return PTR_ERR(info);
>  
> -	switch (info->id) {
> -	case QCOM_ID_MSM8996:
> -	case QCOM_ID_APQ8096:
> -		version = MSM8996_V3;
> -		break;
> -	case QCOM_ID_MSM8996SG:
> -	case QCOM_ID_APQ8096SG:
> -		version = MSM8996_SG;
> -		break;
> -	default:
> -		version = NUM_OF_MSM8996_VERSIONS;
> -	}
> -
> -	return version;
> +	return info->id;
>  }
>  
>  static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
> @@ -166,25 +146,25 @@ static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
>  					  struct qcom_cpufreq_drv *drv)
>  {
>  	size_t len;
> +	int msm_id;
>  	u8 *speedbin;
> -	enum _msm8996_version msm8996_version;
>  	*pvs_name = NULL;
>  
> -	msm8996_version = qcom_cpufreq_get_msm_id();
> -	if (NUM_OF_MSM8996_VERSIONS == msm8996_version) {
> -		dev_err(cpu_dev, "Not Snapdragon 820/821!");
> -		return -ENODEV;
> -	}
> +	msm_id = qcom_cpufreq_get_msm_id();
> +	if (msm_id < 0)
> +		return msm_id;
>  
>  	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
>  	if (IS_ERR(speedbin))
>  		return PTR_ERR(speedbin);
>  
> -	switch (msm8996_version) {
> -	case MSM8996_V3:
> +	switch (msm_id) {
> +	case QCOM_ID_MSM8996:
> +	case QCOM_ID_APQ8096:
>  		drv->versions = 1 << (unsigned int)(*speedbin);
>  		break;
> -	case MSM8996_SG:
> +	case QCOM_ID_MSM8996SG:
> +	case QCOM_ID_APQ8096SG:
>  		drv->versions = 1 << ((unsigned int)(*speedbin) + 4);
>  		break;
>  	default:
