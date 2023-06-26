Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB9473DC44
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 12:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjFZKcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 06:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjFZKcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 06:32:11 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C48619F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 03:32:10 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so3887330e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 03:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687775529; x=1690367529;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pPsxUiB9GWjwGBSnRU8epv6MKBN53dRKhwBYysnzvdQ=;
        b=FCm6d7m5Ldgfx2Qld9rH21Nc9TPPsQHny8sXFf/BjHOP1rMm0O209+2K5qqTyCoYnS
         MeK8nP4j/WA6Nhvc6NIClFWtzzddOt4cPJeGNSesRGP/GOMytGNCetD8zzkex8xgqxZP
         aeiQzfGQgwulBdjOSaGIiHzsP+iJZXZjP+QZbDDjmbeKDETgj3MKT5EsUrJOldOktlbZ
         Frx8OhkXKTd3vaCLmZJMCEzZrnmBb1oe3ADax+7xj0F5+fdLng1eW911fi0kw2cmJOpg
         UWQrRsd21lT43m0V6tD3nSRSU2Cyd+WymHPQ8KsKwAe4xETf2EXDtkHET+lL9nPHGAg6
         eyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687775529; x=1690367529;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pPsxUiB9GWjwGBSnRU8epv6MKBN53dRKhwBYysnzvdQ=;
        b=FNed8R/9fGLGfbbHPwRKd72IQeAosEsb7AWZEVn2qAXgdQObwqhalj5+LqtVPQ/4t0
         qvZff3gQTK95qDfW69Jmx+0/y9rorzANiMFdU6M+yvcrgDvuS03Ad2t8TbY0FDgvwHUD
         7CwoDcnxqNoSn8+iExS54+obzsHGIe2M3JlKT6Esh6AwxprsJ3uRQQ+ZGnc1HGBeomlN
         X5cI4/0oxZHxZ0rd1p7k9iOzhb75GHlGHjWTI8yHaatgWJhe5GPo7a3lHV5Mmbmkw+bM
         sIIq+hHUE+eqWxblKpnRlaBu3qz7RXBiVAV+wE6ldmGAVH1h36s5KQE2L4wFztm0G5uC
         J5yw==
X-Gm-Message-State: AC+VfDzKN3mcQUhfVVSbn+5y4ZjUNl3iuXjfGdEvTWlOz5JXO3bsONGm
        1wntp0rx0lHEgfje2qOrpF6PnQ==
X-Google-Smtp-Source: ACHHUZ7Vq1RayEQCKKKOZ/ELOPCW4x8lEQVD6zKyGBlpmhkLKEXQQa7Kjs0VD4CESTReCC4BC1JxGw==
X-Received: by 2002:a05:6512:1590:b0:4fb:7a4e:b573 with SMTP id bp16-20020a056512159000b004fb7a4eb573mr942061lfb.5.1687775528805;
        Mon, 26 Jun 2023 03:32:08 -0700 (PDT)
Received: from [192.168.1.101] (abyk179.neoplus.adsl.tpnet.pl. [83.9.30.179])
        by smtp.gmail.com with ESMTPSA id c26-20020ac2531a000000b004f13ca69dc8sm1041655lfh.72.2023.06.26.03.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 03:32:08 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 0/3] MM8013 fg driver
Date:   Mon, 26 Jun 2023 12:32:05 +0200
Message-Id: <20230621-topic-mm8013-v2-0-4be6223587ad@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACVpmWQC/3WNyw6CMBBFf4XM2jF9QEFX/odhUeoIk0BLWiQaw
 r9b2bs8J7n3bJAoMiW4FhtEWjlx8BnUqQA3WN8T8iMzKKG0MEriEmZ2OE2NkBp1berqQpemUw3
 kSWcTYRetd0Me+dc4ZjlHevL7aNzbzAOnJcTPkVzlz/55XyUKLEtRO6OMEJW+jextDOcQe2j3f
 f8CrRdehr4AAAA=
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687775527; l=1176;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=neAEm/jOTpyEq30tLAlnYx3yk7D+d7zNKNZgHUszS/0=;
 b=TOTovknD6ZcO4dk9c+zYD1zMrGYhxuR/SNZni4fVp3x/1Clz7f5NSZX7xXUC4t4OWCSGgdBmy
 6UuAVTra24kCvEQdoxcOk5eBtL5M/n6bkblDZhiA07ORpgcOf4UPYHe
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series brings support for the Mitsumi MM8013 Li-Ion fuel gauge.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v2:
- Fix typo in patch 2 commit message
- Drop driver.owner in patch 3
- Add PRESENT psy property
- Pick up tags
- Link to v1: https://lore.kernel.org/r/20230621-topic-mm8013-v1-0-4407c6260053@linaro.org

---
Konrad Dybcio (3):
      dt-bindings: vendor-prefixes: Add Mitsumi Electric Co., Ltd.
      dt-bindings: power: supply: Document Mitsumi MM8013 fuel gauge
      power: supply: Introduce MM8013 fuel gauge driver

 .../bindings/power/supply/mitsumi,mm8013.yaml      |  35 +++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |   5 +
 drivers/power/supply/Kconfig                       |   9 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/mm8013.c                      | 283 +++++++++++++++++++++
 6 files changed, 335 insertions(+)
---
base-commit: 60e7c4a25da68cd826719b685babbd23e73b85b0
change-id: 20230621-topic-mm8013-376759e98b28

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

