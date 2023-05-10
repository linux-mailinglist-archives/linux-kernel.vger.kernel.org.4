Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B216FD973
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236686AbjEJIce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236209AbjEJIb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:31:58 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8271B1FEB
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:31:49 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f42711865eso21199105e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683707508; x=1686299508;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d3Ih+IXdkdHu0q5GJJzsDE+yWYuFmeUF6AErNUV9rpQ=;
        b=v0s+55JdK1Ao1sC+FHB5Qjx56wo5TbsQXhzi5XDSqTI1hYhv37LZaMtnQ7g2HCR1u8
         k+EnDaSjZyfX+7fpLKLHs6ckO1l00uZvQdIDooT/QIkPTOIo8mqJ38kPrAIaCmETM9WV
         o9+ZK81Tk4DaCDKZYRmn0HHUe2oCISi8uXyQ55BXD93SB8WyjjVTznQj1iI1p0WK0lYF
         ESaa/r6rzU9/s0mm6KNWiLwe9T15+7ZsML8nljEHpR5noSB+1Fez2OWwr5d8cZelJnHT
         gwH9A3VF8EsGViJEKkGt7nm4ff9X4wqZFY1XApqmUgFSy9ZUwADG1Ucy4T9iDKyaqO2a
         UHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683707508; x=1686299508;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3Ih+IXdkdHu0q5GJJzsDE+yWYuFmeUF6AErNUV9rpQ=;
        b=O0bfPnTb8Kw02ZBydaaQJHfCbbVs0d+Sp8qtAkgI58wUgHUzf4qa1QdAZimq5QwV9n
         jPa+atpMh+j2n7nhJ8TGmdJ2pAA1ubzXEzrLtFfYGt0vvmBKskSRspGbKf6lxW/Jmq3z
         vm9wHUR8TKRNKNwMz0hANqc+GRw2U9Ttt+DfxAPkQiXPgrbqXJbqID6LafesLeyLtpvz
         ZNAs5QM1sdURngRd9LuB4SrmNpv6ckQkfDXXETYUWd1NxPvIqej9RlNKc3rZppqRiS5B
         kxZbWSDVCMc1HGy6hXl4fx1vTWnj+3v1JNrAf0AcBWAzzn4HURPsOFQ+mAU/f8z3OXki
         t7EA==
X-Gm-Message-State: AC+VfDyy/pWQ892aE8v5cxcHCHcJBBs77zhEBrpqpsTH1G9xuqKOBlu8
        tuiJuT9i/YR2M98c6znF2mwJOZZZgp67Xp9ZBWogPw==
X-Google-Smtp-Source: ACHHUZ654OnPBCBeKlKcxxawcZ1Z9s1MlO6g/yW0rjIMm9VD4S/1ZqkCoRreMz+lOgWDgc9eBmgV2w==
X-Received: by 2002:a7b:c017:0:b0:3f1:94fe:65e0 with SMTP id c23-20020a7bc017000000b003f194fe65e0mr11409343wmb.26.1683707507973;
        Wed, 10 May 2023 01:31:47 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id n23-20020a7bc5d7000000b003ee74c25f12sm22108737wmk.35.2023.05.10.01.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 01:31:47 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 10 May 2023 10:31:40 +0200
Subject: [PATCH v2 2/6] arm64: dts: qcom: sm8450: add ports subnodes in
 usb1 qmpphy node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-topic-sm8450-graphics-dp-next-v2-2-8acbbe1e9d14@linaro.org>
References: <20230503-topic-sm8450-graphics-dp-next-v2-0-8acbbe1e9d14@linaro.org>
In-Reply-To: <20230503-topic-sm8450-graphics-dp-next-v2-0-8acbbe1e9d14@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1041;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=aIXQoyt41t5R0Eiwf1fubyroFfIIJlQLtseapYtZg44=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkW1ZuZQtV6b7hhBWCAJD1zxJfh/WgHPJ+PIEQrfaL
 /gd+ZxCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZFtWbgAKCRB33NvayMhJ0WL2EA
 Cn82TwooCcd/EPvxH1WQ9MBh8mpns4+1xQss/Rq3wcpI9F8+4rtCurgGfsBmU++b15i/nec64/91ZN
 TNGej8l6BL1N+ScQvjfQV7yBCQgqvS8sJ7uNfCJehRtwHNoD41KHgjngDg6Wh0hY6BUyonxkBl7cJ+
 tmw44uCUTYKwQaEQfhR4j1PdbzS1j61odfl+ma7YBWtrt3hFoFrnO7a8fQrrb5WFI6A3TGB3nxwA4R
 37gfXhoL1UeJW3kJCPd8ZQnruubGnBcG63etwxXmkYxWISBJWop3k4Q62/iqaYOiwxOo+ngEy9dQQq
 79dxoy36eS/OQIa3zvyrB00Q+WeMQUHtaxYj52uOh3gMynKcTKoCqviF0p35s0y+n0fb0HfFX6KgT7
 /UrVxCIICAMpLaIqREyJEwa7HMw0J+XhZWZq9MD7341t4njTJjHnd8+/5R/XfRfOWwgyyB4/mUw+5h
 aP8adfUZbp14sahnCAcW3FqGvvAjDoq44Ae1A9ThGi9q0UQMewS1pzKg1hc9fAahfmPAC+tMKQOPBC
 l0ecu7h4iXaoFZgyzO/tDssfr8Yfn3Ns4AFYDC1wpREacfBUMdB6AlzkfZYXSa1QZFMvbmfbeXtyuD
 FwXupynyO+Ni+pYYgdhKGv9fr/am/sgAfd4H2amfRlflfvv96wCIeptqiw1g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the USB3+DP Combo QMP PHY port subnodes in the SM8450 SoC DTSI
to avoid duplication in the devices DTs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 595533aeafc4..6de3327d9b32 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2044,6 +2044,32 @@ usb_1_qmpphy: phy@88e8000 {
 			#phy-cells = <1>;
 
 			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					usb_1_qmpphy_out: endpoint {
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					usb_1_qmpphy_usb_ss_in: endpoint {
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					usb_1_qmpphy_dp_in: endpoint {
+					};
+				};
+			};
 		};
 
 		remoteproc_slpi: remoteproc@2400000 {

-- 
2.34.1

