Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790506642B6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbjAJOEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjAJOEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:04:46 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8118253711;
        Tue, 10 Jan 2023 06:04:43 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pFFF2-0004vx-Rs; Tue, 10 Jan 2023 15:04:40 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        dsx724 <da@lessconfused.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com,
        linux-arm-kernel@lists.infradead.org,
        Markus Reichl <m.reichl@fivetechno.de>,
        Da Xue <da.xue@libretech.co>,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: increase spi-max-frequency of nor flash for roc-rk3399-pc
Date:   Tue, 10 Jan 2023 15:04:32 +0100
Message-Id: <167335938210.2550251.16405982278682213924.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221124072714.450223-1-abbaraju.manojsai@amarulasolutions.com>
References: <20221123094827.250657-2-abbaraju.manojsai@amarulasolutions.com> <20221124072714.450223-1-abbaraju.manojsai@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Nov 2022 12:57:14 +0530, Manoj Sai wrote:
> Increase the spi-max-frequency of nor flash from 10Mhz to 30Mhz,this improves the
> flash raw write speed by 0.9 MB/s to 1.6MB/s and the time taken to write is
> get reduced from 36 seconds to 20 seconds.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: increase spi-max-frequency of nor flash for roc-rk3399-pc
      commit: 36861fd1fa05fb9b5d9654e6ad3d325a7671b1e1

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
