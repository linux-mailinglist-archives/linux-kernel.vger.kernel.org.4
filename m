Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082CE5BAE51
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 15:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbiIPNhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 09:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiIPNhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:37:43 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2F7AC26F;
        Fri, 16 Sep 2022 06:37:42 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r3-20020a05600c35c300b003b4b5f6c6bdso2455173wmq.2;
        Fri, 16 Sep 2022 06:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=rORpGGbJKPVv+PVvk49M2jSMdJUZULrbtHHlInsLrkQ=;
        b=b1iczw5CXHlGhJY+7Y6+yvHb5Q0YgKVqQaqcGhIhTHGzeYY90RZ+xvUOWyTGho+I6h
         soKUQqhApU+V66BwIL0Ul78t1BGJAs7CM/zuPjEzQU+RMr692MsMBBDwjvaEvv0C42/j
         iEN8w6HmnZ937SNzaKWUphPAzhroCvMmiHel6FN06gRBuEMDe++ya4HmB9EdifpXRrN1
         S4y0mZL9HAr1WFuK+wfXsyWIyXwWbq9Lo8RWifYlevhNucPQ/Sm7MEubygHM6pqRfSy+
         qM6IWOp2WHFXIGqiBP2LE91cBxa90EG/5voo7XP/lDNEFnEWrh1OyoJDzN+SYTmOqA5G
         RVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=rORpGGbJKPVv+PVvk49M2jSMdJUZULrbtHHlInsLrkQ=;
        b=hGRBSkxB3q2sVoyOv8dvycWCl+on3FE548ry5vt84m3wKJxGRefp3OJEPIOCOYbquu
         3XwXkPTshaHrt/A1OS069ln9xYMZP0StOKKi6oh7Pr16PZcHq1c85/5+NXB8vTaXLLHb
         qhVN4wEgQNOE1j/h+w8DbhWPgakLPGfLTio7Z93i/5WABrAG5jHPTDnz3YVHtSWDc3WE
         0LDg9OInEI+HPH17mpNhcRqMgcCXolPyVKFSzCmvT+kV9jEJR+RnrlOOn6k6rfTMaEpV
         UxE+lcNhOTbGLTOzuSQmgnX7CaaR6RGXl80Wm1JOCFDHRt3zeJEMVLZMo9vTsa5vlTVO
         y/nQ==
X-Gm-Message-State: ACrzQf0uIz8WbMNo3cNzQhZdVx+xfvI7S9WsJwK83YsFwuH/w7mHbb91
        ElekuHwTlZ6Mb8FbudkvJFc=
X-Google-Smtp-Source: AMsMyM4zgMhHDwxcK38r/llMwjONmZ930iJB3qaVTn/4mUnfujfJsY8z79ZTjhacrl3bux22I3cEpA==
X-Received: by 2002:a05:600c:268f:b0:3b4:acef:34ab with SMTP id 15-20020a05600c268f00b003b4acef34abmr3370602wmt.176.1663335461413;
        Fri, 16 Sep 2022 06:37:41 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:453:ec29:bd55:6b15])
        by smtp.gmail.com with ESMTPSA id p10-20020a5d48ca000000b00229d55994e0sm79024wrs.59.2022.09.16.06.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 06:37:40 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] media: dt-bindings: i2c: ovti,ov02a10: Drop ref to video-interface-devices.yaml
Date:   Fri, 16 Sep 2022 14:37:28 +0100
Message-Id: <20220916133728.73433-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

video-interface-devices.yaml isn't used so just drop it from the
DT binding doc.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/media/i2c/ovti,ov02a10.yaml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov02a10.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov02a10.yaml
index 63a040944f3d..bd1914cf6c33 100644
--- a/Documentation/devicetree/bindings/media/i2c/ovti,ov02a10.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov02a10.yaml
@@ -17,9 +17,6 @@ description: |-
   @ 1600x1200 (UXGA) resolution transferred over a 1-lane MIPI interface. The
   sensor output is available via CSI-2 serial data output.
 
-allOf:
-  - $ref: /schemas/media/video-interface-devices.yaml#
-
 properties:
   compatible:
     const: ovti,ov02a10
-- 
2.25.1

