Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643D0614C0F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 14:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiKANuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 09:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiKANuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 09:50:08 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA44614F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 06:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667310597; bh=8G8ijNpzwZYatDZANaufMBhLpqqvE5uH9B3jRw4pOhY=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=gK9A2sJRRps4UWAIDEHosJmKh9OD7mP3p0gT9bezi4UTuzaAKiBEZaIoHGofN0NuL
         Cb+v7BwGGrmF+xZJ9s0drzohIy6G6e1YInWzk1ZmlQHQ6gKZhSzGS+MUnQYo0e6tLr
         nhdIM37Wiv9n/FIbhoHU8rF7eUzlDeJD8Dd/ofog=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via [213.182.55.206]
        Tue,  1 Nov 2022 14:49:57 +0100 (CET)
X-EA-Auth: erc4JnmKzL1p+tdhqH73lJrMemUhI3sHaSNaLbA9SpuJm69EGX8ipr5WtgnlWcNI72YacsbfxkMSKIccpnyGFcZZZiD7bJJf
Date:   Tue, 1 Nov 2022 19:19:54 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] staging: wlan-ng: Remove unused struct p80211macarray
 definition
Message-ID: <b42eff9b8f73542bc9015948e5e4684416982e1b.1667308828.git.drv@mailo.com>
References: <cover.1667308828.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1667308828.git.drv@mailo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct p80211macarray is defined but is never used. Remove the unused
struct declaration.
Issue identified as part of coccicheck based code analysis.

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Suggested-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Changes in v2:
   1. Include additional code clean-up opportunities and combine changes in a
      patch set based on impact areas.
   2. The patch changes are compile tested only on X86 arch.

 drivers/staging/wlan-ng/p80211types.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/wlan-ng/p80211types.h b/drivers/staging/wlan-ng/p80211types.h
index 6486612a8f31..b2ed96960413 100644
--- a/drivers/staging/wlan-ng/p80211types.h
+++ b/drivers/staging/wlan-ng/p80211types.h
@@ -231,12 +231,6 @@ struct p80211pstr32 {
 	u8 data[MAXLEN_PSTR32];
 } __packed;

-/* MAC address array */
-struct p80211macarray {
-	u32 cnt;
-	u8 data[1][MAXLEN_PSTR6];
-} __packed;
-
 /* prototype template */
 struct p80211item {
 	u32 did;
--
2.34.1



