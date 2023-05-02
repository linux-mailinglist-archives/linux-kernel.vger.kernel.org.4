Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A5D6F3B3D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 02:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbjEBANi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 20:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbjEBANg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 20:13:36 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332063AAB
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 17:13:33 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f00d41df22so25225399e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 17:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682986411; x=1685578411;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w351tNiE3dJPJnhm67jSNg4416e7gcI4wPfoPQnGIBM=;
        b=FjED+5/q1krQaL7ap7zMAcG8eqL9N6Hm8bI5422Usjc3mbN0wB7ZzuN6eZKWrVXcMg
         tCuYVmWp3A5sXntB9Po6xBMfU1MikKvzrSsD0x7s5lA353H20wxEfmVnW+RZfhHB8iQI
         YkwQa0e420mARgm+03XQ3XXl/GLdydLXboNzLpIYtO6NN0KwmcQ8KYqYeewUZqwHgkj9
         1jHoQoIpWJLj6pOmJW/BkY9RvLoftiLo0P3TpVi5qTcdcqO1y4tK4nvwfTGHiHcv8pQl
         RVmHYez/ClyovQejhqtJFSaZTVbBorfEGrQdM7H0G1gJLJdKPcIt8LUxEMIN3Eb4GVwg
         ANyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682986411; x=1685578411;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w351tNiE3dJPJnhm67jSNg4416e7gcI4wPfoPQnGIBM=;
        b=ITBfiC+x/KETnv87fS/3WS/IhMLQHkU8GiWSLOh5O6Y9/wl454Socb3gt6x+mdcJwC
         mCMkJRcwOLaNnkFRwzPq6A7PxKZAR5k8hnb9+K39E1cCcp/HeRYZjLbOsWiJhJmSrGfq
         wEdW3CmHICs4SAdKQvb5OddV8ETil2iQ3XBW1nOv2zVWMMT9Miy0w2Vj71dEOWp3jTgr
         AdkM+Pb6ijfwRRtvszlBoBv+5c9KkL8rXNmo8/8gV8PSj0bqyaGIFA5hHW1vMtgTlvWT
         pQHx/js0RyaiAaKsrhnCV4ACGdGD1N9iIq/q0JH0fahZRvd6Wi4eeYEIQO4MkvdNKc8i
         1dYw==
X-Gm-Message-State: AC+VfDwjb299ly5f39rT2RekBG8PrwLOi5Qb1YfrmO+ATv9kq91prOV0
        FPdY3ZMSo58QAO8wEWeb2AQGVA==
X-Google-Smtp-Source: ACHHUZ4m2pOcnJ2XXpuOc9NrKE39dIhUO4j7GBeW/YIjThz8c7Mgq9JeOlJXny6WARYtgSZnLonlDw==
X-Received: by 2002:a05:6512:31d4:b0:4ed:b86b:9cc9 with SMTP id j20-20020a05651231d400b004edb86b9cc9mr4849394lfe.28.1682986411299;
        Mon, 01 May 2023 17:13:31 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id w15-20020ac2442f000000b004f09126b291sm1119870lfl.213.2023.05.01.17.13.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 17:13:30 -0700 (PDT)
Message-ID: <1be5930d-a389-7fa0-2886-4e9af09cbf85@linaro.org>
Date:   Tue, 2 May 2023 03:13:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v9 2/4] phy: qcom-qmp-usb: add support for updated qcm2290
 / sm6115 binding
Content-Language: en-GB
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, kishon@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
References: <20230501192432.1220727-1-bhupesh.sharma@linaro.org>
 <20230501192432.1220727-3-bhupesh.sharma@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230501192432.1220727-3-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05/2023 22:24, Bhupesh Sharma wrote:
> Add support for the new qcm2290 / sm6115 binding.
> 
> The USB QMP phy on these devices supports 2 lanes. Also note that the
> binding now does not describe every register subregion and instead
> the driver holds the corresponding offsets. This also includes
> the PCS_MISC region.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> index a49711c5a63d..aa143c081805 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> @@ -1414,6 +1414,10 @@ struct qmp_usb_offsets {
>   	u16 pcs_usb;
>   	u16 tx;
>   	u16 rx;
> +	/* for PHYs with >= 2 lanes */
> +	u16 tx2;
> +	u16 rx2;
> +	u16 pcs_misc;
>   };
>   
>   /* struct qmp_phy_cfg - per-PHY initialization config */
> @@ -1558,6 +1562,16 @@ static const char * const qmp_phy_vreg_l[] = {
>   	"vdda-phy", "vdda-pll",
>   };
>   
> +static const struct qmp_usb_offsets qmp_usb_offsets_v3 = {
> +	.serdes		= 0,
> +	.pcs		= 0xc00,
> +	.tx		= 0x200,
> +	.rx		= 0x400,
> +	.tx2		= 0x600,
> +	.rx2		= 0x800,
> +	.pcs_misc	= 0xa00,
> +};
> +
>   static const struct qmp_usb_offsets qmp_usb_offsets_v5 = {
>   	.serdes		= 0,
>   	.pcs		= 0x0200,
> @@ -1922,6 +1936,8 @@ static const struct qmp_phy_cfg sm8350_usb3_uniphy_cfg = {
>   static const struct qmp_phy_cfg qcm2290_usb3phy_cfg = {
>   	.lanes			= 2,
>   
> +	.offsets		= &qmp_usb_offsets_v3,
> +
>   	.serdes_tbl		= qcm2290_usb3_serdes_tbl,
>   	.serdes_tbl_num		= ARRAY_SIZE(qcm2290_usb3_serdes_tbl),
>   	.tx_tbl			= qcm2290_usb3_tx_tbl,
> @@ -2497,6 +2513,12 @@ static int qmp_usb_parse_dt(struct qmp_usb *qmp)
>   	qmp->tx = base + offs->tx;
>   	qmp->rx = base + offs->rx;
>   
> +	if (cfg->lanes >= 2) {
> +		qmp->tx2 = base + offs->tx2;
> +		qmp->rx2 = base + offs->rx2;
> +		qmp->pcs_misc = base + offs->pcs_misc;

pcs_misc should also be usable for a single-lane PHYs.

> +	}
> +
>   	qmp->pipe_clk = devm_clk_get(dev, "pipe");
>   	if (IS_ERR(qmp->pipe_clk)) {
>   		return dev_err_probe(dev, PTR_ERR(qmp->pipe_clk),

-- 
With best wishes
Dmitry

