Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B456F8E19
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 04:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjEFCkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 22:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjEFCkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 22:40:21 -0400
X-Greylist: delayed 419 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 05 May 2023 19:40:15 PDT
Received: from mail.sunmedia.com.cn (unknown [182.150.56.159])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 983F21FC4
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 19:40:15 -0700 (PDT)
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 172.28.114.216
        by mail.sunmedia.com.cn with MailGates ESMTP Server V5.0(14429:0:AUTH_RELAY)
        (envelope-from <qinjian@sunmedia.com.cn>); Sat, 06 May 2023 10:33:11 +0800 (CST)
From:   Qin Jian <qinjian@sunmedia.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     Qin Jian <qinjian@sunmedia.com.cn>
Subject: [PATCH] MAINTAINERS: Update qinjian@cqplus1.com to qinjian@sunmedia.com.cn
Date:   Sat,  6 May 2023 10:33:08 +0800
Message-Id: <20230506023308.430598-1-qinjian@sunmedia.com.cn>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qinjian@cqplus1.com will no longer be used, update to
qinjian@sunmedia.com.cn.

Signed-off-by: Qin Jian <qinjian@sunmedia.com.cn>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c0cde28c6..b0fcfcc81 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2853,7 +2853,7 @@ N:	stm32
 N:	stm
 
 ARM/SUNPLUS SP7021 SOC SUPPORT
-M:	Qin Jian <qinjian@cqplus1.com>
+M:	Qin Jian <qinjian@sunmedia.com.cn>
 L:	linux-arm-kernel@lists.infradead.org (moderated for mon-subscribers)
 S:	Maintained
 W:	https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
-- 
2.38.1

