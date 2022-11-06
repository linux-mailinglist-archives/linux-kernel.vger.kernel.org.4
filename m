Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924E361EB08
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 07:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiKGGcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 01:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiKGGcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 01:32:42 -0500
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.232.28.96])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id DB02C62D3
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 22:32:39 -0800 (PST)
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
        by hzbj-icmmx-1 (Coremail) with SMTP id AQAAfwAnZiMdpmhjc8nrAA--.25604S2;
        Mon, 07 Nov 2022 14:30:53 +0800 (CST)
Received: from centos7.localdomain (unknown [117.121.60.17])
        by mail (Coremail) with SMTP id AQAAfwDnQ_p8pmhj_SAaAA--.37504S3;
        Mon, 07 Nov 2022 14:32:28 +0800 (CST)
From:   Zhiyuan Dai <daizhiyuan@phytium.com.cn>
To:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org
Cc:     kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Zhiyuan Dai <daizhiyuan@phytium.com.cn>
Subject: [PATCH] KVM: arm64: Fix typo in comment
Date:   Sun,  6 Nov 2022 20:30:40 +0800
Message-Id: <1667737840-702-1-git-send-email-daizhiyuan@phytium.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AQAAfwDnQ_p8pmhj_SAaAA--.37504S3
X-CM-SenderInfo: hgdl6xpl1xt0o6sk53xlxphulrpou0/
Authentication-Results: hzbj-icmmx-1; spf=neutral smtp.mail=daizhiyuan
        @phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoW5KFykuw4rJF1ftF48Gr15urg_yoWxWFb_K3
        yfGr40gr1Fgrs29rWFga4rKr1vgws8XrZ8AFn5Xr4kAwnrXrW5WFyDXryIvF1Utr4agr4f
        taykWFyYqr1FyjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
        Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
        UUUU=
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in comment (nVHE/VHE).

Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
---
 arch/arm64/kvm/hyp/vhe/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/vhe/Makefile b/arch/arm64/kvm/hyp/vhe/Makefile
index 96bec0e..3b9e546 100644
--- a/arch/arm64/kvm/hyp/vhe/Makefile
+++ b/arch/arm64/kvm/hyp/vhe/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 #
-# Makefile for Kernel-based Virtual Machine module, HYP/nVHE part
+# Makefile for Kernel-based Virtual Machine module, HYP/VHE part
 #
 
 asflags-y := -D__KVM_VHE_HYPERVISOR__
-- 
1.8.3.1

