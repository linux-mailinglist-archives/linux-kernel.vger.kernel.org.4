Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130277212C8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 22:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjFCUuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 16:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjFCUuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 16:50:12 -0400
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA0D196
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 13:50:11 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id 3a507e03-0250-11ee-b3cf-005056bd6ce9;
        Sat, 03 Jun 2023 23:50:09 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sat, 3 Jun 2023 23:50:09 +0300
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     jic23@kernel.org, lars@metafoo.de, heiko@sntech.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sebastian.reichel@collabora.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        gustavo.padovan@collabora.com, kernel@collabora.com,
        serge.broslavsky@collabora.com
Subject: Re: [PATCH v3 0/8] RK3588 ADC support
Message-ID: <ZHungQT5an39pjEg@surfacebook>
References: <20230603185340.13838-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230603185340.13838-1-shreeya.patel@collabora.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sun, Jun 04, 2023 at 12:23:32AM +0530, Shreeya Patel kirjoitti:
> This patch series adds ADC support for RK3588 and updates
> the DT bindings for the same.
> 
> To test ADC support on Rock 5B board, a voltage divider circuit
> was created using the gpio pin 22 ( SARADC_IN4 ) and few more
> tests were ran for testing the buffer and trigger support using
> the iio_generic_buffer tool.

Well done!

For patches 1-6
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
(with one nit-pick to be addressed)

> Changes in v3
>   - Add bitfield.h header file in patch 2.
>   - Add a Reviewed-by tag in patch 2.
>   - Do not remove clock enabling and disabling from the suspend and
>     resume functions respectively in patch 3
> 
> Changes in v2
>   - Add from address in patches 1 and 2.
>   - Create separate patches for adding new device support and changes to
>     the old device code.
>   - Make use of FIELD_PREP in patch 2.
>   - Move the enablement of clocks at it's original position in patch 3
>   - Add Reviewed-by tag in patches 4 and 5.
>   - Add an Acked-by tag in patch 8.
> 
> Shreeya Patel (8):
>   iio: adc: rockchip_saradc: Add callback functions
>   iio: adc: rockchip_saradc: Add support for RK3588
>   iio: adc: rockchip_saradc: Make use of devm_clk_get_enabled
>   iio: adc: rockchip_saradc: Use of_device_get_match_data
>   iio: adc: rockchip_saradc: Match alignment with open parenthesis
>   iio: adc: rockchip_saradc: Use dev_err_probe
>   arm64: dts: rockchip: Add DT node for ADC support in RK3588
>   dt-bindings: iio: adc: Add rockchip,rk3588-saradc string
> 
>  .../bindings/iio/adc/rockchip-saradc.yaml     |   1 +
>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi     |  12 +
>  drivers/iio/adc/rockchip_saradc.c             | 246 +++++++++++-------
>  3 files changed, 168 insertions(+), 91 deletions(-)
> 
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


