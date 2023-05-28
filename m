Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A3C714110
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 00:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjE1Wpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 18:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjE1Wpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 18:45:44 -0400
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58882B9
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 15:45:43 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 5f153cd5-fda9-11ed-abf4-005056bdd08f;
        Mon, 29 May 2023 01:45:40 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Mon, 29 May 2023 01:45:40 +0300
To:     Astrid Rost <astrid.rost@axis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: Re: [PATCH v4 4/7] iio: light: vcnl4000: add illuminance irq
 vcnl4040/4200
Message-ID: <ZHPZlA5LM5h4xmp3@surfacebook>
References: <20230522142621.1680563-1-astrid.rost@axis.com>
 <20230522142621.1680563-5-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522142621.1680563-5-astrid.rost@axis.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, May 22, 2023 at 04:26:18PM +0200, Astrid Rost kirjoitti:
> Add support to configure ambient light sensor interrupts and threshold
> limits for vcnl4040 and vcnl4200. If an interrupt is detected an event
> will be pushed to the event interface.

...

> +		case IIO_EV_DIR_RISING:
> +			ret = i2c_smbus_write_word_data(
> +				data->client, VCNL4040_ALS_THDH_LM, val);

Strange indentation.

> +			break;
> +		case IIO_EV_DIR_FALLING:
> +			ret = i2c_smbus_write_word_data(
> +				data->client, VCNL4040_ALS_THDL_LM, val);

Same.

> +			break;

...

> +	case IIO_PROXIMITY:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			ret = i2c_smbus_write_word_data(
> +				data->client, VCNL4040_PS_THDH_LM, val);

Same.

> +			break;
> +		case IIO_EV_DIR_FALLING:
> +			ret = i2c_smbus_write_word_data(
> +				data->client, VCNL4040_PS_THDL_LM, val);

Same.

> +			break;

-- 
With Best Regards,
Andy Shevchenko


