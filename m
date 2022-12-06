Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B1B6449FD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbiLFRL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbiLFRLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:11:12 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F3F2DABB
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 09:11:12 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id w15so24416735wrl.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 09:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5v14ZTzRH5HsyEn9mY20Ymo8gJAzpokyO92zkSj5WYg=;
        b=liDhJDy7GxeAOMF/LzJSmXP1wdT5+iq4LBiLncSq2Xj1dmUStASD9aScVhhvdFuL6R
         G2a1AUzuGUMecb/sYwv1ZH8DqCqE4SSC+cDIHK0cBPBceWOPkZR4Zvvr+v3gluXm0+EI
         Dt2bJ/n4s6zWupvA7VQFg3g0hGhiyLmALr5U8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5v14ZTzRH5HsyEn9mY20Ymo8gJAzpokyO92zkSj5WYg=;
        b=hUugGTxWHuSqtTMwJJAYvH0AV0mqUACD5rJVcPgkPJGO6U+Bh8xTvYH8wmt9/0QkYB
         /2+rrKZOciYBDlKqTQDvqZupElnbtjeHlXdtp4+sKRnA84ViEDqp3DeBPcuw66Q0xk4I
         GWDlQeZA4gSuP7NvV8rnJVqZx09OJksb5WNzn+7yNAIxwGE3U29N4aUNEz/RhsAdFvM2
         AqYKXoM2b68lIri4z6YinMUVHPtRDgLwhHY0Cqjv1FqiK+hrQru2e79KiMnEhUwhYiCr
         q8Hztfd+McQxBO91VeuAhPAplIZ4QBp4ZWLAoxKSoC1MbcNUHchs0ab1J8tbCzC8mwZT
         HwkQ==
X-Gm-Message-State: ANoB5pn+y54qdz5a1J2jM1+h3Yj3NvCB/9wta7i883XXz9lWkhLqFmsp
        5jAdeb+KVQBd/9gO+kBH9P0I2zJ5oiDeMyV5
X-Google-Smtp-Source: AA0mqf5rVnGYyi6nQo2ffozLqpG/dpJo+1+F9RpCIVSPq3Ms5qsq2nMwoa4dGTdeTh9jFtNJ7uqSeA==
X-Received: by 2002:adf:e98f:0:b0:242:7f7f:da0a with SMTP id h15-20020adfe98f000000b002427f7fda0amr426399wrm.168.1670346670455;
        Tue, 06 Dec 2022 09:11:10 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.pdxnet.pdxeng.ch (host-82-54-95-136.retail.telecomitalia.it. [82.54.95.136])
        by smtp.gmail.com with ESMTPSA id k10-20020a056000004a00b002365730eae8sm17298534wrx.55.2022.12.06.09.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 09:11:10 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/5] ARM: imx31: add missing of_node_put()
Date:   Tue,  6 Dec 2022 18:10:47 +0100
Message-Id: <20221206171049.3316611-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221206171049.3316611-1-dario.binacchi@amarulasolutions.com>
References: <20221206171049.3316611-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mx31_read_cpu_rev(), of_find_compatible_node() returns a node pointer
with refcount incremented. Use of_node_put() on it when done.

Fixes: 3172225d45bd9 ("ARM: imx31: Retrieve the IIM base address from devicetree")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 arch/arm/mach-imx/cpu-imx31.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/cpu-imx31.c b/arch/arm/mach-imx/cpu-imx31.c
index b9c24b851d1a..35c544924e50 100644
--- a/arch/arm/mach-imx/cpu-imx31.c
+++ b/arch/arm/mach-imx/cpu-imx31.c
@@ -39,6 +39,7 @@ static int mx31_read_cpu_rev(void)
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx31-iim");
 	iim_base = of_iomap(np, 0);
+	of_node_put(np);
 	BUG_ON(!iim_base);
 
 	/* read SREV register from IIM module */
-- 
2.32.0

