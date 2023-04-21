Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDED56EA9AF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 13:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjDULxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 07:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjDULxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 07:53:12 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3893A4EED
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 04:53:04 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4ec816c9d03so1636572e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 04:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682077982; x=1684669982;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Tctvi1T7uWRNiQ9tzC4LHci30BlviPi5BuTXmg+G4U=;
        b=tZuo84f7ymjDqoKsocYpW1UiwisOAs9s8vL4UPa2z/pupNzmkoPcomnrieemcNkMR1
         yMXB59H/cCQ0i9pd7J9DYv2lJwSRxMimsi5QpHAGcDn+rPPSUJYqA+eZHZJCQ5gruBkg
         DXZzq1iJJOZyJ2kPKVQhpYn942GqMdPrwzLF51MeTfH9Jx1zQlmDr5CJmQG27/xhdhQE
         chFdxCKTMDURYGGEA1uD/+9JTdJIAW188cKB0bQq40BfeS2z7L3zok8gAGP/mMoHQd9q
         ORvQhH+klLTbB/+o6QolHgewRnICtyTDyeobKgaO4MXHa7oLCaXo4s3MO9IzCWCFBF32
         8iwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682077982; x=1684669982;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Tctvi1T7uWRNiQ9tzC4LHci30BlviPi5BuTXmg+G4U=;
        b=Jkq1U2PAXiABipGYNHeHRomjkQvdhsXDILcvivwaI9DvLSk74jfpxFV2lJEZNO3sTV
         RkRkg12ZRcxBV9/5AY0VzxEYv7SHhNL1PC/iyh47dxdN03Eav1HMJpVD8LbeM9fmJ9/o
         amnEt2spSlEXcy40SlUNZWYvbymXKtcuTCVso5AEH1Cm2dqH+h/x2cmN1MVlxU0cj4Wk
         582o3gENJ+yzzaRu3Gv3Lm/bcP95tmEWrgCHxIR0r34mKVqJz3sarpcykPp0WCILn/MW
         yaGTkyEa2GZIG7kz2EyOY+bAl13Fs0MwkNjMshEryywArwSFaigxER11GQgrQzaiihi3
         iVuw==
X-Gm-Message-State: AAQBX9fnj38hv9oD+tuFsprdmqQ7+AXY3TCoaE+irmJqY7uVxcbln9eX
        0CSbJPa3vcl5VvLQrb6MAss2HQ==
X-Google-Smtp-Source: AKy350YMZLWzfe50czDUO5u26OQGGazQcsnJZc/FPugk3HRL4VBFH9MHyC3EfxlYvfGWvSWoTQT7vA==
X-Received: by 2002:ac2:41d0:0:b0:4ed:ca92:87f2 with SMTP id d16-20020ac241d0000000b004edca9287f2mr1334279lfi.20.1682077982416;
        Fri, 21 Apr 2023 04:53:02 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id z2-20020ac25de2000000b004ec89c94f04sm534673lfq.155.2023.04.21.04.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 04:53:02 -0700 (PDT)
Message-ID: <bec64668-f6bf-c41a-58b2-6ca25b1b3668@linaro.org>
Date:   Fri, 21 Apr 2023 13:53:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] soc: qcom: rmtfs: Fix error code in probe()
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <76b21a14-70ff-4ca9-927d-587543c6699c@kili.mountain>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <76b21a14-70ff-4ca9-927d-587543c6699c@kili.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.04.2023 12:44, Dan Carpenter wrote:
> Return an error code if of_property_count_u32_elems() fails.  Don't
> return success.
> 
> Fixes: e656cd0bcf3d ("soc: qcom: rmtfs: Optionally map RMTFS to more VMs")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/soc/qcom/rmtfs_mem.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
> index ce48a9f3b4c8..f83811f51175 100644
> --- a/drivers/soc/qcom/rmtfs_mem.c
> +++ b/drivers/soc/qcom/rmtfs_mem.c
> @@ -233,6 +233,7 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
>  		num_vmids = 0;
>  	} else if (num_vmids < 0) {
>  		dev_err(&pdev->dev, "failed to count qcom,vmid elements: %d\n", num_vmids);
> +		ret = num_vmids;
>  		goto remove_cdev;
>  	} else if (num_vmids > NUM_MAX_VMIDS) {
>  		dev_warn(&pdev->dev,
