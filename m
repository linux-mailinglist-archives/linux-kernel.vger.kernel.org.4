Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACA2744CE2
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 11:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjGBJOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 05:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjGBJOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 05:14:21 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052091AC;
        Sun,  2 Jul 2023 02:14:21 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qv3FP6ld2z67pnp;
        Sun,  2 Jul 2023 17:11:05 +0800 (CST)
Received: from localhost (10.48.51.211) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 2 Jul
 2023 10:14:15 +0100
Date:   Sun, 2 Jul 2023 17:14:10 +0800
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     George Stark <gnstark@sberdevices.ru>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>,
        <andriy.shevchenko@linux.intel.com>, <nuno.sa@analog.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <kernel@sberdevices.ru>
Subject: Re: [PATCH v3 1/5] meson saradc: move enums declaration before
 variables declaration
Message-ID: <20230702171410.00007827@Huawei.com>
In-Reply-To: <20230627224017.1724097-2-gnstark@sberdevices.ru>
References: <20230627224017.1724097-1-gnstark@sberdevices.ru>
        <20230627224017.1724097-2-gnstark@sberdevices.ru>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.51.211]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2023 01:37:14 +0300
George Stark <gnstark@sberdevices.ru> wrote:

> Move enums declaration before variables declaration.
> 
This is fairly harmless, but would be nice to say 'why'.
Is this just for consistency with the rest of the driver or will
it be required after changes later in the patch set?

> Signed-off-by: George Stark <GNStark@sberdevices.ru>
> ---
>  drivers/iio/adc/meson_saradc.c | 44 +++++++++++++++++-----------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 18937a262af6..af38d95bd504 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -202,6 +202,28 @@
>  	.datasheet_name = "TEMP_SENSOR",				\
>  }
>  
> +enum meson_sar_adc_avg_mode {
> +	NO_AVERAGING = 0x0,
> +	MEAN_AVERAGING = 0x1,
> +	MEDIAN_AVERAGING = 0x2,
> +};
> +
> +enum meson_sar_adc_num_samples {
> +	ONE_SAMPLE = 0x0,
> +	TWO_SAMPLES = 0x1,
> +	FOUR_SAMPLES = 0x2,
> +	EIGHT_SAMPLES = 0x3,
> +};
> +
> +enum meson_sar_adc_chan7_mux_sel {
> +	CHAN7_MUX_VSS = 0x0,
> +	CHAN7_MUX_VDD_DIV4 = 0x1,
> +	CHAN7_MUX_VDD_DIV2 = 0x2,
> +	CHAN7_MUX_VDD_MUL3_DIV4 = 0x3,
> +	CHAN7_MUX_VDD = 0x4,
> +	CHAN7_MUX_CH7_INPUT = 0x7,
> +};
> +
>  static const struct iio_chan_spec meson_sar_adc_iio_channels[] = {
>  	MESON_SAR_ADC_CHAN(0),
>  	MESON_SAR_ADC_CHAN(1),
> @@ -227,28 +249,6 @@ static const struct iio_chan_spec meson_sar_adc_and_temp_iio_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(9),
>  };
>  
> -enum meson_sar_adc_avg_mode {
> -	NO_AVERAGING = 0x0,
> -	MEAN_AVERAGING = 0x1,
> -	MEDIAN_AVERAGING = 0x2,
> -};
> -
> -enum meson_sar_adc_num_samples {
> -	ONE_SAMPLE = 0x0,
> -	TWO_SAMPLES = 0x1,
> -	FOUR_SAMPLES = 0x2,
> -	EIGHT_SAMPLES = 0x3,
> -};
> -
> -enum meson_sar_adc_chan7_mux_sel {
> -	CHAN7_MUX_VSS = 0x0,
> -	CHAN7_MUX_VDD_DIV4 = 0x1,
> -	CHAN7_MUX_VDD_DIV2 = 0x2,
> -	CHAN7_MUX_VDD_MUL3_DIV4 = 0x3,
> -	CHAN7_MUX_VDD = 0x4,
> -	CHAN7_MUX_CH7_INPUT = 0x7,
> -};
> -
>  struct meson_sar_adc_param {
>  	bool					has_bl30_integration;
>  	unsigned long				clock_rate;

