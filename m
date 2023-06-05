Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEDE722EF8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 20:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjFESx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 14:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjFESx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 14:53:26 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F334EC
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 11:53:25 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f619c2ba18so3189041e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 11:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685991203; x=1688583203;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q9rzG8UD/ldrMcAHE1T1BvaSz6ylxNrtU5fahC9y+bI=;
        b=VcDYifDHedypBZZ1STGBiZySLcfYg6Ha4zn3yorgcINosc89BKZJdtIMuJgtZECZkD
         suMzOHUU8ehqsA0Wpa877CG9/FLtsx74VctyzYiySmhcge98ZeZAkaYO2TzTcRJJ5FOx
         cpWaZc0VzEceKgfQdqF4ylRl9WlG6KgRUuzTZHuh16casmjilzBAsKW4SHVhjNmT/pbK
         G2juGHH2dKJoiwejOcnK+ge+gnwLkVkoZQVtaTPIJxGiE0UPF6ATOf6XdtT5NxPtxc5k
         bFJfsLGSSyHFL3Bh0HRrOGEyoqLcWOnDB+t8JTwbsGdV0JOdvAI0Eje5ZVV9nhIAZ+GA
         l7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685991203; x=1688583203;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9rzG8UD/ldrMcAHE1T1BvaSz6ylxNrtU5fahC9y+bI=;
        b=YdB4P4vIX8ts/4z1rmWWN1deZO+cvkZR6tnHKvuPVCUGZj05NMk/JLG3Uc1CR7qTTK
         6eZLxALlZ/naWmyP2v6xrOlf/NsQ7+wAppqmVVQILuo7N3IX8+y9ZbC2acnuvLD+rpOO
         HMSoWoWZ7zDlDK98lgC2sKKkAcAVdD+tBM75C/e1TJ5hyiF/FiXwwppTv+2tZSUyy/Wl
         7d+GiOEWgm1tnqUioe4JOwWUkXJ54IdHjCSstx4acP5ZQBwZJ5ANc7zsGpJ6IEBfMKbn
         uBbcM40p0PbRbGSFh6bAYLma5X8yp1ptvgNOQU76k1WeAkiDrwY5u5rcKbGmlTIR4tak
         +8Bg==
X-Gm-Message-State: AC+VfDz+CvGSKQVYkR5gRw309PupTKETXAU2aZOyySxK5i3+x+ZOZTPQ
        wfPVV4ALxlsqDA8Z8jqM+tw44A==
X-Google-Smtp-Source: ACHHUZ5rjHaJj9TnfKZQcvYFsyp47ETkS5pDK6TXhDJrno9DBi7/s8YUHv5LhjP9bPqJ0YP85Jy5HA==
X-Received: by 2002:a05:6512:11eb:b0:4f5:1ca1:30ce with SMTP id p11-20020a05651211eb00b004f51ca130cemr5825409lfs.47.1685991203383;
        Mon, 05 Jun 2023 11:53:23 -0700 (PDT)
Received: from [192.168.1.101] (abyj96.neoplus.adsl.tpnet.pl. [83.9.29.96])
        by smtp.gmail.com with ESMTPSA id n7-20020a195507000000b004f1482d9db6sm1197914lfe.155.2023.06.05.11.53.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 11:53:23 -0700 (PDT)
Message-ID: <f755a2d9-353d-edae-f397-cbc48460db75@linaro.org>
Date:   Mon, 5 Jun 2023 20:53:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 08/14] soc: qcom: smem: Add qcom_smem_is_available()
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20230531-rpm-rproc-v1-0-e0a3b6de1f14@gerhold.net>
 <20230531-rpm-rproc-v1-8-e0a3b6de1f14@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230531-rpm-rproc-v1-8-e0a3b6de1f14@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.06.2023 09:08, Stephan Gerhold wrote:
> Avoid having to look up a dummy item from SMEM to detect if it is
> already available or if we need to defer probing.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  drivers/soc/qcom/smem.c       | 9 +++++++++
>  include/linux/soc/qcom/smem.h | 1 +
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> index b0d59e815c3b..3d93a6681494 100644
> --- a/drivers/soc/qcom/smem.c
> +++ b/drivers/soc/qcom/smem.c
> @@ -359,6 +359,15 @@ static struct qcom_smem *__smem;
>  /* Timeout (ms) for the trylock of remote spinlocks */
>  #define HWSPINLOCK_TIMEOUT	1000
>  
> +/**
> + * qcom_smem_is_available() - Checks if SMEM is available
> + */
Shouldn't kerneldoc explicitly say "returns x if y else z"?

Modulo that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> +bool qcom_smem_is_available(void)
> +{
> +	return !!__smem;
> +}
> +EXPORT_SYMBOL(qcom_smem_is_available);
> +
>  static int qcom_smem_alloc_private(struct qcom_smem *smem,
>  				   struct smem_partition *part,
>  				   unsigned item,
> diff --git a/include/linux/soc/qcom/smem.h b/include/linux/soc/qcom/smem.h
> index 223db6a9c733..a36a3b9d4929 100644
> --- a/include/linux/soc/qcom/smem.h
> +++ b/include/linux/soc/qcom/smem.h
> @@ -4,6 +4,7 @@
>  
>  #define QCOM_SMEM_HOST_ANY -1
>  
> +bool qcom_smem_is_available(void);
>  int qcom_smem_alloc(unsigned host, unsigned item, size_t size);
>  void *qcom_smem_get(unsigned host, unsigned item, size_t *size);
>  
> 
