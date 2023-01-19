Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D94F6738F1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 13:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjASMqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 07:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjASMqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 07:46:37 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB15830FD
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 04:46:35 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id r30so1732797wrr.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 04:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IOwo8LF5UioxJqhtkgv5uSSQrAdJemw90Lq8Kb8EeFo=;
        b=oY0Lrthxd4+vVcPlkK09ziRrRgl11/+NebLTHAxVLMXBB2ziZ1kB1T8lRnywftRkOs
         /vNsLRvx0MCi99iQx+LmgKuigteuSa9CDLMppHb3lnBry/sif99j/3ChEBLCB8pJG9Pd
         G2M0If6qdLf5lD0YATxj0gNaY7nEgn0/l4Hx9BmUsyz3ClyLpoJb4bDFKRNxfR8ku0dc
         riZbhwIcs98qvkHsUhNYdluMfbwbi6vxa+URMxNv4BS9VHkylx8i4tj9nAyxlgYvBgfx
         ebeQDuCl/NUDz7ns10DwJNgpaogsWpjDhtCYGS8IMy3bJxfhOF5luCO/bOd1HX9PVjwT
         RHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IOwo8LF5UioxJqhtkgv5uSSQrAdJemw90Lq8Kb8EeFo=;
        b=OOj1zTxSnxzDDelxqQBhBKnkG16Y9Rm/EQKsHrWH4xaKaGudZ+c61C3BW8DUJv6oUL
         iOK1urs5MmCAvHmpEzr6ScvhJZF0SG4WcXcLpC56qR0HD/sXDJuVy/8yubpyGQ8SRvgg
         5b3DkNHy3Hr3l4t/t35/RMvir2RbzLLWyHq0VSSHaUorS0MBzCFzR12k12Gm2MlJiovm
         CQdzvKgxPoPSBPIPdwhMY40H2k2OB70xNw9HqF3hlLKq2jgmdm5tnl0/H2PlwStyJORV
         mH7PtFFQn/L1/vKOxrxlnnYcBHcPwas17nt2Ps6mUJr5to+lJ/eIclkJbxCotb4XNskM
         qnNQ==
X-Gm-Message-State: AFqh2krVRNCM+QwgkAwLeYghdSW8hhYYCFg+HvbwkRMlksEhqDkhsxbq
        Sw3XXGydQlC7Fyv492Nmr47SaQ==
X-Google-Smtp-Source: AMrXdXs3cahP4mQWRJh7rjtkg/wq952cF8AzYtCROCEUoJTTFAa9fHarynjDeD8CeKnZZ4vaaZM4xQ==
X-Received: by 2002:a05:6000:1708:b0:2bd:daf1:9e4c with SMTP id n8-20020a056000170800b002bddaf19e4cmr10737273wrc.43.1674132394400;
        Thu, 19 Jan 2023 04:46:34 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o15-20020a5d62cf000000b002bbedd60a9asm27918175wrv.77.2023.01.19.04.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 04:46:34 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: rockchip: align rk3399 DMC OPP table with bindings
Date:   Thu, 19 Jan 2023 13:46:31 +0100
Message-Id: <20230119124631.91080-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bindings expect certain pattern for OPP table node name and underscores
are not allowed:

  rk3399-rock-pi-4a-plus.dtb: dmc_opp_table: $nodename:0: 'dmc_opp_table' does not match '^opp-table(-[a-z0-9]+)?$'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
index 6e29e74f6fc6..783120e9cebe 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
@@ -111,7 +111,7 @@ opp05 {
 		};
 	};
 
-	dmc_opp_table: dmc_opp_table {
+	dmc_opp_table: opp-table-3 {
 		compatible = "operating-points-v2";
 
 		opp00 {
-- 
2.34.1

