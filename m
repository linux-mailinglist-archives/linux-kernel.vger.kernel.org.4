Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD9F7214AA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 06:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjFDEoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 00:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjFDEoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 00:44:21 -0400
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758CAD3
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 21:44:20 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 5fbGqlk8R8aX95fbGqkWVn; Sun, 04 Jun 2023 06:44:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1685853858;
        bh=yuCvWJusB0jjXwJ/HnT0XtQ4exUNOe6cHL/s4AWv+dQ=;
        h=From:To:Cc:Subject:Date;
        b=aTFm+I9YSsneXEOM9vJJVrcWs/ud1UsnfbBeeaaPXgDK2MLld+4yfcytK3Yo6H7zl
         Dr0uVon4mdyX0pha25rbg/aAGyDp3lCvCVwMlp3FjU4TiLMAt7QeCw6xyG0jSjsfOL
         e6dXBKjpgDBRTY141rPV0MZLruGkKJdCYM/veS78wgOBL9xBCIkFEu91Id4KVlj6Fu
         PIj2fwqSSRF+P7mq1JT6YdZ0tdquMlLJedaV9XPj2not3B+IGr29xHp5Qln0VwfRj/
         kc9/IFM+EkS7O7yNdiVZX3aAH2eqjLLYLc6c/yGGEoSPXVEa/07+85yfYOYTUK9EUB
         +Y2H2yicOoj1w==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 04 Jun 2023 06:44:18 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] cdx: Drop useless LIST_HEAD
Date:   Sun,  4 Jun 2023 06:44:17 +0200
Message-Id: <cee692c7babd754c1c36186af116c4bb4dad0a17.1685853842.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'cleanup_list' is unused, so drop it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/cdx/controller/mcdi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cdx/controller/mcdi.c b/drivers/cdx/controller/mcdi.c
index a211a2ca762e..03e34f214aea 100644
--- a/drivers/cdx/controller/mcdi.c
+++ b/drivers/cdx/controller/mcdi.c
@@ -611,7 +611,6 @@ void cdx_mcdi_process_cmd(struct cdx_mcdi *cdx, struct cdx_dword *outbuf, int le
 {
 	struct cdx_mcdi_iface *mcdi;
 	struct cdx_mcdi_cmd *cmd;
-	LIST_HEAD(cleanup_list);
 	unsigned int respseq;
 
 	if (!len || !outbuf) {
-- 
2.34.1

