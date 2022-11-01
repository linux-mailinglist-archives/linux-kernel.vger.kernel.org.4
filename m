Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7396F61484B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 12:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiKALO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 07:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiKALOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 07:14:52 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F0F19C1D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 04:14:49 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id t4so9997597lfp.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 04:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Et0dLu8NcqFUEiFUqF09J+RIhc7UoMo0suIjCPp+COE=;
        b=Q2PtqRY6KrwP3n9DeLyFElWkTzB87jb7VOfbmqYF6zUGhNijk0IPeJ8TzNKBQuq1F9
         5UlQdtvRnaa6lhyLRHphzhkTQ1K4VjmL6NJ/taHrsvKQaZayYFmiA7YjS7DcTGup/8+v
         okq5l1ps1vTd1KP1wMYGMv43RfKXjWdelFUXgTHgg4WBQzpUVl7diPrXdtsH5zOKkK5i
         9n9WEcLn/LOyXmQafS0bqlKM59MMrRC5tizDeboWNSUN0nRFLZrgwifeVyHOg5L4xUZr
         GI9HWnPKEzUs0YTGLd7rR2jHQMx/vLjkg2+kDGjgzFvCqXi/JwmGgzf9kO8/Gypi9BZg
         PQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Et0dLu8NcqFUEiFUqF09J+RIhc7UoMo0suIjCPp+COE=;
        b=pKdqTwG3NoaPAX0fX2Dcw5EB1+Ob0u8GQdREh6RAjQTUtfRz5hT4IQu/SNlC+mnw4P
         AR6u38Jb+cZIY1S0RXW8ZBHPDMhvyK4LHp/pT+hK3CSE8kBTN8kbkTx45BugvMhmeiSV
         f5vp7owo8bZaVmyrekcTCe2Cvu1fM0HLmwi2gestg8C+rwWj3NTSGmQSn8jGnN1NSyw3
         0UZ7tpSMFrGLqOzFv8zlE9exWZ5yED/pkS8jgcIPEJxu6WbJ2W6nzutzi9Lu0k3bc2Kz
         JyjcF20INrQ6sCabg2VciPfq7rN971iUYW/kGl74clGNx4DryuB51ZTN9ZTjd6PKeLF3
         83pA==
X-Gm-Message-State: ACrzQf2uDNbyIHDS3ho0eYi34unI6e0ShftGIZxeu+KkJSnn8KMQZD2J
        sbu4MNq9e2BKqDQwNQX/k2Q=
X-Google-Smtp-Source: AMsMyM6aGUKbqF8nu2opQO8Hniz97PYjbfRKBgkjR7bJJweSp6d8uOuPN9u/iraFIINPAmdpG60aiA==
X-Received: by 2002:a19:ad03:0:b0:4a0:56ab:7148 with SMTP id t3-20020a19ad03000000b004a056ab7148mr7796171lfc.430.1667301287906;
        Tue, 01 Nov 2022 04:14:47 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id e17-20020a05651236d100b0048af3c090f8sm1629472lfs.13.2022.11.01.04.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 04:14:47 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH 2/2] Join some lines of code to avoid a line ending in a (
Date:   Tue,  1 Nov 2022 11:13:29 +0000
Message-Id: <1da74119d5a50ef97e68f26c82c9c9e429f8d0ec.1667300134.git.tanjubrunostar0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1667300134.git.tanjubrunostar0@gmail.com>
References: <cover.1667300134.git.tanjubrunostar0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code line ends with a '(' which is not allowed in
Linux kernel coding. Joining the lines and indenting
correctly improves visibility

Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
---
 drivers/staging/vt6655/rxtx.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index d7e439cd8675..df7473155704 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -555,19 +555,15 @@ s_uFillDataHead(
 	return buf->duration;
 }
 
-static
-void
-s_vFillRTSHead(
-	struct vnt_private *pDevice,
-	unsigned char byPktType,
-	void *pvRTS,
-	unsigned int cbFrameLength,
-	bool bNeedAck,
-	bool bDisCRC,
-	struct ieee80211_hdr *hdr,
-	unsigned short wCurrentRate,
-	unsigned char byFBOption
-)
+static void fill_rts_head(struct vnt_private *pDevice,
+			  unsigned char byPktType,
+			  void *pvRTS,
+			  unsigned int cbFrameLength,
+			  bool bNeedAck,
+			  bool bDisCRC,
+			  struct ieee80211_hdr *hdr,
+			  unsigned short wCurrentRate,
+			  unsigned char byFBOption)
 {
 	unsigned int uRTSFrameLen = 20;
 
-- 
2.34.1

