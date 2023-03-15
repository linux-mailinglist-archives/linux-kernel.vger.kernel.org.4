Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8C76BBAE6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 18:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjCORa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 13:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjCORaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 13:30:55 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929BD584A7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 10:30:53 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id f16so20229073ljq.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 10:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678901451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nyHC0VUkupsiuWX2pHsL/65xztoUDBBkuNkC20AficQ=;
        b=GJ97q5jYvQR8vrr48icXglGbW7rbJfdUHhHBaxDDPZZlMjuR8MS2JnxvjV8cuStFTt
         6qPpD4iKSjMNHuHp+i9qJ15VUl4IuKII6uZimndhf9u5uDyL4Hm5n9Day/PRXRZDHNm7
         C6YHj0adBrFhpy24nz+Q+2EBEK7c82TPHA7gQpzDGb9O4PnGemNXrk0p8sZoZbnVquM5
         bP54KsuOal0w7AKd8/jnsQM5EirCsBB7/Z2c8C/7YgmrpAn1T9WYh3M28XfSgtHZcyuO
         quvQKTn1rwmVmXlX2gtJQG1Fk4km3eES/RMbwn+KL9WWgPCiypagIjwr4RjYpzuEZe9e
         jfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678901451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nyHC0VUkupsiuWX2pHsL/65xztoUDBBkuNkC20AficQ=;
        b=WBGOnzqw2pHOtgWQ8x2jY1a8Z2KQdWyF4qRLMCxn8D/nrs9U1SQ/dk+JAKwRD8u2UK
         qFN4bsicJy64RXac7w/E5w2a8LeRoAUBvx1yu8VczNY65wR4rbs5uU3OTD+gBwt/z0gS
         5P4M5GBsz4Mwb4IMPn2fHwWRME5HSf/TuDTb+B4H4DyVVdBbg55P9w2+e4NiSv4WiD53
         6mInHrHMtgqrOl2HQ0IunbzQ963p9EAgHluns5tm0uFrexREx+0SXGf+bjrMIvBQa60H
         7qNE+BerFUN5Z10QIjlgpQF1BC3lyXeQf1vFLlGjA3i7oDSeoXNyZz/iAGFZMFtFN0Ww
         3z1Q==
X-Gm-Message-State: AO0yUKXaN5uXip+TDtaxJatgmALcaCaTloWET6tsU81JjtTLBI8ZNCZc
        D71eZGQfz8LjN+1PAnp2yJvY4g==
X-Google-Smtp-Source: AK7set8qdUTG2izjSNf/ErXIPYQfJRIKDjxOhFSDR7Kjx9V/3mxfJTKO2NEma+EDiR6JfZ0/rg41EA==
X-Received: by 2002:a2e:850d:0:b0:290:8289:8cc8 with SMTP id j13-20020a2e850d000000b0029082898cc8mr993566lji.22.1678901451666;
        Wed, 15 Mar 2023 10:30:51 -0700 (PDT)
Received: from localhost.localdomain (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id d28-20020ac244dc000000b004d85a7e8b17sm887561lfm.269.2023.03.15.10.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 10:30:51 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: qcom: gcc-qcm2290: Fix up gcc_sdcc2_apps_clk_src
Date:   Wed, 15 Mar 2023 18:30:48 +0100
Message-Id: <20230315173048.3497655-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the PARENT_ENABLE flag to prevent  the clock from getting stuck
at boot and use floor_ops to avoid SDHCI overclocking.

Fixes: 496d1a13d405 ("clk: qcom: Add Global Clock Controller driver for QCM2290")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/gcc-qcm2290.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-qcm2290.c b/drivers/clk/qcom/gcc-qcm2290.c
index 7792b8f23704..096deff2ba25 100644
--- a/drivers/clk/qcom/gcc-qcm2290.c
+++ b/drivers/clk/qcom/gcc-qcm2290.c
@@ -1243,7 +1243,8 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
 		.name = "gcc_sdcc2_apps_clk_src",
 		.parent_data = gcc_parents_12,
 		.num_parents = ARRAY_SIZE(gcc_parents_12),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_floor_ops,
+		.flags = CLK_OPS_PARENT_ENABLE,
 	},
 };
 
-- 
2.39.2

