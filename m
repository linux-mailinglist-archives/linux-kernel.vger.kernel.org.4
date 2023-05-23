Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A1A70E756
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 23:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238563AbjEWV2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 17:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEWV2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 17:28:39 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48630E5
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 14:28:37 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-19ad6baf96dso204310fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 14:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684877316; x=1687469316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tzEBzzdurFUUNhz8De4QCfW5EnAQn44Yi/fNTM7GMYY=;
        b=JJfzFSZrUXgnpMaedzLsZWVKpJfGy2xSCg2XtxPVEUl4NbtYvrZX8ZqJe7NWOPeR4Q
         DV/Ha+xbFDXX/b3Yv6GfTwM5rhhZ+PXloRz2BqUCZQJLu+Qa9ZehOIexlyXvEo42Btc6
         Mc7rKOvrOC8ekGhkmsfPKPVpAP7uu6rsFte9GeoMtgBk0qHHRvtat7/8mA/bU8uLrJ1W
         kADOnCPAPjZzn4ST6oVR3Uy8qRdjrjz3GUhFFvEXnleV3xUQEBLam1iKYeRZorB25t8S
         iySgdwPRDeUsWcR+5QFKOKQoObseDc4ALG+vqiCkOWeLst221vB/kj7Bi6SKNOCeENAm
         DXZw==
X-Gm-Message-State: AC+VfDwQpf9GlIrLpEgOOd64I6/1mlLrZ6+jvSKvCnXRJbpOHBjGNC+N
        FChPzEW0W+8Ul6weShrQKhU=
X-Google-Smtp-Source: ACHHUZ7Pgpa3fs0T3nGuqSoyp1mlhrMU+NrUl42EtZn4VfZUQfyv/ykYDquhjxIH/KtGGQVOvqajFA==
X-Received: by 2002:a05:6870:e7c3:b0:17a:e1b7:ebef with SMTP id q3-20020a056870e7c300b0017ae1b7ebefmr7317465oak.12.1684877316461;
        Tue, 23 May 2023 14:28:36 -0700 (PDT)
Received: from localhost (201-66-236-34.user3p.brasiltelecom.net.br. [201.66.236.34])
        by smtp.gmail.com with ESMTPSA id o11-20020a9d764b000000b006ab2af64f34sm3870343otl.13.2023.05.23.14.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 14:28:35 -0700 (PDT)
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     shawnguo@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Otavio Salvador <otavio@ossystems.com.br>,
        Alistair Francis <alistair@alistair23.me>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Hansson <newbie13xd@gmail.com>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Remove KERNEL_LZO config
Date:   Tue, 23 May 2023 18:28:29 -0300
Message-Id: <20230523212829.2539417-1-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KERNEL_GZIP is used in most config and is the default, there is no
clear reason to diverge so let default be used.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/configs/imx_v6_v7_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 4de293da4789a..1f3102eeb7dfe 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -1,4 +1,3 @@
-CONFIG_KERNEL_LZO=y
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
-- 
2.40.1

