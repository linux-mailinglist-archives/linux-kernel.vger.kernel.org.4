Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A56735C88
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 18:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjFSQ4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 12:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjFSQz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 12:55:56 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2A710D9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:55:50 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-76241c98586so282347585a.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1687193749; x=1689785749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXhpNMq77ixD+XgN0GcYbuylNiGuY9CxnraNzjgz9ZY=;
        b=PouTpA+2eidqrl2NfeWbcV1LWEd+x0sWxTYQqZBmR29e20+aBqMcRvmbdsZHxk/2Kq
         RlWwI7B6oc4NIV+fZrj9r54OOU1KWGPD93E/gAX81LmHhbzAz0pjOmQ9MyzQOqhaQ325
         8/nMG/HMKeVZlzv/TM7cOrnvPqkTZAVZWRW5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687193749; x=1689785749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXhpNMq77ixD+XgN0GcYbuylNiGuY9CxnraNzjgz9ZY=;
        b=Pynv83PSAsvhBVJOa0G2MTw1aU/7KB8mPlBzMPgAMVPS/Sy0N4RdTqhWRrmOvs0k3t
         uZbSjl6yoBmwOfgU6Ara5rnfaU4IpvAt4VaSKZCeKR6EywFMlIimJxvQ3V3ceomFTm/V
         MPtzRigopzWe138joSXBJXPv9xWM2s6lDGCIpSxAsJK+ei0us9wINQiYP5zW934mKM+p
         aa7E5pxwf6oHN5o5k043P5DRKw2teGW7jsvA4h4cGDhBalECUQuPDWUFCGhuDpgDZcLr
         qxQXnolsfx3Tz9FWmGHaCyOMu1Fc7k1dCzsMtb2uJu6XB4wE+OkIp7aQWezeoWf89Z63
         d7pA==
X-Gm-Message-State: AC+VfDwAyEIv+BNjcA+SLS9TzX9Ll+eiUQt3heGxuNGTeyvtZpwY7YNU
        k98TBu907oJ+lOR+k9jJBlMpf7QR1nz3E68TaP4=
X-Google-Smtp-Source: ACHHUZ6AP48wP9d8GIHmSV3eR8tx7WohjgeTcIWdUh34I5pP/yusbF5PhwUo6SmU/aUFLMfgqX8keg==
X-Received: by 2002:a05:620a:cd2:b0:762:52a1:4687 with SMTP id b18-20020a05620a0cd200b0076252a14687mr4387025qkj.22.1687193749648;
        Mon, 19 Jun 2023 09:55:49 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.pdxnet.pdxeng.ch (host-79-25-27-4.retail.telecomitalia.it. [79.25.27.4])
        by smtp.gmail.com with ESMTPSA id p23-20020a05620a15f700b0075d49ce31c3sm109103qkm.91.2023.06.19.09.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 09:55:49 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Philippe Cornu <philippe.cornu@foss.st.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v4 4/6] dt-bindings: display: stm32-ltdc: add optional st,fb-bpp property
Date:   Mon, 19 Jun 2023 18:55:23 +0200
Message-Id: <20230619165525.1035243-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230619165525.1035243-1-dario.binacchi@amarulasolutions.com>
References: <20230619165525.1035243-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boards that use the STM32F{4,7} series have limited amounts of RAM. The
added property allows to size, within certain limits, the memory footprint
required by the framebuffer.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 .../devicetree/bindings/display/st,stm32-ltdc.yaml          | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml b/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
index d6ea4d62a2cf..1c3a3653579f 100644
--- a/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
+++ b/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
@@ -42,6 +42,12 @@ properties:
       - for internal dpi input of the MIPI DSI host controller.
       Note: These 2 endpoints cannot be activated simultaneously.
 
+  st,fb-bpp:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      bit depth of framebuffer (8, 16 or 32)
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.32.0

