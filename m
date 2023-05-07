Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616506F9AF6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 20:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjEGSes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 14:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbjEGSel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 14:34:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2216E93;
        Sun,  7 May 2023 11:34:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9497B61C67;
        Sun,  7 May 2023 18:34:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752CDC433EF;
        Sun,  7 May 2023 18:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683484468;
        bh=5Ctl8xQn5Up2BfcQEPensi3ZFyebX1h9yHH8JgAlfCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GehbaZeik0nSLoZNom/ZTCM0VHsqmpTwh5xbhVcQl8OSoZhhfGUog1cH08s3zpl9V
         AYYIaMPmJcU0f9YlzCeDy43U1obqTFYZuMNO6BLy7OLdemKuctVdAhuXzNl91nIk62
         f0/LCnyxwniZuHwxfdasaHd1uO8ajjSp7ZlqAocn/0g8dYAIOj/KdknmHwjXJv4cMe
         mGhaaMYZZRYLfOLwvXe8Yq7Bb8pbFmVo0SKNXgUgYcKoTVshRXYHWsumOOXy2437oz
         NrBtzurbpkuyUC1FAY2ko5fqepWgZO7UtRtMfNu4/bLTB3EVX5zoMdIDZlWHBHyPth
         Hp7vTxangetyg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>
Subject: [PATCH 5/5] MAINTAINERS: add entry for T-HEAD RISC-V SoC
Date:   Mon,  8 May 2023 02:23:04 +0800
Message-Id: <20230507182304.2934-6-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230507182304.2934-1-jszhang@kernel.org>
References: <20230507182304.2934-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to temporarily maintain the T-HEAD RISC-V SoC support.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7e0b87d5aa2e..e1e51accec4f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18155,6 +18155,12 @@ T:	git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
 F:	Documentation/devicetree/bindings/riscv/
 F:	arch/riscv/boot/dts/
 
+RISC-V THEAD SoC SUPPORT
+M:	Jisheng Zhang <jszhang@kernel.org>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	arch/riscv/boot/dts/thead/
+
 RNBD BLOCK DRIVERS
 M:	Md. Haris Iqbal <haris.iqbal@ionos.com>
 M:	Jack Wang <jinpu.wang@ionos.com>
-- 
2.40.0

