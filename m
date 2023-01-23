Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B3C677F52
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjAWPQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbjAWPQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:16:01 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2B429142
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:15:42 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id b7so11138352wrt.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V6Dkw7J3C2y3q+K2kqskggmIm85zKuaEB6yaEFnfcwQ=;
        b=KiRmpiNOrNtg8fni9OkE1lE51S93/76jHTUG5ht8Y7vAdFLauGsUFzn5io5mn4aVBG
         2EXPaqNV3O89f0DvQweBuKriIY4uW3DlNqG//VgIHL91SNKuqVX0pu+OUMOmG1X835Nu
         w/GeNpw5PLML/PAy8CmDM5kiqs+dmVfBaz+J6hwioHQJvn+yfLVhSGuBVfSiUPugYfy1
         C6zPDumP57rdz4NBOMfM+Z9ZVOw5pLQHr12uKA3kWxWt8b93LpHBD0Tc9+BzKUhdGA1i
         NOoHfaU/Dr9ieYweitsGLFOoKTzo0EMBwaDW50hyZdP641pfFsd4EA1J4jRiTIajpmZ+
         TXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V6Dkw7J3C2y3q+K2kqskggmIm85zKuaEB6yaEFnfcwQ=;
        b=x2sT9aLZ61lNG1Au4mloQlgafwYhfD7KfQwfUlQjDdEbY4fyWj3ylz4UIRaH8MRgT3
         C4SUT3/tKTaHIHwl2PFZDc0OAsaYHrvf+3RCIlBlGyB6ivxooW4rhq41Ej9QK9n3alU6
         IvsFX4aOEcbMIgRQadLl2EFEGXhidgHF7E1lQsQnVUXFsTzI+NVYGkJQgGVvn8TRexmI
         WeAULFCA2Xz1DlTtuuywV4oM+OcWZHAJHxCWPtNfsDFvTckTfs9PJ5DieKOs907L2eJi
         X7EwFSZCZiahtEdqDH7q50NCOc27NajBAGJyMeh+rap/LRycuaxBz58TuCCN8DliVbSb
         nhjg==
X-Gm-Message-State: AFqh2kppKMGR0JfyOYyoFAkcegeM9jbCt4oRSEJVgEVu7+DsrO2AviKU
        VC8Env7lf3PIF28zEDCYVI89Cg==
X-Google-Smtp-Source: AMrXdXsx1NzZuDi+PcRWo7mdkOFNLg2yTPY/kRzTurJsM52yVp2NlLPcg/qVthAJh1pCrnaiPx3yfg==
X-Received: by 2002:adf:b604:0:b0:2bd:f35f:1b5e with SMTP id f4-20020adfb604000000b002bdf35f1b5emr21632876wre.4.1674486940770;
        Mon, 23 Jan 2023 07:15:40 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f8-20020adfb608000000b002882600e8a0sm4347915wre.12.2023.01.23.07.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:15:40 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jisheng Zhang <jszhang@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: berlin: align UART node name with bindings
Date:   Mon, 23 Jan 2023 16:15:39 +0100
Message-Id: <20230123151539.369654-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Bindings expect UART/serial node names to be "serial".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/berlin2q.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 598a46f96a82..6edaefa617a5 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -581,7 +581,7 @@ i2c3: i2c@8000 {
 				status = "disabled";
 			};
 
-			uart0: uart@9000 {
+			uart0: serial@9000 {
 				compatible = "snps,dw-apb-uart";
 				reg = <0x9000 0x100>;
 				interrupts = <8>;
@@ -592,7 +592,7 @@ uart0: uart@9000 {
 				status = "disabled";
 			};
 
-			uart1: uart@a000 {
+			uart1: serial@a000 {
 				compatible = "snps,dw-apb-uart";
 				reg = <0xa000 0x100>;
 				interrupts = <9>;
-- 
2.34.1

