Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B39617D81
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbiKCNHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiKCNHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:07:05 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7CB14D08;
        Thu,  3 Nov 2022 06:06:22 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id cl5so2653995wrb.9;
        Thu, 03 Nov 2022 06:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fxui20KvNriC9XitvtEzDQZsPD1wh2iQuea1gk/77Mw=;
        b=pB//Raqfkxykfv8IuPbNdoswD4V05DPzrriADnM/RRLIyHcvyN0jjiqPuRoH/dQXIL
         Th4Y19P+XSS3Gd9UmX+ipgYtJnfClI2Y8ZFZM1xl0WD95N38b7iK9dBGzZ7oLtCWhOV8
         o4lBfF/z8NDMC7/G1UybmUMM3mTcVRShaQ0FGyOzzAP5wQ8ICoGdM5KhfAjDtVj522jS
         M4QnoXdKc2wIkOCETz1eQXWRN4p1krgK84w0Hj+t43sYhWxqjFDfq4TbmX1g/vSa1Ygz
         ec5GpNt7YfIuY9jQEm66QYVh8KVaUryAyZXNio4i24MEUKvOjrEoxJ0YFHO5bUK9ZSy8
         0ZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fxui20KvNriC9XitvtEzDQZsPD1wh2iQuea1gk/77Mw=;
        b=S4rFGSnUlrvUMJhXF6G4m8NR3QteS0VgKiJ4EtG5tZobQUmYYNntDo31LO28i3vVOc
         CYweyI4iRd+Slq3iOYlos64EY1TQQU5W9eqy/PdzHcK1wlYZyiXoxcn5NwZwx/6zJmwT
         TNUIoCjS0IlBsaYGE/OzBi4HS9CjVMOsRS8KOLZ2bO/US1L7v52g4D3TJZNaIn3SUnuP
         H/NraOnEu4CnI9sPzOl1Ptb3Ju7EN10cqRVz5OKIw6Wqija9gouPdQ8m02S4FY3GZCci
         ouncTwsHwQrQJ/a2Qn9F1hGMzpLihdJPZrVO3ECIxBmJiRd0oIjWby6pIUMyEoVqMkn2
         C4aQ==
X-Gm-Message-State: ACrzQf2g4LXHdtmvEfGsqvZA4fBQp3nU0h5tW0HmGa0jIKk08lNoXt2s
        LrNLH6jS76jH543X/psb6nY=
X-Google-Smtp-Source: AMsMyM55qyrSvfMGDqYrZzEgYnch4RFuC18ZSjNjhAWLi6kk7whlNNYZmbQFnW2jM5ixRoU4RgKOcw==
X-Received: by 2002:a5d:4008:0:b0:235:a4c4:97c2 with SMTP id n8-20020a5d4008000000b00235a4c497c2mr19201064wrp.295.1667480781075;
        Thu, 03 Nov 2022 06:06:21 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id w12-20020a05600c474c00b003b4a699ce8esm5608162wmo.6.2022.11.03.06.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:06:20 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Aaron Lawrence <t4rmin@zohomail.com>,
        Yogesh Hegde <yogi.kernel@gmail.com>,
        linux-staging@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] staging: rtl8192e: rtl819x_HTProc: make arrays const and one static
Date:   Thu,  3 Nov 2022 13:06:19 +0000
Message-Id: <20221103130619.78413-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make two dead-only arrays const. Make array EWC11NHTCap static const
so it is not populated on the stack, makes the code smaller too.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 62aa8e893c34..84ec8df047d7 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -282,7 +282,7 @@ void HTConstructCapabilityElement(struct rtllib_device *ieee, u8 *posHTCap,
 	memset(posHTCap, 0, *len);
 
 	if ((bAssoc) && (pHT->ePeerHTSpecVer == HT_SPEC_VER_EWC)) {
-		u8	EWC11NHTCap[] = {0x00, 0x90, 0x4c, 0x33};
+		static const u8	EWC11NHTCap[] = { 0x00, 0x90, 0x4c, 0x33 };
 
 		memcpy(posHTCap, EWC11NHTCap, sizeof(EWC11NHTCap));
 		pCapELE = (struct ht_capab_ele *)&posHTCap[4];
@@ -515,8 +515,8 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 	u16 nMaxAMSDUSize = 0;
 	u8 *pMcsFilter = NULL;
 
-	static u8 EWC11NHTCap[] = {0x00, 0x90, 0x4c, 0x33};
-	static u8 EWC11NHTInfo[] = {0x00, 0x90, 0x4c, 0x34};
+	static const u8 EWC11NHTCap[] = { 0x00, 0x90, 0x4c, 0x33 };
+	static const u8 EWC11NHTInfo[] = { 0x00, 0x90, 0x4c, 0x34 };
 
 	if (!pHTInfo->bCurrentHTSupport) {
 		netdev_warn(ieee->dev, "%s(): HT_DISABLE\n", __func__);
-- 
2.38.1

