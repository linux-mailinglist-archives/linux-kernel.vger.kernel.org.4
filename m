Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27E26B6889
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 18:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjCLRDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 13:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjCLRDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 13:03:00 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF2339BBC
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 10:02:44 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id d36so12842131lfv.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 10:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678640562;
        h=cc:to:subject:date:from:in-reply-to:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bMzb4+f+2BylShTzIH+kD9h/2l/yJ2pk3VVMD+904ak=;
        b=UcgQEUTeekUE+yO0Pfm+bm9izAiSVibcvIffL015exUwnHDJuG8iZEHRC3h2DRu4A8
         j6rMpg6coJh4Z8X1Dj/PxIdUxERGROjPj959rb9YoDLajnVivD5BCvErNAS4Bjf/zgyq
         HElDaIT9e3SNBbFFYtIAXh19eeBdPY7qU/vBaHAiIfq03AhSHyzkiD8TZcckk/nsr5jp
         0/fWjXXg2p8+Uk160ywZD/cwDQfZS+o9Bc2Xw2xoWaVAbie9eDuoXrGz8NxXbyI+JRDN
         W1ZeGeLyx1sVMXgB1PLHnAkJXJQaVrM1RVzqkNghlM2ngaH/mbOcNzaAfOMfUw5feOif
         o3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678640562;
        h=cc:to:subject:date:from:in-reply-to:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bMzb4+f+2BylShTzIH+kD9h/2l/yJ2pk3VVMD+904ak=;
        b=w9eWGQCy7VnHHZ7wSvIcRwLAUwXBYLYtfykn6eDYOfNXMThqm3z2f4V9ev2b49DqHe
         rxs2oW0nM97EVx8xU++M8nK8WAOfakzG7DOSUKhm04VWDtoIQC68XbwvQijUtUR2Q8si
         XZ1JkwcGNMwjV9uBQ4ufMacdBD7tdpNCternRKgNHDC9uFke9c4jMs2KBUuUifv2Hl8m
         Q1r/w/7qTiQn4zSwgViI+1VKxEpo4cRJVxOFNDBtl0/xSCi0t5wyOAQip3Rsm3Gy5hUw
         Ckacj2z+JMK55mN2EY8fTChIq1X9piUrc3JNa2CSVQZCf8qawFnumD8t+6zvGoZEmBcY
         ds1Q==
X-Gm-Message-State: AO0yUKUX8/BxOnxmVLYYOb+cyxh6Mk9aG9vTggRJNBFMA7LxLa6utkAH
        TcMOQeyf3bLmynX4PT+0cmLeqFYpnOdRUah6
X-Google-Smtp-Source: AK7set9ZlTH17G0FnW+z13Pb1s3HaUJEmtKLrWEW5BIxE79NrmbvApt2Nmyr1n9kVAWtfq5kdkDqkA==
X-Received: by 2002:ac2:563a:0:b0:4de:290:1c0a with SMTP id b26-20020ac2563a000000b004de02901c0amr9292769lff.57.1678640562189;
        Sun, 12 Mar 2023 10:02:42 -0700 (PDT)
Received: from 0001-dt-bindings-exynos-dw-mshc-common-add-exynos78xx-var.patch (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id b9-20020ac25e89000000b0047f7722b73csm693942lfq.142.2023.03.12.10.02.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 10:02:41 -0700 (PDT)
Message-Id: <1678640497.9030156-1-sleirsgoevy@gmail.com>
In-Reply-To: <1678640497.9030156-0-sleirsgoevy@gmail.com>
From:   Sergey Lisov <sleirsgoevy@gmail.com>
Date:   Sun, 12 Mar 2023 19:59:29 +0300
Subject: [PATCH v4 1/3] dt-bindings: exynos-dw-mshc-common: add exynos78xx
 variants
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Samsung Exynos boards using the arm64 architecture have DW MMC
controllers configured for a 32-bit data bus but a 64-bit FIFO. On these
systems the 64-bit FIFO registers must be accessed in two 32-bit halves.

Add two new compatible strings, "samsung,exynos78xx-dw-mshc" and
"samsung,exynos78xx-dw-mshc-smu" respectively, to denote exynos78xx
boards that need this quirk. But it's very possible that all
"samsung,exynos7-dw-mshc" boards are actually affected.
---
 .../devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
index fdaa18481..a72a67792 100644
--- a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
@@ -22,6 +22,8 @@ properties:
       - samsung,exynos5420-dw-mshc-smu
       - samsung,exynos7-dw-mshc
       - samsung,exynos7-dw-mshc-smu
+      - samsung,exynos78xx-dw-mshc
+      - samsung,exynos78xx-dw-mshc-smu
       - axis,artpec8-dw-mshc
 
   reg:
-- 
2.38.3


