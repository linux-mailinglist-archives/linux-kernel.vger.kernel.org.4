Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C5D6595E4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 08:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbiL3Hno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 02:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234752AbiL3Hmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 02:42:49 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229531A05F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 23:42:31 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id t15so10403554wro.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 23:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vm3xbs/GyRNJ6DBbaHm+OuOgD7iBzBULuO7wncj0ttk=;
        b=YJ3xv/XPA73EvkaW1lBKOVggaYFcs84tPHS+DB5p6ao+VfYOKYLZycW4L+J4AXPXNo
         hHMgM7Nyc5iQkkJro4aqTvmK1IMYyFyC1Tsqi+lKUVKxmMHBFDWRhe4mugp8+wk1rL34
         M+ybcXraUP5kFSsAsFmenhVcK70hMCnz2882Ccf0FfUO9rQp0Uwk8bN8nICJjB6HpWp+
         89ftsz37OPQsnOrW054W+3mfT3Vj7Jqxhrv69cPmVyEeIPWRUcWubxNIeXuBE5FE8jPM
         kYUa2SitK92OTWyVdctlAtDPk+htFO4PdgJVD6vJE+K1rTn+CuvyX5kRnXcYdPzEQzPG
         lRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vm3xbs/GyRNJ6DBbaHm+OuOgD7iBzBULuO7wncj0ttk=;
        b=HY8JuHUtKVV1krGGhv3ds0Vs3YiJZN1JvRVLve7NQQx3FCesPDL5xdJ5Hpj6bIlM10
         wHdneb+gtBDHU6TsEXZICltVR/MHPUpt4NahWkQKFJLkKTGuQwL9fE35yeneNFzI3PxM
         qZEypnIXwksUS880Ct+lZk0VqLLhxHtyEFiskhVf2jvTJay6MGyu3DgJZgPgNImW0xXH
         ssgpLUXuYqbd5xJgKhFgkaUSrBpAaPz+Du6fEDXvqa+bf1F+xDWBDx+3x1tApwonzRPK
         xIETdcVB6FCFdzHXE/v2j102sejpNjPHSv2K+Y4vjweBiQozityXyvkxh8NgjBHdooJ8
         76Fw==
X-Gm-Message-State: AFqh2kr8+VpIXyg5vz0XCE/F+RRPHD4de0EBi9XPacSYKMTb9NW5PcdP
        JHOOm+/HGYAHci6MHi83FbXt/w==
X-Google-Smtp-Source: AMrXdXt6z1uMHoe7utI/pUhm++yBQy6DLzGRR17VY7G/5v6NkL3RnZ6C3wj1ZihItZ3ZB4PCHTMS1A==
X-Received: by 2002:a5d:6ac1:0:b0:284:2216:c23e with SMTP id u1-20020a5d6ac1000000b002842216c23emr6917966wrw.44.1672386149693;
        Thu, 29 Dec 2022 23:42:29 -0800 (PST)
Received: from [192.168.0.28] (2a02-8388-6582-fe80-0000-0000-0000-0007.cable.dynamic.v6.surfer.at. [2a02:8388:6582:fe80::7])
        by smtp.gmail.com with ESMTPSA id a6-20020adfed06000000b0028e8693bb75sm1887655wro.63.2022.12.29.23.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 23:42:29 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Fri, 30 Dec 2022 08:42:07 +0100
Subject: [PATCH v2 3/3] dt-bindings: ufs: qcom: Fix sm8450 bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221209-dt-binding-ufs-v2-3-dc7a04699579@fairphone.com>
References: <20221209-dt-binding-ufs-v2-0-dc7a04699579@fairphone.com>
In-Reply-To: <20221209-dt-binding-ufs-v2-0-dc7a04699579@fairphone.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <me@iskren.info>
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.11.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM8450 actually supports ICE (Inline Crypto Engine) so adjust the
bindings and the example to match.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index a8d896e1617b..2f73a84fcf41 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -107,7 +107,6 @@ allOf:
               - qcom,sc8280xp-ufshc
               - qcom,sm8250-ufshc
               - qcom,sm8350-ufshc
-              - qcom,sm8450-ufshc
     then:
       properties:
         clocks:
@@ -137,6 +136,7 @@ allOf:
               - qcom,sdm845-ufshc
               - qcom,sm6350-ufshc
               - qcom,sm8150-ufshc
+              - qcom,sm8450-ufshc
     then:
       properties:
         clocks:
@@ -243,7 +243,9 @@ examples:
         ufs@1d84000 {
             compatible = "qcom,sm8450-ufshc", "qcom,ufshc",
                          "jedec,ufs-2.0";
-            reg = <0 0x01d84000 0 0x3000>;
+            reg = <0 0x01d84000 0 0x3000>,
+                  <0 0x01d88000 0 0x8000>;
+            reg-names = "std", "ice";
             interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
             phys = <&ufs_mem_phy_lanes>;
             phy-names = "ufsphy";
@@ -271,7 +273,8 @@ examples:
                           "ref_clk",
                           "tx_lane0_sync_clk",
                           "rx_lane0_sync_clk",
-                          "rx_lane1_sync_clk";
+                          "rx_lane1_sync_clk",
+                          "ice_core_clk";
             clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
                      <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
                      <&gcc GCC_UFS_PHY_AHB_CLK>,
@@ -279,7 +282,8 @@ examples:
                      <&rpmhcc RPMH_CXO_CLK>,
                      <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
                      <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
-                     <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
+                     <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>,
+                     <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
             freq-table-hz = <75000000 300000000>,
                             <0 0>,
                             <0 0>,
@@ -287,6 +291,7 @@ examples:
                             <75000000 300000000>,
                             <0 0>,
                             <0 0>,
-                            <0 0>;
+                            <0 0>,
+                            <75000000 300000000>;
         };
     };

-- 
2.39.0
