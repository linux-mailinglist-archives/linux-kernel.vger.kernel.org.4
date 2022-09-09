Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22185B42ED
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 01:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbiIIXMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 19:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbiIIXMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 19:12:33 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CFB36DC8;
        Fri,  9 Sep 2022 16:11:56 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oWn9K-0000Qa-JY; Sat, 10 Sep 2022 01:11:02 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Judy Hsiao <judyhsiao@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        devicetree@vger.kernel.org,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Lin Huang <hl@rock-chips.com>,
        Jaroslav Kysela <perex@perex.cz>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1] arm64: dts: rk3399: i2s: switch BCLK to GPIO
Date:   Sat, 10 Sep 2022 01:10:57 +0200
Message-Id: <166276502654.27767.11970180490311201106.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220708080726.4170711-1-judyhsiao@chromium.org>
References: <20220708080726.4170711-1-judyhsiao@chromium.org>
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

On Fri, 8 Jul 2022 08:07:26 +0000, Judy Hsiao wrote:
> We discoverd that the state of BCLK on, LRCLK off and SD_MODE on
> may cause the speaker melting issue. Removing LRCLK while BCLK
> is present can cause unexpected output behavior including a large
> DC output voltage as described in the Max98357a datasheet.
> 
> In order to:
>   1. prevent BCLK from turning on by other component.
>   2. keep BCLK and LRCLK being present at the same time
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rk3399: i2s: switch BCLK to GPIO
      commit: 91419ae0420f0c91a326655d687b740826d0a3f9

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
