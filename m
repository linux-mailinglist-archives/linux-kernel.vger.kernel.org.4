Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC658678EBC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 04:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbjAXDF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 22:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjAXDFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 22:05:23 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B19B2CC76;
        Mon, 23 Jan 2023 19:05:22 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id n8so12246453oih.0;
        Mon, 23 Jan 2023 19:05:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xk4+Vm8v4wzLEgMP6WlX8JSzRYNU6eFU1QUEyNlFosI=;
        b=4xn3XdE6Xk4+oiBGWcg6Q9l3BrkkqbHlfhYInw7AP89xceyJwIdineJjYBQcnaO7P/
         ZfS53XY7HcKaJwA37pJoR9dC+OQE7jRCgU2FZNE8w5QJ6AyspAAf/9Z2SqG60PzHTzWz
         xeB1q8/29kXp5An4hfBK9Pnd0T3GgHhzySI4lnPJhZm3OuV271kn5yGy+J7rjb8od9NQ
         OeKEL/F37gN/zij5Y2uuCCMJ1vbyZ4vEBBhClDyd8ZdMn+pwPH7/k+VcahPYRKjnL9G7
         B2RS9KN6BxstX8dLDOz1DcnTLDtPhUfHDsbzdM3Zyf/2oIsnbSqBLMlcOX88Knqc+1uX
         199A==
X-Gm-Message-State: AFqh2kpzHgYH6rqk7LAmmpQvqOTfGTElk/yuikqvlvCQ72gRQHT+Arzu
        JzA83Y4QusgRaghXdHUeGg==
X-Google-Smtp-Source: AMrXdXst3JoI2NBXuIrK65blr0cehJdMUewk4qoXF1Qd+FyS0toceDw915fLBXVpo2fyMR3DsMW4Hg==
X-Received: by 2002:a05:6808:228a:b0:364:4eb7:e873 with SMTP id bo10-20020a056808228a00b003644eb7e873mr12078336oib.7.1674529521530;
        Mon, 23 Jan 2023 19:05:21 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bj19-20020a056808199300b0035b4b6d1bbfsm503702oib.28.2023.01.23.19.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 19:05:21 -0800 (PST)
Received: (nullmailer pid 3266337 invoked by uid 1000);
        Tue, 24 Jan 2023 03:05:20 -0000
From:   Rob Herring <robh@kernel.org>
Subject: [PATCH v3 0/5] dt-bindings: usb: Convert some more simple
 OHCI/EHCI bindings
Date:   Mon, 23 Jan 2023 21:05:15 -0600
Message-Id: <20230110-dt-usb-v3-0-5af0541fcf8c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOtKz2MC/22NQQ7CIBREr9KwFsP/BFpdeQ/jAui3JTbUQEs0T
 e8u7c7ocibz3iwsUfSU2LlaWKTskx9DCfJQMdeb0BH3bckMBUoBIHg78TlZDk7LulZoGmlZGVu
 TiNtoguvLPMzDUMpnpLt/7fbrreTep2mM7/0sw9b+eDNwwRuSWpNErUBeHhQDDccxdmxzZPzPY
 eFOqK0D1IIUfHHrun4Ally7aOoAAAA=
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
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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
Changes in v3:
- Fix document references to generic-ehci.yaml and generic-ohci.yaml
- Link to v2: https://lore.kernel.org/r/20230110-dt-usb-v2-0-926bc1260e51@kernel.org

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

