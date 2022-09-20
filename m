Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E933F5BDAE9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 05:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiITDho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 23:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiITDh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 23:37:28 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 486D75A16A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 20:37:26 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxReJqNSlj7FseAA--.48978S2;
        Tue, 20 Sep 2022 11:37:14 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Add kprobe and kretprobe support for LoongArch
Date:   Tue, 20 Sep 2022 11:37:10 +0800
Message-Id: <1663645034-967-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8DxReJqNSlj7FseAA--.48978S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw4DZr18ur4fAF13ur15Jwb_yoW3Arc_A3
        W3t34rCrW8JayUXa4qq3yfJrWDta18GFn0kF9rXr4xWFnxAr17Ga1kXw1Yva9akayDWFZ8
        JrW0gFykZr1jvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb7AYjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8GwCF04k2
        0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8RHq7UUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tiezhu Yang (4):
  LoongArch: Add kprobe support
  LoongArch: Add kretprobe support
  samples/kprobes: Add LoongArch support
  LoongArch: Enable KPROBES in default config

 arch/loongarch/Kconfig                     |   2 +
 arch/loongarch/configs/loongson3_defconfig |   1 +
 arch/loongarch/include/asm/inst.h          |  31 +++
 arch/loongarch/include/asm/kprobes.h       |  44 ++++
 arch/loongarch/include/asm/ptrace.h        |   1 +
 arch/loongarch/kernel/Makefile             |   2 +
 arch/loongarch/kernel/inst.c               | 107 +++++++++
 arch/loongarch/kernel/kprobes.c            | 356 +++++++++++++++++++++++++++++
 samples/kprobes/kprobe_example.c           |   8 +
 9 files changed, 552 insertions(+)
 create mode 100644 arch/loongarch/include/asm/kprobes.h
 create mode 100644 arch/loongarch/kernel/kprobes.c

-- 
2.1.0

