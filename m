Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FF974BDFB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 17:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjGHPBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 11:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGHPBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 11:01:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29A1E4D;
        Sat,  8 Jul 2023 08:01:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EE8A60C96;
        Sat,  8 Jul 2023 15:01:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F163CC433C8;
        Sat,  8 Jul 2023 15:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688828460;
        bh=CPC1Hr5I3g2dfiiYjDfqMogcGRMrPymEWhhX2UxiwvQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rgwQ3N7G3oqWyI5ilvQJ0AC8Eq7ZGEAjs9vjz/sE7U1/khXrszcZmt/keHv2yOSVs
         nfnYJj1PctBeTOOjR0OB4XDLrTAujdfPVSD1y52Pdno8zDASuv91/6o14auRZGKeNJ
         NTJfnSs8yMkNa6LFSAIr3ZBdJkKiI86c/RCaxLxYReX3RQzpG4ZYDqopO9uO6yZkaa
         CivH8z4PMRx8JpPvi+utsTRNIYz1wJI+dC2b0P0Lj1fEr0OZ8P2r3tx0Ms6B65QXYL
         X9BkwAbm3ESnJ8P6SNec1rVchCZkbyXJaVxtuyWB4xPIG8jy6+qOxBc5bH/JUtovr/
         iEUNUMjK65ibw==
Date:   Sat, 8 Jul 2023 16:00:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jishnu Prakash <quic_jprakash@quicinc.com>
Cc:     <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linus.walleij@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <sboyd@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_subbaram@quicinc.com>,
        <quic_collinsd@quicinc.com>, <quic_kamalw@quicinc.com>,
        <quic_jestar@quicinc.com>, <marijn.suijten@somainline.org>,
        <andriy.shevchenko@linux.intel.com>,
        <krzysztof.kozlowski@linaro.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>
Subject: Re: [PATCH 05/11] iio: adc: qcom-spmi-adc5: remove support for ADC7
 compatible string
Message-ID: <20230708160048.5a5ad01a@jic23-huawei>
In-Reply-To: <20230708072835.3035398-6-quic_jprakash@quicinc.com>
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
        <20230708072835.3035398-6-quic_jprakash@quicinc.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jul 2023 12:58:29 +0530
Jishnu Prakash <quic_jprakash@quicinc.com> wrote:

> Now that usage of "ADC7" name has been replaced with usage of "ADC5
> Gen2" name everywhere, remove the "qcom,spmi-adc7" compatible string.
> 
> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>

Nope.  Unless all your dts files are distributed with the kernel, dropping
this breaks anyone who upgrades the kernel against an older firmware...

So even after the rename, you need to keep the deprecated naming around for
the binding side of things.

Jonathan

> ---
>  drivers/iio/adc/qcom-spmi-adc5.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> index 3ac1ee500a67..6cebeaa69a75 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> @@ -807,10 +807,6 @@ static const struct of_device_id adc5_match_table[] = {
>  		.compatible = "qcom,spmi-adc5",
>  		.data = &adc5_data_pmic,
>  	},
> -	{
> -		.compatible = "qcom,spmi-adc7",
> -		.data = &adc5_gen2_data_pmic,
> -	},
>  	{
>  		.compatible = "qcom,spmi-adc5-gen2",
>  		.data = &adc5_gen2_data_pmic,

