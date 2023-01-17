Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D069166E6F0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjAQT1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234067AbjAQTS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:18:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA65329E1E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=qIZV5K+/xr1UoFFR6Rbeq72ce6bK5Ezfx6CLbuorILw=; b=acdEQGlGDVaYZ9+w6V4F2qm1c9
        MZMCk+p+IbQLerrd14XN5KIcqCPj5YqLffiGtXcGSCuc096GXcYJsf4566cDtDKLhsx0NiPBv0WAf
        Db+aBmF7j2iWzb7VC/G2uBD5bqFi/64phkbP/8yjObKBwqwOXbVD/e+Q9yXYQOmTW7bS9Q5VS8POl
        zLRsQwNLXhxnZ7sPKgsqow++F3M565TVYFWwKWmXwzeluAqJjBdAdrNSFSSvr9MpU1klyKQr3LKcK
        oieHC4P9I+hLDpRw+pPkHikkHu1vya61A42MfewEpbFwL4C5/aTlXLLKQV0YUjd6rVUctCYxoCNtC
        vbTiDngw==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHqjs-00FS6D-Fr; Tue, 17 Jan 2023 18:31:16 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrei Stefanescu <andrei.stefanescu@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] regulator: mcp16502: add enum MCP16502_REG_HPM description
Date:   Tue, 17 Jan 2023 10:31:15 -0800
Message-Id: <20230117183115.1910-1-rdunlap@infradead.org>
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

Add description for MCP16502_REG_HPM to prevent a kernel-doc warning:

drivers/regulator/mcp16502.c:90: warning: Enum value 'MCP16502_REG_HPM' not described in enum 'mcp16502_reg'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrei Stefanescu <andrei.stefanescu@microchip.com>
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
v2: remove Fixes: tag, add Rev-by.

 drivers/regulator/mcp16502.c |    1 +
 1 file changed, 1 insertion(+)

diff -- a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
--- a/drivers/regulator/mcp16502.c
+++ b/drivers/regulator/mcp16502.c
@@ -77,6 +77,7 @@
  * @MCP16502_REG_A: active state register
  * @MCP16502_REG_LPM: low power mode state register
  * @MCP16502_REG_HIB: hibernate state register
+ * @MCP16502_REG_HPM: high-performance mode register
  * @MCP16502_REG_SEQ: startup sequence register
  * @MCP16502_REG_CFG: configuration register
  */
