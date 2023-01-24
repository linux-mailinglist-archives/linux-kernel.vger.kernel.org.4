Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D5C67A102
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 19:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbjAXSQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 13:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbjAXSQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 13:16:37 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B68C4DE2C
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 10:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=M/NsWGrrXmmeAKvr09ygsHhxnBseRzplQF5IpT+Ld3g=; b=JVDyieZFu6rpXB+bnXWbXfhh/D
        IEURkDIi78046+1Wg4qZuypwCH1BqXq/Yht+hTJv/imXWFnoZIo7X3+/40RgzqLVsP9mqGbiq37qm
        ALAf2AiO4W6gGYZA4OMI/hO/kU/2DmpsuwtTPPBq8chYT2iEVap+UbQNpoY4hBEcyUtgZWGeEaSE4
        z3knfbVIvYJDbE3v6Xqs/ZNSzUqgFTTZw8+NOKcxyN0lT0UCZ+w0L9tBkSGtpuQqK1482tvVmTeh5
        Qc0rsQ/849WBr5OrToLcOPMibC7U3A2pk+Yp0+pkRyvP1X44gW01j3/QbCU7sN6dKT8o16z3DgSgP
        Q+tkBdwQ==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKNqS-004vXG-Gw; Tue, 24 Jan 2023 18:16:32 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH] cramfs: Kconfig: fix spelling & punctuation
Date:   Tue, 24 Jan 2023 10:16:31 -0800
Message-Id: <20230124181631.15204-1-rdunlap@infradead.org>
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

Fix spelling and hyphenation in cramfs Kconfig.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Nicolas Pitre <nico@fluxnic.net>
---
 fs/cramfs/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/fs/cramfs/Kconfig b/fs/cramfs/Kconfig
--- a/fs/cramfs/Kconfig
+++ b/fs/cramfs/Kconfig
@@ -38,7 +38,7 @@ config CRAMFS_MTD
 	default y if !CRAMFS_BLOCKDEV
 	help
 	  This option allows the CramFs driver to load data directly from
-	  a linear adressed memory range (usually non volatile memory
+	  a linear addressed memory range (usually non-volatile memory
 	  like flash) instead of going through the block device layer.
 	  This saves some memory since no intermediate buffering is
 	  necessary.
