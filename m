Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F8A60BD10
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiJXWF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiJXWE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:04:59 -0400
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7D4E8A81
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:18:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1666614565; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Z1UjISTTBTJriGtOGwVfmm4xDKmMfGSo7eF5ZJFQ7ZthmJfU4oGgmK046VZzDi3OPU3MN2eAHWFZvrBzR55pU/337h7Z0TzrujAOeBZYiKkGvsk0K+r9Y4iGGi0wKdJvUNqZ0BHicsywO6KVLZJca7EzsOhhYPwvhij+JeIHh2U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1666614565; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=YV9zJPe6BANe+bzugKZ5KDDx8ZPaPgjC4e23vXABmow=; 
        b=Gpd9ur68GS5uddMySDDf+mmnL4+oYph84x47GZL+H9QTIpwOz5ztJ0CysLXIdgbLc15XqP6F/cgrkhCVsc0Rj3UACITPNQxbnnCm/YRjD2zcIclNYoTmvHCJAlwmPpNuWLJ8eckwVbfCyyzF5BW9qFN5kaVjzq3s1wfzwHOg9h8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=t4rmin@zohomail.com;
        dmarc=pass header.from=<t4rmin@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1666614565;
        s=zm2022; d=zohomail.com; i=t4rmin@zohomail.com;
        h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
        bh=YV9zJPe6BANe+bzugKZ5KDDx8ZPaPgjC4e23vXABmow=;
        b=dFjIWCt2nMc/T9Ob7cj2zSMeGCOPiwJkY7SLkaqrprViy9E/b6RKiNVVcQ78p38W
        lnxdHJPX8PU831G3eJ28j8JGOKkWpKoDbNTPd9oLEW4elW/Aqgvc8o4Ur/W77hrkLZ+
        mToE//X8yG7A+/F+ggKOLd4Tyd0s8G/6lqYpAByo=
Received: from plymouth (103.47.132.34 [103.47.132.34]) by mx.zohomail.com
        with SMTPS id 1666614562915951.1430752958858; Mon, 24 Oct 2022 05:29:22 -0700 (PDT)
Date:   Mon, 24 Oct 2022 19:29:14 +0700
From:   Aaron Lawrence <t4rmin@zohomail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] Staging: rtl8192e: rtllib_tx: fixed lines ending with an
 open parenthesis
Message-ID: <a8e67d281b4e9ab1254e0b58294f566994ac7d9d.1666612946.git.t4rmin@zohomail.com>
References: <cover.1666612946.git.t4rmin@zohomail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1666612946.git.t4rmin@zohomail.com>
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed several lines that end with an open parenthesis to not end
with it anymore, as per the Linux kernel coding-style regulations.
The issues were flagged by the checkpatch script.

Signed-off-by: Aaron Lawrence <t4rmin@zohomail.com>
---
 drivers/staging/rtl8192e/rtllib_tx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index fa998cd76917..4647efb0f868 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -802,8 +802,8 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 			 * MOREFRAGS bit to the frame control
 			 */
 			if (i != nr_frags - 1) {
-				frag_hdr->frame_ctl = cpu_to_le16(
-					fc | RTLLIB_FCTL_MOREFRAGS);
+				frag_hdr->frame_ctl = cpu_to_le16(fc |
+								  RTLLIB_FCTL_MOREFRAGS);
 				bytes = bytes_per_frag;
 
 			} else {
@@ -822,9 +822,9 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 			}
 			/* Put a SNAP header on the first fragment */
 			if (i == 0) {
-				rtllib_put_snap(
-					skb_put(skb_frag, SNAP_SIZE +
-					sizeof(u16)), ether_type);
+				rtllib_put_snap(skb_put(skb_frag,
+							SNAP_SIZE +
+							sizeof(u16)), ether_type);
 				bytes -= SNAP_SIZE + sizeof(u16);
 			}
 
-- 
2.38.1

