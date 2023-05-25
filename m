Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3652711A7F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 01:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbjEYXSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 19:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbjEYXSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 19:18:08 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BA8119
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 16:18:05 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2af2db78b38so1069301fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 16:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685056684; x=1687648684;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zTB/pmwG63wu1XX6OpijzuyVDCKTeiG0sKpJUUaHack=;
        b=eaTbSaX7bvGX6VR5Tc7SMkP/yhL033FJ4CvGLMJjN7VPGwS7VxfOuzjDNl4l73fqjb
         CZIpDOuHeTSHx0sNliURXDgwldbWJ2kJgmjjEHvdSxrmbpl17ViOYlCJD0fBBfnjjw8x
         IIIMYTELX4K5OawLIpPXrRfcGDimQcO7aJ27H29HsZW3l5+ema3WdJq9jTnSI09KtHRd
         wSIAA94pwgUrETtZxqHz5gELRjG/g6fy0WjsV7h5mHSVv2KII03Gw6MXel4yNAL9HhhK
         0RGwi3q3mxkhj0sQg5QraUHknQmWDe9EVJyOj+eJiKVQEZTm0kA7mBdAv9peBWJ5D9Ag
         4RrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685056684; x=1687648684;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zTB/pmwG63wu1XX6OpijzuyVDCKTeiG0sKpJUUaHack=;
        b=M+vk1+rKdVFughns9g+oe28nDWmnQ7ZssUs+cmLkwv0d+aa7T9507gDf43I2fyfPlR
         +BnXHFlXJbx8qsSXShg33ZaQrBqtZejmdxh/JNkUE1xRE5dpzbIH+U/CjVE7eCcPtjcx
         FCgRthdlNHFUA4JbzEpkUkz68PFBqQul/E61w5gUycvTxg8A5i/mXJCQV42Zi2tpgcBP
         OmfQXZj39QP92BdVcMO2cmBvw5njrPMUrdaQ9RttlY3n3f6fxOmmWuUglOniVnKlalrc
         Npfd0pl7+JySn5ekG1Sp+5CEefDYi/ZOS23UTl6yw94XSx9o6m+VLsVdzpE9XECm5dxH
         KaPw==
X-Gm-Message-State: AC+VfDxPS7rnOt11RYNGN/qMM7wQoLlcLY5P+KoCTeQGpqmwQY6MPhAD
        2ANI7hgn1S1QvgdRJr9eWXnu3g==
X-Google-Smtp-Source: ACHHUZ5ynURV3MRz9L/oak0grldRs3wItPobCfex/UfUcG6ZZMYa1t67R3IhB+PNazHVZ+ohffaBgA==
X-Received: by 2002:ac2:443b:0:b0:4f4:c909:cdda with SMTP id w27-20020ac2443b000000b004f4c909cddamr1926602lfl.46.1685056684120;
        Thu, 25 May 2023 16:18:04 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id y6-20020a197506000000b004f2532cfbc1sm374041lfe.81.2023.05.25.16.18.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 16:18:03 -0700 (PDT)
Message-ID: <5382b518-7691-ee70-c522-9ce0b14d60c1@linaro.org>
Date:   Fri, 26 May 2023 01:18:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 5/5] cpufreq: qcom-nvmem: use helper to get SMEM SoC ID
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        andersson@kernel.org, ilia.lin@kernel.org, rafael@kernel.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     ansuelsmth@gmail.com
References: <20230525210214.78235-1-robimarko@gmail.com>
 <20230525210214.78235-5-robimarko@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230525210214.78235-5-robimarko@gmail.com>
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



On 25.05.2023 23:02, Robert Marko wrote:
> Now that SMEM exports a helper to get the SMEM SoC ID lets utilize it.
> Currently qcom_cpufreq_get_msm_id() is encoding the returned SMEM SoC ID
> into an enum, however there is no reason to do so and we can just match
> directly on the SMEM SoC ID as returned by qcom_smem_get_soc_id().
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Changes in v4:
> * Adapt to name change to qcom_smem_get_soc_id()
> 
> Changes in v3:
> * Adapt to helper using argument now
> 
> Changes in v2:
> * Utilize helper exported by SMEM instead of refactoring
> qcom_cpufreq_get_msm_id()
> ---
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 56 +++++-----------------------
>  1 file changed, 10 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index 60e99be2d3db..a88b6fe5db50 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -29,16 +29,8 @@
>  #include <linux/slab.h>
>  #include <linux/soc/qcom/smem.h>
>  
> -#define MSM_ID_SMEM	137
> -
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
> @@ -135,60 +127,32 @@ static void get_krait_bin_format_b(struct device *cpu_dev,
>  	dev_dbg(cpu_dev, "PVS version: %d\n", *pvs_ver);
>  }
>  
> -static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
> -{
> -	size_t len;
> -	u32 *msm_id;
> -	enum _msm8996_version version;
> -
> -	msm_id = qcom_smem_get(QCOM_SMEM_HOST_ANY, MSM_ID_SMEM, &len);
> -	if (IS_ERR(msm_id))
> -		return NUM_OF_MSM8996_VERSIONS;
> -
> -	/* The first 4 bytes are format, next to them is the actual msm-id */
> -	msm_id++;
> -
> -	switch ((enum _msm_id)*msm_id) {
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
> -}
> -
>  static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
>  					  struct nvmem_cell *speedbin_nvmem,
>  					  char **pvs_name,
>  					  struct qcom_cpufreq_drv *drv)
>  {
>  	size_t len;
> +	u32 msm_id;
__le32

>  	u8 *speedbin;
> -	enum _msm8996_version msm8996_version;
> +	int ret;
>  	*pvs_name = NULL;
>  
> -	msm8996_version = qcom_cpufreq_get_msm_id();
> -	if (NUM_OF_MSM8996_VERSIONS == msm8996_version) {
> -		dev_err(cpu_dev, "Not Snapdragon 820/821!");
> -		return -ENODEV;
> -	}
> +	ret = qcom_smem_get_soc_id(&msm_id);
> +	if (ret)
> +		return ret;
Now since it can return a PTR_ERR, you should check for IS_ERR
and return ERR_PTR if that happens

LGTM otherwise!

Konrad
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
