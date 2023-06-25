Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E19D73D38D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 22:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjFYUMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 16:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFYUMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 16:12:36 -0400
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EF512A
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 13:12:34 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id DW63qPPnMbrosDW63qNCVb; Sun, 25 Jun 2023 22:12:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1687723952;
        bh=HTnGWUbgPOu9tTPS83pukflv+YYfBRc11HYbCi9ouX0=;
        h=From:To:Cc:Subject:Date;
        b=b2ShBgjQ6v15WHD9DHvM6hSighEpWGOflB5hZdnpEp1Wo7tww95BuoosSTZtrdpM0
         eaSTuK04y7HdYQxEwtA1uf3oEVA7PiF1JwRMQzpX0t5VYOv7qP0TQurFcLQFDs2PuE
         zEOpWxESgG4U8CxdXQ7FZYp7IpP04kL7R/CPvTKXnxZpuJA3Itm1bcEyH27vH4Mhot
         xEcMPVfpCwTdJRH9qors2SpIM0MGgWsFnC7/KkyfSHGQBlOjJjhgmfM4tS1t6fSqaz
         oxWAeyJsM0FhaS/uTLde2F/rxfCQaU2GD6oPgNv4tIRJc4biNsxDPHSKAiE9m8Mld4
         ECjYMjYlyzB4Q==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 25 Jun 2023 22:12:32 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH] docs: deprecated.rst: Update an example
Date:   Sun, 25 Jun 2023 22:12:24 +0200
Message-Id: <3484e46180dd2cf05d993ff1a78b481bc2ad1f71.1687723931.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmalloc() has a 2-factor form. It is vmalloc_array().
So use another function as an example.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 Documentation/process/deprecated.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
index f91b8441f2ef..1f7f3e6c9cda 100644
--- a/Documentation/process/deprecated.rst
+++ b/Documentation/process/deprecated.rst
@@ -77,7 +77,7 @@ kzalloc() can be replaced with kcalloc().
 If no 2-factor form is available, the saturate-on-overflow helpers should
 be used::
 
-	bar = vmalloc(array_size(count, size));
+	bar = dma_alloc_coherent(dev, array_size(count, size), &dma, GFP_KERNEL);
 
 Another common case to avoid is calculating the size of a structure with
 a trailing array of others structures, as in::
-- 
2.34.1

