Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BC36911BD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 21:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjBIUEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 15:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjBIUEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 15:04:07 -0500
Received: from relay.smtp-ext.broadcom.com (lpdvacalvio01.broadcom.com [192.19.166.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3F068110;
        Thu,  9 Feb 2023 12:04:06 -0800 (PST)
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.75.146.107])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 2E49BC0000E1;
        Thu,  9 Feb 2023 12:04:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 2E49BC0000E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1675973046;
        bh=nD1KpnDkpUNo11OODNuViOerymv9SHb7k88sIN3OWIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WczsEfNuOepvutZOnz6Vs3PbpJSNBHbWVXpmXWMzNUBGt4ATHOf3fya7vh1ZsHc5R
         C72h5btOGrYPddwugG4VJ5w27x0F+DH+kf/4MJl38Ls+7RUiN5EwR2EHH8cxzvYlqJ
         3llSj1gCky1/NrlCkfQXsWSLRE1EFVpgsWou0mqw=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPS id 2C95618041CAC6;
        Thu,  9 Feb 2023 12:04:06 -0800 (PST)
Received: by bcacpedev-irv-3.lvn.broadcom.net (Postfix, from userid 28376)
        id 2A8E4101B76; Thu,  9 Feb 2023 12:04:06 -0800 (PST)
From:   William Zhang <william.zhang@broadcom.com>
To:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     f.fainelli@gmail.com, dregan@mail.com, joel.peshkin@broadcom.com,
        dan.beygelman@broadcom.com, anand.gore@broadcom.com,
        kursad.oney@broadcom.com, tomer.yacoby@broadcom.com,
        jonas.gorski@gmail.com, William Zhang <william.zhang@broadcom.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/15] spi: bcm63xx-hsspi: Add new compatible string support
Date:   Thu,  9 Feb 2023 12:02:36 -0800
Message-Id: <20230209200246.141520-6-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230209200246.141520-1-william.zhang@broadcom.com>
References: <20230209200246.141520-1-william.zhang@broadcom.com>
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

