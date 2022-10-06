Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3495F6D36
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 19:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbiJFRp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 13:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiJFRpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 13:45:50 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57666B5174;
        Thu,  6 Oct 2022 10:45:49 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id o21so6150962ejm.11;
        Thu, 06 Oct 2022 10:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbpfxoZfIZvEmo9HZUXMCjJj3tITfSfjkTJqndBvotc=;
        b=Iq98et7q0D2+r9dBIn2TdfilqQSuK9tTRjvK3Z0de37xwORXTMG0GNuYXVGinDXU+m
         hhGidSxH3lkOMVN6dpqJlKSYClb1fwEpUNJ9LL0sQrhkdjCG4Ui/8hVt0E0jvhRs52N7
         2i3b5Jch9YeqJKP7szHB69Yp/zJzpwZVhqXiv6bYPKbX5RHGPDsYcvypHmmo/Oobpu/5
         rAJaCL72WBYkB6GizmF0ElxJ3y95l9T/t+w8fvHwcP2r+iGTzYA0GrFmttp+Iuj+85W9
         Fg065kWEd7x1kUULG9s+Hm1acTAxOtFJ4ZrD84+93zVF2HQqEL36bp4l75QylaMH3lk0
         i4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbpfxoZfIZvEmo9HZUXMCjJj3tITfSfjkTJqndBvotc=;
        b=v5mCoxhO/lncuFiNN7vGwvnvpUErYyeR6TWsJth1wrRA2qvu4CLNhqdIlb7BXXPYTG
         AV5JRoFbb+0AvQGQvkbv6ZrrG/gKTYeHnTFRKRvZE5x1xJiKAPVHHJd9xGsePWaC1xVS
         D5lNr1jKmNdl/mah1gBM5VAD284OASwBvfx2+AG4SWbGAPPG16MmBpTZt0YJbNJEYEx+
         3s+TZKJ1gpeqaczd+BC/V/D2QAGeCudMlt+kwj8ECWf0trzxuNHKmC64gjsC4odR0GQq
         6pBKeYiey2zmGpubbIaufwEDhjPRvgEXxBn2cXscGiX6IpLmmDL+eNJT92K/p07wjhxk
         rYHA==
X-Gm-Message-State: ACrzQf2x21FvSTBOE4ZI4TDSOEpmKo2Y84vUY8Aj5mgN00w9Beevf12O
        YPEN65P2xUsMG+m1Tg+BonE=
X-Google-Smtp-Source: AMsMyM48jCLXj11rWnRSabFH/tGmaDhC9+BIaZ+MW7Hw7hp/XYpPGtUxDNOa0kvohqk4LUUzpwca3Q==
X-Received: by 2002:a17:907:1691:b0:78d:4051:9429 with SMTP id hc17-20020a170907169100b0078d40519429mr840144ejc.721.1665078346886;
        Thu, 06 Oct 2022 10:45:46 -0700 (PDT)
Received: from localhost.localdomain (83.24.77.202.ipv4.supernova.orange.pl. [83.24.77.202])
        by smtp.gmail.com with ESMTPSA id w23-20020aa7cb57000000b00452878cba5bsm6105035edt.97.2022.10.06.10.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 10:45:46 -0700 (PDT)
From:   Maya Matuszczyk <maccraft123mc@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     macroalpha@hotmail.com, Maya Matuszczyk <maccraft123mc@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: arm: rockchip: Add Odroid Go Advance Black Edition
Date:   Thu,  6 Oct 2022 19:45:18 +0200
Message-Id: <20221006174519.46161-2-maccraft123mc@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221006174519.46161-1-maccraft123mc@gmail.com>
References: <20221006174519.46161-1-maccraft123mc@gmail.com>
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

Add entry for an updated revision of the Odroid Go Advance.

Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 7811ba64149c..fdd85b0a3b1b 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -432,6 +432,11 @@ properties:
           - const: hardkernel,rk3326-odroid-go2
           - const: rockchip,rk3326
 
+      - description: Hardkernel Odroid Go Advance Black Edition
+        items:
+          - const: hardkernel,rk3326-odroid-go2-v11
+          - const: rockchip,rk3326
+
       - description: Hugsun X99 TV Box
         items:
           - const: hugsun,x99
-- 
2.38.0

