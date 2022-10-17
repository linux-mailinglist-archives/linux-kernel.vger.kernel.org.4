Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FCE6013C4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 18:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiJQQnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 12:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiJQQnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 12:43:01 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080FD6EF11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:43:00 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id y14so26210689ejd.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wd7qt9Y69GxtzzaG+0eDdZVNxTR8osN5UREXRUPZGYY=;
        b=C7yaISHJJcjy28PH08rE9s8ZZMVFQnz7iwYDYhUOyd2+8umUQLF5R8KUzLYBLf9qn8
         sV3zeXmLsZ9B64sXKubPI8W2vfW3ajHbu0dIeFHmLhyfKLe0Pg/J7z7q3L+Y5ihj4zFV
         QusK5ocBPrEGQzkkNJqA42ezRnJzep1IOShKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wd7qt9Y69GxtzzaG+0eDdZVNxTR8osN5UREXRUPZGYY=;
        b=vy3WyKe3aGLKduCHRF3PU1Y83DlIYhueLA44ZinS95V7B545aqKhZhOMroprSFsJVj
         3ze4aluBqUBLGUhagYwKgRkUrTAkAN3enHmEiGCykEpY9UoPj1nyX0W7n098XMQxCGOm
         7f7xQd9T+dc762SG/xd3ndaHtnpQ0DAc4/PK+uT3zSP0XmVCKwmnHYM54B4UoYkS8vPU
         vqCs99yLuev6m8nmhggAVYbSNxNYM5/nZVN2DEl3955mYDrxxQTdD5E4cm6iVx93Czf4
         mBlEUvyDbXMhaPoJmrYsmy/P9bLss3aeshGYVyea/b7NlP+tv5FByxPrEO7NVEY5GPZb
         tNRw==
X-Gm-Message-State: ACrzQf3aAETRQnPNWHnjh4Mkm7fAbOUMn8INFBxTJJ23lHgjsHqAHc1L
        nGNITxZ1IIB3yJDObHvnaENH5Gd5TvSd7A==
X-Google-Smtp-Source: AMsMyM4i2eQhL+b75XqgI4zjogiDW6a8WKKC350BSeJHcgZHSdfB0jvKpLawJ13a87kC+eW+0iXL/g==
X-Received: by 2002:a17:907:a42c:b0:78e:fd1:61b4 with SMTP id sg44-20020a170907a42c00b0078e0fd161b4mr9508774ejc.289.1666024978405;
        Mon, 17 Oct 2022 09:42:58 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-244-101-110.retail.telecomitalia.it. [95.244.101.110])
        by smtp.gmail.com with ESMTPSA id a24-20020a1709063a5800b0078128c89439sm6437388ejf.6.2022.10.17.09.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 09:42:58 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Christophe Roullier <christophe.roullier@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [RFC PATCH v5 1/5] dt-bindings: arm: stm32: add compatible for syscon gcan node
Date:   Mon, 17 Oct 2022 18:42:27 +0200
Message-Id: <20221017164231.4192699-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221017164231.4192699-1-dario.binacchi@amarulasolutions.com>
References: <20221017164231.4192699-1-dario.binacchi@amarulasolutions.com>
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

Since commit ad440432d1f9 ("dt-bindings: mfd: Ensure 'syscon' has a
more specific compatible")
It is required to provide at least 2 compatibles string for syscon node.
This patch documents the new compatible for stm32f4 SoC to support
global/shared CAN registers access for bxCAN controllers.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Acked-by: Rob Herring <robh@kernel.org>

---

Changes in v5:
- Add Rob Herring's Acked-by tag.

 .../devicetree/bindings/arm/stm32/st,stm32-syscon.yaml          | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml b/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
index 6f846d69c5e1..8646350dac44 100644
--- a/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
@@ -20,6 +20,7 @@ properties:
               - st,stm32-syscfg
               - st,stm32-power-config
               - st,stm32-tamp
+              - st,stm32f4-gcan
           - const: syscon
       - items:
           - const: st,stm32-tamp
@@ -42,6 +43,7 @@ if:
       contains:
         enum:
           - st,stm32mp157-syscfg
+          - st,stm32f4-gcan
 then:
   required:
     - clocks
-- 
2.32.0

