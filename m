Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C935A634A3A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 23:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbiKVWqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 17:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbiKVWqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 17:46:19 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EDBC9A81
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 14:46:18 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id b12so13191211wrn.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 14:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=loIlTu8AgTjjJ6bJKu7RkzWKYzkXqArC4i+/pF5KBwc=;
        b=oMkaIW/0mTFAA+i4rUf7b+aSV01mbdvY80WjaKdbE1lKG6728xGMJDvIHEJWKg8Unj
         0PpdDTQlSoXrkEL9Qc9gdm5BQft4jWf4YBsEcjZ7i+rE9nME86Wj0Va32womP+1zVUJ0
         8MZQ0n6zRjv4QuV2yX7LwKipH4ajoAJad0o+WVOQCvMIQeyMR0gELhclStesHLnG/FIh
         qGZhfLz8Yf8PHpMt0W/ieN5GeG/Pg1h/feOSt/Jgd25L/THlGzXYrRRggcPXmiNvQbxB
         RKgUlhuYK8xq2qS15sWFlF4fDkI4+Lrt7kezfBtxK1q0ZodaDODHvTQL5LLFiQOWFUvY
         NLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=loIlTu8AgTjjJ6bJKu7RkzWKYzkXqArC4i+/pF5KBwc=;
        b=d13qKqfUwDSgBf0ix0Gklm5K557BQVJYKW7OybzE4fpb97h6fCprfO5ZDvz07goK0m
         4mfvwjNztXvhMyXH4nTMEKiDJ2u1ohwLeQtZ/R5WYZBpw8MyUv1qY8sLj1iKJf2GcLAl
         RY1ARa0CD7riMPeW12AgK3galrMUtp9T2haDKsLYZ0/pT9PgWpsjbS3sru3t2D6n5XWd
         kSONS/+MaqxUKxlbVOxF0OtEQN6DBg9tA/+4T3Gfw1vrSHzIVEa4pTmYJ/3g06qqfOYG
         K+ijMvkqcli4GFljZ4Z6MwW/KfM3BU3ScVNDTGfjQ2SRr/765DFrLOkLkbl+wWDtG2Js
         XB7A==
X-Gm-Message-State: ANoB5plgmSx7V+MDLX5yd3IEHLc+DZO1ObuhLFa6zR7tVDumuTqVZbSt
        EzZfZSC368Hwy5BrKx/94IM=
X-Google-Smtp-Source: AA0mqf6bsUikRzP+3fX620L7gB6pgldCvN4IFyO9E3NZs/QdGZGwZN8cA/zXdWwoubRAl+opBDkmWw==
X-Received: by 2002:a5d:4bd2:0:b0:241:ec17:6cd8 with SMTP id l18-20020a5d4bd2000000b00241ec176cd8mr191941wrt.108.1669157177281;
        Tue, 22 Nov 2022 14:46:17 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id j15-20020adfe50f000000b002366d1cc198sm14886700wrm.41.2022.11.22.14.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 14:46:16 -0800 (PST)
Date:   Tue, 22 Nov 2022 23:46:15 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] staging: rtl8192e: Remove unused variable
 initialized_at_probe
Message-ID: <4855b2dd5b7296b0eb10e697f605fb820e1dfc7b.1669156825.git.philipp.g.hortmann@gmail.com>
References: <cover.1669156825.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1669156825.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

initialized_at_probe is initialized and never used. Remove resulting dead
code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 369a59a753fe..7b78bdfadc8d 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -836,7 +836,6 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 	priv->up_first_time = 1;
 	priv->blinked_ingpio = false;
 	priv->being_init_adapter = false;
-	priv->initialized_at_probe = false;
 	priv->bdisable_nic = false;
 	priv->bfirst_init = false;
 	priv->txringcount = 64;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 54c7a2128053..1c00ad709a3c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -309,7 +309,6 @@ struct r8192_priv {
 
 	bool		bfirst_init;
 	bool		bfirst_after_down;
-	bool		initialized_at_probe;
 	bool		being_init_adapter;
 
 	int		irq;
-- 
2.37.3

