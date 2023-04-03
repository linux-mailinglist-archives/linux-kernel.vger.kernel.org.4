Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A268E6D54B4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 00:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbjDCWYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 18:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjDCWYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 18:24:10 -0400
X-Greylist: delayed 180 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Apr 2023 15:24:09 PDT
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E337C26A1;
        Mon,  3 Apr 2023 15:24:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1680560288; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=dHXYM0uswVLa7qGJ1n0Y/Hd9He6Q6vdsKCDtxPGeSeD8tqRMnIyDPKCAw7f/iHjMkS
    qkRoxnHjRbyjj9WodQNtMj0JyBO1gB6dmUjdfoFTa9ETlXzX/0b3Id71gbgExLJvR0Tq
    bv7pHdy8BUjxPTZre13Iky6OZ+2JyepwIA8dhnY/Qyvf1IndGg8+3ngX+teyrhx7UvOc
    B/gOD3ncNcxmZzhxbV2N1ygbp/yWcrNXsYos3UFtS6CHPG4e60MqhqnFl4HDUJCtU+4k
    eUXjExo8B52Ph8RplHgWLmwwp1ASlhkQnJ/fMTns0hmyXiOp3tSWZwnZL8OIw4qREj/6
    W1RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1680560288;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=0HMZm2l3hM+JH+7FaoQribqoZQkCA93Qk1fyun3ouAM=;
    b=CR3ghNkFiu7V6vtog8NpZENI2Y4CTf6kZTsAoUt2mmZHzjuDOOD43PZTvjzDg7YDYK
    cKeAuTKsMxIQB7+QnL0t7cMGfuILo1DOpYs9tnzDxWDOWOP9TTBYrxLpsoXWrX8ZVwCI
    ALWXEOUfyaHvxC+vua0AJd/J3phsX/aNWY+4MDWHHEp0rtuH6IB7FM5iuy4TgPfTv0XI
    BT5ZvN/7pYNbwJmG76FSsv9pA3ZZIfYRXW1r7vzybBWLxt7NWvp/ytjm7W9IukDFU3Ca
    b2c7G5PDG0CMrZnaNZNMsiAfCygq3Y5AZmKLws6UCN24bgYkRPjsCs8Km2BkXDKyTYVG
    I4kQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1680560288;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=0HMZm2l3hM+JH+7FaoQribqoZQkCA93Qk1fyun3ouAM=;
    b=UOXm/m1N7RFTeWtPUyGRxc9f+yrMnGGEB4yKSUmGynMLcyoxuwa48xqMRBUmGMlo9Q
    aupGZ6PKWMdRgQCbAtur160CAS5J0CsLBgXkuiYWmyfFrG7cnm3w3DMmVj3xB7xojPef
    XdbFS8CxYpDu5gGTxEgnKu4EtRJDI00nbCfx8Fdg2XCeXCOkDEMlhY+gJQtZPhAyvqqo
    ylg4IIsIb4163yT9Z+VsiFGIBV3/6ex9bWlwivoUSrmUbBpT4A5OeCXThpMto8UhGfRS
    lUktsMeN5x4dKJygHOrOcvtPLAGHN1TbH1RR+i73pxb6hJyKBlzsjMW2nqZVia6muIjK
    Cqpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1680560288;
    s=strato-dkim-0003; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=0HMZm2l3hM+JH+7FaoQribqoZQkCA93Qk1fyun3ouAM=;
    b=HVQhozuwCLUdpFKRVUv3kkjDVZEXG6sJqb5+FZsCTSwxvFDpu6IrQntQtNIIqUjFSE
    hQYsA45u8VBes0AM+CCQ==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1QLj68UeUr1+U1RzWv4bd+7QxaQVB47AxSeMBXfSiHYGZtGVa"
Received: from blinux.speedport.ip
    by smtp.strato.de (RZmta 49.4.0 AUTH)
    with ESMTPSA id z06594z33MI70gD
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 4 Apr 2023 00:18:07 +0200 (CEST)
From:   Bean Huo <beanhuo@iokpp.de>
To:     ulf.hansson@linaro.org, CLoehle@hyperstone.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
Subject: [PATCH] mmc: core: Remove unused macro mmc_req_rel_wr
Date:   Tue,  4 Apr 2023 00:17:54 +0200
Message-Id: <20230403221754.16168-1-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

There is no user for macro mmc_req_rel_wr, so delete it.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/mmc/core/block.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 672ab90c4b2d..00c33edb9fb9 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -76,8 +76,6 @@ MODULE_ALIAS("mmc:block");
 #define MMC_EXTRACT_INDEX_FROM_ARG(x) ((x & 0x00FF0000) >> 16)
 #define MMC_EXTRACT_VALUE_FROM_ARG(x) ((x & 0x0000FF00) >> 8)
 
-#define mmc_req_rel_wr(req)	((req->cmd_flags & REQ_FUA) && \
-				  (rq_data_dir(req) == WRITE))
 static DEFINE_MUTEX(block_mutex);
 
 /*
-- 
2.25.1

