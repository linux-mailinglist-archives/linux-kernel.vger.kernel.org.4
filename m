Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0707B5FC6E9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 16:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiJLOCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 10:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiJLOCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 10:02:00 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05FC5F7FC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 07:01:57 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:3da6:62e6:8ab0:ff90])
        by xavier.telenet-ops.be with bizsmtp
        id X21v2800432x5mf0121voM; Wed, 12 Oct 2022 16:01:55 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oicJ0-001OXt-NX; Wed, 12 Oct 2022 16:01:54 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oicIz-00C31k-W0; Wed, 12 Oct 2022 16:01:54 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] memory: renesas-rpc-if: Add support for R-Car Gen4
Date:   Wed, 12 Oct 2022 16:01:50 +0200
Message-Id: <cover.1665583089.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

This patch series adds support for the SPI Multi I/O Bus Controller
(RPC-IF) in R-Car Gen4 SoCs, which is very similar to the variant found
in R-Car Gen3 SoCs:
  - The first patch fixes a missed initialization issue, which is at
    least seen with the current firmware stack on R-Car V4H,
  - The second patch adds the actual support, and takes care of the
    increased size of the STRTIM field.

This has been tested on the White Hawk development board with R-Car V4H.
Thanks for your comments!

Cong Dang (1):
  memory: renesas-rpc-if: Clear HS bit during hardware initialization

Geert Uytterhoeven (1):
  memory: renesas-rpc-if: Add support for R-Car Gen4

 drivers/memory/renesas-rpc-if.c | 22 +++++++++++++++-------
 include/memory/renesas-rpc-if.h |  1 +
 2 files changed, 16 insertions(+), 7 deletions(-)

-- 
2.25.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
