Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C22664FC7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 00:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbjAJXSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 18:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbjAJXR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 18:17:59 -0500
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8178209;
        Tue, 10 Jan 2023 15:17:58 -0800 (PST)
Received: by mail-oo1-f41.google.com with SMTP id q20-20020a4a3314000000b004f2177e6b38so678621ooq.3;
        Tue, 10 Jan 2023 15:17:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2FJcOTfsjwpdIljEO429tvKoOeEBhTBITWRzGMiqJAg=;
        b=3bfU07fDLNFelmQSSGAY0msu/9J0Cj5OrxwKjI+/8AVR8LEb1qPKVdGJ7Yf1TREcQx
         a26f3AJUxP3FuR3hE5Ky1WvQ/bkT/U/pJcSevQOaL2WQUlFg6oZVlvJzDvEJk48Qkegw
         3EOZPCwHyYfBD9GHEJrMcxHPnKYXqE6gmeT5o41o60TvWZjrJPQtFQ9g4WQkIedrn8iT
         a5v606IckLCxkjop2uIND7LT4TMAj0IdqwxscnzGMs3DCl1d85ORgEgH+ms+7Yy6bz5T
         IqCu9+KMk1w8VzJctDYwdGCw6/R5rPl4aLw4rHfa7/5BRw8YlxZvCdsxpLLkELO/MAlc
         66qw==
X-Gm-Message-State: AFqh2krCKGHrQWEMQSjqAxLhgqub/NmJC1iKqJ139imTVQObOKlEf7jp
        07BR8j9T+uTvtjVozrgYCOfYKkYymg==
X-Google-Smtp-Source: AMrXdXugqEltNT0Rw61nCtbCf4o/oBzHuLjFst8x3k86C7Sd4CJKl6VsO9SIi06WLEmAFjEFGqHjDw==
X-Received: by 2002:a4a:ac88:0:b0:4a2:76a0:7677 with SMTP id b8-20020a4aac88000000b004a276a07677mr32202358oon.0.1673392677968;
        Tue, 10 Jan 2023 15:17:57 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n3-20020a4ad623000000b004908a9542f8sm6364787oon.31.2023.01.10.15.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 15:17:57 -0800 (PST)
Received: (nullmailer pid 3145658 invoked by uid 1000);
        Tue, 10 Jan 2023 23:17:55 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 10 Jan 2023 17:17:44 -0600
Subject: [PATCH 1/4] dt-bindings: usb: Remove obsolete brcm,bcm3384-usb.txt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230110-dt-usb-v1-1-8e366e326513@kernel.org>
References: <20230110-dt-usb-v1-0-8e366e326513@kernel.org>
In-Reply-To: <20230110-dt-usb-v1-0-8e366e326513@kernel.org>
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

