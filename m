Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C722649C10
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 11:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbiLLK0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 05:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbiLLK0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 05:26:17 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADFAFD1E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 02:26:14 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id f18so11555652wrj.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 02:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l879BTu/5FIA2goMiwpSyg0RiCbHZeU5mD7R/xhw8bw=;
        b=yW2MyZalUc/SpObXMNTqeAocoV8ESWARha0NEbcxQn0kvvy7O4NPpGf3YBJ9qad1s0
         VDK9Deol0Go5qBJtuxblNnbrAINeo9Bx/bAuTxZ5HJFBuFa5iPfYzvNInlDVQHN4r7h3
         S4yec+JLVfWEPOd6Lda4XJPvVZdSS2g2FXmY98HxEl7+G2LA7d0/TP+yo1/Gw9/gFse8
         8vQBwhzD8/BYh4v+V1KHJ0TvdQMDp3NTYXSMAtnTFqJh7nzV74IN/xupxMaq7vVrDLHX
         7iVEK19lEI1iT6uCNAF1aV01ddWtDZdomACZ7gRmtt6/f4RjrCxsPWSSOIMcdycDaoUt
         NXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l879BTu/5FIA2goMiwpSyg0RiCbHZeU5mD7R/xhw8bw=;
        b=PTJ/DAypgN1ZVOlSNI76dKx+SZ8fUAkRIHePhi6Ecx9Xe5vbQCgKrGNkXX7rBoxhFM
         kJBI/U2nPD07qptt5+Jy/AWnMfBpi+yUObmKFJ+2YzyxLmrAngxHgDDqOOWV2/ArCPKO
         6UFQa0UQTJQf2gl8BLYyGvPfsNyTxzIuMmff1VKy8G1fJYasgg0P+/pXj4jhDENlGpqG
         nAYb9v8jAVwC4pMrc1MN7Hgc1jL4ibX11otqu2RdXZMUNYMNS+WxgKfUEw1aQfbXXJ1j
         2FrzOxb/nfU8BDVCCyO5KJCA5xh1azEDmUxF5E+0peA34Mo2QhoZWqSNAMfz43GfHHRt
         SIIQ==
X-Gm-Message-State: ANoB5pmO8/w5/8nXmFXyft1MUkY+8jR4NXZLT1AKzxpYj36rXB1qazsW
        QGI/7nEGyLvldro/RznyCabYCtOMiAjtA30R
X-Google-Smtp-Source: AA0mqf5KrtnfirbxeovkqOmIygQa6AoENqfsXGTkQpDsvRN/QXqRL9nx2Ve64S6iGXcP+QimZftwZw==
X-Received: by 2002:a5d:5d0b:0:b0:23a:5a31:29f5 with SMTP id ch11-20020a5d5d0b000000b0023a5a3129f5mr11257752wrb.23.1670840773405;
        Mon, 12 Dec 2022 02:26:13 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id y7-20020a5d6147000000b00226dba960b4sm8493877wrt.3.2022.12.12.02.26.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 02:26:12 -0800 (PST)
Message-ID: <0b5ca79c-5d8c-5720-cd14-cfa4697b628d@linaro.org>
Date:   Mon, 12 Dec 2022 10:26:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] slimbus: qcom-ngd: Add check for platform_driver_register
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, agross@kernel.org,
        konrad.dybcio@somainline.org
Cc:     linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20221212094950.23050-1-jiasheng@iscas.ac.cn>
Content-Language: en-US
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20221212094950.23050-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/12/2022 09:49, Jiasheng Jiang wrote:
> Add the check for the return value of platform_driver_register
> in order to catch the exception.
> 
> Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Applied thanks,

--srini
> ---
>   drivers/slimbus/qcom-ngd-ctrl.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
> index 76c5e446d243..c16fc9e6d1c6 100644
> --- a/drivers/slimbus/qcom-ngd-ctrl.c
> +++ b/drivers/slimbus/qcom-ngd-ctrl.c
> @@ -1590,7 +1590,10 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
>   		goto err_pdr_lookup;
>   	}
>   
> -	platform_driver_register(&qcom_slim_ngd_driver);
> +	ret = platform_driver_register(&qcom_slim_ngd_driver);
> +	if (ret < 0)
> +		goto err_pdr_lookup; > +
>   	return of_qcom_slim_ngd_register(dev, ctrl);
>   
>   err_pdr_alloc:
