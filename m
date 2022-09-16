Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E095BAC16
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 13:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiIPLLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 07:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbiIPLLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 07:11:18 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3973E80;
        Fri, 16 Sep 2022 04:10:20 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t14so35479714wrx.8;
        Fri, 16 Sep 2022 04:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=7Jiy9Z4SJ5cNBRsxm2AaeKN84NRRpfl9TETV1EliQY0=;
        b=cVmemc1dWQooaSXE42w3lLujnnYWM4LnNs1xICO9X2/TuKkAJcv3oJuHS6YWM1sjfv
         Sir3OOXMW4CzzdEd7nGi1zSML9SyJhN9VhFVLsg4sIAqU50vxXvgj0N9VM/okB2JMMqb
         F5UVIwazQ9N5/MUP+4cPemPaWhe2AIGOui0JRDfy2WPYG42N894d2Q3OfbVRzs3tCYQU
         cTVAnfxE5nuALegum6xXN2gjJnq4bfCKdHIhWYmPhWwWcN1atXYcL/eE9mLD3f/nTful
         0ymZYnWdEhq0ZI9mtT/mF+3xQLyC5pC3ENR0vQyA4ac38hVl8FRJ8rcM2PNV+2+LPgaa
         MH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=7Jiy9Z4SJ5cNBRsxm2AaeKN84NRRpfl9TETV1EliQY0=;
        b=TqCWdZmBt2yDf+RmsywAe8RsANYHr/5HE1h+4jwvVGXlC4qAayA2PvsRPCR8XLvjDY
         TPSDoRe2Z+1XImlY4+dVj31cV0e4PPbsEgjZISaNx+SPGiR+pKPuSCAFhXkQJbz4gYBJ
         cY+pZzrykeuF15VYmos/aJEDe+m4Em/lz7GZnQHq24cahjFHbc/kfljywIrfhmnt9Lns
         RE+pzivhqO3sNuFktI5op7W2CLRKjgVBvZLSH9O8YG8g1WfwOs3HiXJ1Vaf6Q2zLuFWj
         xCkwfq/zp8ExY3k+WPo2op90N+vbFMgvTzZTXrCuGOe3qBccAp0Jiuj0Leq3YSxBWwtd
         x/BA==
X-Gm-Message-State: ACrzQf3GQtIc4oGWlqakYCGFh8dE0dlcK78G3RF/V82DSHrOQCPSYWDZ
        9pYgGnqtGsUrsePX5az0nE0=
X-Google-Smtp-Source: AMsMyM5uYYboPdipnTAjvzRjZ63f8BKibpPBYysbOFcFHpjdCslmV3qxSI+WUHChDv6QqbC9cZKT8w==
X-Received: by 2002:a5d:64a8:0:b0:226:f3f3:9914 with SMTP id m8-20020a5d64a8000000b00226f3f39914mr2401583wrp.343.1663326619194;
        Fri, 16 Sep 2022 04:10:19 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:453:ec29:bd55:6b15])
        by smtp.gmail.com with ESMTPSA id v13-20020adfebcd000000b0022a403954c3sm4910975wrn.42.2022.09.16.04.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 04:10:18 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dongchun Zhu <dongchun.zhu@mediatek.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] media: dt-bindings: media: i2c: Rename ov8856.yaml
Date:   Fri, 16 Sep 2022 12:09:55 +0100
Message-Id: <20220916110955.23757-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Rename 'ov8856.yaml' as 'ovti,ov8856.yaml' and update the MAINTAINERS
file entry accordingly.

All the Omnivision sensor DT bindings have vendor prefix "ovti," to
their file name hence this renaming.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../bindings/media/i2c/{ov8856.yaml => ovti,ov8856.yaml}        | 2 +-
 MAINTAINERS                                                     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/media/i2c/{ov8856.yaml => ovti,ov8856.yaml} (98%)

diff --git a/Documentation/devicetree/bindings/media/i2c/ov8856.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov8856.yaml
similarity index 98%
rename from Documentation/devicetree/bindings/media/i2c/ov8856.yaml
rename to Documentation/devicetree/bindings/media/i2c/ovti,ov8856.yaml
index baf92aaaf049..342b3158bd28 100644
--- a/Documentation/devicetree/bindings/media/i2c/ov8856.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov8856.yaml
@@ -2,7 +2,7 @@
 # Copyright (c) 2019 MediaTek Inc.
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/media/i2c/ov8856.yaml#
+$id: http://devicetree.org/schemas/media/i2c/ovti,ov8856.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Omnivision OV8856 CMOS Sensor Device Tree Bindings
diff --git a/MAINTAINERS b/MAINTAINERS
index 99483c13b91c..22381a43aa26 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15191,7 +15191,7 @@ M:	Dongchun Zhu <dongchun.zhu@mediatek.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
-F:	Documentation/devicetree/bindings/media/i2c/ov8856.yaml
+F:	Documentation/devicetree/bindings/media/i2c/ovti,ov8856.yaml
 F:	drivers/media/i2c/ov8856.c
 
 OMNIVISION OV9282 SENSOR DRIVER
-- 
2.25.1

