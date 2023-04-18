Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B326E67C5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjDRPGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjDRPGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:06:41 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB1797;
        Tue, 18 Apr 2023 08:06:40 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id k13-20020a4ad98d000000b00542416816b1so1966479oou.7;
        Tue, 18 Apr 2023 08:06:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681830399; x=1684422399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=baDH5PC9Q3OXodQBfAb2KmBTW16rF3r01RqVZE8Cm4s=;
        b=BvE1VYl7dD8t7/AL3JwTw8Qwo9HO4vBavmiwL8QJmJ5o8OLedaz7rVZZYm0ivpr+u1
         t1y3srw8Z5/AwBASeAqK1YxXNCeV5R4eCIflaWOZcu+glGLGWl6QP+G3BeuJEpl3nmSn
         LKxNcih5E2qdOKHleb4tIsWNKLE84155r9kMl1frD0E9Dxsko/CfqUFmplQMjmKU49oD
         LkokdVLO591uJs+tOneRwg5kDTXk/cb1QsS2xTChId3zs+IEqooNbj59z63fjxDEXZaC
         907NQcPlXV5gV2JuX9LD3WruNoYxSdXPYxJCoeaMS0fa++iottf80r11mTrSs9Icw4Dk
         KXgQ==
X-Gm-Message-State: AAQBX9fyWEK6ECkg1xSOwQ/2MVgTHiWz+xQ6VGteuEQHuRed0NyFTT+j
        HGmnNTTdsDgluN4A0Zsrue4OXX4VNw==
X-Google-Smtp-Source: AKy350ZyDtxsefmfWARj/PxgbCKUyFdL99JKOLXn0Ok71FXGwtLrnSXpqfJBIXHKboG9VNxEP6m9eQ==
X-Received: by 2002:a4a:374a:0:b0:546:1d7b:20be with SMTP id r71-20020a4a374a000000b005461d7b20bemr3743663oor.7.1681830399196;
        Tue, 18 Apr 2023 08:06:39 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 187-20020a4a09c4000000b00525240c6149sm6034941ooa.31.2023.04.18.08.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 08:06:38 -0700 (PDT)
Received: (nullmailer pid 1528349 invoked by uid 1000);
        Tue, 18 Apr 2023 15:06:19 -0000
From:   Rob Herring <robh@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: pinctrl: qcom,sm8150: Drop duplicate function value "atest_usb2"
Date:   Tue, 18 Apr 2023 10:06:13 -0500
Message-Id: <20230418150613.1528233-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enum value "atest_usb2" appears twice. Remove the duplicate. The
meta-schema normally catches these, but schemas under "$defs" was not
getting checked. A fix for that is pending.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.yaml        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.yaml
index 4376a9bd4d70..b61ade8f3713 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.yaml
@@ -81,7 +81,7 @@ $defs:
         enum: [ adsp_ext, agera_pll, aoss_cti, ddr_pxi2, atest_char,
                 atest_char0, atest_char1, atest_char2, atest_char3, audio_ref,
                 atest_usb1, atest_usb2, atest_usb10, atest_usb11, atest_usb12,
-                atest_usb13, atest_usb20, atest_usb21, atest_usb22, atest_usb2,
+                atest_usb13, atest_usb20, atest_usb21, atest_usb22,
                 atest_usb23, btfm_slimbus, cam_mclk, cci_async, cci_i2c,
                 cci_timer0, cci_timer1, cci_timer2, cci_timer3, cci_timer4,
                 cri_trng, cri_trng0, cri_trng1, dbg_out, ddr_bist, ddr_pxi0,
-- 
2.39.2

