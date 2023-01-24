Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB58678EC4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 04:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjAXDFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 22:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbjAXDFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 22:05:25 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5861301A3;
        Mon, 23 Jan 2023 19:05:24 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id a1-20020a056830008100b006864df3b1f8so8497213oto.3;
        Mon, 23 Jan 2023 19:05:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2FJcOTfsjwpdIljEO429tvKoOeEBhTBITWRzGMiqJAg=;
        b=rXB/XXBpIWgp7OEKdmcgz8Q4A4ZN+mlLHmHJiCSVqnjmgyvHsnXmY15DkkFQuyTg3o
         JV70mbmqhIKFAxH6r58h1WweQbRKghx+m3Q8gOJiO7uIEafpXGgXgYpUQdhYEuulGxRm
         I7hZOed9o2BuxUXWC1/EbIKTwa4ur2rFNQ0uM0HwgdvPjraaU0RJs+B5YXtvLl3M3kKM
         xhSEkb0eY5eNE6MjMea3dtgk5CbhRGhF6aKp6Tmi0bXEP7P9HKKAwVZYoppItbj5AqTj
         K9bO/KwTamFeSUKE2Ubd7SFS4YuYbzS6Ux4D9kayosm5AAA3HHbl0/y2FNydsyeuP74q
         SkXQ==
X-Gm-Message-State: AFqh2kr5HRW3I+3BZVnlhfFSrfHHkBSKnWp3q6ZkFZINFoE1+ZSs8tKN
        c7nbWkLt+bnP7XlSgGoNhuaPDxbzDA==
X-Google-Smtp-Source: AMrXdXtk4ESBvi3kPtNVN3s661xo1Y5KZZtfQ+KM3W+ytAIpqKVTTtgkQJaI3xv9A63V8+UpEsWh0A==
X-Received: by 2002:a9d:624a:0:b0:66d:a5f7:9adc with SMTP id i10-20020a9d624a000000b0066da5f79adcmr16670014otk.2.1674529524022;
        Mon, 23 Jan 2023 19:05:24 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s13-20020a05683004cd00b00686543d0f04sm449342otd.21.2023.01.23.19.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 19:05:23 -0800 (PST)
Received: (nullmailer pid 3266340 invoked by uid 1000);
        Tue, 24 Jan 2023 03:05:20 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 23 Jan 2023 21:05:15 -0600
Subject: [PATCH v3 1/5] dt-bindings: usb: Remove obsolete
 brcm,bcm3384-usb.txt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230110-dt-usb-v3-1-5af0541fcf8c@kernel.org>
References: <20230110-dt-usb-v3-0-5af0541fcf8c@kernel.org>
In-Reply-To: <20230110-dt-usb-v3-0-5af0541fcf8c@kernel.org>
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
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "brcm,bcm3384-ohci" and "brcm,bcm3384-ehci" compatibles are already
documented in generic-ohci.yaml and generic-ehci.yaml, respectively, so
remove the old txt binding.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/usb/brcm,bcm3384-usb.txt | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/brcm,bcm3384-usb.txt b/Documentation/devicetree/bindings/usb/brcm,bcm3384-usb.txt
deleted file mode 100644
index 452c45c7bf29..000000000000
--- a/Documentation/devicetree/bindings/usb/brcm,bcm3384-usb.txt
+++ /dev/null
@@ -1,11 +0,0 @@
-* Broadcom USB controllers
-
-Required properties:
-- compatible: "brcm,bcm3384-ohci", "brcm,bcm3384-ehci"
-
-  These currently use the generic-ohci and generic-ehci drivers.  On some
-  systems, special handling may be needed in the following cases:
-
-  - Restoring state after systemwide power save modes
-  - Sharing PHYs with the USBD (UDC) hardware
-  - Figuring out which controllers are disabled on ASIC bondout variants

-- 
2.39.0

