Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515897249D3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbjFFRHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236424AbjFFRHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:07:31 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55A810EB;
        Tue,  6 Jun 2023 10:07:30 -0700 (PDT)
Received: from [91.65.34.120] (helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1q6a9P-0001ED-U6; Tue, 06 Jun 2023 19:07:19 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     jic23@kernel.org, robh+dt@kernel.org,
        Shreeya Patel <shreeya.patel@collabora.com>,
        sebastian.reichel@collabora.com, lars@metafoo.de,
        krzysztof.kozlowski+dt@linaro.org
Cc:     Heiko Stuebner <heiko@sntech.de>, gustavo.padovan@collabora.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com, linux-iio@vger.kernel.org,
        serge.broslavsky@collabora.com, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/8] RK3588 ADC support
Date:   Tue,  6 Jun 2023 19:07:15 +0200
Message-Id: <168607097303.1436521.9380771933631987701.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230603185340.13838-1-shreeya.patel@collabora.com>
References: <20230603185340.13838-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jun 2023 00:23:32 +0530, Shreeya Patel wrote:
> This patch series adds ADC support for RK3588 and updates
> the DT bindings for the same.
> 
> To test ADC support on Rock 5B board, a voltage divider circuit
> was created using the gpio pin 22 ( SARADC_IN4 ) and few more
> tests were ran for testing the buffer and trigger support using
> the iio_generic_buffer tool.
> 
> [...]

Applied, thanks!

[7/8] arm64: dts: rockchip: Add DT node for ADC support in RK3588
      commit: ec084cbddbbe3a778ee06ccc0c59cee23b5cbaf4

I've moved the node to its correct position (by @address)
and also renamed the node to a more generic adc@...

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
