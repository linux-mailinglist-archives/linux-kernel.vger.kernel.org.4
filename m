Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C476D6147F8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 11:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiKAKxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 06:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiKAKxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 06:53:30 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4539318344;
        Tue,  1 Nov 2022 03:53:29 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bk15so19532824wrb.13;
        Tue, 01 Nov 2022 03:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NIlPBoCtz6QpUN1X3vooStQnsHabjk5XLtDmnofRRUw=;
        b=OKwCSadba1pnfMQqYV7dbEnIvi4mEDYO6/IstfRqsTENnU/XmV+xYWI8unuUY7nZer
         n9fGwVtsPo5x13rHeYFyhsJNr0BuAZb6hbsYn1pDEUIlfQHNx1V9iTzqrBNPkzz1smOJ
         9VHP5ZLWNhQdeBnFcRM1u1Dl/P10gakdq37NIBdXie1yq08+UizKwlVDK0Li4JylWRa/
         HjOGlQr+m8mqOAksjoeCsQRPgTtayO0Qj9FPJYj2h0gD6se78wARf7hRc3D/Jz1xSzw6
         vUs0a0fN36USCKLSCyY7MN9tkz5RRmNRu4pqmVGkHF/oETxLTHTWidYkgoyk9WR2o6Pd
         PVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NIlPBoCtz6QpUN1X3vooStQnsHabjk5XLtDmnofRRUw=;
        b=ZaNPGajuWrAMAfcEDK21Lz6+671X176vzwgQEq6VJRtj0URlB9sPVr0O2jbrVVuM7l
         VsXVSAynSatnukTt7fqaT3DTMD01H2uLVUATNCWJ0CguSj+eLlPLEU6677nRC1t472RT
         HJDW4F0hjw8I4kbCHIeg7TyKDS2Up4wJzqOS8wwfahZY+r5vEeKjiaYi/k+YWbMesf3r
         1axjg7+25OkFQ6XgqjC6Bzv4fBPIKNan82hmxY6W+5HUl+BYpLOjmVXjK/sZT4z9w5lz
         cWqdoYfTbBwCaxVQmlLIkonepnsjQudTxQZfEVXEfiiHf1MtJsdI9EUOBLxGFKO00NwH
         sXag==
X-Gm-Message-State: ACrzQf0qO238TJQr5L8xdWnNkp++SThXhVM6PqEiC5eGLt+NlfpBWU7+
        8meNMXindj2EJctXuFtm+hK+J5VBcJlY808M
X-Google-Smtp-Source: AMsMyM50FupETc4yErSLUoojwh+tJo45E7lFTJtjgNLvmiiDWXYDII3ozE7x7RrdbkXzvSfU2hjMNg==
X-Received: by 2002:adf:ffc2:0:b0:236:61e8:de52 with SMTP id x2-20020adfffc2000000b0023661e8de52mr11266153wrs.59.1667300007890;
        Tue, 01 Nov 2022 03:53:27 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id e9-20020a05600c4e4900b003c452678025sm9967714wmq.4.2022.11.01.03.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 03:53:27 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: target: core: Remove unused variable unit_serial_len
Date:   Tue,  1 Nov 2022 10:53:26 +0000
Message-Id: <20221101105326.31037-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Variable unit_serial_len is just being assigned and it's never used
anywhere else. The variable is redundant so remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/target/target_core_spc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/target/target_core_spc.c b/drivers/target/target_core_spc.c
index ffe02e195733..621a460ba234 100644
--- a/drivers/target/target_core_spc.c
+++ b/drivers/target/target_core_spc.c
@@ -227,7 +227,7 @@ spc_emulate_evpd_83(struct se_cmd *cmd, unsigned char *buf)
 	struct t10_alua_tg_pt_gp *tg_pt_gp;
 	unsigned char *prod = &dev->t10_wwn.model[0];
 	u32 prod_len;
-	u32 unit_serial_len, off = 0;
+	u32 off = 0;
 	u16 len = 0, id_len;
 
 	off = 4;
@@ -272,13 +272,9 @@ spc_emulate_evpd_83(struct se_cmd *cmd, unsigned char *buf)
 	prod_len += strlen(prod);
 	prod_len++; /* For : */
 
-	if (dev->dev_flags & DF_EMULATED_VPD_UNIT_SERIAL) {
-		unit_serial_len = strlen(&dev->t10_wwn.unit_serial[0]);
-		unit_serial_len++; /* For NULL Terminator */
-
+	if (dev->dev_flags & DF_EMULATED_VPD_UNIT_SERIAL)
 		id_len += sprintf(&buf[off+12], "%s:%s", prod,
 				&dev->t10_wwn.unit_serial[0]);
-	}
 	buf[off] = 0x2; /* ASCII */
 	buf[off+1] = 0x1; /* T10 Vendor ID */
 	buf[off+2] = 0x0;
-- 
2.37.3

