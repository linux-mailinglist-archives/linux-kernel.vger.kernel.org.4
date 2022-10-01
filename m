Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAD85F1AB3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 09:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiJAHu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 03:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJAHuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 03:50:54 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1D21710ED
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 00:50:51 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id l12so6947569ljg.9
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 00:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=VMZaaIX0zHCfcZ+ypQh+ZHlacF5EMmYtRVGM7uRfTPg=;
        b=B57PxXHHGPSXRXwPGbP3RYONxeFzy51i9QvJ+ewMRyNoonwrz0ImmuBSxJcJ6mcutV
         2NrOWGHOW3HrY2pWZSwy8dq7+CQCeVTHT2GuD1D2qiBQw6I7vztgvvtLA9/N6ii/Dbhl
         0eEh49GZZetIozu1hK+Ij+e2ZwadFdGMuTGIGXmEcEzcUWfC2K15lGyUayljRQtSgvjn
         WLFp2IYCvKYwwKAER3LUNH9lwbC04GHZvKPldWUQJV3iR5CweamnHpItgMSjD863Tqyv
         hutR1Z4Gqni5nYVXu9qD1nYdoWAX9FA36CdPIzW0Sm04NQ/bQlzn+v+oyJyTYv2XlA+F
         QCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=VMZaaIX0zHCfcZ+ypQh+ZHlacF5EMmYtRVGM7uRfTPg=;
        b=4flgBVk2EtGzv585CfZdJ0Z7qBEx6Q2GMarfn+FP5dHcMp3cE53AKOpwuS+2pDAnuM
         NO83VU84WA79P1viotoe9C6d7koMdqW6EN9GBWCx5SmuXvC+fi/ZFvzjWi7Gp9uC1IHn
         8f0/W33047eI7vTaTgnpnihEW6biDJt+rtgASeCnlQXzGVtuF38Gr1sQriArP3Hb7IsP
         nqPfOhAiyy26pRa1hcZRNdVgh8sN+pwPQvkRIsSSk+S/knvJ9BgnzcYyPgG/PGHocaGa
         mNCF6M5uo2PaKD5kjnXGHuJptX96P1bzFpES0dUeTDp8ZPjDgn/FwHCoKR/ffp85aFTc
         pWkA==
X-Gm-Message-State: ACrzQf0YehQmBI9dqA15xpuq7KhlO5ioJdpdFH7cV1uzA/vYZCgRRp/1
        EVNz7mnTbBQ0Feqpx97du8p82Q==
X-Google-Smtp-Source: AMsMyM4wtoqAFmxUM7lkcgxfel1WlXF3a6aI2+3+0rRZsLef6RusyNxg0Vo3P4Z7TvouLiVyFBsquw==
X-Received: by 2002:a05:651c:17a1:b0:26c:87c:c104 with SMTP id bn33-20020a05651c17a100b0026c087cc104mr3644833ljb.419.1664610650050;
        Sat, 01 Oct 2022 00:50:50 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id j15-20020a056512108f00b00499d70c0310sm671179lfg.3.2022.10.01.00.50.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 00:50:49 -0700 (PDT)
Message-ID: <ce605e35-d360-0c69-015a-3c8bf113e056@linaro.org>
Date:   Sat, 1 Oct 2022 10:50:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 4/5] soc: qcom: rpmhpd: Add QDU1000/QRU1000 power domains
Content-Language: en-GB
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221001030641.29354-1-quic_molvera@quicinc.com>
 <20221001030641.29354-5-quic_molvera@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221001030641.29354-5-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/2022 06:06, Melody Olvera wrote:
> Add the power domains exposed by RPMH in the Qualcomm QDU1000
> and QRU1000 platforms.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/soc/qcom/rpmhpd.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
> index 092f6ab09acf..f70573cbc636 100644
> --- a/drivers/soc/qcom/rpmhpd.c
> +++ b/drivers/soc/qcom/rpmhpd.c
> @@ -353,6 +353,19 @@ static const struct rpmhpd_desc sm8450_desc = {
>   	.num_pds = ARRAY_SIZE(sm8450_rpmhpds),
>   };
>   
> +/* QDU1000/QRU1000 RPMH powerdomains */
> +static struct rpmhpd *qdru1000_rpmhpds[] = {
> +	[QDRU1000_CX] = &cx,
> +	[QDRU1000_EBI] = &ebi,
> +	[QDRU1000_MSS] = &mss,
> +	[QDRU1000_MX] = &mx,
> +};
> +
> +static const struct rpmhpd_desc qdru1000_desc = {
> +	.rpmhpds = qdru1000_rpmhpds,
> +	.num_pds = ARRAY_SIZE(qdru1000_rpmhpds),
> +};
> +
>   /* SC7180 RPMH powerdomains */
>   static struct rpmhpd *sc7180_rpmhpds[] = {
>   	[SC7180_CX] = &cx_w_mx_parent,

-- 
With best wishes
Dmitry

