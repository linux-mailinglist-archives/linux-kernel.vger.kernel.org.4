Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA87715602
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjE3HAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjE3HAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:00:36 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1443107;
        Tue, 30 May 2023 00:00:27 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-96f8d485ef3so635478766b.0;
        Tue, 30 May 2023 00:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1685430026; x=1688022026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M1msovPDNghGN9XFlUePTnlnUqozar/gb+Z8CsE1tIE=;
        b=bHbxhtlS02JYob4cLWY25pKPSoSWB7xd/mECYEhvKieroQgmVtpX+o/F+k8f8yaqeR
         VdHVuZqGI9m24ZTCPt69OWTie/ag4co8PjyI/GxPLkJBjdJfIrOKHxg25tdczzIhbKoc
         yc2Ij7GDNLoK3lQFSqHGxjOaKlYFyAU2Fj7TkAGOXS+P6p3BuyXxmN/MWEwPoxWXGuzl
         F609cp8wawlJfxJtWRV20Ao6V15W6NUhMa65NaEQwsqe3pVRhemCVssiIxlOtXJKw+wk
         xgDiGeyndKIdbuRyAaw8vVQa2Hpl5+9gzf8J4sQU8n84yriCYZ6bvhC0aXFsn9EfVf1j
         LHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685430026; x=1688022026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M1msovPDNghGN9XFlUePTnlnUqozar/gb+Z8CsE1tIE=;
        b=SAqeT4zOsHpJCIArznkiior6JNyum1Ue3PSS00iUUjew03EPuvellhB+o5jcYnJMYX
         +KplRfCzuDHSRMyzDO/wD0zMxzSMugjgYnmwSGFujS78WDA+E8awybEAcqhgNurDM6+k
         FHORLj09jyj1bnkQfcB107PxTQuujHuFl8xXaA5C5E7NV25GFmxWCx2sDXGEZp3ZiaoL
         BGuzs5MGXeHGIF6GZqDIFlr6a7cECTS36OIgUkP/EpfxOOeA6vnr+oOn8CWMJneF+I0K
         V6Ocl9hZJqeq+Emnmts/Tk8ihMNunM2yUsuy0IhIhDFiq4/15KynqmiTwfotGEP02/yn
         etvQ==
X-Gm-Message-State: AC+VfDzxmKYbAaGcKlSzqdWwbbEtm1NOH0XBgmt39IxiWDb0ySPWgoyn
        WLLJqH8WbtOchXyUCfNFMuPyKRfhHByzeQ==
X-Google-Smtp-Source: ACHHUZ6ng677kTRv2Vgonnc4DFhdnlPFEyac16iTc7CsRo169rylrIF4bloACNn6QbMGzlNT1vaobg==
X-Received: by 2002:a17:906:9751:b0:96a:717:d452 with SMTP id o17-20020a170906975100b0096a0717d452mr1493039ejy.19.1685430026029;
        Tue, 30 May 2023 00:00:26 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810a:9640:26a8:d56e:8fdf:f926:4676])
        by smtp.gmail.com with ESMTPSA id t7-20020a1709064f0700b009531d9efcc4sm6973767eju.133.2023.05.30.00.00.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 30 May 2023 00:00:22 -0700 (PDT)
From:   Franziska Naepelt <franziska.naepelt@googlemail.com>
X-Google-Original-From: Franziska Naepelt <franziska.naepelt@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, linux-kernel@vger.kernel.org,
        Franziska Naepelt <franziska.naepelt@gmail.com>,
        Ladislav Michl <oss-lists@triops.cz>
Subject: [PATCH v2] mips: Fix spacing issue
Date:   Tue, 30 May 2023 08:59:49 +0200
Message-Id: <20230530065949.22247-1-franziska.naepelt@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some indentation issues and remove the following checkpatch issue:
- ERROR: need consistent spacing around '-' (ctx:WxV)

Co-Developed-by: Ladislav Michl <oss-lists@triops.cz>
Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>
---
v2:
 - Apply review remarks

 arch/mips/sibyte/swarm/platform.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/sibyte/swarm/platform.c b/arch/mips/sibyte/swarm/platform.c
index 484969db7713..339d77a0a08f 100644
--- a/arch/mips/sibyte/swarm/platform.c
+++ b/arch/mips/sibyte/swarm/platform.c
@@ -88,15 +88,15 @@ device_initcall(swarm_pata_init);
 #define sb1250_dev_struct(num) \
 	static struct resource sb1250_res##num = {		\
 		.name = "SB1250 MAC " __stringify(num),		\
-		.flags = IORESOURCE_MEM,		\
-		.start = A_MAC_CHANNEL_BASE(num),	\
-		.end = A_MAC_CHANNEL_BASE(num + 1) -1,	\
+		.flags = IORESOURCE_MEM,			\
+		.start = A_MAC_CHANNEL_BASE(num),		\
+		.end = A_MAC_CHANNEL_BASE(num + 1) - 1,		\
 	};\
 	static struct platform_device sb1250_dev##num = {	\
-		.name = "sb1250-mac",			\
-	.id = num,					\
-	.resource = &sb1250_res##num,			\
-	.num_resources = 1,				\
+		.name = "sb1250-mac",				\
+		.id = num,					\
+		.resource = &sb1250_res##num,			\
+		.num_resources = 1,				\
 	}

 sb1250_dev_struct(0);

base-commit: 7877cb91f1081754a1487c144d85dc0d2e2e7fc4
--
2.39.2 (Apple Git-143)

