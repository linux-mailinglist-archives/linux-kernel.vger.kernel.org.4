Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650576A781D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 00:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjCAXz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 18:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjCAXzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 18:55:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1BC570AB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 15:55:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0083F614E1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 23:54:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2BFC433EF;
        Wed,  1 Mar 2023 23:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677714886;
        bh=MRoCgJBsB4zjckGaUqH0UMuLm5sB79606h6RhYhzdL8=;
        h=From:To:Cc:Subject:Date:From;
        b=DOYfwGSBNmCdXSSABO4eooAYkhazA0Nticx8ivqzMF5CBd3go+lJMgbfEMS4r+Eon
         lDYJS+naZrqOsISBJ/hxaO0GapByfNExk1kgFXBcaLPwkeaLfuz/WX7UXmtU3d/9TX
         uABrARFnto3zT6tYbo/NMpmV4UDa1z5+k8oVnY/XW6FlYLp5pdUglHvN9THmRi5JIE
         KLfvx3SdQcq04wJfbY6husKsmr6EcN6Hu4c/ruicU3uMtGXxqfMxpxRG141XFE1dX0
         qM26R/E8hH/GVG7KWio37ce+uwPZFL8VZmHETpSsb2v2ZhmMNeiwS2C/8n5ZhMPAmF
         7nlUeracr77Jg==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qais Yousef <qyousef@layalina.io>,
        Arnd Bergmann <arnd@arndb.de>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Kirill Tkhai <tkhai@ya.ru>
Subject: [PATCH v2] mailmap: updates for Jarkko Sakkinen
Date:   Thu,  2 Mar 2023 01:54:42 +0200
Message-Id: <20230301235443.6663-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
v2:
- Retain also @profian.com.
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index a872c9683958..e4d35d39b57e 100644
--- a/.mailmap
+++ b/.mailmap
@@ -189,6 +189,7 @@ Jan Glauber <jan.glauber@gmail.com> <jang@linux.vnet.ibm.com>
 Jan Glauber <jan.glauber@gmail.com> <jglauber@cavium.com>
 Jarkko Sakkinen <jarkko@kernel.org> <jarkko.sakkinen@linux.intel.com>
 Jarkko Sakkinen <jarkko@kernel.org> <jarkko@profian.com>
+Jarkko Sakkinen <jarkko@kernel.org> <jarkko.sakkinen@tuni.fi>
 Jason Gunthorpe <jgg@ziepe.ca> <jgg@mellanox.com>
 Jason Gunthorpe <jgg@ziepe.ca> <jgg@nvidia.com>
 Jason Gunthorpe <jgg@ziepe.ca> <jgunthorpe@obsidianresearch.com>
-- 
2.37.2

