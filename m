Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F507481DF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 12:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjGEKRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 06:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjGEKRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:17:53 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2204180
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 03:17:51 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fbaef9871cso5477634e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 03:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688552270; x=1691144270;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5eLOAiii4EOxtxvIyXSfQW5YOuns9j70s4RUapPLtAI=;
        b=uSaFzHtN59RZDeePDZL0PRMGxKWScwW4i28fWgNlbnBDEgMKpfIuEWLsvh326frFpf
         fij4+UjNIY8kXbdLP5IjhT3ng5GTZkLk0PTCGIAWc7VBNTWfTCIjT4Zmt2lgDxJhZH2S
         CGNSOqPGAU0O2ufEW88IoaAKATABjLOIDCMsveg9zdD4zRqlUNu2Mzi8dc1duHgNCfzx
         5Xx7opHzrY05MgkV5twIgxTTzirB+gSrO0Li7uRGUi+umYCkV4QO+X0p3i+BTikuUS+n
         TTvxff9F4nwRXomzLjBSqX3b5ZNN7Rd0e+aMbHARvLnhOk1NyyU39WGpqg58uVhnWH6D
         AXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688552270; x=1691144270;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5eLOAiii4EOxtxvIyXSfQW5YOuns9j70s4RUapPLtAI=;
        b=ieNEw3bI6ZM6xADS0T1saRh4wOcC2G/+IGYupUS02ak11t2VnReLhGT5iML6BeTdqd
         RtiOmLRe/hFbUOqFYOpbOhMfP9JRJwmsp+Q+Z1PQM39soN9GpHeXz2/OBaOHzI6evg6r
         bPqxrfwmfwag1u2X9jN9aTahQagLabqc/2a1hUsvGYku8sBn1g90VcVobs4F4UnqkECy
         kuImy419PMcROrK8Wyv0nV+BHtznWK2gsLi7CVOjHjx9L8S3o/MmPhXOlR9t79Civeu3
         diC+jkv68dAQAb7VShdRbhhB0MODQHzho9ZuStRVzfXF28G1mFUwEDvSL5s+yd3MsfW6
         IwWA==
X-Gm-Message-State: ABy/qLaw6w20F2ezcrKxfTxCsiR37YDd4nzRnAbgQw5whgoAd5lh8P7a
        0CtyEEAtZvkinSqvuy7BeCbtyOvLzlVqV+J2sFIygg==
X-Google-Smtp-Source: APBJJlHyHUfBE5hWiRyGorzbw+EXcdgInM7frWQ6ipuxeNnw3SbsvM/KcM+QOtbOC/WxA1HtwCKPCg==
X-Received: by 2002:a05:6512:3e26:b0:4fb:780c:fce9 with SMTP id i38-20020a0565123e2600b004fb780cfce9mr13868458lfv.58.1688552270234;
        Wed, 05 Jul 2023 03:17:50 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id l27-20020ac2555b000000b004fb75943ab3sm4774418lfk.258.2023.07.05.03.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 03:17:49 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 0/2] Add SEAMA partition types
Date:   Wed, 05 Jul 2023 12:17:45 +0200
Message-Id: <20230705-seama-partitions-v2-0-9d349f0d5ab7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAElDpWQC/32Nyw6CMBBFf4XM2pq2ynPlfxgWUxxgEm3JlBAN4
 d8tbNy5PPeRs0IkYYrQZCsILRw5+AT2lEE3oh9I8SMxWG0vOteFioQvVBPKzHPaRuUKq40pXV1
 XOaSbw0jKCfpu3I+//V5OQj2/D9+9TTxynIN8Dv1i9vSPaTFKq7zSBfaGrtiVtyd7lHAOMkC7b
 dsXj+Dwi84AAAA=
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This type of firmware partition appear in some devices in
NAND flash, so we need to be able to tag the partitions
with the appropriate type.

The origin of the "SEAttle iMAge" is unknown.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v2:
- Make the binding clearly childless
- Link to v1: https://lore.kernel.org/r/20230506-seama-partitions-v1-0-5806af1e4ac7@linaro.org

---
Linus Walleij (2):
      dt-bindings: mtd: Add SEAMA partition bindings
      ARM: dts: bcm5301x: Add SEAMA compatibles

 .../bindings/mtd/partitions/partitions.yaml        |  1 +
 .../devicetree/bindings/mtd/partitions/seama.yaml  | 50 ++++++++++++++++++++++
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts      |  1 +
 arch/arm/boot/dts/bcm47094-dlink-dir-890l.dts      |  1 +
 4 files changed, 53 insertions(+)
---
base-commit: 035cd1416934ef7ae5374272d3c9e378c3d7049c
change-id: 20230506-seama-partitions-b620117b9985

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

