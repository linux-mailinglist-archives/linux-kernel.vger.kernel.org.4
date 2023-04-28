Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803C06F0FF8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 03:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344774AbjD1BW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 21:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344763AbjD1BWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 21:22:55 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCDA268B;
        Thu, 27 Apr 2023 18:22:54 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-63b4dfead1bso7620955b3a.3;
        Thu, 27 Apr 2023 18:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682644974; x=1685236974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdkdWMzz4x4AGpzhwdT30VnSZxzFvaV1SAlbNT3S/jg=;
        b=LfYdNA8CblMtZS0iQbgq+ciNyOoXTh6WTc/GHT7r7meQomt2JC4nsiGVbmApUOaoEO
         ojfxEwlLnbbPObJ+hJs71/Hd4ncFVybg4y8viiNol4hVfky3AOH+yMxmvzgDbIB0MNW3
         fr6kNrS2I0upyIlWDY2b47b42hTRY2PV2PgPaJG+J7wk77xTBtf+ztVbyhBDGkfqhlYz
         3hEvn8416K4kWJ7pNtF1GIeeKN2ZLvJQxwVgzU10myjJe4BJlyRdJIXKTCMdaW8X4HO/
         BDVpKbKbZk/xYeb4BwXOOmTfUUbl/S+SpE0WDbEsWg+leKOav+SrbDNlb0i+rwMsWRFi
         8U+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682644974; x=1685236974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdkdWMzz4x4AGpzhwdT30VnSZxzFvaV1SAlbNT3S/jg=;
        b=XMZng56SW/7HFgvN902t4UPa4Dw4OcH72bgepVu3Po7/ZTDU7O/Je6vZ8B05HT7exl
         HXSr4OZQaw5DnbtRu6iqs9OhYtYHPrWW1poFokEUrKCmmcw2BrZDL8iEXZOOi8gO7MPY
         hCJCaEWidywOYyhbuauv3T3wW3lYHN3E+6oYZBBrWhqXtk4CwTV5YH+CCyX4uI2dbnTF
         KGg2j6YuP2MEpLFVxZA6C79BIUctOKqYbwGy2dAVJZe3Xc5q/+083hWURmkyFT4eqDwu
         /R3VmahYz+66/99aUltvAoViyvKzIjAR7f46lHm9PB13/y7qTh/23rCfw5fMe+0IntQp
         1xjw==
X-Gm-Message-State: AC+VfDwpHIJYL8CBv7SjGhjCIsKYJt8z3KBwy+uxY2pFRiCLelG/r0cC
        jkoUh96bfD6G44qVZKSgh1bLLA+g93k=
X-Google-Smtp-Source: ACHHUZ7wQr1xrqxcC+U3d2L06hi99usqbCx683bnGeXVTdABG6TR324p2D2X8nO+JsZx2o4HTVFLiw==
X-Received: by 2002:a05:6a00:1885:b0:63d:6984:7a93 with SMTP id x5-20020a056a00188500b0063d69847a93mr5085394pfh.30.1682644973849;
        Thu, 27 Apr 2023 18:22:53 -0700 (PDT)
Received: from cxl-test.. ([103.181.222.211])
        by smtp.gmail.com with ESMTPSA id t65-20020a628144000000b0063b8b8580a7sm13691356pfd.29.2023.04.27.18.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 18:22:53 -0700 (PDT)
From:   Raghu H <raghuhack78@gmail.com>
To:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        raghuhack78@gmail.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, vishal.l.verma@intel.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] cxl/mbox: Remove redundant dev_err() after failed mem alloc
Date:   Fri, 28 Apr 2023 01:22:34 +0000
Message-Id: <20230428012235.119333-2-raghuhack78@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230428012235.119333-1-raghuhack78@gmail.com>
References: <20230428012235.119333-1-raghuhack78@gmail.com>
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

Issue found with checkpatch

A return of errno should be good enough if the memory allocation fails,
the error message here is redundatant as per the coding style, removing it.

Signed-off-by: Raghu H <raghuhack78@gmail.com>
---
 drivers/cxl/core/mbox.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index f2addb457172..11ea145b4b1f 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1112,10 +1112,8 @@ struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
 	struct cxl_dev_state *cxlds;
 
 	cxlds = devm_kzalloc(dev, sizeof(*cxlds), GFP_KERNEL);
-	if (!cxlds) {
-		dev_err(dev, "No memory available\n");
+	if (!cxlds)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	mutex_init(&cxlds->mbox_mutex);
 	mutex_init(&cxlds->event.log_lock);
-- 
2.39.2

