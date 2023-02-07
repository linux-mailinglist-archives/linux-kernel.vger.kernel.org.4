Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EB568D008
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 08:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjBGHCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 02:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjBGHB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 02:01:56 -0500
Received: from relay.smtp-ext.broadcom.com (lpdvacalvio01.broadcom.com [192.19.166.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E88137557;
        Mon,  6 Feb 2023 23:01:28 -0800 (PST)
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.75.146.107])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 3AD6FC0000F4;
        Mon,  6 Feb 2023 23:01:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 3AD6FC0000F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1675753264;
        bh=X5cdBYXRB2mwWELEQQJyye+moI+W1M3OCjm+m2greeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OTwAl6PUPWzs1eXx6hPfNWfj1D/ynYN7cwdIE81row63dgG8w9mFcTZytWiafS2cZ
         361H3Biejhr9btfgsvZtStRnQCYfH3ABmFjGM0ZG0ay8RJ1i5PMzdq6Zzhv8+JaIzO
         PGe3ypwZSCDp1jDh5R+qEh0y6yUoDnguZMotdL8c=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPS id 392E818041CAC6;
        Mon,  6 Feb 2023 23:01:04 -0800 (PST)
Received: by bcacpedev-irv-3.lvn.broadcom.net (Postfix, from userid 28376)
        id 34C45101B41; Mon,  6 Feb 2023 23:01:04 -0800 (PST)
From:   William Zhang <william.zhang@broadcom.com>
To:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     kursad.oney@broadcom.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com, dregan@mail.com, f.fainelli@gmail.com,
        joel.peshkin@broadcom.com, jonas.gorski@gmail.com,
        tomer.yacoby@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 15/15] MAINTAINERS: Add entry for Broadcom Broadband SoC HS SPI drivers
Date:   Mon,  6 Feb 2023 22:58:26 -0800
Message-Id: <20230207065826.285013-16-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230207065826.285013-1-william.zhang@broadcom.com>
References: <20230207065826.285013-1-william.zhang@broadcom.com>
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

The driver and device tree doc were originally authored by Jonas Gorski
and it has been updated from Broadcom recently including the dts yaml
file and a new driver for the updated controller. Add Jonas Gorski and
Broadcom engineers William Zhang and Kursad Oney as the maintainers.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>

---

Changes in v3:
- Add Acked-by tag

 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f0b7181e60a..c7b1d4046940 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4299,6 +4299,18 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/phy/broadcom/phy-brcm-usb*
 
+BROADCOM Broadband SoC High Speed SPI Controller DRIVER
+M:	William Zhang <william.zhang@broadcom.com>
+M:	Kursad Oney <kursad.oney@broadcom.com>
+M:	Jonas Gorski <jonas.gorski@gmail.com>
+R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
+L:	linux-spi@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi-peripheral-props.yaml
+F:	Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
+F:	drivers/spi/spi-bcm63xx-hsspi.c
+F:	drivers/spi/spi-bcmbca-hsspi.c
+
 BROADCOM ETHERNET PHY DRIVERS
 M:	Florian Fainelli <f.fainelli@gmail.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
-- 
2.37.3

