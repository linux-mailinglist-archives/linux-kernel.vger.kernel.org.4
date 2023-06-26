Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E8673EE87
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 00:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjFZWMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 18:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbjFZWL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 18:11:57 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0666D30DE;
        Mon, 26 Jun 2023 15:10:10 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-78362f57500so46562339f.3;
        Mon, 26 Jun 2023 15:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687817409; x=1690409409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gXVzfpbKiVE2Um8xkwdkPXmLDJPJN7uoe/+dP9OECgU=;
        b=bqSzDUFzAuCVpNUUROGXqezi640VlBZ7Cz2rv4pi+ixzmnUba4NX6l767EJu/XChgg
         ByVAXostNAMjTAVC0bfKMc52iDSlGFpc1kMwXnVujBJoa04rt+GsK2FQkVj9fPxQimmp
         Qo8BV8P4BDModqtoH+aOBrEKasAnFOgs4Uo0DgPG7MikpSflIDM/fT5QAkfbFSd8YGXr
         clihCE91m08IhMZnN239wcNsM/YJ1C50Z0NQvkdPwsnByrvwLlx0yYqxiu6ioAAeokly
         MTkgs+ARqnXTaSkpf8Njoy4R0Hmj8J3hPTYIUc3lOFCGG7DXaexT8dNFxyhbbEbCw6d9
         x7Kg==
X-Gm-Message-State: AC+VfDx9jlvYrxG8vYLW/mWvZLazZ4A82qFaSa8ulYjDXOYmtaGoxqaV
        COkp0gWOTGMx5+8dFNFuTw==
X-Google-Smtp-Source: ACHHUZ6Em2q77BZkyb3EXRuKN1+CG0wJU+b/3s/pA+hq0hKLcPgEgO9eqtGefN34Dkkz/L0vdBeH/A==
X-Received: by 2002:a6b:d307:0:b0:780:ce72:ac55 with SMTP id s7-20020a6bd307000000b00780ce72ac55mr13596230iob.10.1687817408914;
        Mon, 26 Jun 2023 15:10:08 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z22-20020a6be216000000b0076c5926b381sm2455806ioc.31.2023.06.26.15.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 15:10:08 -0700 (PDT)
Received: (nullmailer pid 3946180 invoked by uid 1000);
        Mon, 26 Jun 2023 22:10:06 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] arm64: dts: mediatek: Fix "status" values
Date:   Mon, 26 Jun 2023 16:10:05 -0600
Message-Id: <20230626221005.3946136-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The defined value for "status" is "disabled", not "disable".

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
index e4605d23fdc8..86cedb0bf1a9 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
@@ -585,11 +585,11 @@ &pwrap {
 };
 
 &sata {
-	status = "disable";
+	status = "disabled";
 };
 
 &sata_phy {
-	status = "disable";
+	status = "disabled";
 };
 
 &spi0 {
-- 
2.40.1

