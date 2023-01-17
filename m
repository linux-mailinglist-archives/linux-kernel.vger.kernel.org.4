Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378A166D690
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 08:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbjAQHBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 02:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbjAQHBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 02:01:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C74222CB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 23:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=OxkNjSlXVlJ4YmI0GiKC1n+i2ahh3Atv8xoHuxCrjbE=; b=vVcSqetOtbZrlfLIv4FOfPYP8+
        BZtH4PK4MI7VB8DdMWSyaDkoWsXfgAEi1F+aS7wxibr36gK4XHtGu49nDBdrKJ+QyD/JrBXlxSFR2
        2v7qu8K2Mr5MnqA4gMiM1y00ERfZw8fymW/cGYjiVyn6Rj9iZamHBJdPJvc907EmBAUTto9BmIQjb
        CJ9TzyOojwtDKHePZNy1jUqZLfa8T+ZfCTxeL4XTiU1rRxF46gZwWucBMOI/2gh7QbyBq/F0uco38
        XynZl9P5qrNKXl8csNCMb5p2V+wUPVB2QJ3RJY7y2iO2jjBv8sUDKVMl+RJ1gbezFoSwRKKCmZ+TW
        +wgqf3Yg==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHfyX-00D75u-8n; Tue, 17 Jan 2023 07:01:41 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrei Stefanescu <andrei.stefanescu@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] regulator: mcp16502: add enum MCP16502_REG_HPM description
Date:   Mon, 16 Jan 2023 23:01:39 -0800
Message-Id: <20230117070139.28905-1-rdunlap@infradead.org>
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

Fixes: 3e5532a011b0 ("regulator: mcp16502: adapt for get/set on other registers")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrei Stefanescu <andrei.stefanescu@microchip.com>
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
---
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
