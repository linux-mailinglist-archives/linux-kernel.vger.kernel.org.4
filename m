Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199B466BA97
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjAPJjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbjAPJjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:39:03 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAB2C679
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:39:02 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id g13so41907190lfv.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wa1H2bfjJGmRxh19Z0B+gnuxLbl0Ed6z2h3II60gTdk=;
        b=jZshpbwPshyC7FdxdfSxw3e8y0mKm8efn4k5G09KYBNYz9Sm5sHyoBGBdMuuKs2bch
         abYSmeLPDczd9lnqm74PhQB96qR7MRNhtw5PppAc0IWFQw8oa+jbKQU9Zy7HUbeJmEQk
         ExVDyNOz+c47zIk17rdJLdU8N8XiVrcjBSNcL2b3HqxHSeqJgYn4/5rsNxr0qo2kr6RP
         RUC1Xmp3lZGuw/dBHxKSVpKvSCEmxFU+HuWhxarfW9GWyyISxI+OeRXttfne5CPxtklX
         tByO60bIWRh0zhGSiRSPKvoN9y75+N+l7K3TSSK7I418/YILPNauJFdLHKjZfvaC/a6M
         JjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wa1H2bfjJGmRxh19Z0B+gnuxLbl0Ed6z2h3II60gTdk=;
        b=y1BcuFsMlQor0vwSILvenAj7wTQV84E82m06/WoeqxgSfqB1l9LYX9rc684UPrYOWR
         QHAfxNde7/MRSFj+TFmhxZwCKE6ff+8svRrdBp2gHr7nPBffMF4ZYEBj7HBoWDERJfwk
         fIBprznV04XOPWUnnRRd359RDWjo3blDNV5gNzrNl2WBx+wWPHS+RLrEN+dcfjmNlw4z
         dqdDvrmPPJkhqz5mWIaEaSfFmNoVPBL/VJCdy9g7ArXK6GFaRt5iZaLjh0yTGdmmtdKA
         MhzxCEeYNKPaN2qdO/GsB9ru3Q+eDdIr87Bph7STde7RcxuAvPLzCjRENeZVg6DoF83S
         htBQ==
X-Gm-Message-State: AFqh2kqSVO65S0o8drZ+WMsGgFgiDHnH82FIDQnaKIOV1WP+Q4t6M6+e
        qeH0qtTTPcAIcTMHeM5e/qHrkQ==
X-Google-Smtp-Source: AMrXdXtY18aSFdOiLIgRkbcyixdlXXEBFFlbVjFqbhGf9NR96/RvXkXOrjeOeuyKiEtpL/aNu2DIqw==
X-Received: by 2002:a05:6512:1115:b0:4aa:e120:b431 with SMTP id l21-20020a056512111500b004aae120b431mr30837421lfg.38.1673861940857;
        Mon, 16 Jan 2023 01:39:00 -0800 (PST)
Received: from localhost.localdomain (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id c5-20020a056512074500b004b53eb60e3csm316985lfs.256.2023.01.16.01.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 01:39:00 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 1/6] MAINTAINERS: Add entry for Qualcomm CPRv3/v4/Hardened driver
Date:   Mon, 16 Jan 2023 10:38:40 +0100
Message-Id: <20230116093845.72621-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230116093845.72621-1-konrad.dybcio@linaro.org>
References: <20230116093845.72621-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

Add maintainers entry for the Qualcomm CPR3/CPR4/CPRh driver.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
[Konrad: rebase, update AGdR's email]
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 02654d2a7e68..a4ba0a7770d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17293,6 +17293,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/power/avs/qcom,cpr.yaml
 F:	drivers/soc/qcom/cpr.c
 
+QUALCOMM CORE POWER REDUCTION v3/v4/Hardened AVS DRIVER
+M:	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
+F:	drivers/soc/qcom/cpr3.c
+
 QUALCOMM CPUFREQ DRIVER MSM8996/APQ8096
 M:	Ilia Lin <ilia.lin@kernel.org>
 L:	linux-pm@vger.kernel.org
-- 
2.39.0

