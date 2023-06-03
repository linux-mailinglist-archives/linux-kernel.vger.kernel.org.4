Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A42D7212C5
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 22:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjFCUsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 16:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjFCUsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 16:48:04 -0400
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD7D197
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 13:48:03 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id ed5e4d7a-024f-11ee-b3cf-005056bd6ce9;
        Sat, 03 Jun 2023 23:48:01 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sat, 3 Jun 2023 23:48:00 +0300
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     jic23@kernel.org, lars@metafoo.de, heiko@sntech.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sebastian.reichel@collabora.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        gustavo.padovan@collabora.com, kernel@collabora.com,
        serge.broslavsky@collabora.com, Simon Xue <xxm@rock-chips.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v3 2/8] iio: adc: rockchip_saradc: Add support for RK3588
Message-ID: <ZHunAIbK7-tIvsm1@surfacebook>
References: <20230603185340.13838-1-shreeya.patel@collabora.com>
 <20230603185340.13838-3-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230603185340.13838-3-shreeya.patel@collabora.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sun, Jun 04, 2023 at 12:23:34AM +0530, Shreeya Patel kirjoitti:
> From: Simon Xue <xxm@rock-chips.com>
> 
> Add new start and read functions to support rk3588 device.
> Also, add a device compatible string for the same.

...

> +/* v2 registers */
> +#define SARADC2_CONV_CON		0x0
> +#define SARADC_T_PD_SOC			0x4
> +#define SARADC_T_DAS_SOC		0xc

Can you use fixed-width values for all registers?

	0x000
	0x004
	0x00c

> +#define SARADC2_END_INT_EN		0x104
> +#define SARADC2_ST_CON			0x108
> +#define SARADC2_STATUS			0x10c
> +#define SARADC2_END_INT_ST		0x110
> +#define SARADC2_DATA_BASE		0x120

-- 
With Best Regards,
Andy Shevchenko


