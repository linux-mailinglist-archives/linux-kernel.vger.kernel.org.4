Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9E26727A6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 20:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjARTAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 14:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjARS7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:59:38 -0500
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E695957F;
        Wed, 18 Jan 2023 10:59:35 -0800 (PST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1433ef3b61fso36502820fac.10;
        Wed, 18 Jan 2023 10:59:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2FJcOTfsjwpdIljEO429tvKoOeEBhTBITWRzGMiqJAg=;
        b=wKaEcRs98rs+WQXuCK99GUfiMsLuVyKh0EEDMxIujNqyL4iI+i4GukXjtuT2oIt9w2
         o67P1uPjuetKONTvGvGclgiBxi0G6bRryA83n05sUnWHHbWdLc6TC6Ab4H7Tu0STT4/3
         rUY49cDvNoiENlfUUFuwBsyEzcRBY8wmy4XG/HF6MTnhUex5ZY+P1mtOyPTStkK12BuD
         SDokdJ2mDi3Fn8kP3DOK3b4lc9q+utUJEkcep1Hyhoh/fKyuTWr7U6S1o7R7Mc3s4Eys
         nSutX7T3g41mDWP5E09n9LQluEugq9jnLEE/UhHIN6cJUIjIG32lA2mUM6KmW6grYdv3
         wB+Q==
X-Gm-Message-State: AFqh2ko02dH7qatKdaLk7yE9aJ0en1qVBosR5jy8msBUTMcNOsK5Th9D
        GN+hqs4SX8ULtF2oNY3XRA==
X-Google-Smtp-Source: AMrXdXscaED9/2tSNc/EWmCUoL6KUA5ro4vcmZupKkFZp8aHQrNSo7DtQPDnUsLGeCcrB99X4bhVlw==
X-Received: by 2002:a05:6870:b6a5:b0:14c:68df:833e with SMTP id cy37-20020a056870b6a500b0014c68df833emr5764905oab.15.1674068374366;
        Wed, 18 Jan 2023 10:59:34 -0800 (PST)
Received: from robh_at_kernel.org ([4.31.143.193])
        by smtp.gmail.com with ESMTPSA id y34-20020a05687045a200b00143ae7d4ccesm5057713oao.45.2023.01.18.10.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 10:59:33 -0800 (PST)
Received: (nullmailer pid 629746 invoked by uid 1000);
        Wed, 18 Jan 2023 18:59:29 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 18 Jan 2023 12:59:23 -0600
Subject: [PATCH v2 1/5] dt-bindings: usb: Remove obsolete
 brcm,bcm3384-usb.txt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230110-dt-usb-v2-1-926bc1260e51@kernel.org>
References: <20230110-dt-usb-v2-0-926bc1260e51@kernel.org>
In-Reply-To: <20230110-dt-usb-v2-0-926bc1260e51@kernel.org>
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

