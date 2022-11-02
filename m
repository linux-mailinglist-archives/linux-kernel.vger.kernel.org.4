Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24D5616480
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 15:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbiKBOJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 10:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbiKBOJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 10:09:20 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D829D11B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 07:09:18 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id b2so28417678lfp.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 07:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGATexOV6vnPuB2p8dA7jNyMLlzx3cNJwqnDQnqy0Lw=;
        b=QWREUQ+MIJRrxRHUnzmPUZtlJTHGq5/FaclL+DWpDyQxxqT/i5uu7XBDF76Uu6ajEe
         mf70HZLIapmkvb4+0bHS/y5X4Kt5QNaT90iNT8cn28CK+wWYVDGLODeERdzPjDn6nH8B
         xUYbtJoJPPwm6imgVr85phnsbZZk3C8HA9iC4Nj7zscE/OmRpEpJanP2ikBDWsnw9hZs
         YEQt4G3pLPP444oE9TZgGXFi9iTY9WDNZryx2RPXh52I3SsiCVBOpRoLHitQyCK2DOon
         OtjJeEIAEk7eCAw3CVyFjTKe9Rm2NWBIbH0HI5ovY68pGGKOF9QZPBgikz9KAmh1lOum
         iDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGATexOV6vnPuB2p8dA7jNyMLlzx3cNJwqnDQnqy0Lw=;
        b=p0E8htpetoA9J3QWAZniezrUDMeuyYNNBEdRaztsIzFaE8VTerCI80yQ7xLal3jkNP
         zj7znMCj39x9jhFJm+cxj6/29eJSEZOfJvo4Ag6NTKPPK482yaDi4tWyNWZOMg60UZzM
         VuZIGjoLoeWCDgaW48W3A1ps9IMlbEf5KjvZqzS8s5nL+utcFLHDi/q1DkxgGHovNvcL
         3HLa8G/2m2wyZ4u7Dj+v0Hl/P5Hljfl91Su1Zul0/cWcpqptaeWEyKO5UEGz4jQsm5fS
         G5R8P0MgrgBDQAruvwjpt0Th3wDSmafDFHkbKR7jp7KhWTXaEYgl+ifc2KxyEa9xn/Sd
         j2dA==
X-Gm-Message-State: ACrzQf3r/X7irzg/30a7K+GLKgup4SRLZ/mHC+2K64KJDKzgZsqcHCJk
        SLhj8IPMZ/ChpvBYBJApGHI=
X-Google-Smtp-Source: AMsMyM7xppK3b50AM2XFDO4L4Ca+NPGXo1QFwfnB5fOVrd6kV2dssjPBwKExCJZN7sIZMIelaoy6bQ==
X-Received: by 2002:ac2:446b:0:b0:4a2:7e14:933d with SMTP id y11-20020ac2446b000000b004a27e14933dmr9134935lfl.338.1667398156338;
        Wed, 02 Nov 2022 07:09:16 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id bj12-20020a2eaa8c000000b0026e0434eb1esm119503ljb.67.2022.11.02.07.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 07:09:16 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH V4 2/2] staging: vt6655: Join some lines of code to avoid code lines ending in (
Date:   Wed,  2 Nov 2022 14:08:48 +0000
Message-Id: <1026afe9c4c358b7b8a9fac62833ee62d2f4f9b5.1667397591.git.tanjubrunostar0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1667397591.git.tanjubrunostar0@gmail.com>
References: <cover.1667397591.git.tanjubrunostar0@gmail.com>
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

Fix checkpatch error related to code line ends with a '(', by joining
some lines and indenting correctly. This improves visibility

Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
---
 drivers/staging/vt6655/rxtx.c | 40 ++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index c01fc1a593f3..debc5d5daede 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -85,15 +85,15 @@ static const unsigned short fb_opt1[2][5] = {
 #define DATADUR_A_F1    13
 
 /*---------------------  Static Functions  --------------------------*/
-static void fill_rts_head(struct vnt_private *pDevice,
-			  unsigned char byPktType,
-			  void *pvRTS,
-			  unsigned int	cbFrameLength,
-			  bool bNeedAck,
-			  bool bDisCRC,
-			  struct ieee80211_hdr *hdr,
-			  unsigned short wCurrentRate,
-			  unsigned char byFBOption);
+static void fill_rts_header(struct vnt_private *pDevice,
+			    unsigned char byPktType,
+			    void *pvRTS,
+			    unsigned int	cbFrameLength,
+			    bool bNeedAck,
+			    bool bDisCRC,
+			    struct ieee80211_hdr *hdr,
+			    unsigned short wCurrentRate,
+			    unsigned char byFBOption);
 
 static void s_vGenerateTxParameter(struct vnt_private *pDevice,
 				   unsigned char byPktType,
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
+static void fill_rts_header(struct vnt_private *pDevice,
+			    unsigned char byPktType,
+			    void *pvRTS,
+			    unsigned int cbFrameLength,
+			    bool bNeedAck,
+			    bool bDisCRC,
+			    struct ieee80211_hdr *hdr,
+			    unsigned short wCurrentRate,
+			    unsigned char byFBOption)
 {
 	unsigned int uRTSFrameLen = 20;
 
-- 
2.34.1

