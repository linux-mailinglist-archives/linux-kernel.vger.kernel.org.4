Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D73768E492
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 00:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjBGXrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 18:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBGXrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 18:47:31 -0500
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD43C1E5F6;
        Tue,  7 Feb 2023 15:47:29 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-16a291b16bfso11602719fac.7;
        Tue, 07 Feb 2023 15:47:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vAWmZR/9aaO3WMybmYbLUDkoTvTo6BOKFZL8/TINxaA=;
        b=f4KYMB/NZ7PrWPYQ19rQxA2AA5gO1bZ6N1AAdzCq/8Lguwc65E0Oz3wdAAQUs+mg3v
         56YcIkD3WUVIKQd+NnTCo7ESquSjG6K/K3QKxFUrdsBL1cJFERzF+vlh+Qa7LwH0+mbB
         NRXFMpiXVBmnr2N0434UgmMe4DjIj226wK9i+VGEIRI3gr8xeJYyAm35VxL36azPU/8l
         ELyxciEVScpvoNMKrjYbp2fULXQLYey4vId/G7eGRIjF4feC0u4Dp4MDEV/HrB5NfnsT
         YG+kr3ULCPHjd5iHJPpZpBuhCiDO7SXf5HexAVjavs3G5EYLrRWsw/GTI23c+wxD48Jz
         JALg==
X-Gm-Message-State: AO0yUKUSxIml7v0ZAW4oSYXG1KLPoF1A61Oy0OGF6/UanM1lHHp4YV5J
        FAqwNs3g6D/U0DR/CF70bw==
X-Google-Smtp-Source: AK7set9JQFZnr+u4gZZ9ICSs6AWBpiF4jN4aNtR+5RHAAFk2klpfyIyxq6nOD3mXSg6lRIG7IMFNOA==
X-Received: by 2002:a05:6870:2215:b0:16a:14c4:2f27 with SMTP id i21-20020a056870221500b0016a14c42f27mr2631566oaf.2.1675813649005;
        Tue, 07 Feb 2023 15:47:29 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ec46-20020a0568708c2e00b0016a471246absm3030206oab.6.2023.02.07.15.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 15:47:28 -0800 (PST)
Received: (nullmailer pid 201645 invoked by uid 1000);
        Tue, 07 Feb 2023 23:47:27 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: broadcom: stringray: Fix GICv3 ITS node name
Date:   Tue,  7 Feb 2023 17:47:09 -0600
Message-Id: <20230207234709.201229-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GICv3 ITS is an MSI controller, therefore its node name should be
'msi-controller'.

While we're here, fix the unit-address which shouldn't have a comma.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index e05901abe957..59c0b4442741 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -178,7 +178,7 @@ gic: interrupt-controller@2c00000 {
 			      <0x02e00000 0x600000>; /* GICR */
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 
-			gic_its: gic-its@63c20000 {
+			gic_its: msi-controller@63c20000 {
 				compatible = "arm,gic-v3-its";
 				msi-controller;
 				#msi-cells = <1>;
-- 
2.39.1

