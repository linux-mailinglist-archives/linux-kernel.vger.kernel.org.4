Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2916CD879
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjC2La6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjC2La4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:30:56 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6D040D9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:30:53 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id c29so19704398lfv.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680089451;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZbkStHhS8RicbgIIuIIrnClWQyhU0ssY7587G4EgzNw=;
        b=AezqGCBKF8JxwLe6ttFT/yFnOh4FBegYDojNt8VAclL2tZXfcP5EuORMusgm6F5p1U
         k6b8hqZWPiDnAT0h0AtwvdWXD3jrKt6ckoMP1Ho76vTn0j96UmjyE262J3GoQMUHYTcn
         REWSxM3kV4aocy28gjxwsvMxIGJffiMp3JmKhfgEZFAwm85IOpbFys8Af0RXC98TQ+YP
         MM9QFXxzLvogsuF2VLGva0zOlqbUJA4M09v5rQhf/asxYm1Mu+vWzH8OtyNfzaq+vyJX
         6HPzqBBQ2Vl/h7b2dYJJ8Zo/yTcrujJYgCss6d5aX3f5m1kX/A1hlVqsbjWCYeRCt4YU
         HkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680089451;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbkStHhS8RicbgIIuIIrnClWQyhU0ssY7587G4EgzNw=;
        b=BeRs2kUUMp/uTZX1ofrjdWqqsu8v916L81ihFR/zWUi/JEcWCBDPn3G25deT7o9fM8
         Tw8544CTckAej417qsv71OXDrmhMK4AelFZHht5T5iG5F0Z4FhPVm4ovNS/FBrP1L0dX
         nYChGNFtGN0n3hdqHG/XqL+VFdqEXGu4XA1NIsoN52YSfaC+m7uuRQRCcyvoZRg/awz6
         fVfVFwCwcYXQCIXJUvfNQjBxK1WlWZUiltlPm3lrgOr166sx7O4oD71HMH/PufTarRm2
         krzSr5c+6dcMJr732XPVSatY7sPp4NDvNzy1aSOnMNDahl8Z6EjaAbdXqLpqDHtIpReY
         IhEg==
X-Gm-Message-State: AAQBX9cs/q8eP1C72lyX5z4vORly3ReDsERsKx0nLw0FRVNLHzYZmjQF
        hv4oH6FHnMYOkgzUQYUuz3HSMw==
X-Google-Smtp-Source: AKy350ZV6sDKOCTXP7mZPDivoS4M7xj7kfUle01CK32kBixoCg2P75PVeoCzYNaj3NW9WtiXMPPxQw==
X-Received: by 2002:ac2:596f:0:b0:4eb:e03:9e6c with SMTP id h15-20020ac2596f000000b004eb0e039e6cmr599912lfp.33.1680089451646;
        Wed, 29 Mar 2023 04:30:51 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id u3-20020a056512040300b0048b365176d9sm5467581lfk.286.2023.03.29.04.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 04:30:51 -0700 (PDT)
Message-ID: <95b4bd56-b307-6c72-494f-e9b190df8d74@linaro.org>
Date:   Wed, 29 Mar 2023 13:30:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/7] clk: qcom: add the GPUCC driver for sa8775p
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230328193632.226095-1-brgl@bgdev.pl>
 <20230328193632.226095-3-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230328193632.226095-3-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.03.2023 21:36, Bartosz Golaszewski wrote:
> From: Shazad Hussain <quic_shazhuss@quicinc.com>
> 
> Add the clock driver for the Qualcomm Graphics Clock control module.
> 
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
> [Bartosz: make ready for upstream]
> Co-authored-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
[...]

> +/* Need to match the order of clocks in DT binding */
> +enum {
> +	DT_IFACE,
I think it's never used?

[...]

> +static int gpu_cc_sa8775p_probe(struct platform_device *pdev)
> +{
> +	struct regmap *regmap;
> +
> +	regmap = qcom_cc_map(pdev, &gpu_cc_sa8775p_desc);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	clk_lucid_evo_pll_configure(&gpu_cc_pll0, regmap, &gpu_cc_pll0_config);
> +	clk_lucid_evo_pll_configure(&gpu_cc_pll1, regmap, &gpu_cc_pll1_config);
> +
> +	/*
> +	 * Keep the clocks always-ON
> +	 * GPU_CC_CB_CLK
> +	 */
> +	regmap_update_bits(regmap, 0x93a4, BIT(0), BIT(0));
You set it as CRITICAL, this should be unnecessary now.

Konrad
> +
> +	return qcom_cc_really_probe(pdev, &gpu_cc_sa8775p_desc, regmap);
> +}
> +
> +static struct platform_driver gpu_cc_sa8775p_driver = {
> +	.probe = gpu_cc_sa8775p_probe,
> +	.driver = {
> +		.name = "gpu_cc-sa8775p",
> +		.of_match_table = gpu_cc_sa8775p_match_table,
> +	},
> +};
> +
> +static int __init gpu_cc_sa8775p_init(void)
> +{
> +	return platform_driver_register(&gpu_cc_sa8775p_driver);
> +}
> +subsys_initcall(gpu_cc_sa8775p_init);
> +
> +static void __exit gpu_cc_sa8775p_exit(void)
> +{
> +	platform_driver_unregister(&gpu_cc_sa8775p_driver);
> +}
> +module_exit(gpu_cc_sa8775p_exit);
> +
> +MODULE_DESCRIPTION("SA8775P GPUCC driver");
> +MODULE_LICENSE("GPL");
