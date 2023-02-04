Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE7868ACA6
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 22:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjBDVoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 16:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjBDVoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 16:44:10 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FBF29411;
        Sat,  4 Feb 2023 13:44:06 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id me3so24465674ejb.7;
        Sat, 04 Feb 2023 13:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gSolVd9RWMTQSGbJqovrCQiB4009f4Lndk05i70gnIY=;
        b=lQ4aNoWvyVyDWs2ag2z6wtGto/556ysvijhmA4FO6nliibbt063l2SOFtxffM+cppz
         xhRj3qEklIxr7eDtOanI05D9BQPhD8XWLCKB2R/ZtY8pWnTbjdiY57pN1D8y3Cdwrt35
         MpgWgKucuXggwxbQz4cCCkjQa268odK4CJ29r8CBmaQewBuWClMoiLIk8wf4qHuQsIA8
         x4WUvhuAILtcInBdzz9k7lW90xQ2Sm4+lQ6JaycC6QRurGD88R0I79uZJlUz6MIAvpH5
         vtG7iKPcJZ6IVKjjFrB3ISJIe1wMWyc7tyw7TfAwGE+Lgf8i5m0yKUaNGeztp/JSaTn9
         6Gkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gSolVd9RWMTQSGbJqovrCQiB4009f4Lndk05i70gnIY=;
        b=YLMPZWLbcZRX1hS+PydGbC63g2L1eMeFduEZ/EHFpgjbBEU0Xgz7Zy43AGj7YDq+Ww
         tYPFO89W9j9TV1pqeIurMRMqP2CP8JlPKepAFX6tcvpzBhmk6up23lj8jyWCNEdr4GKG
         njwHyRAd8CVsvi4qGt7+KD2cqkNZRpl1Tj3irLiRsgrlNc6aejT4lzz8JSrJlfHqo10e
         z/u07jmbxW9tXzLwqPiT32ZEQ0a9fvRpuEvCJLUAzCE5fRiZ/EmshlmzdvaFHfKNE1E7
         MC3/I8tyOF5+sgnZ0ewHs8ZO4Tns2iN3B3HzGOWFE8pFX0Krln/VprRDmMrL4/rT59hH
         qNJw==
X-Gm-Message-State: AO0yUKXKskaGXh7pM+R5iDK6gIcVWf6gz8DuSq7lvuJmGuOsfkQ+nsyv
        OQIKVvBOI7JLSpRbqbBwoBM=
X-Google-Smtp-Source: AK7set/DmWvUisy2uLNLU53cfFYRwZomx58/Y39PhmCOQ6PjHWamFCJNQIzoZ3JtB7cgCoMaskNykQ==
X-Received: by 2002:a17:907:9d08:b0:87b:f7dd:792f with SMTP id kt8-20020a1709079d0800b0087bf7dd792fmr6718214ejc.8.1675547045136;
        Sat, 04 Feb 2023 13:44:05 -0800 (PST)
Received: from arinc9-PC.lan ([37.120.152.236])
        by smtp.gmail.com with ESMTPSA id oq26-20020a170906cc9a00b00886faa3d569sm3295453ejb.58.2023.02.04.13.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 13:44:04 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     John Crispin <john@phrozen.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        erkin.bozoglu@xeront.com
Subject: [PATCH] mips: ralink: make SOC_MT7621 select PINCTRL_MT7621 and fix help section
Date:   Sun,  5 Feb 2023 00:42:49 +0300
Message-Id: <20230204214249.134937-1-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arınç ÜNAL <arinc.unal@arinc9.com>

The dt-binding of the MT7621 SoC uses the pinctrl driver. Therefore, have
this driver selected by default.

The help section for SOC_MT7621 exceeds 80 columns which is the preferred
limit of a single line. A tab character is 8 columns. Rearrange the text
accordingly.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 arch/mips/ralink/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
index f9fe15630abb..06031796c87b 100644
--- a/arch/mips/ralink/Kconfig
+++ b/arch/mips/ralink/Kconfig
@@ -54,10 +54,11 @@ choice
 		select HAVE_PCI
 		select PCI_DRIVERS_GENERIC
 		select SOC_BUS
+		select PINCTRL_MT7621
 
 		help
-		  The MT7621 system-on-a-chip includes an 880 MHz MIPS1004Kc dual-core CPU,
-		  a 5-port 10/100/1000 switch/PHY and one RGMII.
+		  The MT7621 system-on-a-chip includes an 880 MHz MIPS1004Kc
+		  dual-core CPU, a 5-port 10/100/1000 switch/PHY and one RGMII.
 endchoice
 
 choice
-- 
2.37.2

