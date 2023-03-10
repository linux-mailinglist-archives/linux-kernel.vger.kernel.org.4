Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14096B351B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 05:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjCJECJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 23:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjCJEBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 23:01:39 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5800103ED4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 20:01:26 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id a2so4302069plm.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 20:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678420886;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OkeU/XIvYLV7i/BgDe2gN+ETpxPN9Z7bVS2VtFVoXBQ=;
        b=VmwKFKxsj4V7DC/N7M+8Yp58I1Pd7coa9KKLGavkX4MwK+VBg/TTQJtfJRzTywrLPO
         nFBbSmUUomVQVkKzK3pLbK8gtBKOQWefsgx/f14Beb73MOrlNhRwShvc4fjZoj6T5jCI
         8ko//+4ctKuEN2fNUoDa+cZspp/MxfDraN309nTuT6gfbfvZfGpBzn/NF5/2dwlrKDor
         VllBIkjuvV1MFSn4NodHmGIaly1EFWnAq5z5Z/fVqWtQ5GEwNU1VDPbfE3/Rnx6Y71cd
         Wr5tS/koB+yaP7RFuITmL9/NtT9/ByaMaP8k5RqqDNkgcz7N25uGV3Wu1kL8Hc3hUB+r
         x4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678420886;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OkeU/XIvYLV7i/BgDe2gN+ETpxPN9Z7bVS2VtFVoXBQ=;
        b=JGJw5F0Pw1KpwFU6gPA+AvhaM30X/afX9Ms9MZDdiu4t4o/OTfQuZRxD/RZ2Q8yKtK
         aI3n+mD2ZBVHJYJoqiopq4xrfrO2tC28NBcGsIdBHA6qwabpkDuwuJNdraKjIg8kbKLD
         iAibTDCzEOvnXpraGLFxn7c5g2nq3l82o60fs420Pg4YhdX/hEtycuFZah4Dw4AnxU/m
         xPXfUf/0O71ZPg0lkxYw7sul6rTgkRtHWdRXXOSHd7c0SUVX2+TGrFZXTK0z5qRbO3uz
         bxHqlLQzy8kGo8jdeHdPxqVoy8j/VemBaUoz3Obt/D0wElrM2mm6mYJ9Cza1odphGBSX
         JDHw==
X-Gm-Message-State: AO0yUKUBOzJhyLqSp9IOzOyqbZfdz6kYwH1TKCqoDTU4FIAYstb6W5Iv
        PmQyABhs9cCw9CIJ1fe74Oqj/eq0dOR7uQqyR14=
X-Google-Smtp-Source: AK7set+xOPSnesA1jGx25WYZmGOi3VMcUa0/wGgX01Cvh5lRAe2wMpjt0fhEDksDw43BN8ewWdSxhA==
X-Received: by 2002:a17:90a:6acf:b0:236:6e4f:bc1e with SMTP id b15-20020a17090a6acf00b002366e4fbc1emr24949878pjm.49.1678420886155;
        Thu, 09 Mar 2023 20:01:26 -0800 (PST)
Received: from CloudiRingWorld ([122.231.69.163])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090aa20500b00233b18e6fb3sm358597pjp.1.2023.03.09.20.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 20:01:25 -0800 (PST)
Date:   Fri, 10 Mar 2023 12:01:21 +0800
From:   Kloudifold <cloudifold.3125@gmail.com>
To:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] staging: fbtft: fixes alignment should match open parenthesis
Message-ID: <ZAqrkWn22Q1eXjCL@CloudiRingWorld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checks reported by checkpatch.pl
for alignment should match open parenthesis

Signed-off-by: Kloudifold <cloudifold.3125@gmail.com>
---
 drivers/staging/fbtft/fb_tinylcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
index 9469248f2..7d4741c47 100644
--- a/drivers/staging/fbtft/fb_tinylcd.c
+++ b/drivers/staging/fbtft/fb_tinylcd.c
@@ -37,8 +37,8 @@ static int init_display(struct fbtft_par *par)
 	write_reg(par, 0xB3, 0x00);
 	write_reg(par, 0xE5, 0x00);
 	write_reg(par, 0xF0, 0x36, 0xA5, 0x53);
-	write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x00, 0x00,
-		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
+	write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x00,
+		  0x00, 0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
 	write_reg(par, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
 	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
 	udelay(250);
-- 
2.39.2

