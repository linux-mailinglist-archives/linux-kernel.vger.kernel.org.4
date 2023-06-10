Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABFB72AECF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 22:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjFJUmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 16:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjFJUmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 16:42:44 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C201135BB;
        Sat, 10 Jun 2023 13:42:41 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f61530506aso30702405e9.1;
        Sat, 10 Jun 2023 13:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686429760; x=1689021760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VQbsytz9TyV1LG+i5o+RBweOKvc/HeR56N+REltTEvs=;
        b=QlViBFfedjLHorPByjYuUi0uDD/Zn5SlZiWJa4SfzVV/53gsiCRRqS65k7J9Skvbmn
         J6MeuA+I6Pbqrh7h4SGTfc512NJLgVMK0kujhUjAyGrAllvR1pkm5x3Quwvg+jyAyKvR
         EmSt2xAndhmQveisgStzKhSRBFKNq5Kp8s1Ixp+tikNcUyQnDg1GHbVDeYpg1QoNc9Lk
         ENdE2L6Nq1Yads4PkRnL2wVTaUwc6GEHy3wEJ7h40d1bru90LC9zXh+AwjTVzTWytQzo
         MKSLCKdXI7YJeh8yx+I+r+ChemT5Xg/wjaQWk1McCeF/AxqgtlzVtKlZSX+N0lsBl82z
         Uv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686429760; x=1689021760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VQbsytz9TyV1LG+i5o+RBweOKvc/HeR56N+REltTEvs=;
        b=DIoAEj4W7X1BrQwNjF/Wtsnpljc/z9MgVak5cBcrIgKzmtPmJS9Md/1I9tEyuPONgd
         lUsuBsJHQdlZYRVNjANvTJoyreyLgyI7gIaIu0uPOD57IWPLaXivl9B+yhKvyRCDSXEA
         D785Of801CUDOyDndksuCekiVv/A0gRpqb+PFIvi4JM2hKyjeSQN1826UkiHdRwavDIb
         pkiLxbKACamesjW8RBH88N+bekvc6Mdr2AFNFLvSUFjrOCQ75+YMu9sIlHdt2b1xMT+K
         rJGAcK/hFSdHdmgfY2hKeJRDEa/UfGWH8XnNWbvXc36tBG3g9Xv/TwKcAsOougzWXN+0
         puLg==
X-Gm-Message-State: AC+VfDyBfhN9SkCb8KN2j8hcQlsFeBSeC3ABEZGHLIQC9A3Rcz3AjrLn
        jSLKrUP6Y22lEWYUkrWWEu5KWuCAu7qMyxkr
X-Google-Smtp-Source: ACHHUZ713JxFEO0RaksKMViLB1b9DqxdlXmn5SaeyO4l4BysqXEWjvxThMiW/bKGtAiipgIsiB6RTA==
X-Received: by 2002:a05:600c:2147:b0:3f4:16bc:bd19 with SMTP id v7-20020a05600c214700b003f416bcbd19mr4214297wml.23.1686429759836;
        Sat, 10 Jun 2023 13:42:39 -0700 (PDT)
Received: from user-PC.. ([178.134.198.138])
        by smtp.gmail.com with ESMTPSA id p14-20020a7bcc8e000000b003f605566610sm6547733wma.13.2023.06.10.13.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 13:42:39 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maksim Kiselev <bigunclemax@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3 0/3] Add D1/T113s thermal sensor controller support
Date:   Sat, 10 Jun 2023 23:42:17 +0300
Message-Id: <20230610204225.1133473-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for Allwinner D1/T113s thermal sensor controller.
THIS controller is similar to the one on H6, but with only one sensor and
uses a different scale and offset values.

v3:
- Fixed SoB tag again

v2:
- Fixed SoB tag
- Moved binding patch before driver changes

v1:
- Initial version

Maxim Kiselev (3):
  dt-bindings: thermal: sun8i: Add binding for D1/T113s THS controller
  thermal: sun8i: Add D1/T113s THS controller support
  riscv: dts: allwinner: d1: Add thermal sensor and thermal zone

 .../thermal/allwinner,sun8i-a83t-ths.yaml     | 20 +++++++++++++-
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    | 26 +++++++++++++++++++
 drivers/thermal/sun8i_thermal.c               | 13 ++++++++++
 3 files changed, 58 insertions(+), 1 deletion(-)

-- 
2.39.2

