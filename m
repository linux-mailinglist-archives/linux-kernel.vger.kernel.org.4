Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F9765665C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 02:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiL0BHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 20:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbiL0BHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 20:07:39 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E69E2AD1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 17:07:36 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id u12so8748399ljj.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 17:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1OenRKXJiQtXrox+MzteMY+XX3Gll+tUxmfThNma78=;
        b=rQDVP4IWzSZlOthJ+F+2I6KhB/dYVgjxHpvpENBdP4cfx5nMpoeykUyaVgh2bOSrSF
         LnqdMDZ6cQCbhy/clpLZAN/zOqSimu/6tO18F7A5CaqEncbLYWZPI0EETVb+bHc/3dI5
         j+0yqdituRl+BHnz6AYfYkNOsBicd/DBPUd8SzupZrlRUKCiyLGrq4jgZ94eU6/aHDw0
         NOfCFZPwbddBe2XQVXamiv7Bw8x71f7g8ezxo0LDGVnqchmM5nIEc56r1hbSjwpovO6F
         ftImMy04pGSwwXXgIHe/j35LzQUo/WlAhiphWcD1waUQQQH66ofSNH7epzH6SKvdhnoi
         40Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1OenRKXJiQtXrox+MzteMY+XX3Gll+tUxmfThNma78=;
        b=Sx5DIN+XG9IPZqmXV1a72UXFD2+A5Yu/bwtD+zTqllO1icnSaZqUcZRnLdh6VzY8Kj
         PMYELHHN+SxdmHgT60o0I9L0DaY1uDAMNUT1czXnu7uS0IE/YBxoD34GbcfKLFmWgywF
         ZDXoN01kDbb6aG1VtBFkkQuhAa4MTDuhiWadNLjiXqiIb0yKqgVdO4GEhxZ8jC8fUNC4
         y/w+O4s8XMBpGwPsDK84j7jFCXtk+V1Op0DcLcDhPPQKCLehaWdRa96cyPNqPe2DhRvb
         WCJKZPdoiT80zndf8J3M6JP9HDZGzjJgpHaKpvZekN/qsSjEIVCu3tCr4TnXck4PBsZ5
         IFgw==
X-Gm-Message-State: AFqh2kpulVlrNBG6OfQBFXz4DiKZNE/BLSbsEFcZ3H8mah1IEWwT3W49
        3N3NrqRECTTZrTbqHBUSCvnyNg==
X-Google-Smtp-Source: AMrXdXvpqiuwkA4bRxf4TdIWR/3PvqVBrynvBWl3NwVFUI3o/xVd4qOWHUlFaMjQO7MtixQyGwllwg==
X-Received: by 2002:a05:651c:1a0e:b0:278:fe64:12d8 with SMTP id by14-20020a05651c1a0e00b00278fe6412d8mr6407989ljb.40.1672103254792;
        Mon, 26 Dec 2022 17:07:34 -0800 (PST)
Received: from michal-H370M-DS3H.office.semihalf.net ([83.142.187.84])
        by smtp.googlemail.com with ESMTPSA id l14-20020a2e99ce000000b00277159d7f2esm1392098ljj.104.2022.12.26.17.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 17:07:34 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20Grzelak?= <mig@semihalf.com>
To:     devicetree@vger.kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andrew@lunn.ch,
        chris.packham@alliedtelesis.co.nz, netdev@vger.kernel.org,
        upstream@semihalf.com, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Micha=C5=82=20Grzelak?= <mig@semihalf.com>
Subject: [net PATCH 1/2] dt-bindings: net: marvell,orion-mdio: Fix error
Date:   Tue, 27 Dec 2022 02:05:22 +0100
Message-Id: <20221227010523.59328-2-mig@semihalf.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221227010523.59328-1-mig@semihalf.com>
References: <20221227010523.59328-1-mig@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix 'unevaluated properties error' during 'make dtbs_check' appearing on
arm device trees by defining generic 'ethernet-phy' subnode in
marvell,orion-mdio.yaml.

Fixes: 0781434af811f ("dt-bindings: net: orion-mdio: Convert to JSON
schema")
Signed-off-by: Michał Grzelak <mig@semihalf.com>
---
 Documentation/devicetree/bindings/net/marvell,orion-mdio.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/marvell,orion-mdio.yaml b/Documentation/devicetree/bindings/net/marvell,orion-mdio.yaml
index d2906b4a0f59..2b2b3f8709fc 100644
--- a/Documentation/devicetree/bindings/net/marvell,orion-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/marvell,orion-mdio.yaml
@@ -35,6 +35,10 @@ properties:
     minItems: 1
     maxItems: 4
 
+patternProperties:
+  '^ethernet-phy':
+    type: object
+
 required:
   - compatible
   - reg
-- 
2.34.1

