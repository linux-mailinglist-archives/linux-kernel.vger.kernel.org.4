Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC4A637782
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiKXLWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiKXLVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:21:54 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5AEB485
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:21:52 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id b3so2102398lfv.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZOwF1IoRFMxbzXIpHBYM5XNjvDo/YeKJYT2kSquRYBI=;
        b=Fg6jjuFR5m4W3eanpXYUM8RD8eOzPoKNiTAR69CyNrQ2TXTARkiaegBkmDzJvDN1Q5
         TNaH/kMR9SkcsPeZwr/zXwirLELiEk65ZML40X0ZieBPnZceiynsXnabKoCF45oLycbT
         K/TbRswfT8MLL42DQz++bH7QmDWySdsnm6S8HU/whadx+Ut9Sm188yQElzjDfsHgZuMG
         0vPjo0ApdVB0ERSHHgsIls14A194b6K8yvlZRAPPhGeKz85rMFNd+TJn+Bj3Jpyiub7F
         d26vGtmiHfXuX05tkMPiKarpGEXaEiJrAEqy38Xa5EIhEIphEod1yU/WAJUCZpgB7398
         TFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOwF1IoRFMxbzXIpHBYM5XNjvDo/YeKJYT2kSquRYBI=;
        b=fr80+N+wCaQ4DKqfW00KAggjKIBfFghGE+o5ENAWgn/0py173ZZboU/eus3MnD7MNr
         6gbrEcEMRgd8N7meHV/LgWTlZABdcxmvInD7rfM1v+62J23eebovpzZQ/NmBNqIGshDQ
         w93hPfCWXN2CN0mZyGNR8PyVjCT9LeazD7+pHgn4+ZqVVG2KTmlAEw7OR12Od0IXQRCM
         Ww4H4ichnnAXSpKV/l+VHj+pohYKPFwrFeyoPfD238TuTb5SwBJZBZ4zGT/MrgQdNVum
         Hri/oys1uZj4W0XgwVnj19DnMIKOvr4Q3wkoNUOm+jnJtblvqIfID04axW6PnTdT2rSz
         XcSQ==
X-Gm-Message-State: ANoB5pmEeoSuQb601OEq1pfFlBkWTg7lLDbhP3LPVM5sG1b/szum08kl
        pi1Q1AgzZwzPw8PclbAXlaVHqg==
X-Google-Smtp-Source: AA0mqf7vpoM/p1roR8SKJXHdDemXz3anj2sImLjc2Ea3xaf2sqNCO+JS7hjoMTCDlaijBDgrqDHsKA==
X-Received: by 2002:a19:5049:0:b0:4b4:661a:1ce1 with SMTP id z9-20020a195049000000b004b4661a1ce1mr8858626lfj.136.1669288911199;
        Thu, 24 Nov 2022 03:21:51 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f20-20020a0565123b1400b004a46a9cebe2sm88679lfv.289.2022.11.24.03.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 03:21:50 -0800 (PST)
Message-ID: <fc2774de-22d3-0326-a438-c5e804837d77@linaro.org>
Date:   Thu, 24 Nov 2022 12:21:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V5 2/2] firmware: qcom: scm: Add wait-queue handling logic
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@somainline.org, robimarko@gmail.com,
        quic_gurus@quicinc.com, quic_rjendra@quicinc.com
References: <20221123204615.25358-1-quic_sibis@quicinc.com>
 <20221123204615.25358-3-quic_sibis@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221123204615.25358-3-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2022 21:46, Sibi Sankar wrote:
> From: Guru Das Srinagesh <quic_gurus@quicinc.com>
> 
> When the firmware (FW) supports multiple requests per VM, multiple requests
> from the same/different VM can reach the firmware at the same time. Since
> the firmware currently being used has limited resources, it guards them
> with a resource lock and puts requests on a wait-queue internally and
> signals to HLOS that it is doing so. It does this by returning a new return
> value in addition to success or error: SCM_WAITQ_SLEEP. A sleeping SCM call
> can be woken up by an interrupt that the FW raises.

Just two nitpicks while browsing the code...

>  static int qcom_scm_probe(struct platform_device *pdev)
>  {
>  	struct qcom_scm *scm;
>  	unsigned long clks;
> -	int ret;
> +	int irq, ret;
>  
>  	scm = devm_kzalloc(&pdev->dev, sizeof(*scm), GFP_KERNEL);
>  	if (!scm)
> @@ -1399,9 +1486,29 @@ static int qcom_scm_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	platform_set_drvdata(pdev, scm);
> +
>  	__scm = scm;
>  	__scm->dev = &pdev->dev;
>  
> +	spin_lock_init(&__scm->waitq.idr_lock);
> +	idr_init(&__scm->waitq.idr);
> +	init_completion(&__scm->waitq.waitq_comp);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		if (irq != -ENXIO)
> +			return irq;
> +	} else {
> +		ret = devm_request_threaded_irq(__scm->dev, irq, NULL, qcom_scm_irq_handler,
> +						IRQF_ONESHOT, "qcom-scm", __scm);
> +		if (ret < 0) {
> +			dev_err(scm->dev, "Failed to request qcom-scm irq: %d\n", ret);
> +			idr_destroy(&__scm->waitq.idr);
> +			return ret;

return dev_err_probe().

> +		}
> +	}
> +
>  	__get_convention();
>  
>  	/*
> @@ -1417,6 +1524,12 @@ static int qcom_scm_probe(struct platform_device *pdev)
>  
>  static void qcom_scm_shutdown(struct platform_device *pdev)
>  {
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&__scm->waitq.idr_lock, flags);
> +	idr_destroy(&__scm->waitq.idr);
> +	spin_unlock_irqrestore(&__scm->waitq.idr_lock, flags);
> +
>  	/* Clean shutdown, disable download mode to allow normal restart */
>  	if (download_mode)
>  		qcom_scm_set_download_mode(false);
> diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
> index db3d08a01209..323cb49d4976 100644
> --- a/drivers/firmware/qcom_scm.h
> +++ b/drivers/firmware/qcom_scm.h
> @@ -60,6 +60,10 @@ struct qcom_scm_res {
>  	u64 result[MAX_QCOM_SCM_RETS];
>  };
>  
> +struct qcom_scm;
> +extern struct completion *qcom_scm_lookup_wq(struct qcom_scm *scm, u32 wq_ctx);
> +extern int scm_get_wq_ctx(u32 *wq_ctx, u32 *flags, u32 *more_pending);

No need for externs for new entries.

Best regards,
Krzysztof

