Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C116432B5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbiLET2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 14:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbiLET17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:27:59 -0500
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 073E3286D0
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 11:24:53 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id 2GxgpcFOTOAzA2GxhpQODA; Mon, 05 Dec 2022 20:17:12 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 05 Dec 2022 20:17:12 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Christoph Hellwig <hch@infradead.org>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-block@vger.kernel.org
Subject: [PATCH v2] block: sed-opal: Don't include <linux/kernel.h>
Date:   Mon,  5 Dec 2022 20:16:48 +0100
Message-Id: <c1d479b39e30fe70c4579a1af035d4db49421f56.1670069909.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to include <linux/kernel.h> here.

Prefer the less invasive <linux/types.h> and <linux/compiler_types.h>
which are needed in this .h file itself.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Change in v2:
  * No need to add a useless comment    [Christoph Hellwig]
  * No need to add a new empty line     [Christoph Hellwig]

v1: https://lore.kernel.org/all/a2de79b3de30fe70c457953af935dadd49441f00.1670069909.git.christophe.jaillet@wanadoo.fr/

Let see if build-bots agree with me!
---
 include/linux/sed-opal.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
index 6f837bb6c715..87f981c70894 100644
--- a/include/linux/sed-opal.h
+++ b/include/linux/sed-opal.h
@@ -11,7 +11,8 @@
 #define LINUX_OPAL_H
 
 #include <uapi/linux/sed-opal.h>
-#include <linux/kernel.h>
+#include <linux/compiler_types.h>
+#include <linux/types.h>
 
 struct opal_dev;
 
-- 
2.34.1

