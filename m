Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245DA65DBD6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 19:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240034AbjADSF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 13:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239903AbjADSFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 13:05:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EC5108A;
        Wed,  4 Jan 2023 10:05:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43A906179B;
        Wed,  4 Jan 2023 18:05:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8A6C43396;
        Wed,  4 Jan 2023 18:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672855548;
        bh=SpxUfboVfaSWtvMSqW0B+NZAeloH/U4lZdg9RHU4N3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MZyaK10kBqxH/xTpI6ZGaW6VYehCAWKr4pIlLC7OEE5Psip32Y1FhtVa0esLwfIWY
         Ucp6yTs8EtQAPPX4mLo3Z0ezzgA37F2YHznb+fLhEx2N2Vsiozsi1dpb98R05e6Ji3
         4lWe9XtR83YxVnriLYZOjZoD2Sp03q5B3sQZFdiYvC0KSoh0qTalDm+0MMI1dNhr8z
         Mu2JoS+NnX8D5IS6VbhLD60LXXuhyR3tndeHWHxA+zpNdiLGT55SteqzINdxY19xN0
         huKDkhxNkaJr+cINkBg+nXZEYk/SkmnOnyfa/Aav1Ilklsd5dRp5MyPBymK33013/p
         t9ImPPAILndaA==
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
Subject: [PATCH v1 1/2] dt-bindings: arm: move cpu-capacity to a shared loation
Date:   Wed,  4 Jan 2023 18:05:13 +0000
Message-Id: <20230104180513.1379453-2-conor@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230104180513.1379453-1-conor@kernel.org>
References: <20230104180513.1379453-1-conor@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4078; i=conor.dooley@microchip.com; h=from:subject; bh=EHhLKTpL8b24ylcqPJCu6roLTdkZjz8WegHWiaxDAkY=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDMlb91+c0cf+KyCreJNWx16FJ+++CThmLNT2+X5p868tcjfN H29431HKwiDGwSArpsiSeLuvRWr9H5cdzj1vYeawMoEMYeDiFICJ/O5n+O/29NHEsKfOfOqBdjd+b/ /64NeTzX2i7xX/C1jdWFCg47COkWGp9LYpxfppoocYSyYqhum2eh2Y86/V/sqUG2sjGEKfsDMCAA==
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Type: text/plain; charset=UTF-8
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

RISC-V uses the same generic topology code as arm64 & while there
currently exists no binding for cpu-capacity on RISC-V, the code paths
can be hit if the property is present.

Move the documentation of cpu-capacity to a shared location, ahead of
defining a binding for capacity-dmips-mhz on RISC-V. Update some
references to this document in the process.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
I wasn't sure what to do with reference [1], but since the property will
be the same on RISC-V, I left it as is.
---
 Documentation/devicetree/bindings/arm/cpus.yaml               | 2 +-
 .../devicetree/bindings/{arm => cpu}/cpu-capacity.txt         | 4 ++--
 Documentation/scheduler/sched-capacity.rst                    | 2 +-
 Documentation/translations/zh_CN/scheduler/sched-capacity.rst | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)
 rename Documentation/devicetree/bindings/{arm => cpu}/cpu-capacity.txt (98%)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 01b5a9c689a2..a7586295a6f5 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -257,7 +257,7 @@ properties:
 
   capacity-dmips-mhz:
     description:
-      u32 value representing CPU capacity (see ./cpu-capacity.txt) in
+      u32 value representing CPU capacity (see ../cpu/cpu-capacity.txt) in
       DMIPS/MHz, relative to highest capacity-dmips-mhz
       in the system.
 
diff --git a/Documentation/devicetree/bindings/arm/cpu-capacity.txt b/Documentation/devicetree/bindings/cpu/cpu-capacity.txt
similarity index 98%
rename from Documentation/devicetree/bindings/arm/cpu-capacity.txt
rename to Documentation/devicetree/bindings/cpu/cpu-capacity.txt
index cc5e190390b7..f28e1adad428 100644
--- a/Documentation/devicetree/bindings/arm/cpu-capacity.txt
+++ b/Documentation/devicetree/bindings/cpu/cpu-capacity.txt
@@ -1,12 +1,12 @@
 ==========================================
-ARM CPUs capacity bindings
+CPU capacity bindings
 ==========================================
 
 ==========================================
 1 - Introduction
 ==========================================
 
-ARM systems may be configured to have cpus with different power/performance
+Some systems may be configured to have cpus with different power/performance
 characteristics within the same chip. In this case, additional information has
 to be made available to the kernel for it to be aware of such differences and
 take decisions accordingly.
diff --git a/Documentation/scheduler/sched-capacity.rst b/Documentation/scheduler/sched-capacity.rst
index 805f85f330b5..8e2b8538bc2b 100644
--- a/Documentation/scheduler/sched-capacity.rst
+++ b/Documentation/scheduler/sched-capacity.rst
@@ -260,7 +260,7 @@ for that purpose.
 
 The arm and arm64 architectures directly map this to the arch_topology driver
 CPU scaling data, which is derived from the capacity-dmips-mhz CPU binding; see
-Documentation/devicetree/bindings/arm/cpu-capacity.txt.
+Documentation/devicetree/bindings/cpu/cpu-capacity.txt.
 
 3.2 Frequency invariance
 ------------------------
diff --git a/Documentation/translations/zh_CN/scheduler/sched-capacity.rst b/Documentation/translations/zh_CN/scheduler/sched-capacity.rst
index 3a52053c29dc..e07ffdd391d3 100644
--- a/Documentation/translations/zh_CN/scheduler/sched-capacity.rst
+++ b/Documentation/translations/zh_CN/scheduler/sched-capacity.rst
@@ -233,7 +233,7 @@ CFS调度类基于实体负载跟踪机制（Per-Entity Load Tracking, PELT）
 
 arm和arm64架构直接把这个信息映射到arch_topology驱动的CPU scaling数据中（译注：参考
 arch_topology.h的percpu变量cpu_scale），它是从capacity-dmips-mhz CPU binding中衍生计算
-出来的。参见Documentation/devicetree/bindings/arm/cpu-capacity.txt。
+出来的。参见Documentation/devicetree/bindings/cpu/cpu-capacity.txt。
 
 3.2 频率不变性
 --------------
-- 
2.39.0

