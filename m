Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2216B0C29
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjCHPHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjCHPGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:06:33 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13081BC781
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 07:06:32 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so1516788wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 07:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678287990;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cp3QSMZjutrY9l2+ZqdlepFcz1BvCXCgNgFvqcErA/Y=;
        b=qeycNNU7G9UVJcSwOnLSgjPs+SVRK0MgF6mwF7lxJqi13qLky6/fKL8aHASr2sV459
         sKjHdAWQuL7f7Se56DUCogmqAqbv6oClExOIV7tUXyCo7tTO9RKIpdhLjK5+YXgUI5nE
         n6TdjzviLnTS3iWKeSmMrAAIcpN6hKmfqpBbbf3odHK2FVXYPoe0xYxYKlrzsvkCf2nc
         Kt+dWHr4arKvrE/x8nno69h89ecylpkZSxX0Wg8nSYYjSqB9H+CLz49PoS2c91qPb/mG
         SJxcqFfVAGiKdxVBZcAd4xVMm9CGSfqmcJGBshQq8zleahao0Q3ffXZ5DIFdCAi4EL8e
         pvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678287990;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cp3QSMZjutrY9l2+ZqdlepFcz1BvCXCgNgFvqcErA/Y=;
        b=PjmA5LoEb3H64nh5caSaEVyvpNbrQm7l+Bkl/BjAEPeTaRwfHJD+z0vWbOlCMo+8+I
         OuJQE3E8QFxJu0eikRzBBiVktalT4vf4I1IneUX0vsxo09HB/9xswjkBzpjAIaqbTW/D
         c2NLzzLVkUpwPeev2ExCB5xtbkSYXY+Qa+tpI3J6GZi0eCfXG0FOzsPcLvwnMnb0krnD
         cA1FDv4WpqBwAkCoU/6PC3/C2tv3A7bPeAJA+J/y1W0Jv9sQ2D/FCqJkb/C4awYwWzDn
         kDUvIfz/w4xqtF+ocoBhqWHHeovk0GzjzlzioAP6Xg2zEQyFjZsGGpvLOEOTNxtC2b88
         1ECA==
X-Gm-Message-State: AO0yUKXHdiS0gd0XougRIgioHjA1B9kAoFH+beakJaDknPdf3y2j9r6G
        nRcJE5MlwzbrkU0LILJlS4dMdQ==
X-Google-Smtp-Source: AK7set+EKjRtDFd9DblHOrfIvLe1KP6M7gKZP6BTD07f/1kzMBNqrYCc/QBuXixZjL3PczC/08wS8A==
X-Received: by 2002:a05:600c:1e8d:b0:3e2:669:757 with SMTP id be13-20020a05600c1e8d00b003e206690757mr16125364wmb.10.1678287990556;
        Wed, 08 Mar 2023 07:06:30 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id e41-20020a05600c4ba900b003e1f2e43a1csm15747112wmp.48.2023.03.08.07.06.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 07:06:29 -0800 (PST)
Message-ID: <86391f5a-ccbc-133b-47d2-2d98e40d7ef7@linaro.org>
Date:   Wed, 8 Mar 2023 15:06:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 2/4] firmware: scm: Modify only the DLOAD bit in TCSR
 register for download mode
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1677664555-30191-1-git-send-email-quic_mojha@quicinc.com>
 <1677664555-30191-3-git-send-email-quic_mojha@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <1677664555-30191-3-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/03/2023 09:55, Mukesh Ojha wrote:
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


This is the second instance of such pattern of usage one is already in 
./drivers/pinctrl/qcom/pinctrl-msm.c

I think it makes sense to move setting fields in register to a dedicated 
function like this:

int qcom_scm_io_update_field(phys_addr_t addr, unsigned int mask, 
unsigned int val)
{
	unsigned int old, new;
	int ret;

	ret = qcom_scm_io_readl(addr, &old);
	if (ret)
		return ret;

	new = (old & ~mask) | (val << ffs(mask) - 1);

	return qcom_scm_io_writel(addr, new);
}
EXPORT_SYMBOL(qcom_scm_io_update_field);


then we could use it like this:
ret = qcom_scm_io_update_field(__scm->dload_mode_addr, 
QCOM_DOWNLOAD_MODE_MASK, dl_mode)


--srini
>   	} else {
>   		dev_err(__scm->dev,
>   			"No available mechanism for setting download mode\n");
