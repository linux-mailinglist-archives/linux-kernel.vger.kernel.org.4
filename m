Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8276867A6E3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 00:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjAXXfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 18:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233737AbjAXXe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 18:34:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA21E4ED27;
        Tue, 24 Jan 2023 15:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=z33pQjo2sqnjX+oWqsRt7jj4kSZj16MMYd3bF/XJY6w=; b=CAxqrX95Ee2z8b587wMhEVQP84
        SRUdVoImnHfKD4VhbmSKs05kcM1kEKWVlWfqheOCMaKeYvVIsch0kjD/L13OxfSUN5zr9DTAFrzIV
        sBQXwKBdbVQzbThd8NnshGbKpoRhV2wvnyuEjcJ3wqPLStrtjO4xhntq/thtHG6biO3cERVMcOv0n
        baJSTC0s6/Kq7VxEAAb8F2l3AIbc2KVIfLnWeyOmZf7TWJA1cjX5/ijncOxV5fqc6edT3D6oJHge6
        xQyIElNus6txtxxDGj8JxGfTFdif8gHykBf2Q12YnChWS5/0NMGBGEoj/RBUkmkdFOvgVQrwR/QFq
        AESZYfgw==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKSoX-005eDw-Mu; Tue, 24 Jan 2023 23:34:53 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Subject: [PATCH] input: keyboard: fix a Kconfig spelling mistake & hyphenation
Date:   Tue, 24 Jan 2023 15:34:53 -0800
Message-Id: <20230124233453.22893-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
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

Correct a spelling mistake (reported by codespell).
Also hyphenate "matrix-based".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
---
 drivers/input/keyboard/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -557,7 +557,7 @@ config KEYBOARD_PMIC8XXX
 	help
 	  Say Y here if you want to enable the driver for the PMIC8XXX
 	  keypad provided as a reference design from Qualcomm. This is intended
-	  to support upto 18x8 matrix based keypad design.
+	  to support up to 18x8 matrix-based keypad design.
 
 	  To compile this driver as a module, choose M here: the module will
 	  be called pmic8xxx-keypad.
