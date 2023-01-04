Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F4B65DBD7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 19:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240059AbjADSGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 13:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239950AbjADSFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 13:05:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41FC10B41;
        Wed,  4 Jan 2023 10:05:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 807DF617CF;
        Wed,  4 Jan 2023 18:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEE2C433EF;
        Wed,  4 Jan 2023 18:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672855551;
        bh=7hi84JBUzFJsCseSml62aqokn8J6yG6QNrOsogIOB7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VN0/UaFFVZqOMHF3674yqncE3YyRqpXDi5c4Zhr48kmPb5BzW1m0UyuTiRIPHTwJg
         6ohuZFHYCy0Uz7JEkrOAPmJp6q3t2prjNBbnCCfNlUrPifBiZX/pgi8euV7gQdOoHP
         u2v2FU+cSLVuTKpaCiiBL0znJ/bqgcFgJPj811JgYfwkqFLv0/noGd2P054fbFSkum
         27soQ27+YV2HwVuhOTPDmw4Uyao4A8MUh0qiDqJFteLKnA99okpwEfjT/aMBXpvWka
         G0/T0SrhpxzhLwOVaXNTAqDb8xn/dI3ZL3EJewf+ZPwTJfM1E7q1aRvADplGsGgBvl
         /27kkR1aysMtw==
From:   Conor Dooley <conor@kernel.org>
To:     palmer@dabbelt.com
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org
Subject: [PATCH v1 2/2] dt-bindings: riscv: add a capacity-dmips-mhz cpu property
Date:   Wed,  4 Jan 2023 18:05:14 +0000
Message-Id: <20230104180513.1379453-3-conor@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230104180513.1379453-1-conor@kernel.org>
References: <20230104180513.1379453-1-conor@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1179; i=conor.dooley@microchip.com; h=from:subject; bh=o07jjdwBTatvOwh4zgdAJ4rsKJozF7vor3izbX7Vg94=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDMlb91/MCL97v/HRZP+ZQQoTbpy8ObPJZKryPqsFBjsulS4U ZU1Y21HKwiDGwSArpsiSeLuvRWr9H5cdzj1vYeawMoEMYeDiFICJ3H/D8FdGeDLTxqseKd6GMz+vn2 dw6/qlJwmcR85k5/KW588P13jA8Fc6rkupS13k7O3cN8f+q/6375qlbHJd6PmVowdZAyzu/uECAA==
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
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

Since commit 03f11f03dbfe ("RISC-V: Parse cpu topology during boot.")
RISC-V has used the generic arch topology code, which provides for
disparate CPU capacities. We never defined a binding to acquire this
information from the DT though, so document the one already used by the
generic arch topology code: "capacity-dmips-mhz".

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index c6720764e765..2480c2460759 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -114,6 +114,12 @@ properties:
       List of phandles to idle state nodes supported
       by this hart (see ./idle-states.yaml).
 
+  capacity-dmips-mhz:
+    description:
+      u32 value representing CPU capacity (see ../cpu/cpu-capacity.txt) in
+      DMIPS/MHz, relative to highest capacity-dmips-mhz
+      in the system.
+
 required:
   - riscv,isa
   - interrupt-controller
-- 
2.39.0

