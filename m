Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA214653048
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 12:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbiLUL3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 06:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbiLUL3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 06:29:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9792273B;
        Wed, 21 Dec 2022 03:29:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 734D1B81B60;
        Wed, 21 Dec 2022 11:29:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E51FC433F0;
        Wed, 21 Dec 2022 11:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671622178;
        bh=lfNjHpoobfh1U92aaCSBh/XG+o2ERNUSgOcuFcq3XyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fxjOPEfkuUE35cupA2IwOA+xz6Tq3EgeaPvtkalOBbh43B7utoA8r//Z0NIC0uyVL
         tyvY4maBg+uH3sxR82PWBBbpwdqqb4qPq9pCJIwMpAQkfsRyLNxvn3KRYAo6gOQzeA
         xzxzau96vIygNa72vPU+to8oM4dCJhzwqhCWUU556h0L19jhdLpf689g9nAuJv7Xnb
         h8V2cm+rx3yXy3HF7UFxXMscnQ5UfeS4nfCVUzbo4TSPFUuP0p7UusaXI+1Uuq9Mb2
         ZD1qtPfSYZjqg/T1QadY21SyvgG4g2GrKq223qlSS6NMQBE2oZKgYszaQJ9GltNCHH
         L2OaAr2hT9xjw==
From:   Conor Dooley <conor@kernel.org>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v13 2/2] MAINTAINERS: add pwm to PolarFire SoC entry
Date:   Wed, 21 Dec 2022 11:29:13 +0000
Message-Id: <20221221112912.147210-3-conor@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221221112912.147210-1-conor@kernel.org>
References: <20221221112912.147210-1-conor@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Add the newly introduced pwm driver to the existing PolarFire SoC entry.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7729a30b9609..e459d539fdd1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17979,6 +17979,7 @@ F:	drivers/clk/microchip/clk-mpfs.c
 F:	drivers/i2c/busses/i2c-microchip-corei2c.c
 F:	drivers/mailbox/mailbox-mpfs.c
 F:	drivers/pci/controller/pcie-microchip-host.c
+F:	drivers/pwm/pwm-microchip-core.c
 F:	drivers/reset/reset-mpfs.c
 F:	drivers/rtc/rtc-mpfs.c
 F:	drivers/soc/microchip/mpfs-sys-controller.c
-- 
2.38.1

