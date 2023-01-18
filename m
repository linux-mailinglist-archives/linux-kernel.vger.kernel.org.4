Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60854672798
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 20:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjARS7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjARS7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:59:31 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513F95957F;
        Wed, 18 Jan 2023 10:59:31 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id f88-20020a9d03e1000000b00684c4041ff1so10494270otf.8;
        Wed, 18 Jan 2023 10:59:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nHSFrwryn6fPv+cT/r2Gmm/cJBn2LuFhBNelG0ms7lQ=;
        b=NNt2gJH3Zkq/yG9POMCrTPI4cWsMN5QYPkRGATB+vpA58avl4mKA/kYp4QnKvCqN4S
         WWIInwJN1Q7njYiU+DxRWdHH2tyF6YTXYwm1QXocCh0M3myRSi95/prViMvVTnIdl+nF
         MA01DXZX8vTdEivQbHSz0+TXHj+UEi/vnDyNTigSUF1CJtQAAbPlT7ZcFD4x52Dk1MS1
         F3SWBOtKGjmW8fCOqsrfXyvkzNLl2QNED4Ze/L6gte6LaXGIJ0LrlqhM9Rfq5pRu4SXx
         rFHT78vkMEsQG2m9gBsvzikZTztzNgTqeDb3PJwumxDJtm3wOK43OLdcjbn94qXX1Uy7
         iaig==
X-Gm-Message-State: AFqh2kpEpB+COxVgPqPtRxJ/W59YNMfPEHgBAtzs60OuMBltllh/AA4m
        oE2pbOupMvPoZ9FBzCH14GCRvczxFQ==
X-Google-Smtp-Source: AMrXdXsXsibVi/mXBx5wpLNup3wGFrSwbUKQ5EbaZJM3qDLNOiUndqkGVOrWW3O789IRP6ncH5I1sA==
X-Received: by 2002:a05:6830:26c5:b0:686:41a1:4c16 with SMTP id m5-20020a05683026c500b0068641a14c16mr5435393otu.24.1674068370410;
        Wed, 18 Jan 2023 10:59:30 -0800 (PST)
Received: from robh_at_kernel.org ([4.31.143.193])
        by smtp.gmail.com with ESMTPSA id o15-20020a9d764f000000b0066b9a6bf3bcsm18688925otl.12.2023.01.18.10.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 10:59:29 -0800 (PST)
Received: (nullmailer pid 629743 invoked by uid 1000);
        Wed, 18 Jan 2023 18:59:29 -0000
From:   Rob Herring <robh@kernel.org>
Subject: [PATCH v2 0/5] dt-bindings: usb: Convert some more simple
 OHCI/EHCI bindings
Date:   Wed, 18 Jan 2023 12:59:23 -0600
Message-Id: <20230110-dt-usb-v2-0-926bc1260e51@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAItByGMC/2WNywqDMBBFf0Vm3Sl5YJSu+h/iItGpCZVYJiotk
 n9v6rbLc7ice0AiDpTgVh3AtIcUllhAXSoYvI0TYRgLgxJKCykFjituyaEcjG6aWtlWOyhjZxO
 hYxsHX+Zxm+ciX0yP8D7rXV/Yh7Qu/DnPdvmzf91dosCWtDGklamlvj+JI83XhSfoc85f7/lOX
 bIAAAA=
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Lee Jones <lee@kernel.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        openbmc@lists.ozlabs.org
X-Mailer: b4 0.12-dev
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'ohci-usb' compatible is another 'generic' compatible for OHCI, but 
isn't documented with a schema. Let's add it to generic-ohci.yaml 
schema. While looking at this, I found a few other USB host bindings 
which are simple enough to use the 'generic' schemas.

Signed-off-by: Rob Herring <robh@kernel.org>
---
Changes in v2:
- Fix schema error for 'transceiver'
- Split OMAP changes to separate patch and convert omap-ehci
- Link to v1: https://lore.kernel.org/r/20230110-dt-usb-v1-0-8e366e326513@kernel.org

---
Rob Herring (5):
      dt-bindings: usb: Remove obsolete brcm,bcm3384-usb.txt
      dt-bindings: usb: Convert multiple "usb-ohci" bindings to DT schema
      dt-bindings: usb: Convert OMAP OHCI/EHCI bindings to schema
      dt-bindings: usb: Convert Marvell Orion EHCI to DT schema
      dt-bindings: usb: Convert Nuvoton EHCI to DT schema

 .../devicetree/bindings/mfd/omap-usb-host.txt      |  8 ++---
 .../devicetree/bindings/powerpc/nintendo/wii.txt   | 10 -------
 .../devicetree/bindings/usb/brcm,bcm3384-usb.txt   | 11 -------
 .../devicetree/bindings/usb/ehci-omap.txt          | 31 -------------------
 .../devicetree/bindings/usb/ehci-orion.txt         | 22 --------------
 .../devicetree/bindings/usb/generic-ehci.yaml      |  5 ++++
 .../devicetree/bindings/usb/generic-ohci.yaml      | 32 +++++++++++++++++---
 .../devicetree/bindings/usb/npcm7xx-usb.txt        | 20 -------------
 Documentation/devicetree/bindings/usb/ohci-nxp.txt | 24 ---------------
 .../devicetree/bindings/usb/ohci-omap3.txt         | 15 ----------
 Documentation/devicetree/bindings/usb/pxa-usb.txt  |  2 +-
 .../devicetree/bindings/usb/spear-usb.txt          | 35 ----------------------
 12 files changed, 38 insertions(+), 177 deletions(-)
---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20230110-dt-usb-1c637752a83b

Best regards,
-- 
Rob Herring <robh@kernel.org>

