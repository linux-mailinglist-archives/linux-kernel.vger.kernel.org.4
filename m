Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F5267A5DE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbjAXWdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjAXWdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:33:09 -0500
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A49D166DE;
        Tue, 24 Jan 2023 14:32:58 -0800 (PST)
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.75.146.107])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 7CEBFC0000F9;
        Tue, 24 Jan 2023 14:32:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 7CEBFC0000F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1674599578;
        bh=nD1KpnDkpUNo11OODNuViOerymv9SHb7k88sIN3OWIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ElxtsRQB2etoL7Qa2QfGbQXU1czyajDzS6zrLO00vrByVqYzSof6stO2UQNuEb5m5
         R3LDVOPi3F46JHQJuPIZfTcOJ8Hod3CSCB0h5kAD69z4TAMgDyIGC2/KX7EtWBKk9U
         Z25pn1k3gbFeTBPhmxZ7IQttvfUqpX5i5PA0e1b8=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPS id 7B36718041CAC6;
        Tue, 24 Jan 2023 14:32:58 -0800 (PST)
Received: by bcacpedev-irv-3.lvn.broadcom.net (Postfix, from userid 28376)
        id D1876101ACF; Tue, 24 Jan 2023 14:32:51 -0800 (PST)
From:   William Zhang <william.zhang@broadcom.com>
To:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     tomer.yacoby@broadcom.com, kursad.oney@broadcom.com,
        dregan@mail.com, f.fainelli@gmail.com, anand.gore@broadcom.com,
        jonas.gorski@gmail.com, dan.beygelman@broadcom.com,
        joel.peshkin@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/14] spi: bcm63xx-hsspi: Add new compatible string support
Date:   Tue, 24 Jan 2023 14:12:08 -0800
Message-Id: <20230124221218.341511-6-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230124221218.341511-1-william.zhang@broadcom.com>
References: <20230124221218.341511-1-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New compatible string brcm,bcmbca-hsspi-v1.0 is introduced based on dts
document brcm,bcm63xx-hsspi.yaml. Add it to the driver to support this
new binding.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
---

(no changes since v1)

 drivers/spi/spi-bcm63xx-hsspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index b871fd810d80..01d5acad4a1b 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -516,6 +516,7 @@ static SIMPLE_DEV_PM_OPS(bcm63xx_hsspi_pm_ops, bcm63xx_hsspi_suspend,
 
 static const struct of_device_id bcm63xx_hsspi_of_match[] = {
 	{ .compatible = "brcm,bcm6328-hsspi", },
+	{ .compatible = "brcm,bcmbca-hsspi-v1.0", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bcm63xx_hsspi_of_match);
-- 
2.37.3

