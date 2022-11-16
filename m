Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9916762B498
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbiKPIIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbiKPIHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:07:43 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F21ED108
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:07:35 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Bx37dGmnRjQrIHAA--.17603S3;
        Wed, 16 Nov 2022 16:07:34 +0800 (CST)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx9VY6mnRjQ54UAA--.36317S11;
        Wed, 16 Nov 2022 16:07:33 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v8 9/9] LoongArch: Enable CONFIG_KALLSYMS_ALL and CONFIG_DEBUG_FS
Date:   Wed, 16 Nov 2022 16:07:22 +0800
Message-Id: <20221116080722.4745-10-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221116080722.4745-1-zhangqing@loongson.cn>
References: <20221116080722.4745-1-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx9VY6mnRjQ54UAA--.36317S11
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvdXoW7JryrGFW5Gw1kGF15WF1Dtrb_yoWDGrb_Ja
        1agw1Dur48J397uFn7Xw48W3yDA3WUXF1FkFnrXryxZa12gr13GrWDJw15C3WYga4UWrWY
        vaykAasxCr18tjkaLaAFLSUrUUUU8b8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY
        P7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
        AFIxvE14AKwVWUAVWUZwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
        6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAa
        w2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Wrv_ZF1lYx0Ex4A2
        jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw2
        8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I
        3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxV
        WUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI8I
        cVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
        AFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI
        43ZEXa7IU0sXo7UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defaults enable CONFIG_KALLSYMS_ALL and CONFIG_DEBUG_FS to convenient
ftrace tests.

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 arch/loongarch/configs/loongson3_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
index 2d4678e6189a..0bbab17609b0 100644
--- a/arch/loongarch/configs/loongson3_defconfig
+++ b/arch/loongarch/configs/loongson3_defconfig
@@ -34,6 +34,7 @@ CONFIG_SYSFS_DEPRECATED=y
 CONFIG_RELAY=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
+CONFIG_KALLSYMS_ALL=y
 CONFIG_USERFAULTFD=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_COMPAT_BRK is not set
@@ -845,6 +846,7 @@ CONFIG_CRYPTO_DEV_VIRTIO=m
 CONFIG_PRINTK_TIME=y
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_FS=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_SCHEDSTATS=y
 # CONFIG_DEBUG_PREEMPT is not set
-- 
2.36.0

