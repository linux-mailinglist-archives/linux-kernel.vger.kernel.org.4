Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE3C6A1411
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 01:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjBXAEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 19:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjBXAEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 19:04:11 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253E914EBF;
        Thu, 23 Feb 2023 16:04:10 -0800 (PST)
Received: from hatter.bewilderbeest.net (174-21-161-58.tukw.qwest.net [174.21.161.58])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 8F497C65;
        Thu, 23 Feb 2023 16:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1677197049;
        bh=pKBChxXzNwGh/3cjrvLJnt/ncE9syYmhKRb2R7p9QNU=;
        h=From:To:Cc:Subject:Date:From;
        b=b/49qnEupu6A4Xo8R0iH637+1BJ6G0a7AhT64cmcU7J8kEKVhgN+cP7NXNAOe+qZY
         eVFzZVgwL3hZEfGBDq5Gdn/2OGnnvXoMLqX5IWwG0Z1MzjFNgo8UfPsxqfEKCC9QdP
         7daqayiDIyfhL+nEeIS9o3b/qioA4ztPvwvdhHI4=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>
Cc:     Zev Weiss <zev@bewilderbeest.net>, openbmc@lists.ozlabs.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] ARM: dts: aspeed: ASRock BMC updates
Date:   Thu, 23 Feb 2023 16:03:57 -0800
Message-Id: <20230224000400.12226-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.39.2
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

Hello,

This patch series contains a few small device-tree updates for ASRock
BMCs: an LED polarity fix for romed8hm3, enabling the ast2500 PECI
device on e3c246d4i, and a SPI flash clock frequency fix for both.

Thanks,
Zev

Changes since v1 [0]:
 - Added patch 3 correcting SPI flash clocks

[0] https://lore.kernel.org/linux-devicetree/20230203105405.21942-1-zev@bewilderbeest.net/

Zev Weiss (3):
  ARM: dts: aspeed: romed8hm3: Fix GPIO polarity of system-fault LED
  ARM: dts: aspeed: e3c246d4i: Add PECI device
  ARM: dts: aspeed: asrock: Correct firmware flash SPI clocks

 arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts | 6 +++++-
 arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts | 4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)

-- 
2.39.1.438.gdcb075ea9396.dirty

