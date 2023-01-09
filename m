Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70A3662E4D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237400AbjAISKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237411AbjAISJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:09:39 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A158F5F43
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 10:09:02 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id j17so14273758lfr.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 10:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EyRfyaZH1M6G0kKiVcGLUZdinkm1+ObPe8W3gbDZzJ0=;
        b=u36X+8K1/GxKB/jjdjUwyPpwU0pc1hDSybOxB8FH7XK8E8rRRDlUwF6+VvPUAyAwuz
         5Du6zCeddixaRIkc1aFKSCGgU94DHcWrWRojebe0DA4uc1dxjgehWPw/6iFJsIY6yCuw
         1i1OaWQ5NxlDYdMDhNwHgopUvF/FFQy/Bk3CdZzUBd/28Y8HkXUYJ+wMobEr5BWloOvf
         jEOW20xLhzcXw89IlaQNQFhsuba6Eji8qZ2Lz/nZXMTfRdIF9KMohbacWbnbsKsjjNEJ
         EkkCuBSevKz0tybiH6CxNa6k0VaiEEk8JlcVZ9fP/ljZ8bsTcpmH6xSMfxrSS7osaBiA
         OTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EyRfyaZH1M6G0kKiVcGLUZdinkm1+ObPe8W3gbDZzJ0=;
        b=hlJgUXEKuIQTp4DwTigdvzBtcgUkTTR0fFM6lu1X5ubH0DPSUTBCSsuAyukaz2sfBT
         waFDsgsMWqOxjGnjqlucy7JfK3+JizFUNf6wX8j+9SPorKqMh3ahxGIbCpmZJZNH/qow
         W1kN3nfpCsR+Apy/csvyqzciGzF4qX24JTN3pIeryph7wBryq8qTKrhfQ7XW08B3HyQA
         BUkixy5Am6mHE713QIddmW/eCXfeYvnWSgRRbI5esqRce8DgPKgB2dlh9eAfpgB0y5Oo
         aJPCPyjr5k41itgWumozngrjOhUHcq/EG2XDgVx9eKLWjc87lOWyup6ktZvhbOOpEY7i
         g/sg==
X-Gm-Message-State: AFqh2kqjFE7psFBLi3uyU/IQusK/sp9eRNlRPT4PrfeAOaVEaiMX+qfu
        j4KUvKrfipl6LEHwXO1lZpA8Ag==
X-Google-Smtp-Source: AMrXdXsR6KMMPzrNFNF8KEs+1B/T+SBDN5kzRbuKPZzK7AAlK5CPdahZc7pGcVIZozm/jJ0S1vFXug==
X-Received: by 2002:a05:6512:3196:b0:4cc:7ff0:dd64 with SMTP id i22-20020a056512319600b004cc7ff0dd64mr2587059lfe.21.1673287740971;
        Mon, 09 Jan 2023 10:09:00 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id bi26-20020a0565120e9a00b004cc8620281csm367675lfb.62.2023.01.09.10.08.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 10:08:59 -0800 (PST)
Message-ID: <7159fb0f-8dbc-c986-ac27-643070a4ab53@linaro.org>
Date:   Mon, 9 Jan 2023 19:08:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 14/18] soc: qcom: rmphpd: add power domains for sa8775p
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-gpio@vger.kernel.org,
        netdev@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230109174511.1740856-1-brgl@bgdev.pl>
 <20230109174511.1740856-15-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230109174511.1740856-15-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
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



On 9.01.2023 18:45, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add power domain description for sa8775p and a new compatible to match it.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/soc/qcom/rpmhpd.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
> index 4c2d2c296790..f20e2a49a669 100644
> --- a/drivers/soc/qcom/rpmhpd.c
> +++ b/drivers/soc/qcom/rpmhpd.c
> @@ -187,6 +187,16 @@ static struct rpmhpd nsp = {
>  	.res_name = "nsp.lvl",
>  };
>  
> +static struct rpmhpd nsp0 = {
> +	.pd = { .name = "nsp0", },
> +	.res_name = "nsp0.lvl",
> +};
> +
> +static struct rpmhpd nsp1 = {
> +	.pd = { .name = "nsp1", },
> +	.res_name = "nsp1.lvl",
> +};
> +
>  static struct rpmhpd qphy = {
>  	.pd = { .name = "qphy", },
>  	.res_name = "qphy.lvl",
> @@ -212,6 +222,29 @@ static const struct rpmhpd_desc sa8540p_desc = {
>  	.num_pds = ARRAY_SIZE(sa8540p_rpmhpds),
>  };
>  
> +/* SA8775P RPMH power domains */
> +static struct rpmhpd *sa8775p_rpmhpds[] = {
> +	[SA8775P_CX] = &cx,
> +	[SA8775P_CX_AO] = &cx_ao,
> +	[SA8775P_EBI] = &ebi,
> +	[SA8775P_GFX] = &gfx,
> +	[SA8775P_LCX] = &lcx,
> +	[SA8775P_LMX] = &lmx,
> +	[SA8775P_MMCX] = &mmcx,
> +	[SA8775P_MMCX_AO] = &mmcx_ao,
> +	[SA8775P_MXC] = &mxc,
> +	[SA8775P_MXC_AO] = &mxc_ao,
> +	[SA8775P_MX] = &mx,
> +	[SA8775P_MX_AO] = &mx_ao,
> +	[SA8775P_NSP0] = &nsp0,
> +	[SA8775P_NSP1] = &nsp1,
> +};
> +
> +static const struct rpmhpd_desc sa8775p_desc = {
> +	.rpmhpds = sa8775p_rpmhpds,
> +	.num_pds = ARRAY_SIZE(sa8775p_rpmhpds),
> +};
> +
>  /* SDM670 RPMH powerdomains */
>  static struct rpmhpd *sdm670_rpmhpds[] = {
>  	[SDM670_CX] = &cx_w_mx_parent,
> @@ -487,6 +520,7 @@ static const struct rpmhpd_desc sc8280xp_desc = {
>  static const struct of_device_id rpmhpd_match_table[] = {
>  	{ .compatible = "qcom,qdu1000-rpmhpd", .data = &qdu1000_desc },
>  	{ .compatible = "qcom,sa8540p-rpmhpd", .data = &sa8540p_desc },
> +	{ .compatible = "qcom,sa8775p-rpmhpd", .data = &sa8775p_desc },
>  	{ .compatible = "qcom,sc7180-rpmhpd", .data = &sc7180_desc },
>  	{ .compatible = "qcom,sc7280-rpmhpd", .data = &sc7280_desc },
>  	{ .compatible = "qcom,sc8180x-rpmhpd", .data = &sc8180x_desc },
