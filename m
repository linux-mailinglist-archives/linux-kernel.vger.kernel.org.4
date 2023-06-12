Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F59B72BB5E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbjFLIyZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 12 Jun 2023 04:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjFLIxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:53:41 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729263A98;
        Mon, 12 Jun 2023 01:52:42 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 904E824E26C;
        Mon, 12 Jun 2023 16:52:35 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 12 Jun
 2023 16:52:35 +0800
Received: from ubuntu.localdomain (202.188.176.82) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 12 Jun
 2023 16:52:33 +0800
From:   Jia Jie Ho <jiajie.ho@starfivetech.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Subject: [PATCH v3 0/2] crypto: starfive - Add RSA algo to drivers
Date:   Mon, 12 Jun 2023 16:52:28 +0800
Message-ID: <20230612085230.193507-1-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds RSA support to VisionFive 2 SoCs. Patch 1 updates
current irq handling of hash module to prevent conflict among other
crypto modules. Patch 2 adds RSA algo to crypto engine drivers.

Changes v2 -> v3:
 - Rearranged irq mask clear sequence to prevent spurious interrupt
   from completing pka_done prematurely (Herbert)

Changes v1 -> v2:
 - Removed ASYNC flag (Herbert)

Jia Jie Ho (2):
  crypto: starfive - Update hash module irq handling
  crypto: starfive - Add RSA algo support

 drivers/crypto/starfive/Kconfig       |   1 +
 drivers/crypto/starfive/Makefile      |   2 +-
 drivers/crypto/starfive/jh7110-cryp.c |  20 +-
 drivers/crypto/starfive/jh7110-cryp.h |  45 ++
 drivers/crypto/starfive/jh7110-hash.c |   9 +-
 drivers/crypto/starfive/jh7110-rsa.c  | 617 ++++++++++++++++++++++++++
 6 files changed, 691 insertions(+), 3 deletions(-)
 create mode 100644 drivers/crypto/starfive/jh7110-rsa.c

-- 
2.34.1

