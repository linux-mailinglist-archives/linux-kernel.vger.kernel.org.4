Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D3D5B32BC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiIIJE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbiIIJEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:04:20 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552E112D563;
        Fri,  9 Sep 2022 02:04:02 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id fy31so2489394ejc.6;
        Fri, 09 Sep 2022 02:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=fPvofaEf+BM4TxtIyhxZC/zjNI9R8E3LUT46F136ga4=;
        b=V0cXt/H+gZ651uUZmm5iiWwtYqb2u1S6mX/kvwk2irwNgDBDieodH7EdvM2CzPu0TE
         LmPXhFryzDJGiH+0Bq4X4GECAdbCMZFIFhftJft1jpHfDLa1Tcot9wOzdWSD6xiAc5qC
         oeadlFmbDJTQKdApcRJjHcal4kelyTvUFTcdMgnTMQEJXNvJA1+R/F0uTvlcOekx6Y4f
         IomTf06Wtuc+4kGwqGNhA7ThCsd2kMqgMIPoXY7GCHK2VIewPWTPI0m0EtpZxi6l8h+L
         Spu5fr95w8VMv2TwJ8MciXtWHCyKFbeDWr5A8in6zZ6jJc3j36zswvB3e9W/poLTEdYM
         gJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=fPvofaEf+BM4TxtIyhxZC/zjNI9R8E3LUT46F136ga4=;
        b=koZMhKq8YjJmBeH4NxdRVD7Fh8F1hqWtTVc265n19geV3HzkD6XTSQRIu+Agksyd2b
         CC5XqKbrGS5+TQpj0PY3Y1iV9K7yMBPXMKtAw1K2ybGskTJ1QI1P+aMWW4LIp9Fm0W/M
         3ADmc2C0gdK0tuAb8VC9NVwAMbipMdazn8iCbhwC6NOoqFVDrPcGpmIadxM+oXw9fmsf
         IztCi3On6toTX+MjY3CPnGqZTOUVFAZhKOuObfuH3VNKfr+z80mYzOsJCMmmRzoG3CLJ
         J0HAh52i/6yb4ep5k5DPRyfP1EnnjuXgl4JhG1AMlY2u++klXWd0UvPWaxbW7/5vZMSm
         qu1Q==
X-Gm-Message-State: ACgBeo1mtxD1JUY04xTtyw+ul2Ou9n6fLL7yfu/d7ziNvA6qUSfeJh4p
        BDDHMLkW1/NHoTmo7dCpzp4=
X-Google-Smtp-Source: AA6agR5KinRgSTiwz5kN6HDarpCdBIq4fZNySV5zqrv/4j6rw46dTQNHhN6XvlLxLoIrOIguD9C/Tg==
X-Received: by 2002:a17:907:8686:b0:773:6f77:f110 with SMTP id qa6-20020a170907868600b007736f77f110mr5960404ejc.547.1662714240883;
        Fri, 09 Sep 2022 02:04:00 -0700 (PDT)
Received: from felia.fritz.box (200116b8261bf1004cd87416af9987ea.dip.versatel-1u1.de. [2001:16b8:261b:f100:4cd8:7416:af99:87ea])
        by smtp.gmail.com with ESMTPSA id nb3-20020a1709071c8300b007303fe58eb2sm659797ejc.154.2022.09.09.02.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 02:04:00 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linuxppc-dev@lists.ozlabs.org, linux-ide@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] ppc: select HAVE_PATA_PLATFORM in PPC instead of creating a PPC dependency
Date:   Fri,  9 Sep 2022 11:03:43 +0200
Message-Id: <20220909090343.21886-2-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220909090343.21886-1-lukas.bulwahn@gmail.com>
References: <20220909090343.21886-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit cc18e0fea790 ("LIBATA: Add HAVE_PATA_PLATFORM to select
PATA_PLATFORM driver") introduces config HAVE_PATA_PLATFORM, and expects
that all architectures simply select this config when the architecture
supports using the PATA_PLATFORM driver.

This is properly implemented already for all architectures except for the
powerpc architecture. Implement this for powerpc now.

Adjust the config of the powerpc architecture to use the config
HAVE_PATA_PLATFORM and simplify the config PATA_PLATFORM to not mention
any specific architecture anymore.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/powerpc/Kconfig | 1 +
 drivers/ata/Kconfig  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 39d71d7701bd..2575e21b6e6b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -237,6 +237,7 @@ config PPC
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI				if PERF_EVENTS || (PPC64 && PPC_BOOK3S)
 	select HAVE_OPTPROBES
+	select HAVE_PATA_PLATFORM
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_EVENTS_NMI		if PPC64
 	select HAVE_PERF_REGS
diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 1c9f4fb2595d..ed3547165528 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -1103,7 +1103,7 @@ config PATA_PCMCIA
 
 config PATA_PLATFORM
 	tristate "Generic platform device PATA support"
-	depends on EXPERT || PPC || HAVE_PATA_PLATFORM
+	depends on EXPERT || HAVE_PATA_PLATFORM
 	help
 	  This option enables support for generic directly connected ATA
 	  devices commonly found on embedded systems.
-- 
2.17.1

