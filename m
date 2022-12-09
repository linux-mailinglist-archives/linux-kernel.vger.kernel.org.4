Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C73564830C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 14:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiLINyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 08:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiLINyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 08:54:11 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06648750A3
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 05:54:10 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id f7so3161475edc.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 05:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XRmBhl+xO1didxxTxIpTyo1S+nD5JTfKsPbiV9tkby0=;
        b=zAQqsdAGFrHDAYMPimScUijNmZ5kuuI8xgkCBHBW6E3YANtmK5YAabM+zCr3V3XDiZ
         uzKJEgHCrtfXjq5CklbjhLWb6DsPhSiJ3IkBuZ/IbQmNuv/jRkhLNloJnjFeMVTdTL1I
         afdOgrQdl46z8fpLkaQg1TR85aQUrIjROu1d1Cysk5CK6jx2KnAoLMbB87x+qjV//lws
         nyL+DZmhv1+edKiBrL1+5eAFywlGEdNy5fdE5ACorPPrelBF8nHW1Rv1uqL+waNzi0b+
         c0nE086f5ijitn4i3reqLIVfQRUgmHoBICQ/EUTAbxHXFZLD9r1SXCuki4Mg+bPpeFkF
         1/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRmBhl+xO1didxxTxIpTyo1S+nD5JTfKsPbiV9tkby0=;
        b=Vvt83MRYuFwG+6HUhI8L6IetRTc2LxXAPs0k1rCJp0sZq1aejpd/u3/HbGvxFozojx
         ZD1MA1e0ALX0K2mmCbG3z14Fhx8WSgpUmhT4zpowgjBSLFpfUUv7/WdpTAvcp0JHcyOQ
         8pLrksMLv1F9bFexAJqkRFQic9YqMe+zB/qTBwn10Vt2EWgsyINwzGXQUkCpvlUSaCt+
         2d4IS8NYOHuvZP8l2pnh5ghEW+rFSIxiX/xCzNKVpu8Kv9y6Ws6nFnedOMv1v9IRY0aJ
         o+V3WHtMOrm+wc28ucpiDzyvZe0FFvruyX/Fwi93cNLfjbaSBKmnLqwXGgFF3HVnBhqK
         nwsA==
X-Gm-Message-State: ANoB5pmD3ngj+L9MQ2CdPhI5B/K45xBGCkwucH/AxV1szF/IB5Oz+LDQ
        uaPlrOnnvNz6hrGtsldidcLS+w==
X-Google-Smtp-Source: AA0mqf4QyULBJSa7csxpJIthmlParQ3a3lsV6kGcszd2vuuNuB4S/570nzFD6QgqVtu0t3W6QttDfA==
X-Received: by 2002:aa7:d5d4:0:b0:46c:c029:7afc with SMTP id d20-20020aa7d5d4000000b0046cc0297afcmr5323187eds.42.1670594048599;
        Fri, 09 Dec 2022 05:54:08 -0800 (PST)
Received: from [172.16.240.113] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id k19-20020aa7c393000000b0045b4b67156fsm656371edq.45.2022.12.09.05.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 05:54:08 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Fri, 09 Dec 2022 14:54:06 +0100
Subject: [PATCH 1/3] dt-bindings: leds: spmi-flash-led: Add pm6150l compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221209-fp4-pm6150l-flash-v1-1-531521eb2a72@fairphone.com>
References: <20221209-fp4-pm6150l-flash-v1-0-531521eb2a72@fairphone.com>
In-Reply-To: <20221209-fp4-pm6150l-flash-v1-0-531521eb2a72@fairphone.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Fenglin Wu <quic_fenglinw@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.11.0-dev-64ef0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible for the flash-led block found on pm6150l PMIC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml b/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml
index 1b273aecaaec..ffacf703d9f9 100644
--- a/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml
+++ b/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml
@@ -22,6 +22,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,pm6150l-flash-led
           - qcom,pm8150c-flash-led
           - qcom,pm8150l-flash-led
           - qcom,pm8350c-flash-led

-- 
2.38.1
