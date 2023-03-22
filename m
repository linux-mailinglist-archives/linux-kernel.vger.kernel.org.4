Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C686E6C3F5B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 01:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjCVAwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 20:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjCVAwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 20:52:38 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97DD4D600
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 17:52:34 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 21EFA5C012E;
        Tue, 21 Mar 2023 20:52:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 21 Mar 2023 20:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1679446354; x=1679532754; bh=m
        M1zZpfBWD0rrswUszC5U0DSWjt2tLXLYT7+poL8Rg0=; b=pI6vQpx9EgLqMYzVr
        y0phS/05kt5s5+iZn/6H7mo5G9a+9gCzwufpHAQKNnm36nTIzn6NuLUot6LA4b1W
        rOn/iVsYGGD3O8Scf90fuXPNNgyBXWNSeXDLqzLqyKrLU7pG0mZ0IrL5CPUjYs/1
        7a7/Kn0Rm/X/oO3JX15X6zkvjr/VLGBVxVzSU46SeEQvfb5Hbt00tBTc+O/kOG9U
        hckU6z1ry7skCW/d459htpMqEBkn5iGkUNcq9fFYLzAoGsmebvkA8g27c8xH2BUK
        Vzd6/jF/5C/2+x9dF/sW5dzcu0wFcMm4sxFCTilplc5fuP4KqDXxnb/aF4H8zXlt
        mLLvw==
X-ME-Sender: <xms:UVEaZIqelnKK0eKDNKT0YDZnUrDbeLO3qGyx5hCiVJum5ng_l9sjWg>
    <xme:UVEaZOqYvzeLrxwoahjtG6F2woze4YW_SipKBGRP_Q9uksZ12a26aL6T86VVVoJtj
    WlBlU6yd7XjisarOTM>
X-ME-Received: <xmr:UVEaZNOvDruYZDDl6qqgAz-Lw0kyP-kxNkImfNf91AnfXfSD999vLgAR1bjhBgh2aoPwuja5deVrOgtXGPOtoc5j4GC4WFk4X5M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeguddgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepvfevkffhufffsedttdertddttddtnecuhfhrohhmpefhihhnnhcuvfhhrghi
    nhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtthgvrh
    hnpeehfffggeefveegvedtiefffeevuedtgefhueehieetffejfefggeevfeeuvdduleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrg
    hinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:UlEaZP7anyzeAz5Gs8FJ-9mQaqTwxI-5Juu14nYeOUzr3gbT8AFuqQ>
    <xmx:UlEaZH42PAHuWahjxiEqVgBV-LweAw0-zzz-I5oc_EHMyBaatK7JQw>
    <xmx:UlEaZPgDp6DOy2KhjfhpM1S8lhe_lTZeDDWXvz6Q50IkqYN7ozI1xA>
    <xmx:UlEaZEjU5NpiFkr-kn5JgxovQVx4OlJCesB8lbRmLAal58RfZwRPGw>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Mar 2023 20:52:30 -0400 (EDT)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <4f5e5d058c21270ebf31609a71c2b800fd99fa93.1679446472.git.fthain@linux-m68k.org>
From:   Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH] nubus: Avoid scanning "private" card resources
Date:   Wed, 22 Mar 2023 11:54:32 +1100
X-Spam-Status: No, score=-0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Nubus cards have many ROM resources. A single Radius video card
produced well over a thousand entries under /proc/bus/nubus. Populating
/proc/bus/nubus on a slow machine with several such cards installed takes
long enough that the user may think that the system is wedged. All those
procfs entries also consume significant RAM though they are not normally
needed except by developers. Omit the "private" resources from
/proc/bus/nubus/ by default and add a kernel parameter to enable them
when needed. On the test machine, this saved 196 KiB and 5 seconds.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/nubus/nubus.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/nubus/nubus.c b/drivers/nubus/nubus.c
index f70ba58dbc55..777099b8e818 100644
--- a/drivers/nubus/nubus.c
+++ b/drivers/nubus/nubus.c
@@ -34,6 +34,9 @@
 
 LIST_HEAD(nubus_func_rsrcs);
 
+bool all_func_rsrcs;
+module_param(all_func_rsrcs, bool, 0444);
+
 /* Meaning of "bytelanes":
 
    The card ROM may appear on any or all bytes of each long word in
@@ -572,9 +575,9 @@ nubus_get_functional_resource(struct nubus_board *board, int slot,
 			nubus_proc_add_rsrc(dir.procdir, &ent);
 			break;
 		default:
-			/* Local/Private resources have their own
-			   function */
-			nubus_get_private_resource(fres, dir.procdir, &ent);
+			if (all_func_rsrcs)
+				nubus_get_private_resource(fres, dir.procdir,
+							   &ent);
 		}
 	}
 
-- 
2.37.5

