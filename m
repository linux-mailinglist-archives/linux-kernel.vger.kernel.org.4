Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF72771348B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 13:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjE0LvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 07:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjE0LvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 07:51:18 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F508F3
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 04:51:14 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64d24136685so1248993b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 04:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685188273; x=1687780273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJpCwbm/WEPiYbmZRcnPg3zbQ5py3aWRu6GVo31NF5g=;
        b=VFlx8zg1fygBabKPB2KOGQRCchYmXp402Zvu6wRn5uitRW1YL3q5jEteJjdAmu0hCF
         oevYt0FL1bljCoFGMw3r5dnGlARw/js9LNK4MKKH+mpZrTlX2XqZ8AKUYRItzALcuZtu
         ntNkYqxO0cZWYr12k8u5znQt6ybj4uwHiL9OeCTrBrBJoBbGP4lndiwHhMTw2byLe4zH
         oNnj1zFQd6+h89MatK18FUT0JbLvsdqRTtdVp8V8gg3h4VzM69ASFKH5SPYHNyfFJPgj
         KRgv03mfFYM5MTjusHTRAoxTUSzdIzM6fIh8pv+92+XjLHbYYqNNt7VSscGtVfLAAFNw
         O02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685188273; x=1687780273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJpCwbm/WEPiYbmZRcnPg3zbQ5py3aWRu6GVo31NF5g=;
        b=BwMuq7sgLLOuF9ulQYUbNq9jjoA2nPEZx6MQfoDhErEqNnrh9AfALO/1JjFTu38aOC
         9CLm1YrtwPD8GaEgfX5ymM30vEnSp/P9e0qYBcwOvrULY5f/vOvJ66/ojHV6IOxc9gGg
         tyju8H+0pEcWKo4n98fLpn1ZJbxid053RGsuTpH/W2/Bz5J+Hf48jytdmEGgLJiTj7Ey
         Lo8pz80BpFvv25GVH/9ZdVKmwO5haVCKmfyD4vRW/Vw8AQW4rA4H/yW7qna2jV8rSgeR
         cPRlJ1JPRqAhVdbl2n7laZ+8x29fwjfQkzs7dtVdASNFkxrdKT8adZQdacgFNw8y8B3d
         FUBg==
X-Gm-Message-State: AC+VfDwiLNrqfn87CvvdbabdCvf2if5qqRR+LWcrHxtWibTf/ELKlrin
        2IQe+Nt97iJX7uxh1VQQU/w=
X-Google-Smtp-Source: ACHHUZ4EiLdl3+Jsl7/CLV58fqBgApK2hq9JBbNjF9xdOnsU3nSDEEnjEGgWueolcmgLNe4xLSoelg==
X-Received: by 2002:a05:6a00:a12:b0:64d:60f8:cb35 with SMTP id p18-20020a056a000a1200b0064d60f8cb35mr2695560pfh.7.1685188273505;
        Sat, 27 May 2023 04:51:13 -0700 (PDT)
Received: from redkillpc.. ([49.207.219.227])
        by smtp.gmail.com with ESMTPSA id x19-20020aa793b3000000b0064f97ff4506sm2988098pff.68.2023.05.27.04.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 04:51:12 -0700 (PDT)
From:   Prathu Baronia <prathubaronia2011@gmail.com>
To:     prathubaronia2011@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Khadija Kamran <kamrankhadijadj@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, error27@gmail.com, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, oe-kbuild@lists.linux.dev
Subject: [PATCH v4 2/3] axis-fifo: use devm_kasprintf() for allocating formatted strings
Date:   Sat, 27 May 2023 17:20:59 +0530
Message-Id: <20230527115101.47569-2-prathubaronia2011@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230527115101.47569-1-prathubaronia2011@gmail.com>
References: <ZHHE/H2p4Go/Igc/@redkillpc>
 <20230527115101.47569-1-prathubaronia2011@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In various places, string buffers of a fixed size are allocated, and
filled using snprintf() with the same fixed size, which is error-prone.

Replace this by calling devm_kasprintf() instead, which always uses the
appropriate size.

Signed-off-by: Prathu Baronia <prathubaronia2011@gmail.com>
---
 drivers/staging/axis-fifo/axis-fifo.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index 271cab805cad..d71bdc6dd961 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -816,10 +816,6 @@ static int axis_fifo_probe(struct platform_device *pdev)
 	 * ----------------------------
 	 */
 
-	device_name = devm_kzalloc(dev, 32, GFP_KERNEL);
-	if (!device_name)
-		return -ENOMEM;
-
 	/* allocate device wrapper memory */
 	fifo = devm_kzalloc(dev, sizeof(*fifo), GFP_KERNEL);
 	if (!fifo)
@@ -857,7 +853,11 @@ static int axis_fifo_probe(struct platform_device *pdev)
 	dev_dbg(fifo->dt_device, "remapped memory to 0x%p\n", fifo->base_addr);
 
 	/* create unique device name */
-	snprintf(device_name, 32, "%s_%pa", DRIVER_NAME, &r_mem->start);
+	device_name = devm_kasprintf(dev, GFP_KERNEL, "%s_%pa", DRIVER_NAME, &r_mem->start);
+	if (!device_name) {
+		rc = -ENOMEM;
+		goto err_initial;
+	}
 	dev_dbg(fifo->dt_device, "device name [%s]\n", device_name);
 
 	/* ----------------------------
-- 
2.34.1

