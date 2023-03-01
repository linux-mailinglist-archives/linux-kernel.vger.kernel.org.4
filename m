Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50F56A7801
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 00:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjCAXwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 18:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCAXws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 18:52:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A984ECF3
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 15:52:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22884614D6
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 23:52:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0B5C4339B;
        Wed,  1 Mar 2023 23:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677714765;
        bh=NeBNfwqxpTpjXqv5FtvkDZOVmyn0NK1inLqcSIYI3Nw=;
        h=From:To:Cc:Subject:Date:From;
        b=fRT87yXLEdkmkaTst/0kVW0ygcAee9oz+DQP0lhw0mvPYHZ3+jYRUHToijTRuD4vj
         QyTtSFkGKO/kGbCJkRo33QZZ6lEMljBm5FLfaZ4egDc6IGPZu3h1viddmoX4cnl1BA
         bZ+7ZEO4CAJgLx57ZoeThguq//NEkn+E2KO8uh4BhwIZ1lhi8jSiPvLdvIG5HL7lE6
         fxRvwL/QS9kwEwfpkJ+PweVnvY+ZVcAwNoEckA/37LK9UkiuhYVlB4uvlDO3QThNme
         tLu9FAFnrrueo4d5w1bvAnWMnloZCv61Kwyry5ilE1cDP4Xk5Xq61GHu9b6RXmb84m
         xMcSrb4YpCxhw==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Qais Yousef <qyousef@layalina.io>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Kirill Tkhai <tkhai@ya.ru>
Subject: [PATCH] mailmap: updates for Jarkko Sakkinen
Date:   Thu,  2 Mar 2023 01:52:41 +0200
Message-Id: <20230301235242.5771-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update to my current employer:

https://research.tuni.fi/nisec/

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 .mailmap | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index a872c9683958..3f2f009e7b68 100644
--- a/.mailmap
+++ b/.mailmap
@@ -188,7 +188,7 @@ Jan Glauber <jan.glauber@gmail.com> <jang@de.ibm.com>
 Jan Glauber <jan.glauber@gmail.com> <jang@linux.vnet.ibm.com>
 Jan Glauber <jan.glauber@gmail.com> <jglauber@cavium.com>
 Jarkko Sakkinen <jarkko@kernel.org> <jarkko.sakkinen@linux.intel.com>
-Jarkko Sakkinen <jarkko@kernel.org> <jarkko@profian.com>
+Jarkko Sakkinen <jarkko@kernel.org> <jarkko.sakkinen@tuni.fi>
 Jason Gunthorpe <jgg@ziepe.ca> <jgg@mellanox.com>
 Jason Gunthorpe <jgg@ziepe.ca> <jgg@nvidia.com>
 Jason Gunthorpe <jgg@ziepe.ca> <jgunthorpe@obsidianresearch.com>
-- 
2.37.2

