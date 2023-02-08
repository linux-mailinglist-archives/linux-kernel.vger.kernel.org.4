Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48A868F624
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjBHRxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjBHRxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:53:06 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F53C5278
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:53:05 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id n132so1686814oih.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 09:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LSfgmHIZnIl2zNyWMyXqpCYt+vH29jA6dvbtFBb/0fM=;
        b=JWFDqbheTcrXXsmy+6eGyTKyBReLQO0vyGRPfm9zagkFy0NUPaUZVQX2tolzAV+qoG
         ObhbLO6tfV0Ce6aiXaehCdEY40QKAr0eVeaJEO5ZB/SEjRWEilAdAYd5waS8yCTA1y+N
         lrKimZKz39LMLTPNOaiCGeCFmi24QU17tulGYCmLP9WPWbc88YMQegUG7+ogzgk43n7E
         K7WaLNIyoarzmaFagzdmvoonsmZmTb1UwJHAWKuZry1lqeGdp9JmptEMZMlJD4E42f75
         W/d3vSUxcT0250WOvBw6wpMEK8wWy3hpDw8WBedxzjdg4ffPY0jDyUoLJ3YygI2WA0Ta
         /UNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LSfgmHIZnIl2zNyWMyXqpCYt+vH29jA6dvbtFBb/0fM=;
        b=xestGNFdLB8jmGEJtqDxulDjXn7AxB/UMU3Bwtu+e9VCgs/BEtu8oLKGhcvdH0i1m4
         l45TojyewIjYiYbpOuJDj8L5/apZAIvC7hKYQYIWB0JS64itoNavRqlS63PKlly/SbTR
         YMpDWikjxf0uajO45ClwmDtp1bqn+blj5H5eXi+kgFld0H5q96Zo3mGADaVw/EGghpDL
         96OhmD1n+RbFngsvqdSAjoyaRAyqkL96Us3McZg6drgk0I6sbfMKM/Bl0uhLe3Jq30Qp
         perGmus0tS6jf2CLXyDSLODGHgehn310utBF6ySs06RqROqCrAG//TbVKKY9OR3RZLqO
         YGJQ==
X-Gm-Message-State: AO0yUKXt6QcPghQPp10P2P0sC2JD0nTmVSdkCnzmtgkReJ15IRRkoTWP
        zlqASuwIeC7Xe1OsgdHjbHiw0A==
X-Google-Smtp-Source: AK7set8obQpznCYM0FQ0CO46Cz5b0n/SF7X6ncai4VaiRr8NX5J3ge5F3573CgIYM/Fj3HGb6sqYvw==
X-Received: by 2002:a05:6808:647:b0:377:f87c:2b27 with SMTP id z7-20020a056808064700b00377f87c2b27mr3638702oih.36.1675878784466;
        Wed, 08 Feb 2023 09:53:04 -0800 (PST)
Received: from fedora.capitalinasdc.com ([190.123.123.9])
        by smtp.gmail.com with ESMTPSA id r24-20020a0568080ab800b003783caeaf61sm7282094oij.13.2023.02.08.09.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 09:53:04 -0800 (PST)
From:   Mauro Lima <mauro.lima@eclypsium.com>
To:     mika.westerberg@linux.intel.com
Cc:     broonie@kernel.org, michael@walle.cc, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mauro Lima <mauro.lima@eclypsium.com>
Subject: [PATCH] spi: intel: Update help text of PCI driver
Date:   Wed,  8 Feb 2023 14:52:53 -0300
Message-Id: <20230208175253.117714-1-mauro.lima@eclypsium.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modern intel hardware uses controllers that work in hardware
sequencing mode. In this mode, the controller exposes a subset
of operations, like read, write and erase, making it easier
and less error-prone for use.
On the other hand, most of the controllers handled by the
platform driver use software sequencing that exposes the
entire set of opcodes i.e. include the low-level operations
available from the controller.

Since the PCI driver works with modern controllers, remove the
DANGEROUS tag from it.
Update the driver's help text and leave the DANGEROUS tag of
the platform driver.

Signed-off-by: Mauro Lima <mauro.lima@eclypsium.com>
---
 For the record of the base commit:

 Given that the PCI driver handles controllers that only work with
 hardware sequencing, we can remove the dangerous tag.
 This patch is the second part of Mika's suggestion [1].
 The first part was accepted in [2].

 [1] https://lore.kernel.org/r/Y1d9glOgHsQlZe2L@black.fi.intel.com/
 [2] https://lore.kernel.org/linux-spi/20230201205455.550308-1-mauro.lima@eclypsium.com/

 This patch continues the work addressing the comments in the previous
 patch adding information about hardware and software sequencing.
 Discussion: https://lore.kernel.org/r/20230206183143.75274-1-mauro.lima@eclypsium.com/

 drivers/spi/Kconfig | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 3a362c450cb6..9eb3c72d7cd8 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -454,13 +454,16 @@ config SPI_INTEL_PCI
 	select SPI_INTEL
 	help
 	  This enables PCI support for the Intel PCH/PCU SPI controller in
-	  master mode. This controller is present in modern Intel hardware
-	  and is used to hold BIOS and other persistent settings. This
-	  driver only supports hardware sequencing mode. Using this
-	  driver it is possible to upgrade BIOS directly from Linux.
+	  master mode. This controller is used to hold BIOS and other
+	  persistent settings. Controllers present in modern Intel hardware
+	  only work in hardware sequencing mode, this means that the
+	  controller exposes a subset of operations that makes it easier
+	  and safer to use. Using this driver it is possible to upgrade BIOS
+	  directly from Linux.
 
-	  Say N here unless you know what you are doing. Overwriting the
-	  SPI flash may render the system unbootable.
+	  Say N here unless you want to overwrite the flash memory and
+	  know what you are doing or you want to read the memory's content.
+	  Overwriting the SPI flash may render the system unbootable.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called spi-intel-pci.
@@ -473,8 +476,10 @@ config SPI_INTEL_PLATFORM
 	help
 	  This enables platform support for the Intel PCH/PCU SPI
 	  controller in master mode that is used to hold BIOS and other
-	  persistent settings. Most of these controllers are using
-	  software sequencing mode. Using this driver it is possible to
+	  persistent settings. Most of these controllers work in
+	  software sequencing mode, which means that the controller
+	  exposes the full set of operations that supports, making it
+	  more complex for use. Using this driver it is possible to
 	  upgrade BIOS directly from Linux.
 
 	  Say N here unless you know what you are doing. Overwriting the

base-commit: 7db738b5fea4533fa217dfb05c506c15bd0964d9
-- 
2.39.1

