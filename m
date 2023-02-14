Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12D669640A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 13:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjBNM5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 07:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjBNM5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 07:57:45 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDFA222F4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:57:42 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id a2so15545602wrd.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O1iX/bRjubyY8icLKwkxEeosnt7C5yf2ACUDqg5rTDE=;
        b=esQrMFAYjAFxun7TNMECOXXoswmBWLNkD4VZvgXwJLZv9B9dC6O/boUaxl0G3y4JhJ
         qyYz5+Xx6xwagnAkDjVSXoJpCSLVqOh4DDKSc2Oji8q8G5+d8VI9UIpPKyF65eQbaMDp
         FgXD6/todPzvwTR25ZHo+QOiLnyozCwVXJ5DIPvBNFSAx5UMLu6Sv497sH7mvLQg1Yoy
         ao7GdPCmGP4b3QxAIuSKQNBHcWdtn60IMFIKzE5zptCd2ZHFcyXIDrZsSvw7E3MIVzmZ
         JrRvefgCI9Yxe46bZOfXmVrL+XkkitSS7lhc7XHpOO66FHU3N+beyfgJRpfkeNEREODa
         2wNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O1iX/bRjubyY8icLKwkxEeosnt7C5yf2ACUDqg5rTDE=;
        b=LfxzbDGZt9+8F+1emREyIVi6Mgaerkdm0De/f01Hdu8Ww3HIV4pFDDWcOKW+7kgpIV
         5Ug7OpKZpXLhyfDL1X6dsg9L4sMMAe/9Ei7jjVb+Q5t/2PBOxOibbaPPQXpOqH0K/ghn
         M5CWhmOORNEE0lMhu8sJv/qBGlZDGEnOAiAkL0F8AnKKAIIK7b6Vl7rGDLL7RclbdzFM
         bxOej+uhf5+HJyOXIaOiBqUs5Qfqzlh1tSwkzInr2xt/umBBkbyaR2xqkhC9ut2Icw0T
         TWbb09JpmqymCNJbgxbwIhs37Yn0AVm/b8IS0X0Q8y9YL2ek2UUKWRLwKJyyR3/y07MX
         Ua3w==
X-Gm-Message-State: AO0yUKXpyZEIMzh1l/ZeH+srJ4t3MkwX7KQqjG5/7zxIqHZ/6+DbXkhA
        /7If0Aoh7gvz4TmGUHCpegdA2g==
X-Google-Smtp-Source: AK7set/UjSDcHRoAgTRcvJa1W636nGs1OeuTPzOc0E3YkcnrM795r2mKtZkyHB2LFc+TC0Zd423IHQ==
X-Received: by 2002:a5d:4148:0:b0:2c5:4c7f:c91 with SMTP id c8-20020a5d4148000000b002c54c7f0c91mr2090318wrq.66.1676379461126;
        Tue, 14 Feb 2023 04:57:41 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id q2-20020a5d5742000000b002c560e6ea57sm2628077wrw.47.2023.02.14.04.57.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 04:57:40 -0800 (PST)
Message-ID: <ffeff1f8-ebf6-3115-38d1-fa318549baa0@linaro.org>
Date:   Tue, 14 Feb 2023 12:57:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V4 5/5] firmware: scm: Modify only the DLOAD bit in TCSR
 register for download mode
Content-Language: en-US
To:     Poovendhan Selvaraj <quic_poovendh@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        jassisinghbrar@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        shawnguo@kernel.org, arnd@arndb.de, marcel.ziswiler@toradex.com,
        robimarko@gmail.com, dmitry.baryshkov@linaro.org,
        nfraprado@collabora.com, broonie@kernel.org,
        quic_gurus@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_devipriy@quicinc.com
References: <20230214051414.10740-1-quic_poovendh@quicinc.com>
 <20230214051414.10740-6-quic_poovendh@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230214051414.10740-6-quic_poovendh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/02/2023 05:14, Poovendhan Selvaraj wrote:
> CrashDump collection is based on the DLOAD bit of TCSR register.
> To retain other bits, we read the register and modify only the DLOAD bit as
> the other bits have their own significance.
> 
> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Co-developed-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
> ---
>   Changes in V4:
> 	- retain the orginal value of tcsr register when download mode
> 	  is not set
> 
>   drivers/firmware/qcom_scm.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index 468d4d5ab550..8a34b386ac3a 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -407,7 +407,7 @@ int qcom_scm_set_remote_state(u32 state, u32 id)
>   }
>   EXPORT_SYMBOL(qcom_scm_set_remote_state);
>   
> -static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
> +static int __qcom_scm_set_dload_mode(struct device *dev, u32 val, bool enable)
>   {
>   	struct qcom_scm_desc desc = {
>   		.svc = QCOM_SCM_SVC_BOOT,
> @@ -417,7 +417,8 @@ static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
>   		.owner = ARM_SMCCC_OWNER_SIP,
>   	};
>   
> -	desc.args[1] = enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0;
> +	desc.args[1] = enable ? val | QCOM_SCM_BOOT_SET_DLOAD_MODE :
> +				val & ~(QCOM_SCM_BOOT_SET_DLOAD_MODE);

why not read the value here before setting the DLOAD Mode instead of 
doing it in qcom_scm_set_download_mode()?
that would make the code simple and readable.



>   
>   	return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
>   }
> @@ -426,15 +427,19 @@ static void qcom_scm_set_download_mode(bool enable)
>   {
>   	bool avail;
>   	int ret = 0;
> +	u32 dload_addr_val;
>   
>   	avail = __qcom_scm_is_call_available(__scm->dev,
>   					     QCOM_SCM_SVC_BOOT,
>   					     QCOM_SCM_BOOT_SET_DLOAD_MODE);
> +	ret = qcom_scm_io_readl(__scm->dload_mode_addr, &dload_addr_val);
> +
not checking ret value here before proceeding?

>   	if (avail) {
> -		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
> +		ret = __qcom_scm_set_dload_mode(__scm->dev, dload_addr_val, enable);
>   	} else if (__scm->dload_mode_addr) {
> -		ret = qcom_scm_io_writel(__scm->dload_mode_addr,
> -				enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
> +		ret = qcom_scm_io_writel(__scm->dload_mode_addr, enable ?
> +				dload_addr_val | QCOM_SCM_BOOT_SET_DLOAD_MODE :
> +				dload_addr_val & ~(QCOM_SCM_BOOT_SET_DLOAD_MODE));
>   	} else {
>   		dev_err(__scm->dev,
>   			"No available mechanism for setting download mode\n");
