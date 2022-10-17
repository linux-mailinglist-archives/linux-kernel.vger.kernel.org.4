Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBCC60136F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 18:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiJQQ26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 12:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiJQQ2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 12:28:54 -0400
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1EF6EF29
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666024120; bh=QfjybwoxOuA8i9Q0zqRIu7a6CZS8N+C1Jz7hm5aM5II=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=MtZwnz9Oqzh0Nl5gD3BKivB8gyTCYZAg82dY6ouZEuVUE8eGAismFYzgANBhbLHzz
         pf2T7/3MMsVko3Zdbbmewj6+95iFI3ZZoyUP2syxVRAax/fq8wOOQzMBOD9sX1fThC
         kr5xmeWZT92A7pMAZyWK2Z/c9TrrYW7DNlpZScmo=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via [213.182.55.206]
        Mon, 17 Oct 2022 18:28:40 +0200 (CEST)
X-EA-Auth: KENaI594nP0uTNiflLgkiiBWvfB5TWZJGLFdmlgJguIsJVOeAV6lv1JUFm9TthsRwtJKj2x7X9z4ZR2twbV+YnfNtjW//BZC
Date:   Mon, 17 Oct 2022 21:29:06 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, paskripkin@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     kumarpraveen@linux.microsoft.com, saurabh.truth@gmail.com
Subject: [PATCH v1 2/4] staging: r8188eu: reformat long computation lines
Message-ID: <5c3c0ef7c90ab2eec73067e1dd88f337932363e3.1666021212.git.drv@mailo.com>
References: <cover.1666021212.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1666021212.git.drv@mailo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reformat long running computation instructions to improve code readability.
Address checkpatch script complaints like:
	CHECK: line length of 171 exceeds 100 columns

Signed-off-by: Deepak R Varma <drv@mailo.com>
---

Changes in v1:
   1. Further improve the formatting per feedback from gregkh@linuxfoundation.org


 drivers/staging/r8188eu/core/rtw_br_ext.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index 79daf8f269d6..8b1c9fdf6ed2 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -211,8 +211,9 @@ static int __nat25_network_hash(unsigned char *network_addr)
 	} else if (network_addr[0] == NAT25_IPX) {
 		unsigned long x;

-		x = network_addr[1] ^ network_addr[2] ^ network_addr[3] ^ network_addr[4] ^ network_addr[5] ^
-			network_addr[6] ^ network_addr[7] ^ network_addr[8] ^ network_addr[9] ^ network_addr[10];
+		x = network_addr[1] ^ network_addr[2] ^ network_addr[3] ^ network_addr[4] ^
+		    network_addr[5] ^ network_addr[6] ^ network_addr[7] ^ network_addr[8] ^
+		    network_addr[9] ^ network_addr[10];

 		return x & (NAT25_HASH_SIZE - 1);
 	} else if (network_addr[0] == NAT25_APPLE) {
@@ -224,16 +225,18 @@ static int __nat25_network_hash(unsigned char *network_addr)
 	} else if (network_addr[0] == NAT25_PPPOE) {
 		unsigned long x;

-		x = network_addr[0] ^ network_addr[1] ^ network_addr[2] ^ network_addr[3] ^ network_addr[4] ^ network_addr[5] ^ network_addr[6] ^ network_addr[7] ^ network_addr[8];
+		x = network_addr[0] ^ network_addr[1] ^ network_addr[2] ^ network_addr[3] ^
+		    network_addr[4] ^ network_addr[5] ^ network_addr[6] ^ network_addr[7] ^
+		    network_addr[8];

 		return x & (NAT25_HASH_SIZE - 1);
 	} else if (network_addr[0] == NAT25_IPV6) {
 		unsigned long x;

-		x = network_addr[1] ^ network_addr[2] ^ network_addr[3] ^ network_addr[4] ^ network_addr[5] ^
-			network_addr[6] ^ network_addr[7] ^ network_addr[8] ^ network_addr[9] ^ network_addr[10] ^
-			network_addr[11] ^ network_addr[12] ^ network_addr[13] ^ network_addr[14] ^ network_addr[15] ^
-			network_addr[16];
+		x = network_addr[1] ^ network_addr[2] ^ network_addr[3] ^ network_addr[4] ^
+		    network_addr[5] ^ network_addr[6] ^ network_addr[7] ^ network_addr[8] ^
+		    network_addr[9] ^ network_addr[10] ^ network_addr[11] ^ network_addr[12] ^
+		    network_addr[13] ^ network_addr[14] ^ network_addr[15] ^ network_addr[16];

 		return x & (NAT25_HASH_SIZE - 1);
 	} else {
--
2.30.2



