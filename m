Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53FB85BDD2B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiITG3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiITG3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:29:34 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1526BCF0;
        Mon, 19 Sep 2022 23:29:34 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id l65so1804831pfl.8;
        Mon, 19 Sep 2022 23:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=YBtQZeH3wsdy40ng7vXdH8dANci6zTn7e1xBfD0d/f0=;
        b=MsgnZ+iOa9wkQMTHj5bFMWzt5obd9fz7I+spLbys6vPAhOSrtaldoyga6JSM11mQEA
         DvKwMPReJ5XGAggd/L9QlXBFR8GesL9P1L1Zt78mYw14Zs0v8zByr6WHpWziEqeswppk
         KHgKRrNomzf8UL4XuLzReLdiYAU55e2ihFiXW+GPFo7j8V+CmCmjsqk+CqtBAWy0ieap
         77mNALcAOeO/6kctOAy6FWxrgxT9ggj3IAyukjqnFyc+hdtlfyA3PZdiwqS8uCNLyvra
         b7i9NGZotqSWSTShORBtFW78wUU0i7iSCERM0R4PfxoUQxvDqtEd2icWrxkZCOlydk86
         olTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=YBtQZeH3wsdy40ng7vXdH8dANci6zTn7e1xBfD0d/f0=;
        b=BSi2hwHDe+efHBtD2LrpU3MWELiiJG+pZsq+8opEP0XfJk3UUK1a8tvmEZfND7t/z2
         TxW6hygNlH0TFN2AyU+6qZY1LbmqcI7hFoSlXbtVQIni4fw6ydj1q6vz3FoFP346ClBv
         /Z0e0XwiYQwmG+X45UAr8EJplbZ4+NRnzhvZnJKOPRiMRvCsXp71XkwPB5cLglqHSFzR
         uvw3srbZ90oc21k7CyUFVEcLb3dYtKVhEMOgyJf9NhA7NxB/DZxwxI9RBvpCXph006B5
         VWa606I5C9j1hPddbr6CTRqUR1J0mxRm9sRc++C47GCMIC3e8+/kKlAmZD2wA2jhZRBy
         pq9Q==
X-Gm-Message-State: ACrzQf0zSXYAmtqYO4qdpNdZnEinp3X/nz+beC3Nx3jqHFPhg2nq9qr9
        ZQF7ZKXiwYPX5FPXSFQ3IaA=
X-Google-Smtp-Source: AMsMyM5ufZI+Y9ZWKSTRThW4JnMXGcte3B1lKcUAbYnJAhoyq/80A2R8l/c9nQakca/dWEzTWZ65bw==
X-Received: by 2002:a65:6055:0:b0:42a:7b2b:dc71 with SMTP id a21-20020a656055000000b0042a7b2bdc71mr18632465pgp.23.1663655373582;
        Mon, 19 Sep 2022 23:29:33 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id n4-20020a1709026a8400b0016d5b7fb02esm530773plk.60.2022.09.19.23.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 23:29:32 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     damien.lemoal@opensource.wdc.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] ata: libata-eh: Remove the unneeded result variable
Date:   Tue, 20 Sep 2022 06:29:29 +0000
Message-Id: <20220920062929.214976-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value ata_port_abort() directly instead of storing it in
another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/ata/libata-eh.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 7c128c89b454..7dbca2a2f9ee 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1086,14 +1086,11 @@ static void __ata_port_freeze(struct ata_port *ap)
  */
 int ata_port_freeze(struct ata_port *ap)
 {
-	int nr_aborted;
-
 	WARN_ON(!ap->ops->error_handler);
 
 	__ata_port_freeze(ap);
-	nr_aborted = ata_port_abort(ap);
 
-	return nr_aborted;
+	return ata_port_abort(ap);
 }
 EXPORT_SYMBOL_GPL(ata_port_freeze);
 
-- 
2.25.1
