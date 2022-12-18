Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B41064FF1C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 15:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbiLRO1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 09:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLRO1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 09:27:15 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D678C63CC
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 06:27:14 -0800 (PST)
Received: from dslb-178-004-201-210.178.004.pools.vodafone-ip.de ([178.4.201.210] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1p6udC-0007F2-Cf; Sun, 18 Dec 2022 15:27:10 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Martin Kaiser <martin@kaiser.cx>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ARM: highbank: add missing of_node_put calls
Date:   Sun, 18 Dec 2022 15:26:45 +0100
Message-Id: <20221218142647.394881-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's two simple patches to call of_node_put for device nodes that were
returned by of_find_compatible_node.

Both patches were compile-tested only as I don't have the hardware to run
the code.

Martin Kaiser (2):
  ARM: highbank: add missing of_node_put call
  ARM: highbank: fix of node handling in highbank_init_irq

 arch/arm/mach-highbank/highbank.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

-- 
2.30.2

