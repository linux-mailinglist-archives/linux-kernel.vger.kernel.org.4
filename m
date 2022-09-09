Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F7E5B42F6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 01:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbiIIXNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 19:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiIIXMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 19:12:40 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817DF3685A;
        Fri,  9 Sep 2022 16:11:59 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oWn9I-0000Qa-MC; Sat, 10 Sep 2022 01:11:00 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Chukun Pan <amadeus@jmu.edu.cn>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCH] arm64: dts: rockchip: Enable PCIe controller on rock3a
Date:   Sat, 10 Sep 2022 01:10:53 +0200
Message-Id: <166276502653.27767.14125907816107541176.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220726023516.6487-1-amadeus@jmu.edu.cn>
References: <20220726023516.6487-1-amadeus@jmu.edu.cn>
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

On Tue, 26 Jul 2022 10:35:16 +0800, Chukun Pan wrote:
> Add the nodes to enable the PCIe controller on the
> Radxa ROCK3 Model A board. Run test with the MT7921
> pcie wireless card.

Applied, thanks!

[1/1] arm64: dts: rockchip: Enable PCIe controller on rock3a
      commit: 0fbbfb0b00d17ae6b6c4f04e325203de9e37837a

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
