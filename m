Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9568C664FC9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 00:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbjAJXSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 18:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235298AbjAJXR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 18:17:58 -0500
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5513C209;
        Tue, 10 Jan 2023 15:17:57 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-15b9c93848dso5525785fac.1;
        Tue, 10 Jan 2023 15:17:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4lkFM/UpYCvsam9zyZ1K3XdTYML8CgB63Y9WsqByvPo=;
        b=CMTBQgEFzMcPw9PUjwu0ZH1NcyagRpVuTDO+pFjEwtVlRcewzC1hd+8M/eJVauFdZr
         eEn32ZOzyA2rrj3VOmPvJYVzOqlpGWZHOuKlnyVirXF1BkW9pBew/ESMk3GqqaG6j1O4
         wsSHZ6m7kVXFwW3HbK28drLRl+rMIUNQpY97qoxK9LiubA2GX5BGl6zV7C8IN814x6vo
         E0hMDtJ2nethxOWcpV+nlulJpKTL2aqfhtYq8sX1ktCLvg5GBcEGI6Q5JG34d+MbZZDN
         BAb1xklAPLvcTuB5G225wUiQa6hTbdJ7RfbVLX8HDO9toDLdsiOd9GtF7xgDhPYS02Pi
         Ml6g==
X-Gm-Message-State: AFqh2kpFEOmUZNFICkJ29T6EP3Ni+ZSYWusaMFF7RoVk0AC19HYs2djs
        7NKGfEHvdNObt4PPa5HMcA==
X-Google-Smtp-Source: AMrXdXtGIZMyMSZw03e+bmOg9Y8Oj/r4cyRb0WnmOGtKu1/gqpAeEMcs5kC4BksNyAYUlDV9DBsVbQ==
X-Received: by 2002:a05:6871:460f:b0:14f:a68c:7c6a with SMTP id nf15-20020a056871460f00b0014fa68c7c6amr308944oab.20.1673392676411;
        Tue, 10 Jan 2023 15:17:56 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y9-20020a056871010900b00143065d3e99sm6496042oab.5.2023.01.10.15.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 15:17:56 -0800 (PST)
Received: (nullmailer pid 3145655 invoked by uid 1000);
        Tue, 10 Jan 2023 23:17:55 -0000
From:   Rob Herring <robh@kernel.org>
Subject: [PATCH 0/4] dt-bindings: usb: Convert some more simple OHCI/EHCI
 bindings
Date:   Tue, 10 Jan 2023 17:17:44 -0600
Message-Id: <20230110-dt-usb-v1-0-8e366e326513@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABjyvWMC/x2MywqEMAwAf0VyNtAHruKviIe2xjUgVRoVQfz3D
 XucYZgHhAqTQF89UOhi4S0r2LqCtIT8JeRJGZxx3lhrcDrwlIg2fXzbNi50PoLGMQhhLCGnRfN
 8rqvKvdDM9/8+jO/7AzcoPZdtAAAA
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
        Benjamin Fair <benjaminfair@google.com>
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
Rob Herring (4):
      dt-bindings: usb: Remove obsolete brcm,bcm3384-usb.txt
      dt-bindings: usb: Convert multiple "usb-ohci" bindings to DT schema
      dt-bindings: usb: Convert Marvell Orion EHCI to DT schema
      dt-bindings: usb: Convert Nuvoton EHCI to DT schema

 .../devicetree/bindings/powerpc/nintendo/wii.txt   | 10 -------
 .../devicetree/bindings/usb/brcm,bcm3384-usb.txt   | 11 -------
 .../devicetree/bindings/usb/ehci-orion.txt         | 22 --------------
 .../devicetree/bindings/usb/generic-ehci.yaml      |  4 +++
 .../devicetree/bindings/usb/generic-ohci.yaml      | 31 ++++++++++++++++---
 .../devicetree/bindings/usb/npcm7xx-usb.txt        | 20 -------------
 Documentation/devicetree/bindings/usb/ohci-nxp.txt | 24 ---------------
 .../devicetree/bindings/usb/ohci-omap3.txt         | 15 ----------
 Documentation/devicetree/bindings/usb/pxa-usb.txt  |  2 +-
 .../devicetree/bindings/usb/spear-usb.txt          | 35 ----------------------
 10 files changed, 32 insertions(+), 142 deletions(-)
---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20230110-dt-usb-1c637752a83b

Best regards,
-- 
Rob Herring <robh@kernel.org>

