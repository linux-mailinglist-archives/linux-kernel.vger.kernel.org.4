Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6934E7240C8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbjFFLY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235346AbjFFLYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:24:25 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4629DB1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 04:24:25 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5144a9c11c7so5488448a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 04:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686050665; x=1688642665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FgtVUQsPT8FJ5Vzbv9hHerc/vSp2iW4yB4BuCz1QsuE=;
        b=X9RKkocOwQQoXx0VhPNaN13xx38hrB1NL9Qeas968kTz934dCgNjjeIhg99fKEbPlb
         6cM/KOKzsUfPb/s03X4tqWqB/5EHRv4Qtxon8t49Py46hNyOc6jTx8gubOEDmNr4p5LS
         7ESoZVLBN+pXUqw8wkLUQ5X06HCb+u/qJj2wfvtwUzR5PPU7GpLH2BY5wqRlIj/wCJ+k
         G4hi49Wz7WTezp5wicGgKGR/svUC6jVvkkHKoeYgvtbdFOUdDe/Al43wEHKuF1XO3LzM
         QikbIswGFiXSLgmPhQrYCQe/tbkTr2481wbJwS+N+L124uX3OpvY4KGFOXmWnRedsVGR
         JtxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686050665; x=1688642665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FgtVUQsPT8FJ5Vzbv9hHerc/vSp2iW4yB4BuCz1QsuE=;
        b=PYJEiUWjaGCBCY9zc74temIK2uC1xcBAxYZqCOwXsaZM00KsDwTk5NDSMTuQ0zsCJQ
         8v7THbv4rrATMRkWNqxaYOOPFJv6SKZfvcdkRBDcEq+NJQI/dUybsVxsPUk44nhRhc5s
         vF5pa7XoE/DsTf3TnGCLMwaJ0kazv/6vyv0bIr6HR9EY9QQYyVLkgjNvcqL8nI9Te9CX
         lf96ZgIQe17L4HQsVTN1G1U0rS3FjgB+sh30xBrgV1NHvwGw0x3Ujh597dZYZFLVmUGy
         4cqfAbBDOq+4qQvEPoaXsyX2Og1okb8p+t+rBi9jf8NtjZHAQ2Y/fssya+foPTGJRkMD
         z1Vw==
X-Gm-Message-State: AC+VfDw+qnoVzyfZtNrMYrSDl2gXgkKJMOAKrSKADdrdmtzwSuaWgmb5
        Jgf06lLMVuK0vSGwH8KBFNU=
X-Google-Smtp-Source: ACHHUZ4l+g/FfCRp1i0AIdVqCX+QDTMhIRcwBujXABvXRV46+Mu668a9Mk+dBLjqeQ3tEYia9IofNA==
X-Received: by 2002:a17:902:d487:b0:1af:d812:d27 with SMTP id c7-20020a170902d48700b001afd8120d27mr2295462plg.9.1686050664759;
        Tue, 06 Jun 2023 04:24:24 -0700 (PDT)
Received: from devbox.. ([103.165.115.136])
        by smtp.gmail.com with ESMTPSA id ja22-20020a170902efd600b001b008b3dee2sm8271740plb.287.2023.06.06.04.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 04:24:24 -0700 (PDT)
From:   Neel Chakraborty <neelchakrabortykernelwork@gmail.com>
To:     martyn@welchs.me.uk
Cc:     manohar.vanga@gmail.com, gregkh@linuxfoundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Neel Chakraborty <neelchakrabortykernelwork@gmail.com>
Subject: [PATCH 001/001] drivers/staging/vme_user/vme.c: Fixed alignment issues
Date:   Tue,  6 Jun 2023 16:53:22 +0530
Message-Id: <20230606112321.1022783-1-neelchakrabortykernelwork@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Made alignment match open parenthesis.

Signed-off-by: Neel Chakraborty <neelchakrabortykernelwork@gmail.com>
---
 drivers/staging/vme_user/vme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index b5555683a069..8a9efb4a00a3 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -79,7 +79,7 @@ static struct vme_bridge *find_bridge(struct vme_resource *resource)
  * Return: Virtual address of allocation on success, NULL on failure.
  */
 void *vme_alloc_consistent(struct vme_resource *resource, size_t size,
-	dma_addr_t *dma)
+			   dma_addr_t *dma)
 {
 	struct vme_bridge *bridge;
 
-- 
2.40.1

