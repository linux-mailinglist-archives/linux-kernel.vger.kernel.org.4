Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C9E6005CB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 05:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbiJQDk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 23:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbiJQDky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 23:40:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529444F6A3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 20:40:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0782CB80E85
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:40:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EC4C433B5;
        Mon, 17 Oct 2022 03:40:48 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 0/4] irqchip/loongson: Add suspend/resume support for irqchip drivers
Date:   Mon, 17 Oct 2022 11:39:00 +0800
Message-Id: <20221017033904.2421723-1-chenhuacai@loongson.cn>
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

