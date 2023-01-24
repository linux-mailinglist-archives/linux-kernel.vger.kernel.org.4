Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C28967A6E7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 00:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbjAXXf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 18:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbjAXXf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 18:35:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2E248A0E;
        Tue, 24 Jan 2023 15:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=cW7cNZC1JNVz5VkuhtC1lm6VerU8rpNGQcICMIcoe00=; b=U2L7XbzM0mYZYlKRgl6DCkTrI6
        Pu/xJCucp4Z6E4CHiDoIT+5+aFEh3vh2ffja2LS4vPrHmw4PiQwsmG1419eobpBbQsQJ0W+/wtwOB
        96orFFc0m+yEXkhh3OCHnUfurc8Rqy9DWg9ojRCBTmvqoz7AYi+kmr2ylgXtofAqjc7uxCYqiCmcX
        ZWCaFhIgeywntxC7Br1FnnMAe0T6/EHvqPd4IE5TzMaAXtIytqcWfwXtG72L406hHmZ443aU3JkNz
        cPTDEjGWWsi2+DwRr/y/ZGNPsA8c24LweMhyezXi9PfbOITrh5wsj01/W0UKNxhnGICQrBPyZmb4t
        BF3q21xQ==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKSoq-005eGr-HS; Tue, 24 Jan 2023 23:35:12 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] usb: fotg210: fix a Kconfig spelling mistake
Date:   Tue, 24 Jan 2023 15:35:11 -0800
Message-Id: <20230124233511.23616-1-rdunlap@infradead.org>
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

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-usb@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/fotg210/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/usb/fotg210/Kconfig b/drivers/usb/fotg210/Kconfig
--- a/drivers/usb/fotg210/Kconfig
+++ b/drivers/usb/fotg210/Kconfig
@@ -29,7 +29,7 @@ config USB_FOTG210_UDC
 	bool "Faraday FOTG210 USB Peripheral Controller support"
 	help
 	   Faraday USB2.0 OTG controller which can be configured as
-	   high speed or full speed USB device. This driver suppports
+	   high speed or full speed USB device. This driver supports
 	   Bulk Transfer so far.
 
 	   Say "y" to link the driver statically, or "m" to build a
