Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1000962BDDA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbiKPMaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238964AbiKPM3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:29:46 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1B22638
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:29:02 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id n20so23093051ejh.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xg7dVOaFDd0a/VPutRddYPoMuVIlvBiMVnsUwJAfSmM=;
        b=Ungyqh/SYtSuUEiiQBC4ocLKvXefZa5gWgeDZSoEyHPd9uX+Tq4n/Xn8Plpo+fVsQN
         sULodzXKU8p2tLh/5H4umzlfeylwfrIBYhgaVQOYMAW5D34afJuE/Vmve3bj3nbgyx3K
         9VJeID3ERHJeoldPze0EOufSmP8V9yKiyXP8Dh3lB5u1Cc7jbsMD4MPtwzh6c2t3Ch7C
         0T0Qv2Igu/L5rRQBuqtgsW+jgnZR4gFm19N/p5dZpdoDZH+Ip43uTkV0eA5RKwD+yqNV
         8B7hNkjI8HtiUC+SmZFQnai21IMZI/Wht/RvIQ/k4A4kRyKIXkiZYngkkozHzuMoyKbo
         Fnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xg7dVOaFDd0a/VPutRddYPoMuVIlvBiMVnsUwJAfSmM=;
        b=CItIS9C6JYP69wispfybayG1ztIMuUDDRX+iEQWxpWscBJqeRzM6ldxPjwjqxzNyi9
         T9GwL+bPWQImHPRyX2abC/c2aFvCd7a1ysEw12fo91RiULJdhBG2DcsUNFZbrIz0/pzn
         tmX/iwmZZqm6NKXMfNulP+epOeslmIqDT7zM7pwdIbHU02Q5KIiVObdQpvEL/p1+YDTe
         MXk93GItYpFM6nBJXINSwwIkZm9RRY2PscltHhsio3xzqJZ5E5EdnZ8efN3SjGbnfq1n
         mbOIG6j0ARBPwfUgKEs+kagGaFvHYwwj7Tav9Cz0505ypv86PuEFDD1IaH/E9Vo8eHVz
         pcIg==
X-Gm-Message-State: ANoB5pl9teDQiWG9db3cEOk4EF6r7LUrAZ3qVJ7F/S4aStRP7RyqJ1Ru
        nrz2Fg4ZSJSoua+su2w60FJTLA==
X-Google-Smtp-Source: AA0mqf7qjYNJT6DAUPODOJytyXYvsHi572/YCcomACyd0Ftvk6pSCMlUafeu7D1HU5Zv9UfKrRvWkA==
X-Received: by 2002:a17:907:2123:b0:7a2:335e:90e2 with SMTP id qo3-20020a170907212300b007a2335e90e2mr17241409ejb.712.1668601741252;
        Wed, 16 Nov 2022 04:29:01 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id g17-20020aa7c851000000b0046383354bf9sm7466281edt.40.2022.11.16.04.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 04:29:00 -0800 (PST)
Message-ID: <57b0669c-3826-dc33-36a4-2d8220da768a@linaro.org>
Date:   Wed, 16 Nov 2022 13:28:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] ufs: host: ufs-qcom: Clear qunipro_g4_sel for HW
 version major 5
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org
References: <20221116121732.2731448-1-abel.vesa@linaro.org>
 <20221116121732.2731448-2-abel.vesa@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221116121732.2731448-2-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/11/2022 13:17, Abel Vesa wrote:
> On SM8550, depending on the Qunipro, we can run with G5 or G4.
> For now, when the major version is 5 or above, we go with G5.
> Therefore, we need to specifically tell UFS HC that.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>   drivers/ufs/host/ufs-qcom.c | 4 ++++
>   drivers/ufs/host/ufs-qcom.h | 2 ++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index ca60a5b0292b..72334aefe81c 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -227,6 +227,10 @@ static void ufs_qcom_select_unipro_mode(struct ufs_qcom_host *host)
>   	ufshcd_rmwl(host->hba, QUNIPRO_SEL,
>   		   ufs_qcom_cap_qunipro(host) ? QUNIPRO_SEL : 0,
>   		   REG_UFS_CFG1);
> +
> +	if (host->hw_ver.major == 0x05)
> +		ufshcd_rmwl(host->hba, QUNIPRO_G4_SEL, 0, REG_UFS_CFG0);
> +
>   	/* make sure above configuration is applied before we return */
>   	mb();
>   }
> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> index 751ded3e3531..10621055bf7f 100644
> --- a/drivers/ufs/host/ufs-qcom.h
> +++ b/drivers/ufs/host/ufs-qcom.h
> @@ -36,6 +36,7 @@ enum {
>   	/* On older UFS revisions, this register is called "RETRY_TIMER_REG" */
>   	REG_UFS_PARAM0                      = 0xD0,
>   	REG_UFS_PA_LINK_STARTUP_TIMER       = 0xD8,
> +	REG_UFS_CFG0                        = 0xD8,
Are you sure these two should point to the same register? Maybe it 
deserves some kind of a comment?

Konrad
>   	REG_UFS_CFG1                        = 0xDC,
>   	REG_UFS_CFG2                        = 0xE0,
>   	REG_UFS_HW_VERSION                  = 0xE4,
> @@ -75,6 +76,7 @@ enum {
>   
>   /* bit definitions for REG_UFS_CFG1 register */
>   #define QUNIPRO_SEL		BIT(0)
> +#define QUNIPRO_G4_SEL		BIT(5)
>   #define UFS_PHY_SOFT_RESET	BIT(1)
>   #define UTP_DBG_RAMS_EN		BIT(17)
>   #define TEST_BUS_EN		BIT(18)
