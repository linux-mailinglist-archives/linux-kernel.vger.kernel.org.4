Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651E4615165
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 19:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiKASSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 14:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiKASSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 14:18:08 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B8F1A215
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 11:18:07 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id f37so24559407lfv.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 11:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGATexOV6vnPuB2p8dA7jNyMLlzx3cNJwqnDQnqy0Lw=;
        b=NICToIixUPdDC32HkPXSHGZ1OMrDXhb4jM2cPeHaAvS2JEaa2zUnm66gEKccp1vn6q
         TJe9bqk7bU677eyWlRrS1UOuV8IIvBlHe92LgKfoWwoQSo80n4gBq89IHxby2/KdSPk4
         7xAwjrBbqSFqWH+wEWb/BVyMowVJ73LYiihQVyyfEUr+jjjy9JUypFrR5Z62pGFsVoM5
         GjjzCGUT6FrUHfLa15E2lh5lEk4yFd2VPqGv9A+zq/JicOzxi6Xxz0vlly4AkgsRKqs+
         +WYcSWDqz9W42R9Obd0vuaVkuChUbSD4relDbwEAnFVbBtkO8kwZKei57JNKspdUXmqe
         HfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGATexOV6vnPuB2p8dA7jNyMLlzx3cNJwqnDQnqy0Lw=;
        b=s21GQjilxgzx3NOKpsRp++7SdA+u9TOe8XOdEMO5CGfVC4KxNWiEWarCm2Kw/8flDI
         kIEUbGZbD72DY1d8El+GmqwMa25XA8sRmR0gPkt989YI3UoEpReBh+tlfDxBMGM6oizN
         ay6dyfpQxe4sewlIgorUMPB79mKjxbfcrc3ELEQKGLcXt7hyuG8+Nft1/XZgigUXnSzy
         YW2fefOQxo2O61LP4H0lS+FQ9t10vk4UrfcyT1b9i+zONWCXIodLLGn9iAAZBIlZREUC
         snls6Rc8zf+hg/yXilq8Er8fbwBOtoNFNEhZZZpFxSUABDubJP7eJaslS2sD0I3qwdtd
         dVQQ==
X-Gm-Message-State: ACrzQf0GD7JxG4bq3ie8KBKgJmoDNGkOBNFx3aT7R6pP1v7HdrNXJ7ti
        Pp/6EUXkP92cq5sPB91atDc=
X-Google-Smtp-Source: AMsMyM5vxq7beSkQn4ZNXzOnIzBhVzpDtibz5gLX1Urhz4O4JUcKpGt/nmGCQtS0K+bpPG5SFLqHEQ==
X-Received: by 2002:ac2:5193:0:b0:4ab:db5d:10f0 with SMTP id u19-20020ac25193000000b004abdb5d10f0mr7574671lfi.225.1667326686066;
        Tue, 01 Nov 2022 11:18:06 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id 190-20020a2e05c7000000b0026f9cb6d10fsm1850601ljf.45.2022.11.01.11.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 11:18:05 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH v3 2/2] staging: vt6655: Join some lines of code to avoid code lines ending in (
Date:   Tue,  1 Nov 2022 18:17:49 +0000
Message-Id: <4433970c86a4d1bf9e3af5d6c34eb972f7be26e9.1667326000.git.tanjubrunostar0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1667326000.git.tanjubrunostar0@gmail.com>
References: <cover.1667326000.git.tanjubrunostar0@gmail.com>
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

