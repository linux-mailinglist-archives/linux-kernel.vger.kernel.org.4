Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C62D687591
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 06:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjBBFvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 00:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjBBFu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 00:50:57 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A8D84B41;
        Wed,  1 Feb 2023 21:49:18 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id cq16-20020a17090af99000b0022c9791ac39so4534992pjb.4;
        Wed, 01 Feb 2023 21:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WJHXGcMPbsm+TmmE5w1mIelrfxQREvYv7aDDpU6QASI=;
        b=qrdSJen2Lhi8KMNi67rpuVfFDR2u1/7ixhoCQBMKUvNNf6F9XwVmZlkklNVvfBuK1d
         SXS45Mo6t87Cg+7uAKrTVcv/+Imq81X0NWXZb6ljcZtN2wauRc7C1za2p75XRwx9nqFL
         glgc/ftarg/ODmKm57NdK71oeBOU0UggyfcB8y1YaGjDgECdz+NIaO/V9/NdIaxbtb8A
         9QAIrUTCOIb5TFAWizCzB+1EKnDMtANWQ9AnJ5VIJn4jGC02A7AUipDBa6RB8BG7DahO
         cqnIOC620Ss/zar7/cJ0h2V4qNo4zQFd1HCJmWMg+KFBu026cSjUjudJhUQ1qfiIJjp3
         Mbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WJHXGcMPbsm+TmmE5w1mIelrfxQREvYv7aDDpU6QASI=;
        b=ytfW6OopMnBg2dpD1nrVGeQpuFzr6SB9oD11qGiM4vlHsd6trXhU8W8dpNbWizV+ku
         sSWdj4/FzKzPcJ9rqDi7/x+A1yWTR80x2Ot3qjijQUPnHGtDYi4sw+rlCaarJQg8LSkQ
         uDyG5uI8+XWj6i57yEOf1PAc1bDNwBV4MayDrUxGaKioXwT7KW7blW8GlprQoGXDfXcx
         5ZDlx8wbU7l1EVKcsv9h/J2ZT4M6cp/lmhgiYQ6NFcn101inm6vZ4BentwV7d/nC9df8
         x/A3vNhxsazXkraJ1iOJVDZ2nAJlMMoDEtMCIIGqgGQVr9+dWEpB8hRkHqJSgXxxzqXh
         lovQ==
X-Gm-Message-State: AO0yUKWCarx4vKMqAf2IgkyFS6Nd8I00qEzqV6BNqAu7YZ4zY9m6xUiH
        axRX427JuKAEsLCgmDJY7a3nregFTO9mc/VE
X-Google-Smtp-Source: AK7set/HgJa7X3WaoyT0tTT3yKffJPnO8l0WP5fQK9tcre9o2nIaxnhSWDbxn8wrNkqldQ5FVFKObw==
X-Received: by 2002:a17:902:e748:b0:196:6308:c9d3 with SMTP id p8-20020a170902e74800b001966308c9d3mr6482887plf.0.1675316957436;
        Wed, 01 Feb 2023 21:49:17 -0800 (PST)
Received: from jamie-desktop.lan ([2001:8003:cce7:dc00:39b1:aea0:8c97:186])
        by smtp.gmail.com with ESMTPSA id ik26-20020a170902ab1a00b001895f7c8a71sm12686145plb.97.2023.02.01.21.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 21:49:16 -0800 (PST)
From:   Jamie Douglass <jamiemdouglass@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Petr Vorel <petr.vorel@gmail.com>,
        Dominik Kobinski <dominikkobinski314@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Jamie Douglass <jamiemdouglass@gmail.com>,
        Petr Vorel <pvorel@suse.cz>
Subject: [PATCH v2] arm64: dts: qcom: msm8992-lg-bullhead: Correct memory overlaps with the SMEM and MPSS memory regions
Date:   Thu,  2 Feb 2023 16:48:19 +1100
Message-Id: <20230202054819.16079-1-jamiemdouglass@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

The memory region reserved by a previous commit (see fixes tag below)
overlaps with the SMEM and MPSS memory regions, causing error messages in
dmesg:
	OF: reserved mem: OVERLAP DETECTED!
	reserved@5000000 (0x0000000005000000--0x0000000007200000)
	overlaps with smem_region@6a00000
	(0x0000000006a00000--0x0000000006c00000)

	OF: reserved mem: OVERLAP DETECTED!
	reserved@6c00000 (0x0000000006c00000--0x0000000007200000)
	overlaps with memory@7000000
	(0x0000000007000000--0x000000000ca00000)

This patch resolves both of these by splitting the previously reserved
memory region into two sections either side of the SMEM region and by
cutting off the second memory region to 0x7000000.

Fixes: 22c7e1a0fa45 ("arm64: dts: msm8992-bullhead: add memory hole region")
Signed-off-by: Jamie Douglass <jamiemdouglass@gmail.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>

---
v1 -> v2: Added detail about second memory overlap and fixed commit to commit
message
---
 arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi b/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi
index 79de9cc395c4..5e375ea73c79 100644
--- a/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi
@@ -53,8 +53,13 @@ cont_splash_mem: memory@3400000 {
 			no-map;
 		};
 
-		removed_region: reserved@5000000 {
-			reg = <0 0x05000000 0 0x2200000>;
+		reserved@5000000 {
+			reg = <0x0 0x05000000 0x0 0x1a00000>;
+			no-map;
+		};
+
+		reserved@6c00000 {
+			reg = <0x0 0x06c00000 0x0 0x400000>;
 			no-map;
 		};
 	};
-- 
2.25.1

