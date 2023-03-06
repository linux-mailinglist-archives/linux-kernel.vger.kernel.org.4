Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185806AC19C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjCFNkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjCFNkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:40:33 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474ED2FCCF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 05:40:30 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id k10so14774780edk.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 05:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678110029;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZW1Oqg+WLuWWxkuIkyJR54a4c3JXn+NZetW0zwSCeSw=;
        b=cuvBAavVvAQVUP54IBvXmzklqerlQN2fNulM+x734wtvrCyyyrFSIbHxMeBokGLcIP
         pkkJ6uBVZTDQqpgRfgEM0/sIW+6WotEmGDeNJMHIFUnsKW3h8CT0EyAbw4DyCwPjrhpE
         WudN8Y2KYBCkeTqmo098LV4W0EhF8FQ9AG47GHRVeqay66sObxfm7csAncStrbk90EAh
         p9MuucTj6mF/pYqJInvyqLxpp9ZRxUGgvEILHxA+E3oSzZkir0BQGVEe8UTKEG9HPT3V
         keZBOsBoCo7mHVVRWvvMxGhqTWmwssFJzwzm/VEmYdUSYA4o6m1U5i9ucyxuwjw+8PSw
         r9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678110029;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZW1Oqg+WLuWWxkuIkyJR54a4c3JXn+NZetW0zwSCeSw=;
        b=03yMRIFlsCTtLYwXgvPOlCmCQPbVUmWv5ZX5XNSYUGwDyC5meN9zTnP3iX0S5yZqC3
         gK3i1hwKhvOUclvvxftCPIEOHxBtCfV0QzuaoJZnh20cPqtpfBvcWzV1SksW9joX1ixr
         Nl0hv4C4DisscrxPhiwJLnQYjo7IQ+HKxvUd9t9vzObpNVqG9JCZvaj6czb6XsqqWPe5
         X2KVsBuBN/xMOnV00mHcKd3h23LqJct40Y9z/mAojqfwUUYf271T/sFZOr2Uy/k0QyGu
         QjENdxDoVMtpOGYT19kYR1sEZwbU9bNHDEX9laNuDSlPFGqvw1DFglJt7hO449wHZGvf
         1OXg==
X-Gm-Message-State: AO0yUKUH8xfRFB63tB8cPabaEEg+9aK6aU09PqylNpSA08cnZWOntx7h
        qdaCxva5L+ap4/wJM1vidFot+Q==
X-Google-Smtp-Source: AK7set/0XrGcKW6yxv/wJZcYC83SiD0kz0lIalXfaXFBbdXe/zoJAr5MHbFp08xZq8Th54ZnERWtsw==
X-Received: by 2002:aa7:cf90:0:b0:4bc:502e:e7de with SMTP id z16-20020aa7cf90000000b004bc502ee7demr9831944edx.32.1678110028679;
        Mon, 06 Mar 2023 05:40:28 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id u2-20020a170906c40200b008e2dfc6382asm4574959ejz.125.2023.03.06.05.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 05:40:28 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Mon, 06 Mar 2023 14:40:11 +0100
Subject: [PATCH] Fixes dt-bindings: display: mediatek: Fix the fallback for
 mediatek,mt8186-disp-ccorr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230306-ccorr-binding-fix-v1-0-177d81d60c69@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2033; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=Sllvr1qcJosNPm/127wltPmXLo/4qloGmkwT8rLTdQs=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkBe1Lg8S54sdx+TkgJNo3Q94C1ufIjETI8glahloA
 wAMPhpWJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZAXtSwAKCRArRkmdfjHURYxBD/
 0TgSfGN1WScR5N5YN6E/+DvS8lJCRDx+Ky+06JfD0PD/Oskchz6XpYCjhFeSKztRXMpZZIbonI1aa0
 fyxq18BAhYPzBeELrCMD8fWqGuC069YvDqTVQeIE3pz9XpooTDesaQWHh59UgT4119MCpLnLHM2xE+
 rdpm+l7he9szKBSEdvS9RbBHYh/GUY22ipY6APt5qFgua2DsCr+QPrcNxlnY75p7DbifXqBu3V3NPZ
 QBywL/k0JnIraVsSTr20XYmhGtKYv1GmwimQ1uXxGjDbIQM9CxaM6Eg2Ngeob9m4KUZwa9AdPTo52l
 kP7dELhSgd+qei7U/kKgQVj0vCQv8w/JjRJkR2ylQO1SDTdoJmfbGOr49GWsWE/aqp3AV5QsBHiful
 17Xcw5DcnpG/5wbbuNc472Fr7uWwxIkSvvLZxuiER3g8+3oF8O0rx/JXFKTZvzf3S4fzNNuyglXTt+
 fOMYxL3iB5pjsOMJmPtRKenLhJnde6pGHcBMFJo28ZG9aRVLQDOV+Mp8kAPRwjqaI1bPWOLrDyOsfj
 Z9w8RwWVBKXHC3XXkRiSMtER76zkOZdiTHo3An37wNV98cTQ5VWuyuiscunseNUjqqnbdad17m2Moj
 /8HwAtPOqMmrdoWqDXF1RAzdGPD/BuXBlelZvYCVZN20LXGywmz0hMDFG3Yw==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The item which have the mediatek,mt8192-disp-ccorr const compatible already
exist above. Remove duplicated fallback.

Fixes: 137272ef1b0f ("dt-bindings: display: mediatek: Fix the fallback for mediatek,mt8186-disp-ccorr")

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
Fix MTK color correction binding

The fallback compatible has been duplicated in the 137272ef1b0f commit.

To: Chun-Kuang Hu <chunkuang.hu@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
To: David Airlie <airlied@gmail.com>
To: Daniel Vetter <daniel@ffwll.ch>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Matthias Brugger <matthias.bgg@gmail.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc: Rob Herring <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-mediatek@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
index b04820c95b22..3aaf44719786 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
@@ -29,9 +29,6 @@ properties:
           - enum:
               - mediatek,mt8188-disp-ccorr
               - mediatek,mt8195-disp-ccorr
-          - const: mediatek,mt8192-disp-ccorr
-      - items:
-          - enum:
               - mediatek,mt8186-disp-ccorr
           - const: mediatek,mt8192-disp-ccorr
 

---
base-commit: add072536971d7ce891fde3cdbf68c55e7cfa95a
change-id: 20230306-ccorr-binding-fix-718c6d725088

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>
