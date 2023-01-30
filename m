Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A522C6815F2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbjA3QF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235587AbjA3QF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:05:57 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6960DEC55
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 08:05:55 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id be8so12082656plb.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 08:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KokH30JDIzxDGaC1x+0b+EMKCAN6MSlfv0P938jyASo=;
        b=JtfOkSxZfDZm4S7o3ReKBPP2gH7CTGGiycUmiZEsoBYBlsU9iWnCjdi+VZ3fRobB7Y
         3ytA+ttCMYG+VKcVqCBdR2nSZ5Xl93ErG6hgbKlkjcRNAmC0zFhoXiyVspUA8w3snrlV
         Pa/HwJrakSfwVd7/J80ChZzaQENwC/IMDHXOKncd4mkt6q8fkYhjzlaCfgwPALitYXIV
         rl8irG2a1K82+X0qeMbGdyH2nlOqTOIsxvAmxa0p6FusS+1Go2h/43KFSxKKrhnUA2YG
         Ib2jX+1MgWBEFb2bt2cR+Ron1Tg1GFIBH1VSlaE811pKMiS3/VVIOttSA5zQLaEdzP4V
         muLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KokH30JDIzxDGaC1x+0b+EMKCAN6MSlfv0P938jyASo=;
        b=AM7F1pExG2VFsOGAAnhnbpqbl4qRT2gSXKECF9qlDcAaybbLnqwTVo6lNd0///eftC
         xnV7tCbYDzN595+IPFPhaxcIG+5Mi0eVeBneOwx7W4Zjdt46okGuIJWXUJH4AEBpLv8u
         n0bQNwNCN1U/XsuAgSK+uUAYdFDANG+rPi6FWmPGH+khqcplHvVc74Dcs2iJ+dSTNHnh
         FTZdzsJiqDPaoqXbHrL4UJOrCf37Gs6hOViRLpMP0fDuBjTTHcYCgr7HVjxO2H8DEvfp
         r8yGp6b4ecvc9G6fULg/0P1hJhYGUiRJ0v6kpQqurLr3mmxNgT2zHEDVDctuC8I9/o/v
         PjHg==
X-Gm-Message-State: AFqh2kqGRyyp9apto1UwQsjwm0YW/7/KMsoJHp5NgsMz3pOCPvCK1u2b
        iJ+5t3evMVosy3kVHLV7CL4=
X-Google-Smtp-Source: AMrXdXseh+XsMJ9zxICqoRbtz6thohANB0jPakj0GX6bXwOACgZOdu96RTSQOxtoEpw7p5pZNYWGeQ==
X-Received: by 2002:a17:902:8c94:b0:193:ab5:39c7 with SMTP id t20-20020a1709028c9400b001930ab539c7mr47506462plo.11.1675094754867;
        Mon, 30 Jan 2023 08:05:54 -0800 (PST)
Received: from localhost.localdomain ([112.212.226.173])
        by smtp.gmail.com with ESMTPSA id e3-20020a17090301c300b00177faf558b5sm7974224plh.250.2023.01.30.08.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 08:05:54 -0800 (PST)
From:   Jongwoo Han <jongwooo.han@gmail.com>
To:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        gregkh@linuxfoundation.org, jongwooo.han@gmail.com
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] vc04_services: mmal-vchiq: fix typo in comment
Date:   Tue, 31 Jan 2023 01:05:48 +0900
Message-Id: <20230130160548.45879-1-jongwooo.han@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

Correct typo from 'witin' to 'within' in comment.

Signed-off-by: Jongwoo Han <jongwooo.han@gmail.com>
---
 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 294b184d4..e318f3609 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -245,7 +245,7 @@ static void event_to_host_cb(struct vchiq_mmal_instance *instance,
 /* workqueue scheduled callback
  *
  * we do this because it is important we do not call any other vchiq
- * sync calls from witin the message delivery thread
+ * sync calls from within the message delivery thread
  */
 static void buffer_work_cb(struct work_struct *work)
 {
-- 
2.34.1

