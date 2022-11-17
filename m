Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278B662D33A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 07:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbiKQGH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 01:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239251AbiKQGHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 01:07:17 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A5D28729;
        Wed, 16 Nov 2022 22:07:11 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id o4so1873106wrq.6;
        Wed, 16 Nov 2022 22:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UiXSAQsSjwWqOGc9spTfADfVAnOu8H9dxOp6ONZY5HI=;
        b=BqXgBQ7H19xsIldwSJ3XEtEaIyFB1pdOaoIIBGAvsLqPWuYbRoHDUN2CEBw0y3fxO3
         uwXsNGip+B4h9O1rmk+YMJmusJHfaeq7vO88bENdgIc6d4g/Q5ERZP8h+CMGECBu+X6k
         DHr3Vgr6V2tKU6lJj4Je8jANmXUTuaIp0l0++ThbeldD1m97ufIyMdpurrQHTy95XFcz
         dONdw2asOsd8CV8KJJwzAEFz5StzdHnVE0EM+gDQ28o/PqGKMes0ezBU3AmSxPHq4QcM
         SR1e7NutED2dxq9rz3GeAL70s9b4ihla6W7mGew7S/MZI2pr/0jy20LEPAyRCBdyzW3z
         xR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UiXSAQsSjwWqOGc9spTfADfVAnOu8H9dxOp6ONZY5HI=;
        b=X/4ipZL1rf9rsdLmuYi9fwC7CrYaGL5cKKni46SVhXyL4G/pPk6nTUxKj7GIzsonrD
         Srw/Y0D7dwQT+LxtK31Uik20DSNUYRvjUTXXamd1o19doAtgEO5cQLcqbkaa1jo3wnuw
         eEfiOSRbI4nS4EM5gq/P4IL9W1Xf6ZKEcICOx2c+FqnBacNaS5JgUMUZdJd5xobfXbNd
         fyOev/Nn7WpdImFQXkCMc5VFmyOwY6Mf2d8UncOg+VLCPGXDmKhovaupgKc/yvoctkqE
         RyWbH4UK43sHUL2mWWMEY75qQCVYUJSC7RC+tSm/AxApR7HmwkY2DLNUepdjmcQtcvcn
         cfmw==
X-Gm-Message-State: ANoB5pmDGLPaUosJa5Td99FE2ILSXYfR8Xpg9kJdBydeJDvlDPOMqIX8
        BemE/m6GQPwip+/n7KeJqfE=
X-Google-Smtp-Source: AA0mqf5SwUTUY/lj91u2/nwQu6g7fE2GFbJh2pd3jLHyIsRrmrwZ+DiGtLaGJyqtt7bLuhpDmkLHAg==
X-Received: by 2002:a5d:6b8d:0:b0:236:4c14:4e4c with SMTP id n13-20020a5d6b8d000000b002364c144e4cmr431753wrx.634.1668665229774;
        Wed, 16 Nov 2022 22:07:09 -0800 (PST)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id r11-20020a5d694b000000b0023691d62cffsm16542568wrw.70.2022.11.16.22.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 22:07:09 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        samuel@sholland.org
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 0/2] arm64: allwinner: h6: Add second IOMMU reference to Cedrus
Date:   Thu, 17 Nov 2022 07:07:02 +0100
Message-Id: <20221117060704.367945-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.1
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

It turns out that Cedrus on H6 actually uses two IOMMU channels. Manual
mentiones two IOMMU channels, but it doesn't specify which is used when.
Page faults were also observed from both.

This series updates binding to allow up to two IOMMU channels and fixes
H6 DTSI.

Please take a look.

Best regards,
Jernej

Changes from v1:
- add minItems to binding
- add reviewed-by to DT patch

Jernej Skrabec (2):
  media: dt-bindings: allwinner: video-engine: Fix number of IOMMU
    channels
  arm64: dts: allwinner: h6: Fix Cedrus IOMMU channels

 .../bindings/media/allwinner,sun4i-a10-video-engine.yaml       | 3 ++-
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi                   | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

--
2.38.1

