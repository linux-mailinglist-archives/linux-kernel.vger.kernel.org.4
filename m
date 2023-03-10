Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEE86B5228
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjCJUsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjCJUsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:48:33 -0500
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2827760413
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 12:48:27 -0800 (PST)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 5363C200FA;
        Fri, 10 Mar 2023 21:48:13 +0100 (CET)
Date:   Fri, 10 Mar 2023 21:48:11 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: reset: qcom-pon: drop of_match_ptr for ID table
Message-ID: <20230310204811.sjfl3lzlmijzeatf@SoMainline.org>
References: <20230310200652.19926-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310200652.19926-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-10 21:06:52, Krzysztof Kozlowski wrote:
> The Qualcomm SoC power-on driver is specific to ARCH_QCOM which depends
> on OF thus the driver is OF-only.  It's of_device_id table is built

Its*

> unconditionally, thus of_match_ptr() for ID table does not make sense.

Agreed.  Searching for of_match_ptr on any *qcom* file yields 25 results
on a few-weeks-old tree, are you planning on assessing those too?

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

> ---
>  drivers/power/reset/qcom-pon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
> index 16bc01738be9..ebdcfb28c4a0 100644
> --- a/drivers/power/reset/qcom-pon.c
> +++ b/drivers/power/reset/qcom-pon.c
> @@ -91,7 +91,7 @@ static struct platform_driver pm8916_pon_driver = {
>  	.probe = pm8916_pon_probe,
>  	.driver = {
>  		.name = "pm8916-pon",
> -		.of_match_table = of_match_ptr(pm8916_pon_id_table),
> +		.of_match_table = pm8916_pon_id_table,
>  	},
>  };
>  module_platform_driver(pm8916_pon_driver);
> -- 
> 2.34.1
> 
