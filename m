Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8712614C10
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 14:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiKANue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 09:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiKANuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 09:50:25 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D7C617E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 06:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667310617; bh=XmP1+R7p/DnWE5QzKvv5uzhyseayhrVNsX9HWBGsGr8=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=VExi3kuq/HmPb0/aDWSXNQOY7ISbyBbW5d+yK/DcBRJJbrcicNKbfVEnpQcDo9LWC
         OKD6Pn7tR1b5UM93MgwQH4p9YDr8/vkFxYSY3joD3Gp8io459DD5XSsisSzy9d1hp/
         Uaf+yt33pz5i2snxiBKpsRjMBPnA6wS1tGQu/PZw=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via [213.182.55.206]
        Tue,  1 Nov 2022 14:50:17 +0100 (CET)
X-EA-Auth: gOpbJ+yZ/65L/9kxRhFEwwz17m1XTt5yz03Fd6XsbTcl10l1/WuCWkGYjjQ3rWczKNL8G2kBfpJrudGWB+4lLwoE5KQGl5/e
Date:   Tue, 1 Nov 2022 19:20:13 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] staging: wlan-ng: Remove unused function declarations
Message-ID: <09e2af8d702e33c15ed9f655b0a1190b4e8bec86.1667308828.git.drv@mailo.com>
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

Several functions are declared but are not implemented or used in any
part of the code. Remove such unimplemented function declarations.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Changes in v2:
   1. Patch included in patch set.
   2. The patch changes are compile tested only on X86 arch.


 drivers/staging/wlan-ng/p80211mgmt.h | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/staging/wlan-ng/p80211mgmt.h b/drivers/staging/wlan-ng/p80211mgmt.h
index 816b25641f5a..da824bc36365 100644
--- a/drivers/staging/wlan-ng/p80211mgmt.h
+++ b/drivers/staging/wlan-ng/p80211mgmt.h
@@ -449,26 +449,4 @@ struct wlan_fr_deauthen {
 	/*-- info elements ----------*/

 };
-
-void wlan_mgmt_encode_beacon(struct wlan_fr_beacon *f);
-void wlan_mgmt_decode_beacon(struct wlan_fr_beacon *f);
-void wlan_mgmt_encode_disassoc(struct wlan_fr_disassoc *f);
-void wlan_mgmt_decode_disassoc(struct wlan_fr_disassoc *f);
-void wlan_mgmt_encode_assocreq(struct wlan_fr_assocreq *f);
-void wlan_mgmt_decode_assocreq(struct wlan_fr_assocreq *f);
-void wlan_mgmt_encode_assocresp(struct wlan_fr_assocresp *f);
-void wlan_mgmt_decode_assocresp(struct wlan_fr_assocresp *f);
-void wlan_mgmt_encode_reassocreq(struct wlan_fr_reassocreq *f);
-void wlan_mgmt_decode_reassocreq(struct wlan_fr_reassocreq *f);
-void wlan_mgmt_encode_reassocresp(struct wlan_fr_reassocresp *f);
-void wlan_mgmt_decode_reassocresp(struct wlan_fr_reassocresp *f);
-void wlan_mgmt_encode_probereq(struct wlan_fr_probereq *f);
-void wlan_mgmt_decode_probereq(struct wlan_fr_probereq *f);
-void wlan_mgmt_encode_proberesp(struct wlan_fr_proberesp *f);
-void wlan_mgmt_decode_proberesp(struct wlan_fr_proberesp *f);
-void wlan_mgmt_encode_authen(struct wlan_fr_authen *f);
-void wlan_mgmt_decode_authen(struct wlan_fr_authen *f);
-void wlan_mgmt_encode_deauthen(struct wlan_fr_deauthen *f);
-void wlan_mgmt_decode_deauthen(struct wlan_fr_deauthen *f);
-
 #endif /* _P80211MGMT_H */
--
2.34.1



