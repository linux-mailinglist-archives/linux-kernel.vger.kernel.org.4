Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510E46AE114
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjCGNry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjCGNrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:47:23 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CD883887
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:46:40 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id e13so12145897wro.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678196798;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SEf10B8VEiphcTb2B4uTjdUHx2WfwTpFd5+nhXo7zM8=;
        b=4sOznHYviOoLd6Zd8EYiOJist7t8fD5mJ+NBE7qVWJmSnPsvlosTA2cevluMpj197D
         40uGAHQCT3WlWo7+hpEtsQyqFii+aVMxXSnaN4McuYKRFQIPFUzdCot9KMUlGUU/CYL7
         P2S82Eqp14aXOn2DfVRIZLesyAuzLnCcXUef3xy/LhoOE7LNiQ0uSWqy1bpZLcZxO21b
         uLlbsGY3OMMeWQIxRXNCujtOh3iItegi9gz70HoUKtGEemGoEadtpxqUjshuRz5x1BB5
         QTwefKOx83KFVEIH1x5xe8NcP0iTuyVZxeYoibjrFdat6I2TzJwA3OG2pCJULhrD2Z7Y
         nK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678196798;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEf10B8VEiphcTb2B4uTjdUHx2WfwTpFd5+nhXo7zM8=;
        b=OhRyE9bHoBIm4Ud76j2kdKcdXuH7cysr7Fucm+c1fVd4lm/sTWOe4rvRTqlrc4Xs71
         Nhvz9K4JJoI1xacImLTvf/juD/udVVcZqiYKGHj6JXPlMBiwPLPMW5/k9qQanxjlTHyC
         cX7pdvT2+2ld5RVSHBP6WG6E/OqB8Ds9jLcWFbNQkF64JDZ/Tu81lurGoULI34QRY7uO
         slsgilHgxB9XejI+k2CiCRzjw2cGDSc6sf+r6X+6Gj+rQJsh6GEHapUGl+3LJ4ll2Pdw
         +vFB6K9gT6PnI4130Aqb0O44fKPuP+LlSj6h5Lbm2UE91EmSEX8JcR9ftV4r3GQZXiCa
         ff2A==
X-Gm-Message-State: AO0yUKWiJ8UQNURtD9iS9JcYRWGd9ZBD7DhSO93YRnmrK24XHClWmFaQ
        uy3Bp2JftYekuFOLZMM5QYKM6NzHHG1cju8/DQ4=
X-Google-Smtp-Source: AK7set94hvOKIE8CibQ7R/8FK8dBtsN5U3aL2wjYc5zEKPs6aatdvCcFPZwezGFFtCpd4yZqHZdgrQ==
X-Received: by 2002:a05:6000:104b:b0:2c7:13e4:2094 with SMTP id c11-20020a056000104b00b002c713e42094mr8912781wrx.42.1678196798354;
        Tue, 07 Mar 2023 05:46:38 -0800 (PST)
Received: from [127.0.1.1] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o13-20020a5d670d000000b002c8476dde7asm12657607wru.114.2023.03.07.05.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 05:46:37 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Tue, 07 Mar 2023 14:46:27 +0100
Subject: [PATCH 2/6] dt-bindings: memory-controllers: mediatek,smi-larb: add
 mt8365
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230207-iommu-support-v1-2-4f0c81fd52c1@baylibre.com>
References: <20230207-iommu-support-v1-0-4f0c81fd52c1@baylibre.com>
In-Reply-To: <20230207-iommu-support-v1-0-4f0c81fd52c1@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=898; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=o5INfZQdHMAzRwteTSUE4GnwTkm9SQeKy4Fu0Y5Tde8=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkB0A7aarELR02nYYjRryO3XRDB2eH+dFM6D6Rljrp
 qSQee5OJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZAdAOwAKCRArRkmdfjHURVuiEA
 C5eGs1STXqlKB+t00zv5k0ryooUVKloiajkvpVhlXiUWCv+ZRR3p4+P3iw3XgbA2R295UCLSDNqqFg
 vrM+kCLl0Xr/hntRdHqI1kGcC1dPt81L2OtwBKTM4J0MnI6cEJ8pEmTzgR0aLzAzhog/2wwMJAWa3b
 r8q2bkaQd23d+Gi0rToQh3D11H+5hcufvkxl/nBzgHx+ju/JrgVR4XGW/hbb3ICocBl38XUL8A1iBD
 rGpJp0mo3EsZCEF9iUOYkmBr2OCkfHzSPQ4BNRY1ukkYZNEaLb6q6H91QdvWoxNPAq79d2c7Te938c
 L0ZjFXcwC7/vPf9DVQxl5EYO0GhAV+dL3wjdcKo46JDSNRdF7FY4iYbAFzyc8C8sMBVyR7EkMTbNQL
 EKajjbZQHNtQE31O3JEjY6aN8a39ImMIfi90OKD2n8xXBCa3svml0DVu887VxN7ujdWLHVKJaKRAlW
 rFFVwKWimqbz6P8z/Y04AqEkJ30TAx7moKOhNC7CTefFo9iPGzTkoO3NlQUVr0MCZjzGzFzCAmdNq8
 fxI/TQ16f9uR8qoLQA4mWIRh3JPAZs3dTAfM8UmUkdSs4I3j9tXQs8BdgSu/f932KhU52OW5YFeFuf
 CL6gMd8ZUiZXDkpB6qboc61/wyYsL7Z5e4694VRm4jOog1FSiMor5i6SU5xg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding description for mediatek,mt8365-smi-larb

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 .../devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml     | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
index 5f4ac3609887..aee7f6cf1300 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
@@ -34,6 +34,10 @@ properties:
           - const: mediatek,mt7623-smi-larb
           - const: mediatek,mt2701-smi-larb
 
+      - items:
+          - const: mediatek,mt8365-smi-larb
+          - const: mediatek,mt8186-smi-larb
+
   reg:
     maxItems: 1
 

-- 
b4 0.10.1
