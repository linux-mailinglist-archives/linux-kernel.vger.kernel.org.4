Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FD16C8867
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 23:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjCXWcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 18:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCXWcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:32:31 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C796C1F908
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 15:32:03 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id l12so3161297wrm.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 15:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679697098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Mi0Pc446/hNZjoA2whb7pVis3I9iPt8Xg8w3eBefMA=;
        b=mobA70mS99HIO8GofxD3z9FKdGusnjzAI/gAeFjArElMNCo5NfQvSbk6Sxh9NWZScu
         0N3K/5Nlr4AEYpeglA53RuQWLjPblzOoua5gBnGIjpKeQdRGMwV4Y3Xi1roA0YeP3fYe
         6y1uJSGwfYYJCE6aM+fLGdYKjKk5mtpAbfSVU5HamqNnX5bmAliBHKoH7PAd2XHwuGYT
         Tm+w+2Pu0J/2Kn4/NFPJgl2ZPwGJUyO6RvDEPGLGI/tCErRBTyIpxX36f++YbYHDliwv
         OWdw7przsj+4A5pXd+4LM9h0baNua+tUR9xjetbcjHgqvl1Wtm6IazNHd+3bV4ccALaz
         BG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679697098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Mi0Pc446/hNZjoA2whb7pVis3I9iPt8Xg8w3eBefMA=;
        b=No/kVAOe+Uj2s6lLXOp8FYk8SyoFNi3mKcrKXMHHr4dE7mUzfnmQkn435jouJjTCxw
         3S7nC9QkeFLXCCj/e6HWK4UBe+ez3Q/16y1ELg/g142AvVg96nsmQqBVP5NxgwYqdyCW
         /z1aT/rJalBH5VB/a3QY933ryf+4Xo3hfJPqiGJn6WzSRYvW2qqIngP2WgSsOgaFWtgH
         AW3H6VNlS//CxnGNn9iPZywC957an2HgBhgbMDt5F6EZViXXFwvBmumGsMNS417V0/Nd
         iw3AMVl7q3rjVo7gW9xWn3qs5JA+UyyXcjWme2wKU00k+0s/dkLJWKfYBYldIiHOA+pQ
         dzOw==
X-Gm-Message-State: AAQBX9f4FMleuFyw5gSYQnigkZD1+k4y8KI6iwWYxvIWI4pM0VzXmSQH
        LIxo6niwyURoguIwhZnNE5TyQWfZoqL+ow==
X-Google-Smtp-Source: AKy350aF8hqqUeU5omOOYaYRzd2NcGnM1I0RRzkrA4T9gmjTQPoPECgS8HaiMJrnyj1W0t3wJb377g==
X-Received: by 2002:a5d:4b44:0:b0:2d8:47c7:7b50 with SMTP id w4-20020a5d4b44000000b002d847c77b50mr3464652wrs.1.1679697098358;
        Fri, 24 Mar 2023 15:31:38 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id d7-20020adffbc7000000b002d5a8d8442asm14984138wrs.37.2023.03.24.15.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 15:31:38 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/4] staging: rtl8192e: add blank lines after declarations
Date:   Sat, 25 Mar 2023 03:31:29 +0500
Message-Id: <d8a5e738046ffdc1b257e1935eacb8e16af34d5e.1679696777.git.kamrankhadijadj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1679696777.git.kamrankhadijadj@gmail.com>
References: <cover.1679696777.git.kamrankhadijadj@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add blank lines after declarations to adhere to the Linux kernel
coding-style guidelines. These issues are reported by checkpatch.pl

"CHECK: Please use a blank line after function/struct/union/enum
declarations"

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index c6114d99829b..7144a0630ea6 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -231,10 +231,12 @@ rtllib_rx_frame_mgmt(struct rtllib_device *ieee, struct sk_buff *skb,
 static unsigned char rfc1042_header[] = {
 	0xaa, 0xaa, 0x03, 0x00, 0x00, 0x00
 };
+
 /* Bridge-Tunnel header (for EtherTypes ETH_P_AARP and ETH_P_IPX) */
 static unsigned char bridge_tunnel_header[] = {
 	0xaa, 0xaa, 0x03, 0x00, 0x00, 0xf8
 };
+
 /* No encapsulation header if EtherType < 0x600 (=length) */
 
 /* Called by rtllib_rx_frame_decrypt */
-- 
2.34.1

