Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E32C61EB85
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 08:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbiKGHPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 02:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbiKGHP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 02:15:27 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5459913D43;
        Sun,  6 Nov 2022 23:15:18 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id c15so6424967qtw.8;
        Sun, 06 Nov 2022 23:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FevbBLdguXCFmnA0gYiJMt8h51HW7EHdkkwF3DmVtiM=;
        b=Oj0vqp+43Yq+/jWzQLRnuJhR+XUgWDl31H1CMGjjWKzn9r8KSbLXPNTvPdJEaZ5LZI
         q0MoSips3u+fpLOOMflvcjpjvyHYCYof38b3K4RFWeTtVCT7vOqgzTstARhu2SGwZ5eN
         RbfQACddReC7PUwmkvuMRr6z3s8M2BHVvamSCwAp+KQV6AKPJDYvBMPGskowB03uihae
         DCxz4EXPbPSz3mxqN8S7a+Egc602hA2cYKRn/cia5q81vyKYiIQ0CIzpEgbpQaAM3j7e
         nf6rKB1Rvpgv2X1vmH/u3iSF/JcwAOHP58jjUrs0TKhaG8DPnACLEyb9VSIJt2HrqZ04
         5Atw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FevbBLdguXCFmnA0gYiJMt8h51HW7EHdkkwF3DmVtiM=;
        b=jM+/D7I9q6aFOaM8uZlWXkPtloGyo9XxF9lsRFQFh0CIWDnNUe0MAkJiv/59k6WtgY
         edW7JjLvvtwiQ6ULPXehAEJ7PLC+RGIXDG38Jo/tg4wcoi42WubhW1lfG8D6vxUsgS8F
         gWHY1fOzWq/I6ts+WG4RVHK3wS5BVJwK1129q0fGjDXoCEpaHqyrIq9Pndap2qz78Kaw
         swKde++1oacE8MLjJqTmoElOHuv5X/wV5Bow1sJgClC/aP5tDw97jkTvNgjhA1xJDFNk
         fof3oWC4pFencz34sEGiUtg4vxOa9lcQr46Cx3Dp07vCNm6jV2fYTr479mK6YZ+QXzN0
         jCKQ==
X-Gm-Message-State: ANoB5pkKnsMY4is+q9ZVsKo16W0zB9yzGfXCyA5xkBx9yRDJX2u97smo
        hQbU5Vud0vq7gWcpfsv7sbI=
X-Google-Smtp-Source: AA0mqf7SQASvWKnqHMl5xXSgn1OAMYbUQcQ7wyKnX1Z91mCBgs4y4/2sjwK3qPE81S9M9O3kpXEbRQ==
X-Received: by 2002:a05:622a:11d0:b0:3a5:8ff2:8496 with SMTP id n16-20020a05622a11d000b003a58ff28496mr2679067qtk.302.1667805317449;
        Sun, 06 Nov 2022 23:15:17 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab (pool-108-26-185-122.bstnma.fios.verizon.net. [108.26.185.122])
        by smtp.gmail.com with ESMTPSA id br8-20020a05620a460800b006cf38fd659asm6318428qkb.103.2022.11.06.23.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 23:15:17 -0800 (PST)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-imx@nxp.com
Cc:     robh+dt@kernel.org, sboyd@kernel.org, shawnguo@kernel.org,
        kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        stefan@agner.ch, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, linux@armlinux.org.uk,
        abel.vesa@nxp.com, dev@lynxeye.de, marcel.ziswiler@toradex.com,
        tharvey@gateworks.com, leoyang.li@nxp.com, fugang.duan@nxp.com,
        Mr.Bossman075@gmail.com, giulio.benetti@benettiengineering.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v1 4/7] dt-bindings: serial: fsl-lpuart: add i.MXRT1170 compatible
Date:   Mon,  7 Nov 2022 02:15:08 -0500
Message-Id: <20221107071511.2764628-5-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221107071511.2764628-1-Mr.Bossman075@gmail.com>
References: <20221107071511.2764628-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MXRT1170 compatible string to Documentation.

Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
index 30eaa62e1aed..74f75f669e77 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
@@ -32,6 +32,9 @@ properties:
               - fsl,imx8qm-lpuart
               - fsl,imx8dxl-lpuart
           - const: fsl,imx8qxp-lpuart
+      - items:
+          - const: fsl,imxrt1050-lpuart
+          - const: fsl,imxrt1170-lpuart
 
   reg:
     maxItems: 1
-- 
2.37.2

