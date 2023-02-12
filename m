Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507B8693A03
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 21:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjBLUvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 15:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjBLUvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 15:51:19 -0500
Received: from relay.smtp-ext.broadcom.com (saphodev.broadcom.com [192.19.144.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4DCF757;
        Sun, 12 Feb 2023 12:51:18 -0800 (PST)
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.75.146.107])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 661E0C0000D4;
        Sun, 12 Feb 2023 12:51:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 661E0C0000D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1676235077;
        bh=GKrIYCf+0Gl9AWmvUN8MRMAVt29qZUg+xsdxn48Wdl0=;
        h=From:To:Cc:Subject:Date:From;
        b=HDqJreQZA37Gne8MrKfuzBAf72Ns8bEFvqn8UnAnpC5bVfLnP5O0XAx1KW9ikp/3Y
         KgI/Uol7m1V+STRfqtZ7zANqXN24T53Bg5izlsykSTu2hRNgcEd5rAtNXk9XJYr/uV
         aPhtOgPpIXMQbjX7SSoE6LV+/+NBrl/LJ1n5jyIk=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPS id 2C02E18041CAC6;
        Sun, 12 Feb 2023 12:51:17 -0800 (PST)
Received: by bcacpedev-irv-3.lvn.broadcom.net (Postfix, from userid 28376)
        id 4FC2B101AB0; Sun, 12 Feb 2023 12:51:09 -0800 (PST)
From:   William Zhang <william.zhang@broadcom.com>
To:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        joel.peshkin@broadcom.com, dregan@mail.com, f.fainelli@gmail.com,
        kursad.oney@broadcom.com, tomer.yacoby@broadcom.com,
        jonas.gorski@gmail.com, William Zhang <william.zhang@broadcom.com>,
        kernel test robot <lkp@intel.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Remove file reference for Broadcom Broadband SoC HS SPI driver entry
Date:   Sun, 12 Feb 2023 12:50:54 -0800
Message-Id: <20230212205054.26348-1-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
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

brcm,bcm63xx-hsspi-peripheral-props.yaml is not in use at least for now.
Remove it from the maintainer entry.

Fixes: 80323599e33f ("MAINTAINERS: Add entry for Broadcom Broadband SoC HS SPI drivers")
Reported-by: kernel test robot <lkp@intel.com>
https://lore.kernel.org/oe-kbuild-all/202302121840.GtduUT37-lkp@intel.com/

Signed-off-by: William Zhang <william.zhang@broadcom.com>

---

 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c6a2c3175ea3..df1c71ca1a69 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4306,7 +4306,6 @@ M:	Jonas Gorski <jonas.gorski@gmail.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-spi@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi-peripheral-props.yaml
 F:	Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
 F:	drivers/spi/spi-bcm63xx-hsspi.c
 F:	drivers/spi/spi-bcmbca-hsspi.c
-- 
2.37.3

