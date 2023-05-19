Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488A170A146
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 23:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjESVJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 17:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjESVJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 17:09:17 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F7F1B4;
        Fri, 19 May 2023 14:09:16 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4efe8b3f3f7so4230555e87.2;
        Fri, 19 May 2023 14:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684530555; x=1687122555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JPDo8e4tRBQPb+NJv/Lu6c3klf6NkNIWf2qv6QbyS4=;
        b=qeK0K7/7ciV2Dv6Tyj8x3RrJeIZmpngYYZzPW/c67VqZRa1XXkWbll96gHQ55D1d/Y
         B1Xd7YhvcdsHn/aDgBRCl3NHAubpD2t6lerGv01TXKfZ7hh0/Sa129Hp2rYPZwx5+S4k
         i9AE8HSWt4AYHPCmEOZTozkywXOnzmVMPSNcaNalrgMxrTnLPrW+BYOwux1hT/JZ6CNU
         rK2Rd+HPo7HJG0DMoaYqwTxYHHcPl+JDUe7+l5iuCk9kcAP2BtE9KxHL2HNLwVV1RtCY
         Y3qUZcm+I0hMHBZzULp1H2a37a4Qj4SxsLCBBTdqBleOCT3v3MAvkrCxl9EcLJe6Z77m
         oxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684530555; x=1687122555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+JPDo8e4tRBQPb+NJv/Lu6c3klf6NkNIWf2qv6QbyS4=;
        b=bS05PLzx9mxe7r4iInglR+S9yWwEUfXhi3MvDt5fIkKHoXxMtiaxKqrOjUWj6jsilq
         NEZ570tjVS4APAA4ruQeTTIVg6Mg1wiH7doAqqd6ZnVwSs7xue0dvsscCCgDDXBG+XUx
         ylEwITqibsWXofHi1o8LJj3Vdm1a77tZLmfICywEPQ7KTz8PpgU9tllF06S9o3YCe8Tg
         c77BzM5poZ8cPjiOZtRX9pQ/fUtl9Fh0IdjCV7E4LNpZDjQefXsuvtpF98Mv0EFx4WdT
         d1zsl0v8nG99TD/OpV5vaQT+WeuGHClgWtleRR88Z7jTfTiWonJwTdKKswmOKCpSvK1Z
         j3cQ==
X-Gm-Message-State: AC+VfDxvDDbBGn1QBQc6vxQwydvOxN04AKPDyh75nZlHjpaW359XtT28
        6Kp2DZtDAze3/DORT9K9mojrI2mnKx0iEw==
X-Google-Smtp-Source: ACHHUZ6nizjTH51O7v8kP9632wc+WAytvtIge7YjHP10XXEIb/bQmoxiAcFLkB1H5Z7jVA/jcn0z8A==
X-Received: by 2002:a19:750f:0:b0:4f2:4bc2:fc35 with SMTP id y15-20020a19750f000000b004f24bc2fc35mr1058720lfe.53.1684530554651;
        Fri, 19 May 2023 14:09:14 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id i14-20020ac2522e000000b004f3945751b2sm30043lfl.43.2023.05.19.14.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 14:09:14 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] ARM: dts: qcom: msm8226: Add PMU node
Date:   Sat, 20 May 2023 00:08:59 +0300
Message-Id: <20230519210903.117030-3-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519210903.117030-1-matti.lehtimaki@gmail.com>
References: <20230519210903.117030-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable perf events on MSM8226 devices by adding the PMU node.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
 arch/arm/boot/dts/qcom-msm8226.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
index 42acb9ddb8cc..e272a1e15b44 100644
--- a/arch/arm/boot/dts/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
@@ -47,6 +47,11 @@ scm {
 		};
 	};
 
+	pmu {
+		compatible = "arm,cortex-a7-pmu";
+		interrupts = <GIC_PPI 7 0xf04>;
+	};
+
 	reserved-memory {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.34.1

