Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4053F600F45
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 14:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiJQMfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 08:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiJQMfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:35:01 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8EC23E8C;
        Mon, 17 Oct 2022 05:34:51 -0700 (PDT)
Received: from p508fc122.dip0.t-ipconnect.de ([80.143.193.34] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1okPKO-00087p-5E; Mon, 17 Oct 2022 14:34:44 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Jensen Huang <jensenhuang@friendlyarm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: add enable-strobe-pulldown to emmc phy on nanopi4
Date:   Mon, 17 Oct 2022 14:34:38 +0200
Message-Id: <166601006786.173248.18425643235756984622.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220928091129.20597-1-jensenhuang@friendlyarm.com>
References: <20220928091129.20597-1-jensenhuang@friendlyarm.com>
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

On Wed, 28 Sep 2022 17:11:29 +0800, Jensen Huang wrote:
> Internal pull-down for strobe line (GRF_EMMCPHY_CON2[9]) was disabled
> by commit 8b5c2b45b8f0, which causes I/O error in HS400 mode.
> 
> Tested on NanoPC-T4.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: add enable-strobe-pulldown to emmc phy on nanopi4
      commit: 463be3cb357dab7d7e4d8dcc7c15c642e10c5bef

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
