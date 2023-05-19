Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A526709BFA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjESQFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjESQFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:05:34 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAE3BA;
        Fri, 19 May 2023 09:05:32 -0700 (PDT)
Received: from ipservice-092-217-072-086.092.217.pools.vodafone-ip.de ([92.217.72.86] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1q02bf-0001Ah-Jo; Fri, 19 May 2023 18:05:27 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 0/3] hwrng: imx-rngc - simplify register definitions
Date:   Fri, 19 May 2023 18:04:30 +0200
Message-Id: <20230519160433.287161-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230427185357.923412-1-martin@kaiser.cx>
References: <20230427185357.923412-1-martin@kaiser.cx>
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

This series simplifies some definitions for register bits and fields. We can
then use the FIELD_GET macro to read register fields instead of masking and
shifting manually.

Tested on an imx258 board (rngb).

v2:
 - simpler check if random bytes are available

Martin Kaiser (3):
  hwrng: imx-rngc - simpler check for available random bytes
  hwrng: imx-rngc - use bitfield macros to read rng type
  hwrng: imx-rngc - use BIT(x) for register bit defines

 drivers/char/hw_random/imx-rngc.c | 35 +++++++++++++------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

-- 
2.30.2

