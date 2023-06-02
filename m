Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AE671FEF2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbjFBKVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235317AbjFBKVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:21:43 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C09196
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 03:21:41 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5149e65c218so2751071a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 03:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1685701299; x=1688293299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+N6ncdPhuJx70XZ6yjaTOtXW/wJdhXZgpqu86CyLnmg=;
        b=FN+wcbGOSq0oaAGO68O3XS3iH/IcziIzYBzGbvG0X5hp7SCpf4EJJNAg1ZHmseAnew
         VPCMtcRQpkV5+FX+hVA0hl3xoaUG8TEfI/J/HgK+jzruhXOyLLGtoLcSSQIjLRIjohII
         VKnbARjYi/zDstgJJ4cvJWtQugRvzYaC5omoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685701299; x=1688293299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+N6ncdPhuJx70XZ6yjaTOtXW/wJdhXZgpqu86CyLnmg=;
        b=FngLqwiNesdtaz1Nod8AsoAWy/V+pbEBmJrhXw2ljMkBOmGP/mgb7nYqHiJn1dqcxW
         WHD16d6da9+re8n2iY/9/g6XJh0CmUDG3ACP8ILQ5mPaVLMQCVTBUyT5RKNlQ64FigKe
         X3Z5FborUYCWfTZo+hFUbjhyjBH5r8i9Eh5j2xF8FKMSAbur8h6gPTvfmh9pYZb3d/st
         Ry1FxDlqifAnR7lGr8H3vQ4fxGnTus0VWma4BsveE7W+7fwyuV0nLVVW2WxhSN2oINWu
         atrlcMh6RClipyQhGDPBiJTkhg3GXuQi490nXKxlSSE2s3YPaG5Au97M88JyeSAGeQHv
         n+Mw==
X-Gm-Message-State: AC+VfDwCigrk9IlXdsN6nOmxsiff3PYT27SMU/v8rWWyHdgwicHL8a9P
        rJ7RlD+nMdWw7mpxuTZojbXjO93+1uSI5KyKPTczOw==
X-Google-Smtp-Source: ACHHUZ4cxTRC+aOD1sVygvyNLnQtq32ncqv67n9fRQJ5jpcnMNundXDEtA2HWACi2ZfzZnSq8+CJvw==
X-Received: by 2002:aa7:d817:0:b0:514:9d17:d6e8 with SMTP id v23-20020aa7d817000000b005149d17d6e8mr1521068edq.26.1685701299310;
        Fri, 02 Jun 2023 03:21:39 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-248-31-20.retail.telecomitalia.it. [95.248.31.20])
        by smtp.gmail.com with ESMTPSA id x24-20020aa7d398000000b0051499320435sm528887edq.14.2023.06.02.03.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 03:21:38 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v2 4/6] dt-bindings: display: simple: add Rocktech RK043FN48H
Date:   Fri,  2 Jun 2023 12:21:20 +0200
Message-Id: <20230602102123.3345587-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230602102123.3345587-1-dario.binacchi@amarulasolutions.com>
References: <20230602102123.3345587-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible to panel-simple for Rocktech Displays Limited
RK043FN48H 4.3" 480x272 LCD-TFT panel.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>

---

Changes in v2:
- Add 'Acked-by' tag of Conor Dooley.

 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 01560fe226dd..bd6a92d2b41c 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -280,6 +280,8 @@ properties:
       - rocktech,rk101ii01d-ct
         # Rocktech Display Ltd. RK070ER9427 800(RGB)x480 TFT LCD panel
       - rocktech,rk070er9427
+        # Rocktech Display Ltd. RK043FN48H 4.3" 480x272 LCD-TFT panel
+      - rocktech,rk043fn48h
         # Samsung 13.3" FHD (1920x1080 pixels) eDP AMOLED panel
       - samsung,atna33xc20
         # Samsung 12.2" (2560x1600 pixels) TFT LCD panel
-- 
2.32.0

