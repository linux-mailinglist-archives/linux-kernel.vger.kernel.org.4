Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738CE71F4F6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjFAVm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 17:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbjFAVmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:42:54 -0400
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A1BD1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 14:42:53 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 41dcce44-00c5-11ee-abf4-005056bdd08f;
        Fri, 02 Jun 2023 00:42:51 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Fri, 2 Jun 2023 00:42:50 +0300
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/8] pinctrl: qcom: qdf2xxx: drop ACPI_PTR
Message-ID: <ZHkQ2j6axPYGq_Lg@surfacebook>
References: <20230601152026.1182648-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601152026.1182648-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Jun 01, 2023 at 05:20:19PM +0200, Krzysztof Kozlowski kirjoitti:
> Driver can bind only via ACPI matching and acpi_device_id is there
> unconditionally, so drop useless ACPI_PTR() macro.

With this acpi.h becomes unused and has to be replaced with (AFAICT)
property.h
mod_devicetable.h
(maybe others, but I haven't checked deeply)

With that,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-qdf2xxx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c b/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c
> index b0f1b3dc6831..b5808fcfb13c 100644
> --- a/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c
> +++ b/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c
> @@ -142,7 +142,7 @@ MODULE_DEVICE_TABLE(acpi, qdf2xxx_acpi_ids);
>  static struct platform_driver qdf2xxx_pinctrl_driver = {
>  	.driver = {
>  		.name = "qdf2xxx-pinctrl",
> -		.acpi_match_table = ACPI_PTR(qdf2xxx_acpi_ids),
> +		.acpi_match_table = qdf2xxx_acpi_ids,
>  	},
>  	.probe = qdf2xxx_pinctrl_probe,
>  	.remove = msm_pinctrl_remove,
> -- 
> 2.34.1
> 

-- 
With Best Regards,
Andy Shevchenko


