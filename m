Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C86715713
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjE3Hi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjE3Hic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:38:32 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD0910D
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:38:23 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f603ff9c02so27644875e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685432301; x=1688024301;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L8Wj+HDjZSnhs7OQTpUP21VKK/kmLLc0wW1eKOrWb7M=;
        b=suZawle7XyCtmTwc9koewCMnKkWPXacwHsZLDFLFYQc3h8tUK/ExADY4dPmZuPA2hP
         /2Otqa3QJVnMcWdz/ZIrVBE1/wHd1C0FynszMshKwVb1eP9jz9/Xb3PFlTps1pz6OegW
         bWZiQVQtr4ErEeffk3KKdTOHQ7e+94+iSX2WzbaDAfQ5VVBgJDbfVmTLapSwfYTppFhv
         oAfHRp68hwGYopDlGIkVcrZtNJJ+XlO/U1dRpOms/isnM0jfs0bVrwFRA7RfGWK6FxXb
         452cNwWfHaqWUuoApq2gUPLFUKPJgmmbeOUh8DKRQn+XyYPKAY4xT/Lpw+Q2vBggAQj7
         KfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685432301; x=1688024301;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L8Wj+HDjZSnhs7OQTpUP21VKK/kmLLc0wW1eKOrWb7M=;
        b=CGxEEPhtKY8UgnyxRwmPgJpyI/zf3Pu2hof8bAkULp7IxVxjdJPaZENhFW+93WHPUG
         sMTc7JyfOezeFBE0xQX3Wv8dViPoG+W/pDAs2HdkC0G9C1N5xgYzGYjFWyvoy/Ki8/Y0
         mIcEuErtjCb/SHugN8HY1ZjfzfF5yRHspgzC3SjoHuRX0c1e4R+cMwJGBulO40cFyv2u
         bcBGywLd6ZnKzmamNw+hDVpoJ7erX7JwbqItoNQNoDvdGIF+Eqr8+fWtNyJjzA9K2YG8
         fnVuw3SY30G3iGzt71vAhBJM5mBxK6C+8pnh6lxSZ7dXk2/z+l1HDbdXtwnrul4QRVtr
         Q9Qw==
X-Gm-Message-State: AC+VfDy75oqkZ3TyUGUUKRDOEeplQnL85V7lCQc8Ed4P7Ot2yoto6lCe
        8wxSEebu25gWsf0W7rmx1fRxLA==
X-Google-Smtp-Source: ACHHUZ4MbWC2LdJcXlvseLKtinFpCmjk45kQkUC4gyJQ6tXM3sCovJx5aDRdYpZlfNDPK2Ol6Xs8Wg==
X-Received: by 2002:a5d:4003:0:b0:30a:f02a:b84d with SMTP id n3-20020a5d4003000000b0030af02ab84dmr898742wrp.13.1685432301659;
        Tue, 30 May 2023 00:38:21 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m4-20020a5d4a04000000b003079c402762sm2312013wrq.19.2023.05.30.00.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 00:38:21 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 30 May 2023 09:38:08 +0200
Subject: [PATCH v5 07/17] dt-bindings: display: meson-vpu: add third DPI
 output port
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v5-7-56eb7a4d5b8e@linaro.org>
References: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v5-0-56eb7a4d5b8e@linaro.org>
In-Reply-To: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v5-0-56eb7a4d5b8e@linaro.org>
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
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     "Lukas F. Hartmann" <lukas@mntre.com>,
        Nicolas Belin <nbelin@baylibre.com>,
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkdafgrQ+d6kVlnqgthYceWHgXDRj4X3G8yCwWhqxC
 zPMd+56JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZHWn4AAKCRB33NvayMhJ0eT3EA
 CaIP+cIiapaagNPLfNF2mzXan492id42Vf+UOmKe5aW23Bk7xsIVga2C3eORTyR87dGU0msoFj0M0o
 PspPAeNAg7DXsMG3N0tpN3pQU9joVnYJobwujt7fMlBo9h2LqkjTlvD1BrWSnOtkn92Amoj9lROpbd
 296eS7FzQBOybBtYOICBCbI5Me8Epuh84+WZy9pqHaj44YiDeH9U4UsdteRPYutqED/1oGKZ0z6Eet
 Y6VNtS14EwxYbcB/hIoF07ReQFwqaSkuJOZFVVCVmABEfKsP7Civ8Kr5jWI70sI6eq9Uqn+aOEqUDT
 z2nnSHtmrzR6pIp1cWb9YbDB6YXQ1HUTx/PyXxp+M4Lj9Gw3laPdn0qRQ785bQSUSqFZgTXge26B0q
 xZVu4MnknfHXLTdZ1v2tPtErmaTrvGa9G0vadKqvqHbD0oqrSGHIlsg6zkw3c0GC8lzaFKdO6ZQ68D
 fm3GGGGjDrUvhgOdaMo4clJxq0mhDdRadCdwdWAJm1KikDaVwKShkRU87r5uu/kXur/uyQD/B5JLtU
 JGE2aZD4cvNjIywneK6eobQpnxStvcZs6mI3WOUwjNtYFqXnNKefvE9oP4lxjqMak0Mux0gf8vXtRL
 xJgFplqz2XADbImv2izEtL/ZAHgG1BZhNGjXQCZT1aImRaz9rH3OUOnzwSrg==
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

