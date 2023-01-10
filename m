Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC73B664CD3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbjAJTy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjAJTyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 14:54:02 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E595EC08;
        Tue, 10 Jan 2023 11:53:58 -0800 (PST)
Received: from obbardc-t14.home (unknown [IPv6:2a00:23c7:6883:e501:329c:8425:8e97:eae9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: obbardc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 250706602D29;
        Tue, 10 Jan 2023 19:53:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673380437;
        bh=j/8Gif3NnDbiDrt0IFW2ZyV2q1c+kw+yFb4xTvuG194=;
        h=From:To:Cc:Subject:Date:From;
        b=C2pXox6xy7EDSWKcsa2rvfegQuz10jK4VhBnKq40ddvVazOxgAz052o5npeEwcU4j
         eTnbxQKmMbQjM96kSH8CFx6gKYOGMcom2l9GncOiEFbLSxLfQH/sfTjm/l4vK+UqqQ
         dDVscXbTaWr+B63Ehc9u5Bo/Lp1Lh49DjUJumseJT5HmBe/vMteouC4q0LikRmNHOK
         /j5EvBAg7Wan2UZjrlUr1TpZdkDK8fZIfMOua73zb+CgEpEF4C/5OvoPgs2breb0xE
         TQxCl1aD6wtWaWnbkoR7IAj3Rm/rC0NXji40Zr+hvrCrhuMXtyUmreVmoh46oGsyZ4
         f5RPyfKCF1c0Q==
From:   Christopher Obbard <chris.obbard@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Christopher Obbard <chris.obbard@collabora.com>
Subject: [PATCH v2 0/3] Update eMMC alias for Radxa ROCK 5 Model A and Model B DTS
Date:   Tue, 10 Jan 2023 19:53:49 +0000
Message-Id: <20230110195352.272360-1-chris.obbard@collabora.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MMC aliases for the Radxa ROCK 5 Model A and Model B do not match the other
Rockchip devices: mmc0 is usually the eMMC. In the initial devicetree series,
I incorrectly set the alias for the eMMC to mmc1 to match the vendor kernel.

Update the alias for the eMMC to mmc0 to better match other Rockchip devices.

While we are here, remove an empty line to keep good style across the tree.

Changes in v2:
- Use correctly line length for commit messages

v1: https://lore.kernel.org/linux-rockchip/20230110155252.189300-1-chris.obbard@collabora.com/

Christopher Obbard (3):
  arm64: dts: rockchip: Update sdhci alias for rock-5a
  arm64: dts: rockchip: Remove empty line from rock-5a
  arm64: dts: rockchip: Update sdhci alias for rock-5b

 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts  | 2 +-
 arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

--
2.39.0

