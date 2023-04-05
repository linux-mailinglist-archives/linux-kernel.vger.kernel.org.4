Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B441B6D73E8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 07:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236926AbjDEFsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 01:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjDEFsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 01:48:45 -0400
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC081FEC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 22:48:41 -0700 (PDT)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20230405054839879abfdb55a9e8ffe0
        for <linux-kernel@vger.kernel.org>;
        Wed, 05 Apr 2023 07:48:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=4HQ/5t4h1V7LJfN8OsbuPnPZmtymnOtNckgYd4DfAxE=;
 b=T4gOJLO0EONRcJ/JhF17g7thnU5wmgZ1MRfNRjRSe8lb5VDGp8sMWH+UBGvu67yrB49PXW
 gk1Hyi7XvA8pCFnPFfeoWTO2CWsV0QrYazyVvzAiymXj3By/y7doeRDKQ+uzGlxq+hVDgO8f
 AYBP/QQs4W4/B5TigMY06Pnw9iWIk=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 3/9] tty: n_gsm: add missing description to gsm_config
Date:   Wed,  5 Apr 2023 07:47:24 +0200
Message-Id: <20230405054730.3850-3-daniel.starke@siemens.com>
In-Reply-To: <20230405054730.3850-1-daniel.starke@siemens.com>
References: <20230405054730.3850-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

Currently, all available structure fields in gsmmux.h except those
for gsm_config are commented.

Fix this by adding appropriate comments to the not commented fields.

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 include/uapi/linux/gsmmux.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/uapi/linux/gsmmux.h b/include/uapi/linux/gsmmux.h
index 33ee7b857c52..422a52e184b3 100644
--- a/include/uapi/linux/gsmmux.h
+++ b/include/uapi/linux/gsmmux.h
@@ -8,17 +8,17 @@
 
 struct gsm_config
 {
-	unsigned int adaption;
-	unsigned int encapsulation;
-	unsigned int initiator;
-	unsigned int t1;
-	unsigned int t2;
-	unsigned int t3;
-	unsigned int n2;
-	unsigned int mru;
-	unsigned int mtu;
-	unsigned int k;
-	unsigned int i;
+	unsigned int adaption;	/* Convergence layer type */
+	unsigned int encapsulation; /* Framing (0 = basic option, 1 = advanced option) */
+	unsigned int initiator;	/* Initiator or responder */
+	unsigned int t1;	/* Acknowledgment timer */
+	unsigned int t2;	/* Response timer for multiplexer control channel */
+	unsigned int t3;	/* Response timer for wake-up procedure */
+	unsigned int n2;	/* Maximum number of retransmissions */
+	unsigned int mru;	/* Maximum incoming frame payload size */
+	unsigned int mtu;	/* Maximum outgoing frame payload size */
+	unsigned int k;		/* Window size */
+	unsigned int i;		/* Frame type (1 = UIH, 2 = UI) */
 	unsigned int unused[8];	/* Can not be used */
 };
 
-- 
2.34.1

