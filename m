Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B0E601086
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiJQNwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiJQNwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:52:40 -0400
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980221C125
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 06:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666014744; bh=oYVwPDhXlI3Y4t67S9SXV2J/p4NYzrT/hdmHZXrTn7A=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=hvlC17puZA5L1lKIYDi5h5K/Byf14bivO7iCwpO0l0IZTgEVy81+YNIn/wtUNEfDw
         muhD3Iq+bpqBGNd4ZjsfJI/+IUSOXvocujRDbCk78McMlQxMUvErtspeVJ9V2E0z8V
         eTXKTO6g1DHCmQqXzSymGrntRSV8DFv41PceR4CI=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via [213.182.55.206]
        Mon, 17 Oct 2022 15:52:24 +0200 (CEST)
X-EA-Auth: dh3puqb9svTS10k+Nb9Vk8Bw4QeB0YC0aC3X5FK0Xu9oWOTuOSqm9EvVedcOtwE1VhO6BpMlPSPi9xH1mnk2PS2tXCzE19vJ
Date:   Mon, 17 Oct 2022 18:52:50 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, paskripkin@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     kumarpraveen@linux.microsoft.com, saurabh.truth@gmail.com
Subject: [PATCH 2/4] staging: r8188eu: reformat long computation lines
Message-ID: <2dd27eff9aab5ffe31e61086c0584982794507cf.1666011479.git.drv@mailo.com>
References: <cover.1666011479.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1666011479.git.drv@mailo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reformat long running computation instructions to improve code readability.
Address following checkpatch script complaints:
	CHECK: line length of 171 exceeds 100 columns
	CHECK: line length of 113 exceeds 100 columns

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/staging/r8188eu/core/rtw_br_ext.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index 79daf8f269d6..427da7e8ba4c 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -211,8 +211,10 @@ static int __nat25_network_hash(unsigned char *network_addr)
 	} else if (network_addr[0] == NAT25_IPX) {
 		unsigned long x;

-		x = network_addr[1] ^ network_addr[2] ^ network_addr[3] ^ network_addr[4] ^ network_addr[5] ^
-			network_addr[6] ^ network_addr[7] ^ network_addr[8] ^ network_addr[9] ^ network_addr[10];
+		x = network_addr[1] ^ network_addr[2] ^ network_addr[3] ^
+		    network_addr[4] ^ network_addr[5] ^ network_addr[6] ^
+		    network_addr[7] ^ network_addr[8] ^ network_addr[9] ^
+		    network_addr[10];

 		return x & (NAT25_HASH_SIZE - 1);
 	} else if (network_addr[0] == NAT25_APPLE) {
@@ -224,16 +226,20 @@ static int __nat25_network_hash(unsigned char *network_addr)
 	} else if (network_addr[0] == NAT25_PPPOE) {
 		unsigned long x;

-		x = network_addr[0] ^ network_addr[1] ^ network_addr[2] ^ network_addr[3] ^ network_addr[4] ^ network_addr[5] ^ network_addr[6] ^ network_addr[7] ^ network_addr[8];
+		x = network_addr[0] ^ network_addr[1] ^ network_addr[2] ^
+		    network_addr[3] ^ network_addr[4] ^ network_addr[5] ^
+		    network_addr[6] ^ network_addr[7] ^ network_addr[8];

 		return x & (NAT25_HASH_SIZE - 1);
 	} else if (network_addr[0] == NAT25_IPV6) {
 		unsigned long x;

-		x = network_addr[1] ^ network_addr[2] ^ network_addr[3] ^ network_addr[4] ^ network_addr[5] ^
-			network_addr[6] ^ network_addr[7] ^ network_addr[8] ^ network_addr[9] ^ network_addr[10] ^
-			network_addr[11] ^ network_addr[12] ^ network_addr[13] ^ network_addr[14] ^ network_addr[15] ^
-			network_addr[16];
+		x = network_addr[1] ^ network_addr[2] ^ network_addr[3] ^
+		    network_addr[4] ^ network_addr[5] ^ network_addr[6] ^
+		    network_addr[7] ^ network_addr[8] ^ network_addr[9] ^
+		    network_addr[10] ^ network_addr[11] ^ network_addr[12] ^
+		    network_addr[13] ^ network_addr[14] ^ network_addr[15] ^
+		    network_addr[16];

 		return x & (NAT25_HASH_SIZE - 1);
 	} else {
--
2.30.2



