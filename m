Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2B55BF354
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 04:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiIUCNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 22:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiIUCNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 22:13:06 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6F85E304;
        Tue, 20 Sep 2022 19:13:04 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id z191so3916659iof.10;
        Tue, 20 Sep 2022 19:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=3SHNagHJHSTdbA63dtSW/yOSqmd6hb+O+bm6iebyLxs=;
        b=AcewuZHFiHmecKbXctkUKLuE9iqhQIgqu77kqqC426CEdV7XK17pnBm43DCD1e3rR1
         M958o3rA0rGC9owGYfOpaBKMnuSuMzYjJN+/gD160L6v6CvkfRvd6E1JZIliQnmBSzh0
         KliePdLcTnsdIC5jSISYCEkIyoPW5ufc3bpzbaowWMNTa7Jeo6H/2P6+FkFBsZ17DRwp
         0K1JAgU6/A3hLLb37KFt3xwZZ+r5GKwM3yBrWyfGbzOAQlXmMz80L83cqkL/eV4KKqWd
         UcHoQyqxz4J3wzyTwaLV9vQ9p8rG8fdoClauA+JpWiym0MTcCughT0wqq9+OdrD3fCXJ
         d8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=3SHNagHJHSTdbA63dtSW/yOSqmd6hb+O+bm6iebyLxs=;
        b=NUrZ64jSGbmy+bTM08qhpktapXNqEVE/v+vrvrpVdmcuMnV6sN+rFb11gw14t4chmb
         TEWLGhvhE4N4TRwfRvyHQuPXKs35NdegVnHc+qUkBq4ZhbOXuoAtic9eZMBn68S0/yWG
         GXKrovEpffJ8r1nDgFnqf8AS5GmTT7K5Bk+LwCrcstV5ZECokfCr4W8ErCOc41rbCBxF
         gZAkABcdmTHTqgoMH6qz3HD5/psFG+sTDwLJbRLbsZYEU2v9YRtOU6Y/H1ZIjpYQLDcl
         54Zj+YyJfj3a3GdSXs1MLp9ywuzR8LZhOR4L7sG9bJq8PAWIV1+ABQ+5SypfI+R+9Pqc
         9axg==
X-Gm-Message-State: ACgBeo1YgLUkiy6i1o8w9FD5Ouf57NPG4jEMSe6EIUPLx8icQTWNygku
        FJR8b1phF7M+PImJ/23MXxY=
X-Google-Smtp-Source: AMsMyM5QpQBkDx09I8R7l4ImhrquJJ4WxtG7jfdctvc4gbTtUJCOVsnBMuCzvZN3X6uOjWbu0mMGkA==
X-Received: by 2002:a05:6638:2502:b0:35a:271b:abef with SMTP id v2-20020a056638250200b0035a271babefmr12042766jat.54.1663726383819;
        Tue, 20 Sep 2022 19:13:03 -0700 (PDT)
Received: from hestia.gfnd.rcn-ee.org (208-107-176-7-dynamic.midco.net. [208.107.176.7])
        by smtp.gmail.com with ESMTPSA id z3-20020a05660229c300b0069e265cabb1sm648471ioq.0.2022.09.20.19.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 19:13:03 -0700 (PDT)
From:   Robert Nelson <robertcnelson@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Nelson <robertcnelson@gmail.com>,
        Rob Herring <robh@kernel.org>, Nishanth Menon <nm@ti.com>,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <drew@beagleboard.org>
Subject: [PATCH v3 1/2] dt-bindings: arm: ti: Add bindings for BeagleBone AI-64
Date:   Tue, 20 Sep 2022 21:12:59 -0500
Message-Id: <20220921021300.4111283-1-robertcnelson@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This board is based on the ti,j721e

https://beagleboard.org/ai-64
https://git.beagleboard.org/beagleboard/beaglebone-ai-64

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
CC: Rob Herring <robh@kernel.org>
CC: Nishanth Menon <nm@ti.com>
CC: Jason Kridner <jkridner@beagleboard.org>
CC: Drew Fustini <drew@beagleboard.org>
---
Changes since v2:
 - rebased on next after k3.yaml alphabetical sort
Changes since v1:
 - added documenation links
 - add board in alphabetical order
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 28b8232e1c5b..09e6845ff243 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -61,6 +61,7 @@ properties:
           - const: ti,j721e
           - items:
               - enum:
+                  - beagle,j721e-beagleboneai64
                   - ti,j721e-evm
                   - ti,j721e-sk
               - const: ti,j721e
-- 
2.30.2

