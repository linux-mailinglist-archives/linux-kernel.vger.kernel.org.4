Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A623C62BCE4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbiKPMCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbiKPMBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:01:53 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5056C53ECE;
        Wed, 16 Nov 2022 03:54:21 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id y16so29502949wrt.12;
        Wed, 16 Nov 2022 03:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/dBHYiGQPfAOm44gb83u9eMqNEioC2JWlqqtjsfn40=;
        b=a3aw3UPpNjZYuOPdLBZxItd3w790hbGJN/DvfhkqGk9KhEVo12unbG2lFJUff7dRHZ
         TwC217MOVOAI0HelX2P03q0WtrV3R3hpZGVoJRX2otppAmqS9KjH8O+xB+2OJPtpiWcw
         uujhiIC/eYWpVZZz3BD9ZjyUylJlneJv6T/adPrH0PkCSWsARQSrUnrWKFLddr0R8J//
         NITRfzqSD85sIAuX5yI/JWYV3QISWVpZ+tGI9tsEUk4Mim+zZqlPP4KwIKKkwxHToAqz
         +F8j1krcoZhAxwsKZIYCSSgoNIa6eYgPMyeXGXXMoID+v0wletc5fKd1CG5EbCp92ixG
         HUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v/dBHYiGQPfAOm44gb83u9eMqNEioC2JWlqqtjsfn40=;
        b=MV7QT3ZMGcPacs9yoA3yXruMUxeVN0OgD1OVuM3gt3RRm/Egherex0ldJ/6zlNo6No
         53oDwkQEhcmSUjp41TUPZVKPNgHK6OhwxNU5QrlgI/mgI2ZimJcgkItZN4c9YvFwXtdq
         IGm25TO+eQtlLnpbuh7juxjDyf8LYHFwbm75hdvwfIVhPxF9PglPGWI+xJiftmQ53GAb
         YJaXRXqUHzcIUrgyS67EANUTYYbT83Xoyb90muUyszDDCSUvaHb9/d9+ELYZQ1yPWqsh
         +QZak2R6R7AynnE+RAEvmC8mtKSPv0oMZVvI012HuJynJ9LM0aOXkmNM8h/lGUTPpWCu
         2k/g==
X-Gm-Message-State: ANoB5pkg7BelLiHb3Mc9tvS/WxjYzPgv4O4kP4GaUNq1t4QBBEzjh72W
        qKY+bSP6f3JV7I/UlpCntE4=
X-Google-Smtp-Source: AA0mqf4HNoBld+9R6flEzkP53/yY0U9fFtHEiwUYhci3bW7R+qr/rXHLZecXAVM3iUDwlL25mhgWiQ==
X-Received: by 2002:a05:6000:12cd:b0:241:9b26:d18e with SMTP id l13-20020a05600012cd00b002419b26d18emr4706556wrx.548.1668599659900;
        Wed, 16 Nov 2022 03:54:19 -0800 (PST)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id bt14-20020a056000080e00b002417e7f0685sm14576047wrb.9.2022.11.16.03.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 03:54:19 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] dt-bindings: arm: rockchip: Add SOQuartz Model A
Date:   Wed, 16 Nov 2022 12:53:36 +0100
Message-Id: <20221116115337.541601-4-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116115337.541601-1-frattaroli.nicolas@gmail.com>
References: <20221116115337.541601-1-frattaroli.nicolas@gmail.com>
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

The SOQuartz Model A base board is a carrier board for the CM4
form factor, designed around the PINE64 SOQuartz CM4 SoM.

The board sports "Model A" dimensions like the Quartz64 Model A,
but is not to be confused with that.

As for I/O, it features USB 2 ports, Gigabit Ethernet, a PCIe 2
x1 slot, HDMI, a 40-pin GPIO header, CSI/DSI connectors, an eDP
flat-flex cable connector, a 12V DC barrel jack for power input
and power/reset buttons as well as a microSD card slot.

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 19797aca1fa0..1eff0afc19a1 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -580,6 +580,7 @@ properties:
           - enum:
               - pine64,soquartz-blade
               - pine64,soquartz-cm4io
+              - pine64,soquartz-model-a
           - const: pine64,soquartz
           - const: rockchip,rk3566
 
-- 
2.38.1

