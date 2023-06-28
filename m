Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519A67414C8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjF1PUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjF1PUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:20:44 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B456268E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 08:20:42 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b698937f85so68748371fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 08:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687965640; x=1690557640;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O1zwqe2L/ZqF+4ydv1LkIfmqL/mIwvO8jVnOWDtDmHc=;
        b=nTxbvr+SBUiWzq9OAQX07rXCVvs2/Lbd4/KmFokAqczlvC+YDKyj96ycYBeELJHLbE
         ZaFgdtiUoZtw3RX8I1WbSeS7pmYLkLH3BwTfE4SbvtJjFJIc6/l00moGy0eNLiRpqtVW
         /qTk9Rsc7SV11Ua/yyvVfI9vP/ZsTZqH3cjehWmbPMPTeswMLb5fnMjwWCYZm9Pjs63F
         TUFXM0QSSn0s7eYwyZMHVM/ybdj4OhXHYh8Pjy6eYUk0Q/vMKH+aQrhfvye8VQEAL3k9
         7IEZqJNJ0elQNNtWnkKY7iTiqBjCgaeV8NYUO6y0ya4Bi6rb1yHm2HJnv5u2YKSTL925
         K17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687965640; x=1690557640;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O1zwqe2L/ZqF+4ydv1LkIfmqL/mIwvO8jVnOWDtDmHc=;
        b=NMdnayg7mfjrn6qulyuq9yW/AccFKtSNXZUEUawN7ccJFoz32bno87izvuqMs1NdxC
         ETQ+HtvwYWMxtXw+re7n0u63iT07X9nfULeNZfcfMRxrN/5nF4bIDMj2PH8dQKoVEdHj
         OsrGCmYNTWQUrs1UOaO62BcCYbHIrQhNv5iivVZsPNAPQ3hQX9pBa6yor/rd8UgOwYTy
         2p0gBTQNrA1rHBeVZae1rCg70wWsUQ2tA16kVx7yIeWAXguQaIjR7MPr1FQFwTaL+cL6
         4tBjSYdRyJ0ujiX1k7tTDT5k/HkHyLMUBdZdgg6lBAFp2qo7vcLTdJOB4KUAKMmVvH8j
         oF3g==
X-Gm-Message-State: AC+VfDyEXUtD0FeNtNOqyxBMlOjbyDr471oGFhZG8WtaGfBMCbqnoKm2
        ZN1eo953Q4Fvjb/2XuU5ZdFtLQ==
X-Google-Smtp-Source: ACHHUZ6JfrUGGy1kQpxW6rclkKMCtjKkk1FPM6l2RRR6pdSpC5gvG8oz7MM9jhGyN//xPLtECFBahA==
X-Received: by 2002:a2e:8089:0:b0:2b6:b88b:6689 with SMTP id i9-20020a2e8089000000b002b6b88b6689mr2940268ljg.22.1687965640187;
        Wed, 28 Jun 2023 08:20:40 -0700 (PDT)
Received: from [192.168.1.101] (abyk82.neoplus.adsl.tpnet.pl. [83.9.30.82])
        by smtp.gmail.com with ESMTPSA id x17-20020a2e8811000000b002b34f9cfc7asm2271183ljh.90.2023.06.28.08.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 08:20:39 -0700 (PDT)
Message-ID: <d5c5671f-b6a8-9e97-f917-784dffed7f90@linaro.org>
Date:   Wed, 28 Jun 2023 17:20:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 19/21] firmware: scm: Modify only the download bits in
 TCSR register
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, corbet@lwn.net,
        agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        mathieu.poirier@linaro.org, catalin.marinas@arm.com,
        will@kernel.org, linus.walleij@linaro.org,
        andy.shevchenko@gmail.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
 <1687955688-20809-20-git-send-email-quic_mojha@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1687955688-20809-20-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.06.2023 14:34, Mukesh Ojha wrote:
> CrashDump collection is based on the DLOAD bit of TCSR register.
> To retain other bits, we read the register and modify only the
> DLOAD bit as the other bits have their own significance.
> 
> Co-developed-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  drivers/firmware/qcom_scm.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index 104d86e49b97..a9ff77d16c42 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -30,6 +30,11 @@ module_param(download_mode, bool, 0);
>  #define SCM_HAS_IFACE_CLK	BIT(1)
>  #define SCM_HAS_BUS_CLK		BIT(2)
>  
> +#define QCOM_DOWNLOAD_FULLDUMP		 0x1
> +#define QCOM_DOWNLOAD_NODUMP		 0x0
> +#define QCOM_DOWNLOAD_MODE_SHIFT	   4
> +#define QCOM_DOWNLOAD_MODE_MASK		0x30
GENMASK and then FIELD_PREP below?

> +
>  struct qcom_scm {
>  	struct device *dev;
>  	struct clk *core_clk;
> @@ -440,6 +445,7 @@ static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
>  static void qcom_scm_set_download_mode(bool enable)
>  {
>  	bool avail;
> +	int val;
What's wrong with initializing it in the same line as ret?

>  	int ret = 0;
>  
>  	avail = __qcom_scm_is_call_available(__scm->dev,
> @@ -448,8 +454,10 @@ static void qcom_scm_set_download_mode(bool enable)
>  	if (avail) {
>  		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
>  	} else if (__scm->dload_mode_addr) {
> -		ret = qcom_scm_io_writel(__scm->dload_mode_addr,
> -				enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
> +		val = (enable ? QCOM_DOWNLOAD_FULLDUMP : QCOM_DOWNLOAD_NODUMP);
unnecessary braces

Konrad
> +		val <<= QCOM_DOWNLOAD_MODE_SHIFT;
> +		ret = qcom_scm_io_update_field(__scm->dload_mode_addr,
> +				QCOM_DOWNLOAD_MODE_MASK, val);
>  	} else {
>  		dev_err(__scm->dev,
>  			"No available mechanism for setting download mode\n");
