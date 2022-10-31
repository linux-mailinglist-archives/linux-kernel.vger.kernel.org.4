Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82500612F04
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 03:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJaC3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 22:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJaC3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 22:29:06 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C146A45D;
        Sun, 30 Oct 2022 19:29:01 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 78so9526323pgb.13;
        Sun, 30 Oct 2022 19:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ym7VlgsY2ND1TufftBYNXemLLzwPWb6Y/WuEGfjTql0=;
        b=GZwxGwVscF6LN3u//xc+Xv3BdUt0QEiZ0RSRehwah11hGFQFQU1yH2u+q5Ce/z7BR4
         3Kj0N1PxO1FMfk5SHRb801HoGBORzDI4S1VFLldMwnBXOrn2xw98+rBVsWF0aAw9q9kU
         QYFZ2ms1UBCYXCa70rCVMtGtYz1K1GF06JKSD0n6lKCZwLrshoOtOVAolpdAyk1CrNYe
         IwuNMwROcJKSLMsJgg8xpia6iz1slZJyNZEgwxR7O8gESy6YjRogJp4N0Te4tFm1k1/P
         dwzRpSFTsf4aXUjNJRP6i8PtHC44triJpFPk4oICyS4Q7hPELabicG0LboqQOSbOg2xp
         KwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ym7VlgsY2ND1TufftBYNXemLLzwPWb6Y/WuEGfjTql0=;
        b=vRHXT/kJp05bmy63Wxtn2DBiENtmBrm7iwcs+zV5w+zS6os7Vnbc31pYyC7QdrpPTH
         wssxqepiaDrAs02lRNwy+mdKrFVtF1bakI8YcraRVxWlhxykXyFTl+SYWuoFj0c/L3B6
         2+ROb2AwCQt+pMfr+6osKCrZFhOK4pAUVvPzrlITU1dZdVOeuhrO9HFfQEaZxaV5Ye8N
         e7cAguBPAWBWLkpMCaPbmNP6ppC46aueNJgNRhKb74/iG0LpTgJaYpUHa5qXoLYo79hA
         fZ/iPoLm93YzHubCr/PLTo8a/5qgoj3SuYBp5bfe4TmeFdDSdR15nIU/riTmKf9TOZUA
         Cqkw==
X-Gm-Message-State: ACrzQf3YCrhC/h5rfkrt0WngPI3c8fr/Terw6VmE/NSyawV/tDoFkBd0
        vi1ZT8ly6dzO1R1JUVb+P6DdM1D9TTw=
X-Google-Smtp-Source: AMsMyM6ZUUAcJdycmC58Eeg3JYXtoSDDTfx/+SgW/Dl4cvYl2UBOCHKLa9P0nYQRJVswzmXIeoPKHw==
X-Received: by 2002:a63:d313:0:b0:46b:2ea0:5b68 with SMTP id b19-20020a63d313000000b0046b2ea05b68mr10556487pgg.464.1667183340398;
        Sun, 30 Oct 2022 19:29:00 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:46a:ab6a:820:3d51:c22d:4bb5])
        by smtp.gmail.com with ESMTPSA id q42-20020a17090a17ad00b0021282014066sm3064504pja.9.2022.10.30.19.28.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Oct 2022 19:28:59 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        broonie@kernel.org
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Add support for Richtek RT6190 36V 4-wwtich regulator
Date:   Mon, 31 Oct 2022 10:28:52 +0800
Message-Id: <1667183334-16511-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

The RT6190 is a 4-switch Buck-Boost controller designed for USB power delivery
(USB PD). It operates with wide input voltage range from 4.5V to 36V, and the
output voltage can be programmable between 3V and 36V. It implements peak
current mode control mechanism to deliver up to 100W power with the
programmable constant voltage and constant current output. It also has built-in
charge pumps for driving external low-cost N-MOSFETs to control the power path.

Since v3:
- Fix the typo 'upply' to 'supply'.
- Declare 'enable-gpios' maxItems as 1.
- Declare the 'maxItems' for the property 'regulator-allowed-modes'.

Since v2:
- Rename binding filename to 'richtek,rt6190.yaml'

ChiYuan Huang (2):
  dt-bindings: regulator: Add bindings for Richtek RT6190 regulator
  regulator: rt6190: Add support for Richtek RT6190 regulator

 .../bindings/regulator/richtek,rt6190.yaml         |  79 ++++
 drivers/regulator/Kconfig                          |  11 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/rt6190-regulator.c               | 495 +++++++++++++++++++++
 4 files changed, 586 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt6190.yaml
 create mode 100644 drivers/regulator/rt6190-regulator.c

-- 
2.7.4

