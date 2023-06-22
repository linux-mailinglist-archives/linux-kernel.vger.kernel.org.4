Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FB1739C14
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjFVJHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbjFVJE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:04:57 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540E026B8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:58:20 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f9c2913133so16117795e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687424258; x=1690016258;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qSEmFq3YxbeiKoCeFTkl05+Yz5x7Lbhx+LsHriK4Ets=;
        b=AcpEkm69lZTPzghNku1SKmsXl3pXsejyjq1KyPcAqOVJZJ9ojyuOyoRjpFTNMIaPto
         kYf2DT246JTt5KaPbGnx6jhTvs+Jm7ZjJZsPnDhV2Yb7o3UUcQyHnN0w4fjYecQSpDlU
         g+uwtAI2YDi6d4ePomUYjqIV/adsw9jcRJ3H3YFLF06Qq+TulLygauI6t6El+RYGXISt
         ntoRCF4LKKtoyKzK0YZPARN5o/3iRzCa0/TsnyxaiTsFP/WvLh+bMSmm+806GSEaHFIm
         ja/dtOOtvEXojcG5imDx6twaE2sDhsD//g/r5a+uPFwcGvcUDOjsayEeRknIvjFaLDkt
         wCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687424258; x=1690016258;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSEmFq3YxbeiKoCeFTkl05+Yz5x7Lbhx+LsHriK4Ets=;
        b=aFCmFMlftaWLBD5wEGEnNukmt9i8jNVWlrV1TwkauUyok8yQvP9X3NURGnKowrnnwQ
         3jcuCT8+HA9bpkzm7+7nPl4LYTKuU2DHLt3g0NnYVttyAiLTLzuxv4Krtyp3xcA++6B2
         Grku+0KSJ9iQ5GhJe4eahPzLEinIPoME4NJ9P8E5S4wCgeDyqHm9soNtpDqYK6GtB4GK
         tPUdfRJW2GIykzUUyf4p5QcgaoWbLplek6wy1H9KiZoTAtsI0Tn4mV1bYb0lzm3upeP2
         RlOv5CdkGT3e/wDiqJks0ypiJT32aCpZxfIWrUBacyKmCmwzmtDbdXfTMjzan7UYNxyf
         tJYg==
X-Gm-Message-State: AC+VfDwSvai2B4S1nhtQx5F6rDWcgHP/CBwrhxrypKlEPxgiE4C0sphL
        3bF0feq9OciTU+n056yVjMg2DQ==
X-Google-Smtp-Source: ACHHUZ7h75jqzLOPjpnQdyDGHX83w2l/2PhBZLFxuDZfDnXQyWvLT7kzHLkoNx26oPO46lPwuFCOcg==
X-Received: by 2002:a7b:c4d0:0:b0:3fa:7828:df33 with SMTP id g16-20020a7bc4d0000000b003fa7828df33mr8183wmk.35.1687424258442;
        Thu, 22 Jun 2023 01:57:38 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id y10-20020a05600c20ca00b003f9b29ba838sm7136305wmm.35.2023.06.22.01.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:57:37 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 22 Jun 2023 10:57:22 +0200
Subject: [PATCH 5/5] arm64: dts: qcom: sdm845-mtp: add chassis-type
 property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230622-topic-sm8x50-upstream-chassis-type-v1-5-13f676eb71f3@linaro.org>
References: <20230622-topic-sm8x50-upstream-chassis-type-v1-0-13f676eb71f3@linaro.org>
In-Reply-To: <20230622-topic-sm8x50-upstream-chassis-type-v1-0-13f676eb71f3@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=691;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=4ovpoZV7TNdBivA7TBVkyWbrfZACOHU5mXUZCTQ4xms=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBklAz8YamBE9TsOeQpQM0WkSYoLVPjXb6QEtgOVjSX
 C3WE91uJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJQM/AAKCRB33NvayMhJ0XwCD/
 9DMijzaiA1q/QP+BqDeEmM8MR/yBeUmmewK3FH8Fszp/4+zRtYzeLu3lYhu3xDDO6kt8A52sLKZe6m
 lcMy4OX6KnvXZgJBC/+1eQyDxJyh/vU80YF00F7V5gSKqVJKlE83x+HBSusb9bVB95iv7PKbSNssuQ
 gtu0ntwRhETOt9lMzP1rROQ3ZiFhGSr9iSHK6bbCvKx5kLlsxrBWw3rLsbkqROasNF0zqMVI5Nhfpe
 F3svv3TXghBkHvBNyWN+IPxzs8iAQ7VQPSVDPdg76ri+ZiKpHniF2w+06h63BJwjKWs2Uzk5Yc/M8h
 4gg+DDCLNBaDCVHAJvwiz/y93pOBY1s4NNIsiEBeoX75e0OEYsp5vgFAB/9p+2ZXtDjjpobNbZilUe
 d8/f+vHw026CHRPzynca3E6FZ8L+MRKJU81p75IekdCKI7xHtLpvSo9mzxd7l+OIZCWx3cIMt30Hhb
 w/taQjzXUL/NSTKz0L144QMrwntg+L27wt2A3w0oumBPzgMxMZDrCPO38cxNVWHtI/UyMXAyGseNNS
 xHQLRNuTcIsIq8dS3n5Tt4zaMvW3wh8qEe4YbCmW7Py9kULlVY09rkB46dKT8wuHhJ3HcVMz9aK4Yu
 1yPNqPuPeFBhqVYCK59jvMMkJXeHqsOQWdSkebiCIXzPy822DibT0slo7VLA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm's Mobile Test Platforms devices are handsets, set the
chassis-type property to 'handset'.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index b2d4336e764b..41675a8de268 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -15,6 +15,7 @@
 / {
 	model = "Qualcomm Technologies, Inc. SDM845 MTP";
 	compatible = "qcom,sdm845-mtp", "qcom,sdm845";
+	chassis-type = "handset";
 
 	aliases {
 		serial0 = &uart9;

-- 
2.34.1

