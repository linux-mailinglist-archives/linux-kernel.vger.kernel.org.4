Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306116EC30A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 01:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjDWXDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 19:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDWXDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 19:03:49 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B8CE7F;
        Sun, 23 Apr 2023 16:03:47 -0700 (PDT)
Received: by gandalf.ozlabs.org (Postfix, from userid 1003)
        id 4Q4P2R2Qg3z4xFh; Mon, 24 Apr 2023 09:03:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
        s=201707; t=1682291023;
        bh=VYkkgpvSfhfSaj5MZGaTDNMdwOg0eL/EKXCZb281p2c=;
        h=Date:From:To:Cc:Subject:From;
        b=UH1Vqb8xF5YQAIUUee8HJQPfaNDaKbqtS12kniSXIQA26EQ/zbnovifX6EJ8SdWqd
         asD2oLcZWIqWthr6TgxfyOO54UeMZKIW9qlgSJVk2aGGeGQnRxkXR1xh+69ODF9Egr
         vdVUXqdk46U78n85I0mfduozNur+Z8U2fAWNLZY/+7vV6yJ3YLGM+9ev+iuVsgH6/J
         qDabpn1BK1jI8bYgWxaWopOi1aWVA+wwen+tAxEGDsmcUBAurfDuBkPssNYr8DGByM
         e1YHEjhCwWcSM1P+7AlguBcin862VwnTXi/qYbbwA6OPHSTSm4oMwyXzMTx0ZxvKqO
         PbuY/yY4esHRg==
Date:   Mon, 24 Apr 2023 08:59:16 +1000
From:   Paul Mackerras <paulus@ozlabs.org>
To:     linux-fbdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] MAINTAINERS: Remove rage128 framebuffer driver maintainer
Message-ID: <ZEW4REOoU8XuT6sS@cleo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have not worked on this code for years, so remove my name as
maintainer.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c6545eb54104..d79bae5590f8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17462,9 +17462,8 @@ F:	drivers/block/rbd.c
 F:	drivers/block/rbd_types.h
 
 RAGE128 FRAMEBUFFER DISPLAY DRIVER
-M:	Paul Mackerras <paulus@samba.org>
 L:	linux-fbdev@vger.kernel.org
-S:	Maintained
+S:	Orphan
 F:	drivers/video/fbdev/aty/aty128fb.c
 
 RAINSHADOW-CEC DRIVER
-- 
2.39.2

