Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962CF6728E2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 21:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjARUAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 15:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjARUAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 15:00:11 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CF25CFFE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:59:56 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id q8so13736631wmo.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k3R7IB1dzrow/0Vr25tuv7jgHVFQelvLSJmLj6RztKg=;
        b=BwCqiuF5rAns/7by5wAvM7UGegecxxogcobljziaCG95at/IxsAxj705wzdLi21lbB
         nMyFmITB7jqRMmRzFMQGnhNd4MoIcZRPTXwBbJfiKIRedP3sM1qMwHjzCDrVdaZ2nrbS
         nT5ciWbg8eqpc60g2FsRnPxSeqEQABxDzV1FBuvJbawm/hLSe65OHvUtU8nPd0FybwDc
         gRjUBFsvyLRydbDiSfO8zGMybzEWaomyJDRpAtPqGqYFxIf3QPySMuDA8qWEHzzU7NFi
         UFN6zTNusmhOszo/CYH/VsT/dtLFcAHQi2HrwrbjLPHeTMZxI558jpPuJaWqltHhu/AK
         Gl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3R7IB1dzrow/0Vr25tuv7jgHVFQelvLSJmLj6RztKg=;
        b=OTyIW3eBdMHDbsVEr5Fv2dQSdnGQRB+kJrlw/9GeChcXiv/9IM0jnva5/gS2TIUO12
         XRObMQRlA8Sgl1Z1pkIZ3lx9WGOsYw97N2isrCMxe227Aws1XMzlOUs1i1t2aS1MrXfv
         MIPLQ2WIIB2YVgse/L7mhPdxEn/8EfARl8rwmJp7MI2I2hZM1KzRC9OpPQEjOS4E8EwE
         Gead9tojxz9m8O3JdyDhXHsLebqNXaQgD07TdmO1Ytfhw02LQZJDTK9MpF/smrC+k8yk
         n7qQJFr4Y6kRiO+GqnOWC593DH4SVakbkJPBFEuoJp17xU4TLuFdf9ZfftgKSQ7rsc+z
         G5bg==
X-Gm-Message-State: AFqh2kpAw8YyEIPRU1DZ63r5CBK0aAwY3jmbWaVidzOmArVx82hrbzhK
        wAoamf7gMyMyFkn5aUAW+UU=
X-Google-Smtp-Source: AMrXdXujSXUzoIM1dbRu2AwiupxJNiRB32qV9TPx4Wdot64USNx8/1/KvkZ9STHwwfXPI3kr5ciNdA==
X-Received: by 2002:a7b:c849:0:b0:3db:303:2724 with SMTP id c9-20020a7bc849000000b003db03032724mr2008902wml.1.1674071994863;
        Wed, 18 Jan 2023 11:59:54 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id bu9-20020a056000078900b002be1dcb6efbsm6009244wrb.9.2023.01.18.11.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 11:59:54 -0800 (PST)
Date:   Wed, 18 Jan 2023 20:59:52 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] staging: rtl8192e: Remove unused variable
 PwrDomainProtect
Message-ID: <769f4d3337872d29d8fc5e31613aac52b6bae95b.1674071236.git.philipp.g.hortmann@gmail.com>
References: <cover.1674071236.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674071236.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PwrDomainProtect is initialized and then never evaluated. Remove resulting
dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 --
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index fe985f4b8dbb..227c13d552fc 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -2027,8 +2027,6 @@ rtl92e_init_variables(struct net_device  *dev)
 			    IMR_RDU | IMR_RXFOVW | IMR_TXFOVW |
 			    IMR_BcnInt | IMR_TBDOK | IMR_TBDER);
 
-	priv->PwrDomainProtect = false;
-
 	priv->bfirst_after_down = false;
 }
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 626a2bc48969..e90cc61b3817 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -526,7 +526,6 @@ struct r8192_priv {
 
 	bool		chan_forced;
 
-	u8		PwrDomainProtect;
 	u8		H2CTxCmdSeq;
 };
 
-- 
2.39.0

