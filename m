Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D167268D9E5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 14:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjBGN46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 08:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbjBGN4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 08:56:42 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B8E38E82
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 05:56:15 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id i5so6461233wrc.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 05:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woyCLhhr9GNDZ+ZK9imdrAaOvVCw51EmSZRJm9R7J5w=;
        b=NtU54NwNW0ruK/8LURJT6C7S7FeX/i5HcbZpzVPSd8N4FDeryJMrp6kX0Ad05ncNEc
         g9vDeJ1/IVQLVx3XzIc+t86oT6mr60a2tMn0UqqxrOC8LSTRd3ycdIRBs7chpFuPc0X+
         qNqC4otwYGd4bjSgMGjhAh9e1OMmbbFXvFVFQk2fS0fSVcPbp2uq0k6KMaYkKSDnhysS
         88iL/fSSSKruvvOoLlrRofeuXgpaYWHUsuRSg+VS1V/wvSI6x2njwiqw/sSFXA8M80/r
         x/pD2M37xtEOV4yy03FSeC9nDx60cjzg8MdiBWM/e85wWIfOP82P5LNmh1KzLIACptYD
         Fomw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=woyCLhhr9GNDZ+ZK9imdrAaOvVCw51EmSZRJm9R7J5w=;
        b=IV8UZj9rPrpiW2jY1rOp5181j5OBqChjj2DZjKu+hbuwjA1ltTllFLgUxKyMoL8FqC
         uzE3xroFKpJGGld3cXmEjAdQ37Dq+uPAXfxVU9Bbh1DeedoAytTqjp6uLmBeFq1Xfknn
         NN2YLbDyU2+/dh9TUv+5H+zIFGVCjlcihW9D7ggreCaCYhLOJuhCjz7WKuNQPwMqovZk
         1F53cax9km4sMODuwgOJd2Jg6Gee5uAcZm3DZuyc9Doj7M5N5hNWWT5GAf/WPW4Tv+bz
         nCV2BQ70hTNoebtcZNlxwtgnlMRnXdK0NXTsSOt+GqMrIvfKqB+8tW3QxWIM0Pu4YxFt
         YqEQ==
X-Gm-Message-State: AO0yUKULoTp9oPosmxbZ/KCpDA/EMWYjMIuru+S8bLCzNk+NWAXzQiLT
        suz3+zc1DtMY63o4+oSaQWGe/g==
X-Google-Smtp-Source: AK7set+310+2rkvwM3A7GBlhW9EtKuxs3n1k3TNZRXyXkrqITOpLCmAe3j3hq/Bam4I+ObeiHtxrgQ==
X-Received: by 2002:a05:6000:188d:b0:2c3:be89:7c36 with SMTP id a13-20020a056000188d00b002c3be897c36mr15394572wri.25.1675778157897;
        Tue, 07 Feb 2023 05:55:57 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id p10-20020a5d59aa000000b002be5401ef5fsm11611312wrr.39.2023.02.07.05.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 05:55:57 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/7] dt-bindings: mfd: qcom,spmi-pmic: Add pattern property for phy
Date:   Tue,  7 Feb 2023 15:55:46 +0200
Message-Id: <20230207135551.1418637-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230207135551.1418637-1-abel.vesa@linaro.org>
References: <20230207135551.1418637-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The phy pattern property will be used for providing eUSB2 repeater
functionality. This will be modelled as a Qualcomm PHY driver.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

The v3 (rfc) is here:
https://lore.kernel.org/all/20230202133816.4026990-2-abel.vesa@linaro.org/

Changes since v3:
 * made this the second patch rather than the first in the series

 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index adf88245c409..1e6fadec1301 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -135,6 +135,10 @@ patternProperties:
     type: object
     $ref: /schemas/pinctrl/qcom,pmic-gpio.yaml#
 
+  "phy@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/phy/qcom,snps-eusb2-repeater.yaml#
+
   "pon@[0-9a-f]+$":
     type: object
     $ref: /schemas/power/reset/qcom,pon.yaml#
-- 
2.34.1

