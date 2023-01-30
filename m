Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36A1680C09
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 12:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbjA3LcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 06:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236651AbjA3LcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 06:32:05 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD37F34C20
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 03:31:55 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id p26so19568822ejx.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 03:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4YbWf65lg2cQpgfmV5inxaJ+xw++SwQJT+M7eoK5F4Q=;
        b=x6p8Wts7qSiLZarPrBkLp0wV/Ji/Izq6x9YUDQ+t2ydvkeNyAAcwooP/s5sxdbXTJZ
         QfAhnkLD5xXVNOmoQPxXZQhRvOxyDefu9UfCdXDPdsQxFwgN7nYp5rOnrHmQubeU0Wz7
         eK8nt31Y79kCDI/WUOlpVbVLKhY/A31MF9kIPCvHzXEuKzigl5N+HTdSbOTO3jVO9UrJ
         rvIPF4HY1xI8S88pNf/hGoRybHV6Gnw15MGvIukhgOTviXWV+h9ZyCkIvMDsOCHhPSaF
         l8IGOlFeqnLzxwf6O4+j4feBX2xVOR+1HMOBCCcBzWUZeSdWFXNCW1cUaYH9u8txG47Z
         Bvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4YbWf65lg2cQpgfmV5inxaJ+xw++SwQJT+M7eoK5F4Q=;
        b=1PBf+2PUzM/6VAR139WKcCDuXEOBw1RrV85wgJVOH5oK62OOxG/jGYfwRay7N8I6c4
         +uncCh8UgyGGqrwBfC2Sc1Q4Aq1HZ7li9RFUaGs9qHswgHfpBzQ8FM0Y2CUcaYDyv5ls
         ysL9idEJjNFFEQHxDCHz/875k00kpVl+iT24ygDASgpWIORMIgoUnt44P43uV2obE8fB
         YbIxN7oCUjBcoBaXXPopZmuIPifPTJeKiASIP6vY2Tx2kPF5V0z/Gaem56crHKCVlwl3
         EaKkjPY8yR27pDO7aPL9nRO5el6dDTnz0gwawJqAs+EyZA2EcAYXya0vMyJAGcH6NpAd
         31Kw==
X-Gm-Message-State: AFqh2kpag3JoudrtYY4vwy3P3LNjovxd0F5rXRXAIrTFZUimrKU7A2XY
        l4lbWVjC95TMJbaO1AosePqBkA==
X-Google-Smtp-Source: AMrXdXtOvcr+SFVypdszhnnG8chKGR68qAsLVWoEYFnrJOTeUx1xaP+iDHtDb/nHwypYGL0jd/mnXQ==
X-Received: by 2002:a17:907:7e9c:b0:84d:363c:888b with SMTP id qb28-20020a1709077e9c00b0084d363c888bmr64669724ejc.58.1675078314495;
        Mon, 30 Jan 2023 03:31:54 -0800 (PST)
Received: from localhost.localdomain (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id w5-20020a1709061f0500b0086a2e31d1c1sm6703356ejj.28.2023.01.30.03.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 03:31:53 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: usb: fsa4480: Use generic node name
Date:   Mon, 30 Jan 2023 12:31:50 +0100
Message-Id: <20230130113151.2130063-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
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

Node names should be generic. Change fsa4480@ to typec-mux@.

Fixes: 01afa882f12d ("dt-bindings: usb: Add binding for fcs,fsa4480")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml b/Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml
index 9473f26b0621..51120fe90322 100644
--- a/Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml
+++ b/Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml
@@ -51,7 +51,7 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
 
-        fsa4480@42 {
+        typec-mux@42 {
           compatible = "fcs,fsa4480";
           reg = <0x42>;
 
-- 
2.39.1

