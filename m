Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BDC713A8E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 18:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjE1QaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 12:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjE1Q36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 12:29:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7888FA7;
        Sun, 28 May 2023 09:29:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 161C960BA0;
        Sun, 28 May 2023 16:29:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB045C433D2;
        Sun, 28 May 2023 16:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685291396;
        bh=ei8N2Em3Nr2Uv8xvmQo82ZVNT14+4f7srT0ooNh+iQo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=afV34sY38FPwajLAlwDWQFBlyPOq+izpon2VPq1T29AhDO+jOomUpeqrMi8s3+RKE
         e/K4tWZ/MmpILm07QY2RGKmzRJUh+fGBOYqUDOkvn9sTaAhWyxkknHjo1AM4plzptd
         gHrd+7MOXgZj3h97saRXomXc28ftLrML7FJsWSC6jDMB+q+i0z6a+KTGje9zk+lN2H
         cXXjCMu5YEcDuo6Op0yGCHlbK9bv+BVjJ1A5l7R7q55WcK5A/6g6lF8MP9yB+tEW6r
         J2Uhn+oJfqMvMxrYEDvX92Krd9yjhZkIPDpATS9NFLZnUb44CNjxL5cer/cQ8UaZCr
         Ade9q6Ww7Nhaw==
Date:   Sun, 28 May 2023 17:46:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     lars@metafoo.de, heiko@sntech.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sebastian.reichel@collabora.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, gustavo.padovan@collabora.com,
        serge.broslavsky@collabora.com
Subject: Re: [PATCH v2 0/8] RK3588 ADC support
Message-ID: <20230528174614.4dc5cd01@jic23-huawei>
In-Reply-To: <20230525212712.255406-1-shreeya.patel@collabora.com>
References: <20230525212712.255406-1-shreeya.patel@collabora.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 May 2023 02:57:04 +0530
Shreeya Patel <shreeya.patel@collabora.com> wrote:

> This patch series adds ADC support for RK3588 and updates
> the DT bindings for the same.
> 
> To test ADC support on Rock 5B board, a voltage divider circuit
> was created using the gpio pin 22 ( SARADC_IN4 ) and few more
> tests were ran for testing the buffer and trigger support using
> the iio_generic_buffer tool.
> 
FWIW I don't have any additional comments on this beyond agreeing
those made by others need addressing.

Fingers crossed for v3.

Jonathan

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
>  drivers/iio/adc/rockchip_saradc.c             | 262 +++++++++++-------
>  3 files changed, 168 insertions(+), 107 deletions(-)
> 

