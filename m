Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA17771F031
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjFAREH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbjFARDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:03:53 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56A418D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 10:03:51 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-96fe2a1db26so148457266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 10:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1685639031; x=1688231031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTcjRJtvmJkq+LZbJsn7Ql99XlhQeL7VF1cYGLTbIN0=;
        b=n7Sl+iCP+FVrRNRM+g0Sz9GCNp5AtH9LEbszoEgXP3nux2UZChxRBclTN0TV5Q+8Nj
         HcANmkqpCwpAKoTljNxUqZ/L0V2hRruf8GVkXgRhID9oQx82u1i3j1xk5wUs/Xz6jwhd
         fh4Yw9IOyWDEp8gpS/QhwOnfSJMFnUNspWCDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685639031; x=1688231031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TTcjRJtvmJkq+LZbJsn7Ql99XlhQeL7VF1cYGLTbIN0=;
        b=IXhhamlx3guoZAKWOpN5PyuE/tcUT0mPC3P6NIz8cJFt8O4Zs5yGCG2IEujSn1w4HH
         +S3FfzmQ8gdMfbS7V57Rn4cSAGPhiguCEykVzxhMUlc6K+ksuzj8pUWiFFydLJZNOFTi
         79TU4uA6UukgUJ76LVTl8NKKpt02s+N/xf6wT4WH2ygkmqVq2FTBg93qeuQ5/YpF2eTn
         rneaRwlwPG7ahMXiOVPlzMmgxBBcxlntiuemsLteuPV65u8qQj5MHGbmOK5jgKeFCVAp
         ocKYLEwRzHyoxpsiU8RkOPyg6NcayODRJRbopBVYO0Ans4LItx6oFpxzjsrVcLYk8qUc
         b7Gw==
X-Gm-Message-State: AC+VfDwdqBrT/Zd/Odq1QnaGlOfIZLPL/SwKaPV/gGAhCwTnRP56nlbu
        7i4eT8abuToPeTZNvoRuIh3anvYB6qbnhQcQtWfSvg==
X-Google-Smtp-Source: ACHHUZ4FzuZULxk+9erHkcf26CSBR1lbhOScIjaiZzQRVe4X/4sI5tkBoCLZAbqVQDR0tZeyiWty6A==
X-Received: by 2002:a17:906:ee87:b0:96f:781e:a4d5 with SMTP id wt7-20020a170906ee8700b0096f781ea4d5mr7658970ejb.77.1685639031091;
        Thu, 01 Jun 2023 10:03:51 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-248-31-20.retail.telecomitalia.it. [95.248.31.20])
        by smtp.gmail.com with ESMTPSA id bh25-20020a170906a0d900b0096165b2703asm10658522ejb.110.2023.06.01.10.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 10:03:50 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 4/6] dt-bindings: display: simple: add Rocktech RK043FN48H
Date:   Thu,  1 Jun 2023 19:03:18 +0200
Message-Id: <20230601170320.2845218-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230601170320.2845218-1-dario.binacchi@amarulasolutions.com>
References: <20230601170320.2845218-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible to panel-simple for Rocktech Displays Limited
RK043FN48H 4.3" 480x272 LCD-TFT panel.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 01560fe226dd..bd6a92d2b41c 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -280,6 +280,8 @@ properties:
       - rocktech,rk101ii01d-ct
         # Rocktech Display Ltd. RK070ER9427 800(RGB)x480 TFT LCD panel
       - rocktech,rk070er9427
+        # Rocktech Display Ltd. RK043FN48H 4.3" 480x272 LCD-TFT panel
+      - rocktech,rk043fn48h
         # Samsung 13.3" FHD (1920x1080 pixels) eDP AMOLED panel
       - samsung,atna33xc20
         # Samsung 12.2" (2560x1600 pixels) TFT LCD panel
-- 
2.32.0

