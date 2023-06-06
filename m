Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9FC72503B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 00:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240063AbjFFWwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 18:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238285AbjFFWwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 18:52:32 -0400
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A012188
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 15:52:31 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id cebfce1e-04bc-11ee-b3cf-005056bd6ce9;
        Wed, 07 Jun 2023 01:52:27 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Wed, 7 Jun 2023 01:52:26 +0300
To:     George Stark <gnstark@sberdevices.ru>
Cc:     jic23@kernel.org, lars@metafoo.de, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com,
        andriy.shevchenko@linux.intel.com, nuno.sa@analog.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kernel@sberdevices.ru
Subject: Re: [PATCH v3] meson saradc: fix clock divider mask length
Message-ID: <ZH-4qsNcLGiQFiSE@surfacebook>
References: <20230606165357.42417-1-gnstark@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606165357.42417-1-gnstark@sberdevices.ru>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Jun 06, 2023 at 07:53:57PM +0300, George Stark kirjoitti:
> According to datasheets of supported meson SOCs length of ADC_CLK_DIV

the datasheets

> field is 6 bits long. Although all supported SOCs have the register

6-bit

> with that field documented later SOCs use external clock rather than
> ADC internal clock so this patch affects only meson8 family (S8* SOCs)

s/SOC/SoC/g, and mind the grammar period at the end.

I believe Jonathan can fix when applying this, no need to resend unless
he asks for it.

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: 3adbf3427330 ("iio: adc: add a driver for the SAR ADC found in Amlogic Meson SoCs")
> Signed-off-by: George Stark <GNStark@sberdevices.ru>
> ---
> Changelog:
> 
> v1 -> v2:
>     * Update commit message
> v2 -> v3:
>     * Update commit message
> ---
>  drivers/iio/adc/meson_saradc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 85b6826cc10c..b93ff42b8c19 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -72,7 +72,7 @@
>  	#define MESON_SAR_ADC_REG3_PANEL_DETECT_COUNT_MASK	GENMASK(20, 18)
>  	#define MESON_SAR_ADC_REG3_PANEL_DETECT_FILTER_TB_MASK	GENMASK(17, 16)
>  	#define MESON_SAR_ADC_REG3_ADC_CLK_DIV_SHIFT		10
> -	#define MESON_SAR_ADC_REG3_ADC_CLK_DIV_WIDTH		5
> +	#define MESON_SAR_ADC_REG3_ADC_CLK_DIV_WIDTH		6
>  	#define MESON_SAR_ADC_REG3_BLOCK_DLY_SEL_MASK		GENMASK(9, 8)
>  	#define MESON_SAR_ADC_REG3_BLOCK_DLY_MASK		GENMASK(7, 0)
>  
> -- 
> 2.38.4
> 

-- 
With Best Regards,
Andy Shevchenko


