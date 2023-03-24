Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BB66C8846
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 23:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjCXWXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 18:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjCXWXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:23:13 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00B13599
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 15:23:12 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d17so3149483wrb.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 15:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679696591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Mi0Pc446/hNZjoA2whb7pVis3I9iPt8Xg8w3eBefMA=;
        b=MNRkhKNj3sCbgwRJ2yk7v83fdoOZzPzi7W1TlyCg/FV/FgxtRzX5LdHt+55AOxxeoY
         RfsJIWeRfky8/gjKUWlrN3WDFf7YM7HRhKLf5KcJuiUkxSJw69ru4j2pSMN5liSJeRKA
         jJlsh92Qgw6IQvaitVCdaBGiDHm+j8v6j9MtK18ZeGwCtdPeLoxeVww99zEQ7lFj/deL
         hKh2etKpl1hn9mrJ6rE7uQ/rxUU7voDSMgvZlVac8vZ+Xnw4O7ky93HpGtP6UPpDy4sV
         0Jus34STl0t/RJDE6SWs4W2aEU6WecwKLpybGGZbWvqMVCWpX5ngE4NlskEKOBkQDd6E
         AKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679696591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Mi0Pc446/hNZjoA2whb7pVis3I9iPt8Xg8w3eBefMA=;
        b=OgNpecgaT4uoJEnzQ7DxQnmd/5M0FdMvHVf8OGUdSmtFz2lVBpvgU06J5rkkIR735w
         zdwVr9tJprl9jEFmzpfUJu8VWZznWHBKbfNZlj/VNpxZrrX1uzngYNW3LPFWSHOaEwpe
         t+boDwntAfDBA9DN7xuYMm02AbsGLKZPlyzqmwtKWhKDqygUwUVspdl8c70eP/bDT8uD
         gHoqsX/HnYTMIeH8f/5Qr+/suZfYLzLmIrUVQ3SIUxKagfADsfuBSHdlt3c2TpuqjWJ3
         INFirSw/fRdO3TMLhmV5gJx94ZV3fPj2LEQfw98rzJDkTSA+I14Ptpvz45pZxVLHgHGe
         Gsxw==
X-Gm-Message-State: AAQBX9fn0STuWAsJ6Q4YNTaMkLsc4AwSsnE+33JNn3KxNHS8gKEPQVEg
        YvCNQI6dUSlfsADwP5/UACU=
X-Google-Smtp-Source: AKy350auIia6rlBSSZzQmAltG5DNbQIKt9Tm+UVIwJdWlFQXMIL7G7CMik6v1hRBMdmZIfuouNNvAA==
X-Received: by 2002:a5d:4535:0:b0:2ce:a7a7:b8b4 with SMTP id j21-20020a5d4535000000b002cea7a7b8b4mr3409538wra.35.1679696591084;
        Fri, 24 Mar 2023 15:23:11 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id m8-20020a5d4a08000000b002c3f03d8851sm19161446wrq.16.2023.03.24.15.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 15:23:10 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] staging: rtl8192e: add blank lines after declarations
Date:   Sat, 25 Mar 2023 03:23:02 +0500
Message-Id: <d8a5e738046ffdc1b257e1935eacb8e16af34d5e.1679696291.git.kamrankhadijadj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1679696291.git.kamrankhadijadj@gmail.com>
References: <cover.1679696291.git.kamrankhadijadj@gmail.com>
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

