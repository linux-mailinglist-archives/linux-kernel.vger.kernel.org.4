Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A257D7330C6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241187AbjFPMHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbjFPMHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:07:13 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF09F30EB
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:07:09 -0700 (PDT)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 88A783F15F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 12:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686917228;
        bh=HXrbrNjx5wkbmZikN4dyh9skh67sgOUdUExxc/zzJTU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=C5vVY7DCWb+XWlyf/eb8f6T/8YVm+QwqG8ki5qc2Jah4kCjENpXIzvQySs9Rj8+Ec
         gvaj6b0YcuvJ77JLp9POeFUq50DZ7FX5Sax08VMH3/5ehnvhFHV/UjAr07GfiKjB0w
         LLtei/zyHGvtjjiLPgU8R2b7JUiHsJch3BXIBlZhPQGicry2p/t1QU8jI+ty1eHDzL
         ffWbJnmgYHZaVwcpAKpaQkRF0tYANx+UdIo5pYK8KvEhEBOEHqLW/yUbe9OUIFdJcY
         Vzea1orGhINbxLkDgtdDXQgMDhMLI2bX8DIvAX8N9UO2WTvowN1NUv//pTL9w9hA3m
         DH5eiboAuYqnQ==
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30c6060eb32so784189f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:07:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686917228; x=1689509228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HXrbrNjx5wkbmZikN4dyh9skh67sgOUdUExxc/zzJTU=;
        b=bdw1yLbSIO1d882P3O8Tfs3nJq6OTQsJP1CE30NunNg3eBLz3ebrcq5ZExJ5hLF6bB
         lJWq4Lb4XWwjfM3c5hqiCGlqCgaIvu73mhQaeu61xhnM9BElDRxRPrDfbgAa2KGxHTLz
         zMbiga5dxjzamRqXilDRGIC4U0e4Su//JVmc1Pl1WsVX52MQaZuHZXV3BOANNrB1EFHP
         Y1sq4WJSz6Rz0kJVK0fcaJ0XLzN7PgRNgqaZoeQRGjHeDrIZy5U0OHw+ZU74M1ROewyT
         4lbiPu0vFY1jsGpRurqB8XLK18CapijpBCPW/1TpwDIFY2sPEBvFEv8Q3bvgjL4UC1mF
         J4OQ==
X-Gm-Message-State: AC+VfDyPGyQlO9Pzf62UjR8HgdNQYN8/t+jwURYsy4H0FYZGCXiUfNb5
        NngBSBKyCLVrxPgJ6RIeR5alNL08JuaQIb8wcLCeqAa+mBaGLqMYQchtPtj2Ix89OusJmU9v5sy
        qx36FBr7j57jTcvU6gPEFiAzn0vh1xTOUjMrg7Svk4A==
X-Received: by 2002:adf:f30b:0:b0:311:1390:7b55 with SMTP id i11-20020adff30b000000b0031113907b55mr1318542wro.68.1686917228249;
        Fri, 16 Jun 2023 05:07:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6y5XukSe+P9vq+zfXWohqAIWdKqIQWbdE7ej4TGZZFMtoW9oJ1tfvYWN7PDP7vhBlrCWHGmQ==
X-Received: by 2002:adf:f30b:0:b0:311:1390:7b55 with SMTP id i11-20020adff30b000000b0031113907b55mr1318529wro.68.1686917227945;
        Fri, 16 Jun 2023 05:07:07 -0700 (PDT)
Received: from localhost ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id q7-20020adff947000000b0030af72bca98sm23428851wrr.103.2023.06.16.05.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 05:07:07 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     deller@gmx.de, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, juerg.haefliger@canonical.com,
        u.kleine-koenig@pengutronix.de
Subject: [PATCH] fbdev: broadsheetfb: Add MODULE_FIRMWARE macro
Date:   Fri, 16 Jun 2023 14:07:05 +0200
Message-Id: <20230616120705.1030177-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The module loads firmware so add a MODULE_FIRMWARE macro to provide that
information via modinfo.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 drivers/video/fbdev/broadsheetfb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/broadsheetfb.c b/drivers/video/fbdev/broadsheetfb.c
index b518cacbf7cd..678d182d187d 100644
--- a/drivers/video/fbdev/broadsheetfb.c
+++ b/drivers/video/fbdev/broadsheetfb.c
@@ -1223,3 +1223,5 @@ module_platform_driver(broadsheetfb_driver);
 MODULE_DESCRIPTION("fbdev driver for Broadsheet controller");
 MODULE_AUTHOR("Jaya Kumar");
 MODULE_LICENSE("GPL");
+
+MODULE_FIRMWARE("broadsheet.wbf");
-- 
2.37.2

