Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523B95BAE43
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 15:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiIPNfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 09:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiIPNfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:35:36 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAD34BD0E;
        Fri, 16 Sep 2022 06:35:35 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id u15-20020a05600c19cf00b003b4acef34b1so3295986wmq.4;
        Fri, 16 Sep 2022 06:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=nDnDce8rBMMJuRJYWfPrj7rbkGJfYBlnkTE3vJZ36sU=;
        b=Zijioaybi8TOqRSTxLl1q9hRGLvwVbMPY5F1f5r3n6tV3tbbrd489EiM7XvqK+ecJw
         F3rt7+pdq0p5/7P/3Pmk0ilNo6Vhq8JDa8BmawLQ0aUtBju3DUGvrhJwAnXu6NlKOJk7
         c4B51w0ExeIoZjCNx+3MZZ3+Ohp/K7lqqjJMK5MN41e+tCCLqumOpVC86m3yREda9j1U
         WK8EEAcExVWRo1VYkZ2Er6rvLGdJSfZPhw5EjoTkOKbuCjmPhP9iCEEOsHYsSOvyWc6n
         ZsY+6ofUfWJeQbyCdgYOBea8+aBkiMIvMIDNhMc46V9UZ6aGqsI+D95OcvfZSZ/p6fkw
         bsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=nDnDce8rBMMJuRJYWfPrj7rbkGJfYBlnkTE3vJZ36sU=;
        b=0IrIdyGV20/J9ctm2JrRm1whnEv86//oqlpu3wMA7s8nkwZJZlzsWHtm/3+oKBfRbm
         Q4woBD5f3ACibM9LyEGlWyyUzmBj03hGFXLoqheV8iNeU5snOSk5QsNjzArJ0kMjxbF6
         SSFAz9b1l77s07ROtwAkyBAlK6CxrAkkBvEEZRvb8rvLMga0ZzShMqiBerRJX4VUp8iR
         xTq0sh7/zkUThGkoWA5cxPL/beG2GVOITo+L0X3/8CwPauzAbaSRtPivXN/51viRM9yI
         036blGw9EBwjYqXASu6Wx29kQnzcTz3fd7WpGGAUkXmKa/CML5Nd5hUwidL+D4OOhsaE
         PAOw==
X-Gm-Message-State: ACgBeo3X/xLaF9uYJ3XfDS6nKVNRQbi8Hg7RQdspou0mxmmc2BNuzc8X
        fpVF+tMtJqIo1Z42munix1lmp11sHt3KXJu/
X-Google-Smtp-Source: AA6agR6AsFGYGaufE/XB2baP22fwXxA/H87Vng6laElDkNEIpV8vw5WkArS6afqAXrwLwiGA0dncbw==
X-Received: by 2002:a05:600c:3781:b0:3b4:63c8:554b with SMTP id o1-20020a05600c378100b003b463c8554bmr10212123wmr.25.1663335334003;
        Fri, 16 Sep 2022 06:35:34 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:453:ec29:bd55:6b15])
        by smtp.gmail.com with ESMTPSA id d7-20020a05600c34c700b003b4ac05a8a4sm2541748wmq.27.2022.09.16.06.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 06:35:33 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] media: dt-bindings: i2c: ovti,ov5640: Drop ref to video-interface-devices.yaml
Date:   Fri, 16 Sep 2022 14:35:21 +0100
Message-Id: <20220916133521.73183-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
 Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml
index 540fd69ac39f..ce99aada75ad 100644
--- a/Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml
@@ -9,9 +9,6 @@ title: OmniVision OV5640 Image Sensor Device Tree Bindings
 maintainers:
   - Steve Longerbeam <slongerbeam@gmail.com>
 
-allOf:
-  - $ref: /schemas/media/video-interface-devices.yaml#
-
 properties:
   compatible:
     const: ovti,ov5640
-- 
2.25.1

