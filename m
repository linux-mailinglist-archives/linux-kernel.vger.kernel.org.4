Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A1774D8C2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbjGJOQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbjGJOQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:16:30 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6E4100;
        Mon, 10 Jul 2023 07:16:26 -0700 (PDT)
Received: from i53875a50.versanet.de ([83.135.90.80] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qIrgd-0001RE-0V; Mon, 10 Jul 2023 16:16:23 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org,
        Christopher Obbard <chris.obbard@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        Conor Dooley <conor+dt@kernel.org>,
        Akash Gajjar <Akash_Gajjar@mentor.com>,
        Pragnesh Patel <Pragnesh_Patel@mentor.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
        FUKAUMI Naoki <naoki@radxa.com>, kernel@collabora.com,
        Stephen Chen <stephen@radxa.com>
Subject: Re: [PATCH v1 0/2] Disable HS400 for eMMC on Radxa ROCK 4 SBCs
Date:   Mon, 10 Jul 2023 16:16:15 +0200
Message-Id: <168899855922.1747213.6113714105963833215.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230705144255.115299-1-chris.obbard@collabora.com>
References: <20230705144255.115299-1-chris.obbard@collabora.com>
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

On Wed, 5 Jul 2023 15:42:53 +0100, Christopher Obbard wrote:
> There is some instablity with some eMMC modules on ROCK Pi 4 SBCs running
> in HS400 mode. This ends up resulting in some block errors after a while
> or after a "heavy" operation utilising the eMMC (e.g. resizing a
> filesystem). An example of these errors is as follows:
> 
>     [  289.171014] mmc1: running CQE recovery
>     [  290.048972] mmc1: running CQE recovery
>     [  290.054834] mmc1: running CQE recovery
>     [  290.060817] mmc1: running CQE recovery
>     [  290.061337] blk_update_request: I/O error, dev mmcblk1, sector 1411072 op 0x1:(WRITE) flags 0x800 phys_seg 36 prio class 0
>     [  290.061370] EXT4-fs warning (device mmcblk1p1): ext4_end_bio:348: I/O error 10 writing to inode 29547 starting block 176466)
>     [  290.061484] Buffer I/O error on device mmcblk1p1, logical block 172288
>     [  290.061531] Buffer I/O error on device mmcblk1p1, logical block 172289
>     [  290.061551] Buffer I/O error on device mmcblk1p1, logical block 172290
>     [  290.061574] Buffer I/O error on device mmcblk1p1, logical block 172291
>     [  290.061592] Buffer I/O error on device mmcblk1p1, logical block 172292
>     [  290.061615] Buffer I/O error on device mmcblk1p1, logical block 172293
>     [  290.061632] Buffer I/O error on device mmcblk1p1, logical block 172294
>     [  290.061654] Buffer I/O error on device mmcblk1p1, logical block 172295
>     [  290.061673] Buffer I/O error on device mmcblk1p1, logical block 172296
>     [  290.061695] Buffer I/O error on device mmcblk1p1, logical block 172297
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: rockchip: Disable HS400 for eMMC on ROCK Pi 4
      commit: cee572756aa2cb46e959e9797ad4b730b78a050b
[2/2] arm64: dts: rockchip: Disable HS400 for eMMC on ROCK 4C+
      commit: 2bd1d2dd808c60532283e9cf05110bf1bf2f9079

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
