Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA1F61EB79
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 08:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbiKGHPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 02:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiKGHPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 02:15:20 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5501513D3F;
        Sun,  6 Nov 2022 23:15:17 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id i12so7555431qvs.2;
        Sun, 06 Nov 2022 23:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rujbv6bKgQOEyHFPYldtrR7Cpoq25BGO11nL2f1oX38=;
        b=iSLvidCkZqtoV2Tl9IDn05Yg1hwAwzWvcwIQeK0ZGCShauUXjF5rgGeEORYUiFhhnB
         cLOmsGvH388K/cokMP6/QjxfakJbvxydeqYSe6SsWhZ8l1bzmB9SbaiRk5J8iF+1CLXW
         tW0a0bOuFM1VUyfJIYPC3tLdNssLw3phjq62I6MuKDwCZNhq0EYk6rwiewoxoluBBScq
         tQsju5Z/c+6BMLtPIXMGiMD2LLWFaV+P3NtdWmcirSFtxYof35CNGmN6CaBXt5YVmNLC
         qJLO6Rsbdqop1rw7cwM4ZCnvzQVmxyLnVtIKXWccwRiw05E9L+riGL9QrPnh6+tWkEG5
         b8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rujbv6bKgQOEyHFPYldtrR7Cpoq25BGO11nL2f1oX38=;
        b=uwKqv4zliM2o17TXwuxjdbfRZ4KBsS3DK/P+Na+PKAKDMAigIMiCu0Nt0tREZPgKs+
         ZyUPHL2G9+QjB/Qus06k0oYGj920VbxPzSl/jyk+Ei1Ku59QY5GGuN1jlJDL8UyLlRHp
         4hJFdnCjWzvG0SrQRTSROJnfpyTeblJUMG8zvO7mer/E8TmVeptUPVA0OWJYKIkhYojf
         LxcuemBDGOps4uroKey+gnxvC0SP3CNipMhB+E9HpLtKeMfUs8jr8AuTcEwDsxPxbp1E
         PCygaMQQBOPjCpfvCrhhBIS35CFb3RGVbCHAsafOsR1OA6BRmFu2XMXxpF7Bn+kS9LH/
         N40g==
X-Gm-Message-State: ACrzQf0nhW02ourOmEVUykHC6kbu/AYwsf/HsTRe07R1ry5xjcVTYZzd
        zCqRDjhO7mEbvY523g8kxc4=
X-Google-Smtp-Source: AMsMyM6KsjhgOm4uFsTfXn9s49un2+OpakxWD2QhahyM3daQtCGIEYlmtawlYkVmQj+Da5+ugT01Xg==
X-Received: by 2002:a05:6214:5015:b0:4bb:5ce1:88c0 with SMTP id jo21-20020a056214501500b004bb5ce188c0mr42492042qvb.15.1667805316339;
        Sun, 06 Nov 2022 23:15:16 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab (pool-108-26-185-122.bstnma.fios.verizon.net. [108.26.185.122])
        by smtp.gmail.com with ESMTPSA id br8-20020a05620a460800b006cf38fd659asm6318428qkb.103.2022.11.06.23.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 23:15:16 -0800 (PST)
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
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v1 3/7] dt-bindings: timer: gpt: Add i.MXRT compatible Documentation
Date:   Mon,  7 Nov 2022 02:15:07 -0500
Message-Id: <20221107071511.2764628-4-Mr.Bossman075@gmail.com>
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

Both the i.MXRT1170 and 1050 have the same GPT timer as "fsl,imx6dl-gpt"
Add i.MXRT to the compatible list.

Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
index a4f51f46b7a1..716c6afcca1f 100644
--- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
+++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
@@ -31,6 +31,8 @@ properties:
           - enum:
               - fsl,imx6sl-gpt
               - fsl,imx6sx-gpt
+              - fsl,imxrt1050-gpt
+              - fsl,imxrt1170-gpt
           - const: fsl,imx6dl-gpt
 
   reg:
-- 
2.37.2

