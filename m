Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0C56A6AF0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 11:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjCAKj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 05:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjCAKjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 05:39:52 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AED033443
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 02:39:39 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id i9so17018548lfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 02:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UjHndKN1tS+EjYQpoHOpF9EKyx2gABq4MzoiM3edZ1U=;
        b=upMI+E7EJLlCLqENGp+ai12ZHdrNra4+9PJ/r+CE4cX3qrSxLeuCPhnP8eynIoZAa0
         7F64l/KZn3Su4IqA/nlVzKsyA8O8ijiTut5aTy0c2X1wwxmk1KT4pikQqjYdLyVFlI0g
         tXuPTFc3OEPDnqZM8YL+U/31q8IStGpvMLHazGoWHy+vYq/qgZnky0354csDnNEZ5qzm
         ayah7jFRqfo7BaSMb0e9HuiXw8Nzzb7/ehHM9fk39XCB8Li3hGPsu851SzylNoZU0CgV
         VZJaLdi30hjhQ9G9nQTuRnFbtZjvV6ZpAzQFQvze61M6Ab5bAjIx5Hr3y3FaF5TDQibr
         0qoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UjHndKN1tS+EjYQpoHOpF9EKyx2gABq4MzoiM3edZ1U=;
        b=Jcw3MLf7WVkqp2q+5BA/oEg2+0oAluoSGCIL9ifetCzhJoeGujYWbGFuWa+yAds0LC
         coBW5Zr8iO1qhi8ZSsB1O1GdsFYuLNlB92Rq+TrjPAc3jSTTM6Wp93OmDFHbq3ZyWGde
         sCCRfOpR/BMmvsIWgyjQXKfWa+TiHAPWT1EqC+3bXohPCzXXxeNioBa2SgVNCX3aoeQA
         EjN3GacZY2351vfsUuBeAMOdbqenuTImZQ/Pxk6hUp22t6I6Fc0C7TPntwckVu/Sk0kp
         hKBBPPrvF0C3gapXaH2a+20f1O0WQXXeR6NQ0B8Ce9O8AMiCY/eKmRYsWVMvXYIxnXIS
         31Bg==
X-Gm-Message-State: AO0yUKXqJpPOVOrv393ZqlCdbevmnkgnK7tOYcjY55nG/Vue/0Nc2GaP
        zwxsVexJ2oMweILxzZH1S3l3nQ==
X-Google-Smtp-Source: AK7set8De0Z7lVNOT5/6YGenuD9ZOXuT9s3eKmwqLdIyhwvUdMF+fH3SusR++xsHxw/yflBI42d1ng==
X-Received: by 2002:ac2:42d6:0:b0:4db:384c:bb8 with SMTP id n22-20020ac242d6000000b004db384c0bb8mr1556543lfl.69.1677667177662;
        Wed, 01 Mar 2023 02:39:37 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id w9-20020a056512098900b004dc721ea6a1sm1665050lft.273.2023.03.01.02.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 02:39:37 -0800 (PST)
Message-ID: <c59cbc7b-baa8-ec57-ec33-0455edf34c29@linaro.org>
Date:   Wed, 1 Mar 2023 12:39:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 2/4] firmware: scm: Modify only the DLOAD bit in TCSR
 register for download mode
Content-Language: en-GB
To:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1677664555-30191-1-git-send-email-quic_mojha@quicinc.com>
 <1677664555-30191-3-git-send-email-quic_mojha@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1677664555-30191-3-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2023 11:55, Mukesh Ojha wrote:
> CrashDump collection is based on the DLOAD bit of TCSR register.
> To retain other bits, we read the register and modify only the
> DLOAD bit as the other bits have their own significance.
> 
> Originally-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
> Changes in v2:
>   - Addressed comment made by Bjorn.
>   - Added download mask from patch 3 to this.
> 
>   drivers/firmware/qcom_scm.c | 17 +++++++++++++++--
>   1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index 51eb853..c9f1fad 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -27,6 +27,8 @@ module_param(download_mode, bool, 0);
>   #define SCM_HAS_IFACE_CLK	BIT(1)
>   #define SCM_HAS_BUS_CLK		BIT(2)
>   
> +#define QCOM_DOWNLOAD_MODE_MASK 0x30
> +
>   struct qcom_scm {
>   	struct device *dev;
>   	struct clk *core_clk;
> @@ -419,6 +421,7 @@ static void qcom_scm_set_download_mode(bool enable)
>   {
>   	bool avail;
>   	int ret = 0;
> +	u32 val;
>   
>   	avail = __qcom_scm_is_call_available(__scm->dev,
>   					     QCOM_SCM_SVC_BOOT,
> @@ -426,8 +429,18 @@ static void qcom_scm_set_download_mode(bool enable)
>   	if (avail) {
>   		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
>   	} else if (__scm->dload_mode_addr) {
> -		ret = qcom_scm_io_writel(__scm->dload_mode_addr,
> -				enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
> +		ret = qcom_scm_io_readl(__scm->dload_mode_addr, &val);
> +		if (ret) {
> +			dev_err(__scm->dev,
> +				"failed to read dload mode address value: %d\n", ret);
> +			return;
> +		}
> +
> +		val &= ~QCOM_DOWNLOAD_MODE_MASK;
> +		if (enable)
> +			val |= QCOM_SCM_BOOT_SET_DLOAD_MODE;
> +
> +		ret = qcom_scm_io_writel(__scm->dload_mode_addr, val);

Any locking for this RMW?

>   	} else {
>   		dev_err(__scm->dev,
>   			"No available mechanism for setting download mode\n");

-- 
With best wishes
Dmitry

