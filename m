Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07D26B5D5A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 16:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjCKP12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 10:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjCKP10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 10:27:26 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2977810EAAD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 07:27:25 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id j11so10391578lfg.13
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 07:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678548443;
        h=cc:to:subject:date:from:in-reply-to:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8s9gnIYUH4a7DISj2GFil2OdRXxeDO2P0HDbRjCc19c=;
        b=PXcbWJQtlcm5Vz6ToS322SJ+YCuBK2OCQuUf4KN+bVgtMAofOJt5wk1RNk7LBq2KHT
         toA2JaG67l1njOGKTdpZ55jG5yEnfRkJP6DfUwhUpqWMe51QmyErBBo/g83D5WRO3tqu
         Mb3Vcd6awES+xdQqkWvioKeuCJWNrG61O4/bsjLHDjGqxIUxgIRcybwQAegJVSCYqjZz
         JqXktXIxuOQQ/09DqTO0a16ucQL2Ik78QH7yV5rM5EVfncM9rpgRq4avkG+D1vEQ7+/Z
         nJXtmJdtGLYSKrhAymvPvIoCmQ2OdjISS1kF345czbh8/gSz+tZHPcfE8jlDSQJZbriG
         MB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678548443;
        h=cc:to:subject:date:from:in-reply-to:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8s9gnIYUH4a7DISj2GFil2OdRXxeDO2P0HDbRjCc19c=;
        b=TUcNLNVe4l7GHy5L2R9o04EO1odGk/r8WczNd/ISxeE7ltrt3o9vLcaE7LpWUc7Zax
         ZyjZYIeEDdNbYPUrRnFi7WNCej2VYLPtdSs83nsgCJzmYLquFcrtxTnKhv5PgTdV6a51
         IYLdxA4MngDWyBfVFtLOKE+H7S10i+kYI4Z56BNUirz8ilBQZfRKpkJfa5dwavMkMslk
         J+kfDi2qMG/OLteI+XT9wNZjm72qzRY1BMzZiJXWuvRJnypkb1Y0FBkpo3ZT66lSDtvL
         zyXUl+51Gn5TJHPrI1vCEwh1CQv0v77Ldz/CsCQIQK2+Xs0L9g5u3xyqhu15wWFTFl0A
         xhRg==
X-Gm-Message-State: AO0yUKVWCdchBrClRxG9JCnKgECNjvbv746544rTVFyQEyHvpfNyqKBN
        oA34B0uYtJg4XWtPfvsG0y4fgcaCN+aVk1dIPE0=
X-Google-Smtp-Source: AK7set9pg2wcl81Ze91WKCr75db/f1RIBL8nLZPSnGDu/scPkZEIKnm8rn0EcVJwpSiS9/WAwgTBRw==
X-Received: by 2002:a05:6512:390e:b0:4db:26b1:ec52 with SMTP id a14-20020a056512390e00b004db26b1ec52mr9339298lfu.59.1678548443309;
        Sat, 11 Mar 2023 07:27:23 -0800 (PST)
Received: from 0001-devicetree-synopsys-dw-mshc-common-add-fifo-access-3.patch (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id d28-20020ac244dc000000b004e7fa99f2b5sm345737lfm.186.2023.03.11.07.27.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 07:27:23 -0800 (PST)
Message-Id: <1678548256.0817535-1-sleirsgoevy@gmail.com>
In-Reply-To: <1678548256.0817535-0-sleirsgoevy@gmail.com>
From:   Sergey Lisov <sleirsgoevy@gmail.com>
Date:   Sat, 11 Mar 2023 18:22:41 +0300
Subject: [PATCH 1/2] devicetree: synopsys-dw-mshc-common: add
 "fifo-access-32bit" property
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 .../devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml    | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
index 8dfad89c7..2bc5ac528 100644
--- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
@@ -57,6 +57,12 @@ properties:
       force fifo watermark setting accordingly.
     $ref: /schemas/types.yaml#/definitions/flag
 
+  fifo-access-32bit:
+    description:
+      Specifies that this device requires accesses to its 64-bit registers
+      to be done as pairs of 32-bit accesses, even on architectures where
+      readq is available.
+
   dmas:
     maxItems: 1
 
-- 
2.38.3


