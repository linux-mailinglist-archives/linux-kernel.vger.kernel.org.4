Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735F96F96E2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 06:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjEGEuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 00:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjEGEuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 00:50:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F141D120AF;
        Sat,  6 May 2023 21:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=bPRbQeNTrpSAndE0MaXajdXvqZ/eX3I6xTDffTsiSIU=; b=lloclno4EFHxO5gaFzZmxJ9a0B
        b2DuTbmG0raCRqbgKIZvYdCDdYpT8x2PIyWPvoWAIJfxoTei/ec+Fmx2rUJaAPQLDtOdzga0rBAv8
        lBECOnZs0MeLozXtCrBT0EYcm4nbodgFuKDprq9buxEaQobXfs4mhMAnfF0Jy+bAhKMEbLZy3sfNF
        /CIVbScs7MGIEbu7JDAWHAoTgiy/kenQqLG85ba5E5DLggpT7rb3dvQPRKnX2fPTQmhVTrkNUMbkT
        9KczQoohnmHlRTdnJFRGzHcNreg/T7RPQBLZ9nt9Qdui8Wl659gIxMBADgvvkZnNrNqsO3eLjKrCQ
        DfDbO1Ww==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pvWLd-00FBE5-21;
        Sun, 07 May 2023 04:50:13 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH] Documentation/block: request: delete the unused FIXME comment
Date:   Sat,  6 May 2023 21:50:12 -0700
Message-Id: <20230507045012.15172-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This FIXME comment looks like it could be a local file contents
attempt, but this file is short and does not needs its own contents
block, so drop it completely.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/block/request.rst |   17 -----------------
 1 file changed, 17 deletions(-)

diff -- a/Documentation/block/request.rst b/Documentation/block/request.rst
--- a/Documentation/block/request.rst
+++ b/Documentation/block/request.rst
@@ -5,23 +5,6 @@ struct request documentation
 Jens Axboe <jens.axboe@oracle.com> 27/05/02
 
 
-.. FIXME:
-   No idea about what does mean - seems just some noise, so comment it
-
-   1.0
-   Index
-
-   2.0 Struct request members classification
-
-       2.1 struct request members explanation
-
-   3.0
-
-
-   2.0
-
-
-
 Short explanation of request members
 ====================================
 
