Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BBE7008D2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 15:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241182AbjELNM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 09:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241149AbjELNMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 09:12:03 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681E113291
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 06:12:00 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3090408e09bso193839f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 06:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683897118; x=1686489118;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L8Wj+HDjZSnhs7OQTpUP21VKK/kmLLc0wW1eKOrWb7M=;
        b=UVCtYsypN67W5itTExzTednHd0K+yG+KL4EpyNFwnGdPdIvNUsOSxp7lcnYZG/7Ey2
         v7oMZugKSY4pohBQmPy4eDZ7SDAvHSx2mWzXWRUmNorKmZ2OP8sNYcorwTl5BguMnOVI
         eoaPpYswy51MjtCRPSBMbG4MnpDAjnJazw6cKKroZbMosEvudzDD1fg2VttBx1HCD0cX
         j3cVCxKuASiYy+9eusgcIJLNYMF0LOSWO7+WChTnItgB45fXDHuzXC+0uhtVL7kDEqEN
         IUQt4XV8EchJME2glik6NgOWTiVbazRCAvEf3FmaH+D0jyfN++T3/jMxa21GHVrJWxAo
         nHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683897118; x=1686489118;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L8Wj+HDjZSnhs7OQTpUP21VKK/kmLLc0wW1eKOrWb7M=;
        b=JT0sv7BDbbJW6ZN9IaACpto+soDohlkxjWsoTFeLoaApz4OdBIFAOFxvhDydy+uwf6
         OhDrlVOARfujTf6gUDKH2ZDP2H0NbKV17giYY+nSx9ubq9p0CP8cddUFkaGpOISA08tm
         NEgAVA+yP3MYnZihDFaMf6yUUmPSFH9L2ztp0AjUFfQPotHMAeGGziloFdKhPPY9wwkH
         IgcIDUTqGRtnHjty412I0LRhsG8anZBDYw6X2iUP4yBtIaQdizDVM8gcTXYabnjpQiaM
         kMATGHUEuMBSPeykezBoJ/LlTH8ky59ucJdAVh4pR+7/y5VPDTt7gLpwctlxXsSBph00
         SmJQ==
X-Gm-Message-State: AC+VfDw41z6jv3EVecuZaY6pOxr70xzBf2DA90+gL4KqjAH8R2Mvhyqa
        xCP1VKEJPvKFkT2Im2dXQjHUYw==
X-Google-Smtp-Source: ACHHUZ7IzdPm61Rr2uFsr715Ac526tlT5Hv0vb6s2t7X9303MA77SS0I44BQBpcPw2M5AeT9ip2IFw==
X-Received: by 2002:adf:e84e:0:b0:306:35fa:202b with SMTP id d14-20020adfe84e000000b0030635fa202bmr16023907wrn.6.1683897118717;
        Fri, 12 May 2023 06:11:58 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id v10-20020a5d610a000000b0030647449730sm23461965wrt.74.2023.05.12.06.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 06:11:58 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 12 May 2023 15:11:36 +0200
Subject: [PATCH v4 05/13] dt-bindings: display: meson-vpu: add third DPI
 output port
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-5-2592c29ea263@linaro.org>
References: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-0-2592c29ea263@linaro.org>
In-Reply-To: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-0-2592c29ea263@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Nicolas Belin <nbelin@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-phy@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1111;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ngaRaj/ff6scDRZWhYNPrhhh/3jRLEZndlPLfgP8m5M=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkXjsTubNQpwmz5c/oK2m/saPsEBPvZXH2UV0wcY7w
 qdfTDvqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZF47EwAKCRB33NvayMhJ0boiEA
 ChDW4mIkGle2SE4bBMV+Zdy6APbp4Iah8IZf//W3pW5aOoJ/7v0VbGd2wOH9OSw2WpezBbdZjXEDfU
 4J9ocYwS6ZG5EtfIZifV5aW9EbmwrUhs9Qep++6/B5NrJtj1YqTcP8ml+CiUSHNZWtEyxIm+ygAzDP
 MmIyVX0ZPeasfzNcQTaj7EFrY9VxytAtkj5p8MxP6jNWcc7XPz3iw3dU5aK4Ixlctrwl55QPG3B63m
 8gY0qnLyr3jpQSR5zPMKuZ/4hppbnl7RwAZrQyFKxnBulrR1Y0GmVFFHh1RxD84cWuZG/D6fq2ZIG8
 rOKj/wWjE/AGcKSEIZiuvww0d+Ndp1Z3rKiOZiaLTDpsncFqWbTuw4LBUpzZfv7KJCedXkYDI3/fwe
 qd9/8Dk6n+6Z+8/sfvHIgIECRqpAtsOAPVLe+vJa4Nq0cmjmBXAx1dJONcuBRFNB1l+8sNDS8A5BJy
 IMeYC9r7/DPdijCDEr0HposrbxEQdWK3+MqTkB+eXE5QNX8Y/xpGYFIzDY03ZrVPHm58y02VYj+4Lm
 AwduefS4VNvdEx2qsygT5jBVt4YCWJpIy2P9VpXd9z2KbU+45RFPLA0naqcsXZi3RxPEBJg6vQX6j8
 6jWpuSH0Ss9dqkCnXktP5QCzzrxwM3+LIE0L1rWMD+Mp0GtPXsAevIDtt5Kw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add third port corresponding to the ENCL DPI encoder used to connect
to DSI or LVDS transceivers.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml b/Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml
index 0c72120acc4f..cb0a90f02321 100644
--- a/Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml
+++ b/Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml
@@ -96,6 +96,11 @@ properties:
     description:
       A port node pointing to the HDMI-TX port node.
 
+  port@2:
+    $ref: /schemas/graph.yaml#/properties/port
+    description:
+      A port node pointing to the DPI port node (e.g. DSI or LVDS transceiver).
+
   "#address-cells":
     const: 1
 

-- 
2.34.1

