Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3875BD314
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiISRCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiISRBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:01:02 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6373F1E8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:00:28 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id e17so138863edc.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=2Meo31PuvkGIwIM5AdXoX0Hd0Yqmep6vNoeB5sp1WIo=;
        b=h4xvs+f5cmaWKYK71+hYnOmPVkiLtaB2mRla9tuoCEJPd+4ppfNzN0FBFiwIs70U65
         tbJ9aJA3dpNgt1Ckv+Bx6Hc8Syb3OFhB4z+FJI0fxOKxNgoDOjZd8j6Uskwq0OWUm816
         O7xPp4SJYuri2o1ZZKVZOB4LzhA9nFL2qpDxRJhsPPzW8j/vsldo+OZmErddviwJRjTi
         p4lfIW565oRIN/c+Vrhth50HEka7xMLu+MKAjKA+FPbmPD21phAwhccqtGiVTtSD60Zd
         EGLplHMN2dasKn0QgJPqQZBi+CeACR4L5U4Dlj9odh9YO7SKHNRH5sQETerhK+QEqrcG
         P3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2Meo31PuvkGIwIM5AdXoX0Hd0Yqmep6vNoeB5sp1WIo=;
        b=4UjhTE9gIhVhvh/1Fkn//xBZWae5uoIBWDy3rVi6Map7xBe12DPiNXOIxxz1Fd3UGv
         rarmlpYnHTEe0l+L7Orfuv9SVGQ4l4/sIRmWY+EKwMye+bHcAhL9W14v3IZ6p8jPAyH4
         /D/yZb5Gk6P5UKv5FOys5CDdKFlX7FRcrqO/ruZm2i0nrZGUrJDSKjWe361XTgg4AA+O
         voc4W8f/RIdSdWRmnLMqwf0D0zyEOG7UrUtMzWawSSb9ilGdduwzTpCiiYeBS4fmJq+Q
         68mfcU/yJ7j3PeyyTmMXxkaZGmNxU/1odf1qwLAM7fl1JEiEegPSPu9uMd991dt5J3yh
         Dq3w==
X-Gm-Message-State: ACrzQf2SvtRV0gyqqGmk4y652v3zT7+fBBeiIbMb6MAO05UtLShXiUOn
        /NqJtRrUmJ27mXRpNvTyfpjZmw==
X-Google-Smtp-Source: AMsMyM4nXsx/EGy8bNgRHqGUolsSurVZgmUHv5N2kQ+oMKWiHF7U6zG3vs9wXOsAsDPUMkE0zR3f8A==
X-Received: by 2002:a05:6402:847:b0:453:943b:bf4 with SMTP id b7-20020a056402084700b00453943b0bf4mr11555407edz.301.1663606819619;
        Mon, 19 Sep 2022 10:00:19 -0700 (PDT)
Received: from [127.0.0.1] (2a02-8440-6340-f287-3074-96af-9642-0003.rev.sfr.net. [2a02:8440:6340:f287:3074:96af:9642:3])
        by smtp.gmail.com with ESMTPSA id cf16-20020a0564020b9000b0044fc3c0930csm20424246edb.16.2022.09.19.10.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 10:00:19 -0700 (PDT)
From:   Guillaume Ranquet <granquet@baylibre.com>
Date:   Mon, 19 Sep 2022 18:56:13 +0200
Subject: [PATCH v1 15/17] dt-bindings: display: mediatek: dpi: Add compatible for
 MediaTek MT8195
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220919-v1-15-4844816c9808@baylibre.com>
References: <20220919-v1-0-4844816c9808@baylibre.com>
In-Reply-To: <20220919-v1-0-4844816c9808@baylibre.com>
To:     Vinod Koul <vkoul@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Pablo Sun <pablo.sun@mediatek.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org,
        Guillaume Ranquet <granquet@baylibre.com>,
        devicetree@vger.kernel.org
X-Mailer: b4 0.10.0-dev
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-binding documentation of dpi for MediaTek MT8195 SoC.

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
index 5bb23e97cf33..2c7ecef54986 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
@@ -24,6 +24,7 @@ properties:
       - mediatek,mt8183-dpi
       - mediatek,mt8186-dpi
       - mediatek,mt8192-dpi
+      - mediatek,mt8195-dpi
       - mediatek,mt8195-dp-intf
 
   reg:

-- 
b4 0.10.0-dev
