Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89A368FA74
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 23:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjBHWxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 17:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjBHWxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 17:53:36 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D11326CE0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 14:53:33 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pPtJi-0003OP-FW; Wed, 08 Feb 2023 23:53:30 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@rivosinc.com
Cc:     conor@kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, christoph.muellner@vrull.eu,
        ajones@ventanamicro.com, Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH 0/2] Small fixups for the Zbb string functions
Date:   Wed,  8 Feb 2023 23:53:26 +0100
Message-Id: <20230208225328.1636017-1-heiko@sntech.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@vrull.eu>

I didn't manage to address Andrews comments on v5 [0] in time
before the series got applied, so here are two addon comments
that hopefully do his comments justice now.


[0] https://lore.kernel.org/r/20230117122447.y6tdsmsxqdwf76ri@orel

Heiko Stuebner (2):
  RISC-V: fix ordering of Zbb extension
  RISC-V: improve string-function assembly

 arch/riscv/kernel/cpu.c  |  2 +-
 arch/riscv/lib/strcmp.S  |  6 ++++--
 arch/riscv/lib/strlen.S  | 10 +++++-----
 arch/riscv/lib/strncmp.S | 16 +++++++---------
 4 files changed, 17 insertions(+), 17 deletions(-)

-- 
2.39.0

