Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB95A660E7B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 13:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjAGMEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 07:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjAGMEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 07:04:40 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D9C59F9C
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 04:04:39 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id x37so4077707ljq.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 04:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wz4wfE/YkxeRpDHi0xsr/1VlzIloR8P1Orz6mqqqXdI=;
        b=u5hZHU1DLWiMN3icESMKB+5pSnFsgMiK1TNUvkhYeA/oYjnbU7bLdklGIoyE3tITOA
         6+y7o0p79rP8BvhRs7D9GVhWp/IPOJ23Ax6ukxewGzbhmXMTsnqnaIkxEwGEL01sN4B2
         4cJCjppRhAuSB52Xs8f8/hLJue+ELy3xsGZM/fxhL/oKcKm+74GdpMipf2MfFyNOXGuu
         JuY47z6jD4RrDi7YkI4Wg+GitcZKHkSjBg0TA9PeIP4dvBD43GM5dkQoNE+A73noUMYT
         TTtnkz6qlBrJYyyrlCtnwYZbAI1u+ZaXX9AflawLIJVvkb37xH2qsf3CSf+tl4ru8R0c
         7wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wz4wfE/YkxeRpDHi0xsr/1VlzIloR8P1Orz6mqqqXdI=;
        b=r8OP8ear0ot8JW6bTV1tYNs56iMsaeUJPFS/9JAKbng2cL2EpSczmbznho1Vlw0QpN
         YWSZW8qWSMTGF2Wfgj0JeQxOxB/7MdxzGVdXeQbba6JJMnPo59eCZj34t7CG+JXE3J24
         yAdsVyRPoh0t94LRhCzz3U6KPckBc9ZbkQCqVUulb+aDMEQ3Utv4KX2JYJKW8NMlydiW
         52jZBVRYc5rqYMOZ874YfZBGIOVZ38V0zgEghh+4K49c8mfTW9+tHyORRP9lePwCvAHb
         cxtgOgM8P7E7CcSuiOKkJFYJfIyJhd+OCuA5OvN2L3CDdJZN9pT+EnvkeJMvoMAr2R8R
         gBig==
X-Gm-Message-State: AFqh2kq4AKkoAhYoqHFOEeNBdSpcgKwAl3pp97cWL2ytTYTUY1ttDsjb
        9o+zo86Uj8PUnBkibe8vRbRAQQ==
X-Google-Smtp-Source: AMrXdXu8hqdGKJPcfqsVB/g+ExpJckzz1eBU6hDjGOXRZM631RBaYm3VGB0ibYEB4gGKjA7gKcR9tQ==
X-Received: by 2002:a2e:8606:0:b0:280:c06f:1f52 with SMTP id a6-20020a2e8606000000b00280c06f1f52mr3539180lji.11.1673093077381;
        Sat, 07 Jan 2023 04:04:37 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id g3-20020a2ea4a3000000b0027fdd6ded99sm343521ljm.4.2023.01.07.04.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 04:04:36 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        kernel test robot <lkp@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: qcom: camcc-sm6350: Make camcc_sm6350_hws static
Date:   Sat,  7 Jan 2023 13:04:34 +0100
Message-Id: <20230107120434.1902666-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
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

There's no reason for it not to be static, and some compilers don't
like not it being that way. Make it so.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 80f5451d9a7c ("clk: qcom: Add camera clock controller driver for SM6350")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/camcc-sm6350.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/camcc-sm6350.c b/drivers/clk/qcom/camcc-sm6350.c
index ea8600530046..acba9f99d960 100644
--- a/drivers/clk/qcom/camcc-sm6350.c
+++ b/drivers/clk/qcom/camcc-sm6350.c
@@ -1742,7 +1742,7 @@ static struct gdsc titan_top_gdsc = {
 	.pwrsts = PWRSTS_OFF_ON,
 };
 
-struct clk_hw *camcc_sm6350_hws[] = {
+static struct clk_hw *camcc_sm6350_hws[] = {
 	[CAMCC_PLL2_OUT_EARLY] = &camcc_pll2_out_early.hw,
 };
 
-- 
2.39.0

