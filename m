Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4375614ADD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 13:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiKAMi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 08:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiKAMik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 08:38:40 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4CD60C0
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 05:38:37 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id c25so7110055ljr.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 05:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlF0TxgQdB9El9HMgVNkTNkSGlJ7JQkiUcra0SV3NJs=;
        b=RiuNuV6nMsbcTgUz7pjtL2BQMXHduzlKBqVSBRHcEKIXtt6nlr7VSsLb7k4YT5/yQZ
         WGx2IqMXqzn3eWQpRJuYMPrzBy3wP/fr76BFRBTTEOTwC+7ARRauDtTnwtwL+oJvAmtc
         unDPCbIsyxnmymgUzTRv4XD9KR6YGp8FrrRlFOVHTBN0H1JdkN+vJ55C4zk1YcUtAHbo
         977nnMtd8y5A431ynshkAfwOKwVlvsKjicaeHGzD1Afv47SUYtNxjLc97eZ3grwQfHQ/
         xAxabuXGh1Cuaydtgd8vkweYX14ssjGPbBwOvVbfGpuDckDsitmarZXfxvSIDC0Z+1Nc
         CDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZlF0TxgQdB9El9HMgVNkTNkSGlJ7JQkiUcra0SV3NJs=;
        b=ws+kLTjdQhsKLs/adgjkRua8wgW/eMu1ORxzZb+W/nmdyydX+iG2rqR+eCsi0ZZAJA
         B95fGKMhj7+KA0zgOUSF5PZdMPvChFbilyG2FbQDaQBrg3O2QQacLWGOxrW4HKYBYZNP
         Q6VdjxnKpFAKVUoTYemGrAx5xBzQx36Z0ZXuyZb7Xq35n5+a+mgurba1T1zz/Efk4kIn
         e0WghP9Dp6ofTGjscfgwejnOl1LWBTcD0Q0seBV0B3ryqlLQI7ZBBwlZkalybHo5ttXH
         hCux7oZzUHiwCMNyHDr5uTJo+ysO348mRAScGFDP5Jhncj/sOxe3/cRClx8UWsjrFO3G
         Z/rg==
X-Gm-Message-State: ACrzQf1HWty1p6D+NZSCRqbJniJD8D9TZvNKQk/we2rNsm3wn/0Uu9HC
        NxxHDLonoeo4BjRSnFQkJBIrtBltNkGLFQ==
X-Google-Smtp-Source: AMsMyM7nNIiARjaLTsBqKh2XT1ggp+KS7+iocKtcVW5UZrOI+mCtoJ//DXkSrajuYUgAQEspsj0ziw==
X-Received: by 2002:a2e:9018:0:b0:277:a4e:98f2 with SMTP id h24-20020a2e9018000000b002770a4e98f2mr829467ljg.358.1667306316170;
        Tue, 01 Nov 2022 05:38:36 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id p21-20020a2eb7d5000000b0026e897e3236sm1771625ljo.6.2022.11.01.05.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 05:38:35 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH v2 2/2] Join some lines of code to avoid code lines ending in (
Date:   Tue,  1 Nov 2022 12:38:00 +0000
Message-Id: <04122308bf02e5c99329f120fe076bcffc16b08f.1667305446.git.tanjubrunostar0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1667305446.git.tanjubrunostar0@gmail.com>
References: <cover.1667305446.git.tanjubrunostar0@gmail.com>
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

