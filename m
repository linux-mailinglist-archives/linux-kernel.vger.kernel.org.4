Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A157472F815
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243360AbjFNImX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243003AbjFNImV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:42:21 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C33E1BC6;
        Wed, 14 Jun 2023 01:42:20 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-97467e06511so75995266b.2;
        Wed, 14 Jun 2023 01:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686732138; x=1689324138;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opM3iGVAspr9kRraTUg2dpdsl+wTsC8aJ5I0FXPKrxw=;
        b=Wk16ZydFOesluSaK1ZqoT7KG3Fhc9htRTlxyRk8zkhykFxIghx/+7qZ1xLgdjxioMl
         LEVJniNwvxFsDjV7gtJm4TGphBPptwMGFh3Gx0XjBeG7E6NAD2fWvYjj3XLj+aOTw5kA
         pw3IRYRBltLxeRvXwUZeHOLJTQv030SaUZX1npNTxwHv2qjj4eBonmg1z2IyhlmKhpiv
         uGcfMRv5fiPhhlQblMHQciZkZ22QPAptosBU8gWsq62vAZg+9ZKqIO/9wYOqgrWk3g/a
         imnKZSvZY0A3r0NwqyPj37gCjsYv0vQKa32yh2e2w2Teufs4J5yMwP/XY9u4pWnwpnfS
         KEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686732138; x=1689324138;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opM3iGVAspr9kRraTUg2dpdsl+wTsC8aJ5I0FXPKrxw=;
        b=UKXYC0i2zPDJtu0BsmQD7kzG+uwQSyT3bcdEG2xo9vxTkqNk92dLmLLzGTcks6cHbl
         X+Lhzv8BAtO1+Sk38Yg1PD9Y7o7mNJZGIqjMh0+AW1ZV5wPC4mIYsyA/lCpkPc+0uyBq
         MqmfmHsHhOxWKHrjdKaYXAYV9zNAAFAaQoOLM7HtV26ibonexy8T1oWZTo3XAfHtbyDX
         0lCW0k5DZKO4XuJMP914loQf6juhVrtYUlcr+nIUPJc+UAZbIGFT84PNC5VVFeLFulsN
         BS1Q/NLj2n47gDAdHCtbLk1ydf/ZQYimUwkLLElo8xjyIupomXIlwkYxgUTYy+SsikAt
         EIXQ==
X-Gm-Message-State: AC+VfDxCrwjOgPe5HWra3DYcqKUDtr3GotlQXICvJ6CYWxHPxBdhfQVh
        CaHkB/NEkhzCzsPjAAYsc3A=
X-Google-Smtp-Source: ACHHUZ7ya47oM5/J7tl94dZdyLzklENOnczzEO6zvU9K1dvMu+8hLctghYF1M6GLPCAEacPna04cBQ==
X-Received: by 2002:a17:907:3ea1:b0:96f:be1e:bf1d with SMTP id hs33-20020a1709073ea100b0096fbe1ebf1dmr14432692ejc.69.1686732138321;
        Wed, 14 Jun 2023 01:42:18 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:fd81:17b5:3295:3921])
        by smtp.gmail.com with ESMTPSA id g8-20020a170906348800b00977cfa6ff46sm7685042ejb.103.2023.06.14.01.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 01:42:17 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jian Hu <jian.hu@amlogic.com>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-amlogic@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: repair pattern in ARM/Amlogic Meson SoC CLOCK FRAMEWORK
Date:   Wed, 14 Jun 2023 10:42:12 +0200
Message-Id: <20230614084212.1359-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e6c6ddb397e2 ("dt-bindings: clock: meson: add A1 PLL clock
controller bindings") adds a file entry with pattern
"include/dt-bindings/clock/a1*" to the ARM/Amlogic Meson SoC CLOCK
FRAMEWORK section. However, all header files added in the patch series to
add Amlogic A1 clock controller drivers carry the prefix "amlogic,a1", and
there are not header files matching "a1*".

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Adjust the pattern of this file entry to match the headers actually added.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 08c7efe271c3..08f7c69c67c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1887,7 +1887,7 @@ L:	linux-amlogic@lists.infradead.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/clock/amlogic*
 F:	drivers/clk/meson/
-F:	include/dt-bindings/clock/a1*
+F:	include/dt-bindings/clock/amlogic,a1*
 F:	include/dt-bindings/clock/gxbb*
 F:	include/dt-bindings/clock/meson*
 
-- 
2.17.1

