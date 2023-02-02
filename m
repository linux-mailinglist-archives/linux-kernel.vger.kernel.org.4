Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAFC687834
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjBBJFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjBBJFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:05:07 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A01265B9F;
        Thu,  2 Feb 2023 01:05:05 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Bxa+rAfNtjGEIMAA--.24748S3;
        Thu, 02 Feb 2023 17:05:04 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxjb6+fNtjfEYnAA--.15499S2;
        Thu, 02 Feb 2023 17:05:03 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Remove CONFIG_MIPS check in Makefile
Date:   Thu,  2 Feb 2023 17:05:02 +0800
Message-Id: <1675328702-8328-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8Bxjb6+fNtjfEYnAA--.15499S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvdXoW7Jr17JryDXF1fZrWrJw4xZwb_yoW3JFX_K3
        92k3WUKw4rXrsYga17uryrGa4DA34UArn3ursYy3s0v345t34rWFZrCw1DAa18XF929rWr
        tFZ3ZFy3CrsFyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY
        b7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
        AFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
        6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7
        xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWle2I2
        62IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4
        CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvj
        eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxV
        CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
        6r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
        WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG
        6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
        1UYxBIdaVFxhVjvjDU0xZFpf9x07UiiSdUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_MIPS is set as y by default in Kconfig, no need to check
it in Makefile.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/mips/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 490dea0..6ed41c8b 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -316,11 +316,9 @@ KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 
 KBUILD_LDFLAGS		+= -m $(ld-emul)
 
-ifdef CONFIG_MIPS
 CHECKFLAGS += $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \
 	grep -E -vw '__GNUC_(MINOR_|PATCHLEVEL_)?_' | \
 	sed -e "s/^\#define /-D'/" -e "s/ /'='/" -e "s/$$/'/" -e 's/\$$/&&/g')
-endif
 
 OBJCOPYFLAGS		+= --remove-section=.reginfo
 
-- 
2.1.0

