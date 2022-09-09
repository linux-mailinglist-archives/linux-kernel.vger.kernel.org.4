Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33EF5B3B78
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiIIPJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiIIPI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:08:58 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322EF13E4DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 08:08:56 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id u18so3184147lfo.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 08:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=OFl3KVYMwoKCA5gQPOAWcRrgWousLHFPlPzosiKMPAM=;
        b=X5XTx6S2KgWJ+JA+QRFDx0RWr6e+TRPp2Sz7f2lqt58qI0bknyk/ct/kzhYdwWAGOr
         cXki5Cd4jWF9eGcYSfEiP95rItylMlwow/f5sll94gGtKRix65HFNAjOxrv4PfjXd9lx
         NOYPp7ww3TEULP3xu6K+vHFBk8m/Iw6LVULJ44pRObr4sLlxm1GXPJmXKtkXeyrrfVdI
         pymQFmLzGBw1YgOkaiLGC5bd1QQt+Glv+rpI9ESOq2Xxo/Ya5pe8IpNZ5JzLxp/0m5hT
         bOlMiPK5Y3l+BamGwbB95p6AVcgubMlRgx27+WVHxdm3zAwjNwO4kdUxSETXBL/dBduS
         Hmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=OFl3KVYMwoKCA5gQPOAWcRrgWousLHFPlPzosiKMPAM=;
        b=8PSjLHs/GLfYV7NzLp6KOlR2wHRKBR9Kfc7dKXi7ONkHMcS1xtqvZ4HOrLLRJWflaF
         dbs3JztXirw+D/dpvY9CXszkmp7n7bHc49pPO6/8FtMJuDSnaC9NhBZ3uEMlOPPFGumG
         R4lVq9jZGu+tISLVVeVHjGDqi7R1ZdZFtKmlN6fsPeeE18wbQD1tsvnyGA3nSYGOYg+t
         SejWNZVdJTTgKECgeiA+mBC7mjzT2KtLl/KKsmG6cnt30BeZluu3Hs+/y2r/Hw+PW3BF
         g/bNcrfcAibQjRLTta+Hp9n7vLDCUWS2kC3Vaf0/o0bzBqy42VacdLDrMwkB6ecShZZe
         lwSQ==
X-Gm-Message-State: ACgBeo07MvQ/L2HB5EtQSwlGUs81d50P5bcofj/R2PJ2mAID4pR6EQY3
        FYy5wDgKV7r4UHmri1n/8XdUMD8m/1f63A==
X-Google-Smtp-Source: AA6agR4FN4UZ1MeD4KdaYCws73kSEI+YhbT4w0FFcJ1iRYXsiaN6wwY9/EcHgX9n1reM0ZKfCjRY2Q==
X-Received: by 2002:a05:6512:3daa:b0:494:8270:f6b9 with SMTP id k42-20020a0565123daa00b004948270f6b9mr4718992lfv.486.1662736134564;
        Fri, 09 Sep 2022 08:08:54 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id d26-20020a2e361a000000b0026ab83298d6sm110605lja.77.2022.09.09.08.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 08:08:54 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 1/2] Samsung SoC driver for v6.1
Date:   Fri,  9 Sep 2022 17:08:48 +0200
Message-Id: <20220909150849.820523-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-6.1

for you to fetch changes up to 6212d2d9bbde60171d0c534e5f43932f84a06d5e:

  MAINTAINERS: Drop Bartlomiej Zolnierkiewicz (2022-09-09 16:59:25 +0200)

----------------------------------------------------------------
Samsung SoC drivers changes for v6.1

1. Convert Samsung Exynos G-Scaler bindings to DT schema.
2. Maintainers update (drop Bartlomiej Zolnierkiewicz).

----------------------------------------------------------------
Krzysztof Kozlowski (3):
      dt-bindings: media: samsung,exynos5250-gsc: convert to dtschema
      MAINTAINERS: pwm-fan: Drop Bartlomiej Zolnierkiewicz
      MAINTAINERS: Drop Bartlomiej Zolnierkiewicz

 .../devicetree/bindings/media/exynos5-gsc.txt      |  38 -------
 .../bindings/media/samsung,exynos5250-gsc.yaml     | 109 +++++++++++++++++++++
 MAINTAINERS                                        |  13 +--
 3 files changed, 110 insertions(+), 50 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/exynos5-gsc.txt
 create mode 100644 Documentation/devicetree/bindings/media/samsung,exynos5250-gsc.yaml
