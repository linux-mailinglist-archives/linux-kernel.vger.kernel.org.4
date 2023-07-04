Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238D97477DC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 19:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjGDRdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 13:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjGDRdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 13:33:50 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC51810D5;
        Tue,  4 Jul 2023 10:33:49 -0700 (PDT)
Received: from ipservice-092-217-072-126.092.217.pools.vodafone-ip.de ([92.217.72.126] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1qGjuM-0000yT-6B; Tue, 04 Jul 2023 19:33:46 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Joshua Henderson <joshua.henderson@microchip.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/4] hwrng: pic32 - some simple cleanups
Date:   Tue,  4 Jul 2023 19:31:59 +0200
Message-Id: <20230704173203.70706-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a series with simple clenaups to the pic32 driver. The patches were
compile tested only.

Martin Kaiser (4):
  hwrng: pic32 - enable compile-testing
  hwrng: pic32 - use devm_clk_get_enabled
  hwrng: pic32 - remove unused defines
  hwrng: pic32 - enable TRNG only while it's used

 drivers/char/hw_random/Kconfig     |  2 +-
 drivers/char/hw_random/pic32-rng.c | 71 +++++++++++-------------------
 2 files changed, 27 insertions(+), 46 deletions(-)

-- 
2.30.2

