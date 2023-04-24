Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0676EC6AE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 09:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjDXHCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 03:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjDXHCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 03:02:02 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFDE3C13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 00:01:54 -0700 (PDT)
Received: by gandalf.ozlabs.org (Postfix, from userid 1003)
        id 4Q4bf40HmZz4xFq; Mon, 24 Apr 2023 17:01:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
        s=201707; t=1682319708;
        bh=swC5YCfO3+z51GtfmHcqJiyOiKdX/kgn4ysrjJoj/0w=;
        h=Date:From:To:Cc:Subject:From;
        b=aS0+eqn3h3ORUCSEfo0hD2VlwLT8bO88+cVMV/G5sE4c3T+M4cgdRY49zgIdWlZDH
         jpKNavRjOEN10O8CqNo+2QOfaf2KjzP9xwjDUwnjgzmnEaebsWNEz3DhL6BlCOniw/
         5NJ+YgWa75ej6aVov+2JcDkuPMVxBvlzq1qIqmoWYDGtxXaHlskPATQRDG2kHzPxmd
         vlvX4WYiFRr/2FK3Q+kuRAB0rLlW1y+ed2EDT9oEjEuaJFK465RwZrFpqzq8PvnwXK
         KpCYnE1e+8SO9qVYApc+aeyfnORCOLXDqzQR0nUotyv0U2OFa5sWs6yJBDQl0gmhku
         aZqMAIDYDz/uA==
Date:   Mon, 24 Apr 2023 17:01:32 +1000
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] mailmap: Add entries for Paul Mackerras
Message-ID: <ZEYpTAufVHTvsO1n@cleo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index 6686879ce0d5..d3a6776706f7 100644
--- a/.mailmap
+++ b/.mailmap
@@ -375,6 +375,8 @@ Paul E. McKenney <paulmck@kernel.org> <paul.mckenney@linaro.org>
 Paul E. McKenney <paulmck@kernel.org> <paulmck@linux.ibm.com>
 Paul E. McKenney <paulmck@kernel.org> <paulmck@linux.vnet.ibm.com>
 Paul E. McKenney <paulmck@kernel.org> <paulmck@us.ibm.com>
+Paul Mackerras <paulus@ozlabs.org> <paulus@samba.org>
+Paul Mackerras <paulus@ozlabs.org> <paulus@au1.ibm.com>
 Peter A Jonsson <pj@ludd.ltu.se>
 Peter Oruba <peter.oruba@amd.com>
 Peter Oruba <peter@oruba.de>
-- 
2.39.2

