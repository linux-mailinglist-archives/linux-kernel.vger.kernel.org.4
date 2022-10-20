Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307BF6058C0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiJTHhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiJTHhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:37:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EE6167276
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 00:37:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25B29B8265D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 07:37:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B74C433C1;
        Thu, 20 Oct 2022 07:37:08 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V2 0/4] irqchip/loongson: Add suspend/resume support for irqchip drivers
Date:   Thu, 20 Oct 2022 15:35:23 +0800
Message-Id: <20221020073527.541845-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add suspend/resume support for Loongson-related irqchip
drivers (i.e., HTVECINTC, EIOINTC, PCH-PIC and PCH_LPC), which is needed
for LoongArch's upcoming suspend/hibernation support.

Note: this series is applicable after "irqchip/loongson-htvec: Add ACPI
init support".

V1 -> V2:
Holding irq_desc->lock while eiointc_set_irq_affinity().

Huacai Chen (4):
 irqchip/loongson-htvec: Add suspend/resume support.
 irqchip/loongson-eiointc: Add suspend/resume support.
 irqchip/loongson-pch-pic: Add suspend/resume support.
 irqchip/loongson-pch-lpc: Add suspend/resume support.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/irqchip/irq-loongson-eiointc.c | 31 ++++++++++++++++++++++
 drivers/irqchip/irq-loongson-htvec.c   | 27 +++++++++++++++++++
 drivers/irqchip/irq-loongson-pch-lpc.c | 25 ++++++++++++++++++
 drivers/irqchip/irq-loongson-pch-pic.c | 47 ++++++++++++++++++++++++++++++++++
 4 files changed, 130 insertions(+)
--
2.27.0

