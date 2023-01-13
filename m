Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC5C668EA3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 08:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241146AbjAMG7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 01:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjAMG6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 01:58:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4CD6B198
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 22:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=OYErp9cwiDlOFIrBQwCTSkpcQkF/bRlYz/F0lK7TdgM=; b=lVVywf2tSABQ0wxEDCL1lvr0K0
        Aer1TuBlAT4E0aHfDGvlDinDej1u5+RtJFDiqu2VbXCO5eD+XKCfP6cvE2sd73Xm2LTpnsTPImGSf
        64S0pGOXmrJFymnaYL68POR4eL9L8/2nJY2qEkKBByv22JOzr1OptyOvxUkouG14WdfCbOki1Fokq
        /W/YXuBSDGPssvXn7A5GZhyNjBOgj1Ru55cqrSmZr+VZZQOsGWEzXoc1pnNqBnCPzF1mTM1IaMmD9
        ZvbvQBlugfUhcJcTCarr+wKVJSd3DDPt+dXjjalXhMGdxN92OFYI+ZED09jkGjp0IQ1unF2Xvhm88
        iwNVAZ6g==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGDna-000rt6-EJ; Fri, 13 Jan 2023 06:44:22 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] regulator: fixed-helper: use the correct function name in comment
Date:   Thu, 12 Jan 2023 22:44:21 -0800
Message-Id: <20230113064421.11986-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the correct function name and modify the function short description.
This prevents a kernel-doc warning:

drivers/regulator/fixed-helper.c:32: warning: expecting prototype for regulator_register_fixed_name(). Prototype was for regulator_register_always_on() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/fixed-helper.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/regulator/fixed-helper.c b/drivers/regulator/fixed-helper.c
--- a/drivers/regulator/fixed-helper.c
+++ b/drivers/regulator/fixed-helper.c
@@ -20,7 +20,7 @@ static void regulator_fixed_release(stru
 }
 
 /**
- * regulator_register_fixed_name - register a no-op fixed regulator
+ * regulator_register_always_on - register an always-on regulator with a fixed name
  * @id: platform device id
  * @name: name to be used for the regulator
  * @supplies: consumers for this regulator
