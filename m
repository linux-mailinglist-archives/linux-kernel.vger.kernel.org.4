Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2706A628BAE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237525AbiKNV63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237136AbiKNV60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:58:26 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D868610FDF;
        Mon, 14 Nov 2022 13:58:22 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id e189so9314676iof.1;
        Mon, 14 Nov 2022 13:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eLuktCTSBHrWVfseua1QujoHXFQTgdM1z2Sw54d8NOs=;
        b=OMI2kEoWCUTZZFdhlIPLZDnV9B7ClBzJJQJOiZmyTrlH9qIsvRf0/aRqo5MaBIJ4MP
         R+S7f7CY0vaVxYELkQFRJUol5k57chitWsQ+wHi2hO6+OtC/7WfuS9/o2jVNlLVbwsBm
         11ln8tqWT1tu//UbN6kirb5K+SJFdDuiCVX2PtxXAhJ4TnVhiiUxZ9RF5p2gChcO1X1J
         IZQJm7O/rfNJZXzMq+aOYIV/dTzT9P6maCicXVrLQuMJcfazGeqY6vwDZcuvEkTpJ0PW
         SsKWOrJfShFefrZpC3+Nd/+ejdYOKtsE2Ehat54w451ANwSlQLEPBdDe9I5iqHnVqm2u
         noVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eLuktCTSBHrWVfseua1QujoHXFQTgdM1z2Sw54d8NOs=;
        b=d+FHI1eCQqBUHEhGtqaJWhfuj+/38w6TCoXINLKkM/Q8Tuf6VzI3/yA4LsbEITyX+N
         ZlbdkGMtO5wJ++4lrZPB+U2qdtxuPWotGfHJtEbm6sqo+E3dmZc4aOITOe1m7MKt7W4h
         LfXz2ix+fufy1b7q3vyq4RYmPFkNCE5t7ZITNtksUamH0CWHrqiVdypq7ofFUCu1gKR9
         8p4/0HXMplB4i2kvLK0DIMEGNR85abRtmYoEaKIq+UwIgB0tta6BpRfNhlxK0HeXfE5D
         BTLH0K6op4ubk8WR0GlpxoZ2eCypbt1ROCoFYSlQJeJHBm/LxrFsdp0UzmbCp27nc5/p
         XS3Q==
X-Gm-Message-State: ANoB5pnF0T5NMDEypy8VRJ3+LqMFQzX1hiIsnjO8evXH1LTiKrffvdav
        gA7x82aPVPG/qS+9+SDt4lilMTzzfzs=
X-Google-Smtp-Source: AA0mqf7YUNTRaRZCCVYW8IxNOOVRQ1KiPQ9Q1hZIPE/jVOoKIHnzA865rBXMGGox3BYoSXwf4M66Qg==
X-Received: by 2002:a02:2207:0:b0:375:f7b:7219 with SMTP id o7-20020a022207000000b003750f7b7219mr6125991jao.295.1668463102171;
        Mon, 14 Nov 2022 13:58:22 -0800 (PST)
Received: from hestia.gfnd.rcn-ee.org (208-107-176-7-dynamic.midco.net. [208.107.176.7])
        by smtp.gmail.com with ESMTPSA id a1-20020a027341000000b003738c0a80b4sm3960357jae.144.2022.11.14.13.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 13:58:21 -0800 (PST)
From:   Robert Nelson <robertcnelson@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Nelson <robertcnelson@gmail.com>,
        Rob Herring <robh@kernel.org>, Nishanth Menon <nm@ti.com>,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <drew@beagleboard.org>
Subject: [PATCH v5 1/2] dt-bindings: arm: ti: Add bindings for BeagleBone AI-64
Date:   Mon, 14 Nov 2022 15:58:16 -0600
Message-Id: <20221114215817.1953186-1-robertcnelson@gmail.com>
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
Acked-by: Rob Herring <robh@kernel.org>
CC: Nishanth Menon <nm@ti.com>
CC: Jason Kridner <jkridner@beagleboard.org>
CC: Drew Fustini <drew@beagleboard.org>
---
Changes since v4:
 - no changes
Changes since v3:
 - added Acked-by from Rob Herring
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

