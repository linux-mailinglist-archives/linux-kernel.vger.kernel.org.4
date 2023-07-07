Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0386774B5F1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 19:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjGGRmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 13:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjGGRms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 13:42:48 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D5B2102
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 10:42:46 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b6f9edac8dso33250601fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 10:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688751764; x=1691343764;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q4fZInERUKONwLi7zatknNO9EBrKc4pjofSBjBTHI78=;
        b=LKK3/g4N2YDcUoL/gcfmYOOFibmW32lGjMDwtZfUpkQb4d5QkumrPEDDdcWDxAXyff
         GSYkofjekTcVmQJqsWeXPnf31sFR+yvx2WA4QoRm4JcI1eiyuk7TDHyhpKN8bmNZUAfU
         dyqvMemhrEbqFC0uVI0ji526W+z4zO0YhgpZ0AtRSqZlt9L4Iu6mjUzt0m/2n5ayVwAM
         xuG1l6aGc96v1IKvAYkpzDyUQcZ45urQJ/JMC6iNFZBGTti0q3eBIqxGPwTeV3UpS2lZ
         bedzee52f8hRYxuEpK8RThS7+r5UaBU9wzISW222mnzAzyPLz5is3Ko2vTwx3y8cIExz
         rzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688751764; x=1691343764;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q4fZInERUKONwLi7zatknNO9EBrKc4pjofSBjBTHI78=;
        b=BiMF6mXb7asAYXBEb6J5gdpPD1e34/axJxz3lH8kBJDlg9oS2rbAjVScjJDU5pq12W
         tSt44KwAe86dPutrrDW8ewG+daP0lhWOo0kx39gBF37k5B3RL5cEYsbtxbii/4n7y5G/
         EsICV/Tc4NVFrUKj96SNe5/avh4U29cLRixarqnic/sj5WqV41F3897v6PJE8bBCZ/N/
         PjC6c4eiZFXr+qFFbTp/rVKOK2FH+cX5TQA0vOXP8JSoGbsgl8ngQeNg8D6efGO0xM0s
         VHJJFWRlUNRYXk7r0eLbGNunFPTjmnNBRAtpyXVfwIJxiakRsUWF+ko1HEsjuZAcGrwJ
         /ptQ==
X-Gm-Message-State: ABy/qLYka3jscdgQZlEvtMYjXZBA1sfasQwy3DEfzpZYCper3xTPHJnU
        YbKpJyuDaj34vcnQeuGOp3g23A==
X-Google-Smtp-Source: APBJJlEVWutgSf46RQehJdflVv4IEPBh7sz0Sbpk7yxaz30bxgEKIBPMlVyTVpSLJ1R6/S8rCCEoYg==
X-Received: by 2002:a2e:9959:0:b0:2b6:d495:9467 with SMTP id r25-20020a2e9959000000b002b6d4959467mr4095870ljj.6.1688751764652;
        Fri, 07 Jul 2023 10:42:44 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 7-20020a05651c008700b002b6ece2456csm859163ljq.121.2023.07.07.10.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 10:42:44 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3 0/2] (no cover subject)
Date:   Fri, 07 Jul 2023 19:42:39 +0200
Message-Id: <20230707-seama-partitions-v3-0-6aa9391b46bb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI9OqGQC/32NQQ6DIBBFr2JYl2ZAUemq92i6GBSVpAUDhrQx3
 r3gxjRpuvwz/7+3kqC90YFcipV4HU0wzqZQngrSTWhHTU2fMuHASxBQ06DxiXRGv5gldQNVNQf
 GGiVlK0iaKQyaKo+2m/Lw6Ofn7PVgXrvvdk95MmFx/r3rI8vXP6bIKFDRQo0D0xV2zfVhLHp3d
 n4kmRb5QWhA/CDwRJB9WckBeoHqm7Bt2wcx6HmeEAEAAA==
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Changes in v3:
- Drop reference from partitions.yaml again
- Drop select: false
- Use unevaluatedProperties
- Link to v2: https://lore.kernel.org/r/20230705-seama-partitions-v2-0-9d349f0d5ab7@linaro.org

Changes in v2:
- Make the binding clearly childless
- Link to v1: https://lore.kernel.org/r/20230506-seama-partitions-v1-0-5806af1e4ac7@linaro.org

---
Linus Walleij (2):
      dt-bindings: mtd: Add SEAMA partition bindings
      ARM: dts: bcm5301x: Add SEAMA compatibles

 .../devicetree/bindings/mtd/partitions/seama.yaml  | 48 ++++++++++++++++++++++
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts      |  1 +
 arch/arm/boot/dts/bcm47094-dlink-dir-890l.dts      |  1 +
 3 files changed, 50 insertions(+)
---
base-commit: 035cd1416934ef7ae5374272d3c9e378c3d7049c
change-id: 20230506-seama-partitions-b620117b9985

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

