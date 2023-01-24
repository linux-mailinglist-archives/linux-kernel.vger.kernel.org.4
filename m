Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18E867A6E5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 00:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbjAXXfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 18:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbjAXXfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 18:35:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44DE4B8B6;
        Tue, 24 Jan 2023 15:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=j+Ij8B4FmQFzvhgIaXBGR57xyNuw6Bm4LHaUavMwE6g=; b=ixccSXnLSZJeIlIrTBeheJOgX6
        SvDt6Lr3ekDqiMtiEw6jTPn0n3xZj28qtV02dkFP09ZkGcPo5OFBHaA/6EYOTRCnRMV6vZIuqCwYF
        na/rfYnlXh3Z27FLtca9Y2T7wy5fP6R5g4meF7W39vf6N+ZBMfChS9jYnFKfNulXOI4zy+ukvKxLy
        S0NurMDlsu6Sh1ROzipUcCIGjAFvfCG31vvIqehOB3fkZwxDBmCqEqHPRUGonWpbM2eD75br5say4
        oD2Gz06LifCnAPREG0QAxNOvXMLoTLoUORgB6YwBEwC8MHgfccABeSw2nXHlg75/0erdgiIxTe21i
        e9dmxvzA==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKSoh-005eFZ-2N; Tue, 24 Jan 2023 23:35:03 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH] spi: Kconfig: fix a spelling mistake & hyphenation
Date:   Tue, 24 Jan 2023 15:35:02 -0800
Message-Id: <20230124233502.23330-1-rdunlap@infradead.org>
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
Also hyphenate "8-bit".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
---
 drivers/spi/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/spi/Kconfig b/drivers/spi/Kconfig
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -247,7 +247,7 @@ config SPI_CADENCE_XSPI
 	  Enable support for the Cadence XSPI Flash controller.
 
 	  Cadence XSPI is a specialized controller for connecting an SPI
-	  Flash over upto 8bit wide bus. Enable this option if you have a
+	  Flash over up to 8-bit wide bus. Enable this option if you have a
 	  device with a Cadence XSPI controller and want to access the
 	  Flash as an MTD device.
 
