Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2028B652C8A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 06:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiLUFwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 00:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234376AbiLUFw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 00:52:28 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B608F209B1;
        Tue, 20 Dec 2022 21:52:24 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id c13so9975407pfp.5;
        Tue, 20 Dec 2022 21:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9y7vTaoTo9o+JdWAFPFAlEafYcyYlhQjz5DqmnkuKJk=;
        b=j8d1gvhF8hecKiDysPSjqZZ4ugb+m9nFh6rGhwrS7ZuiNG3EeZnNw0IphSdLA1WgwS
         lBsoYpe7yplmmXheLFBeeqHRD0LGfZKiTiU0QXu9RS059Fgt48EymgC7rG4+/owrm29E
         eSLzUnXfsqCGN36JGZ5BXpsgR5V33sljdczdn982mQAChVb/asQqb6pBw+rK3ikSwePo
         6sPJMLij7oHgVjPcwpk+eQMQrPvaDdqMF3ISGi8nx8gSXShWv9p9fmk3toA0HhB/uUSe
         8hM58iTSrVCKjs4tuGJqA8BNJ/HuPMleJ2bHQ7VjQC/fTbXK2KblU0LAJRbELRbkEH9K
         Q9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9y7vTaoTo9o+JdWAFPFAlEafYcyYlhQjz5DqmnkuKJk=;
        b=Z2g31b6gpNoKnCn5QgIw5LZrmL7WW00J2Hkctyxb6YL1S27nzVvBIIdyi88d7N5gtP
         yp1ndpT0Gos5qRXSm76Qmjai7k1AJw/WL1vqR+DUXXuiiWL9yvNUPUuoJGqKzmYle892
         R+9IPAMn6ujKBe8fSPI5L19PvIsMo5/l8PvbD4aSuOHy2MsEdL52RXT/AW7R1yEMS/Iv
         70hjgU67TyvgAm7dN47cbLcZaQQyrhS63bi12a6+/JSZSCpLJRUJTVPW02GrWSCBvZnM
         jQD96iM/uFuD3quGmATpHAn6KQzWqSiPP5FqngJhjrxRsuQZh7ojL14FWQYqAhUbRNSf
         JAgA==
X-Gm-Message-State: AFqh2kqR9K+Y1MRKj6L3z8C3vVV/PxTc0PkHGIHpyszDUnJ8DpEftuBe
        kSxbQKLM6Io6i+d0HoSPTCw=
X-Google-Smtp-Source: AMrXdXvhf5ms2kPruq/C1NKfP3TPEEKfe1SiGyJdRIXkZ+UfYpl8EgIGVcikXTdg7BR/iR3L0FsZ1Q==
X-Received: by 2002:a62:506:0:b0:56c:7216:fbc6 with SMTP id 6-20020a620506000000b0056c7216fbc6mr1004541pff.30.1671601944234;
        Tue, 20 Dec 2022 21:52:24 -0800 (PST)
Received: from VM-66-53-centos ([43.132.141.4])
        by smtp.gmail.com with ESMTPSA id x128-20020a626386000000b005767cb32fdasm9633824pfb.188.2022.12.20.21.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 21:52:23 -0800 (PST)
Date:   Wed, 21 Dec 2022 13:52:20 +0800
From:   Yuteng Zhong <zonyitoo@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Peter Geis <pgwipeout@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Yuteng Zhong <zonyitoo@gmail.com>,
        DHDAXCW <lasstp5011@gmail.com>
Subject: [PATCH v4 2/2] dt-bindings: arm: rockchip: Add EmbedFire LubanCat 1
Message-ID: <Y6KfFEChA67E7oX/@VM-66-53-centos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6KdvAlWLMG4whJh@VM-66-53-centos>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

from: DHDAXCW <lasstp5011@gmail.com>

LubanCat 1 is a Rockchip RK3566 SBC based
is developed by EmbedFire Electronics Co., Ltd.
Mini Linux Card Type Cheap Computer Development Board

Signed-off-by: Yuteng Zhong <zonyitoo@gmail.com>
Signed-off-by: DHDAXCW <lasstp5011@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 88ff4422a8c1..84d39a3a8843 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -781,6 +781,11 @@ properties:
           - const: rockchip,rk3568-bpi-r2pro
           - const: rockchip,rk3568
 
+      - description: EmbedFire LubanCat 1
+        items:
+          - const: embedfire,lubancat-1
+          - const: rockchip,rk3566
+
 additionalProperties: true
 
 ...
-- 
2.27.0

