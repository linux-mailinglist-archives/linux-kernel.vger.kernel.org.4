Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D0A66B180
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 15:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjAOO0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 09:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjAOO0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 09:26:50 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBA16EBC
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 06:26:48 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so17056820wma.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 06:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLQqIynPN/pT84DVC6KpLTcAe3g0Vq4uxVa23539u9M=;
        b=ph6j2mV9QtgYB6RYOHt0jIk9j6j356U1Udxk0D99bRzeOov1hAGE5IUENdM5GP08Ka
         aA5uU0oWMt6emYkwafpPsQxym6jcIdla1CNLtQ9g/NS/Zatv5quYWg9P2HhwZ+v/KzxS
         wsNhbSExgHU9TaxwR8obmxiMX9xUcAlZKQV6qQ7Ossb0j8zmiy3fV4kg2SWdr8hS7QLb
         4NoT8GBCPo945w879fsghNCHN1G0+iIc6qFO4MFiRtky7+ybmh4zR8b6Eapze4b4lGoe
         51agl28rndt4OvlQVNO0STz/i7J2jZTfYVN3yQbVUXuryxmGRZOs3wu8tGSpkAb97hY/
         +jWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TLQqIynPN/pT84DVC6KpLTcAe3g0Vq4uxVa23539u9M=;
        b=PHSFO2v5z4RK0StbahQ1H2x4RqMj6ZM0pfB6nS7J9ieusflJsfIA3wtWx1ZaWjMv45
         psRpu/aJ2cXn1S3UPuDLxuRY630u3HFVHCzNnlYicYBDQoY9YR86vQdlLGeBeal/UiVJ
         sDivHmJgLBUV2TO/NSwqueeHU03fKmAzg28LuimqqENXaWznSnT6AaOoVBGGlIdSWHHJ
         l5Vpu9aMSENOTNkJHIVyQkDHNPtGZA31EXvjcPPVEPeOTk3CJtE8JO+4hxoE5SH3PBH8
         fKrBJDMqg096FobW7xAiy0c1l8CAzH0xVHEnXCCRFoV1EI2yLM47JsFs3U7mQVEX6LxP
         L8Ug==
X-Gm-Message-State: AFqh2kooCCrzKk+XkimP/oFSkwC8pOmzYFw08+EUF3hHK5Qce9E2HSY0
        v7yHSFG0EpC5Wnqk4S/5yhM=
X-Google-Smtp-Source: AMrXdXvw3m1Dacl6ZKOHdwKsCCaEN4Is2WYBhyseFfVSsp4ym8yGFjQiyNwImcowiwaeIZQely1wRQ==
X-Received: by 2002:a05:600c:1f08:b0:3d1:bf7c:391c with SMTP id bd8-20020a05600c1f0800b003d1bf7c391cmr5527248wmb.4.1673792807423;
        Sun, 15 Jan 2023 06:26:47 -0800 (PST)
Received: from ?IPV6:2a01:c22:6e61:8c00:154f:326e:8d45:8ce7? (dynamic-2a01-0c22-6e61-8c00-154f-326e-8d45-8ce7.c22.pool.telefonica.de. [2a01:c22:6e61:8c00:154f:326e:8d45:8ce7])
        by smtp.googlemail.com with ESMTPSA id ay15-20020a05600c1e0f00b003dab77aa911sm4043801wmb.23.2023.01.15.06.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jan 2023 06:26:47 -0800 (PST)
Message-ID: <38f87b22-d9a8-b8d8-ba7b-a2c2d7311b04@gmail.com>
Date:   Sun, 15 Jan 2023 15:26:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH resend] MAINTAINERS: add PHY-related files to Amlogic SoC file
 list
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Content-Language: en-US
Cc:     "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PHY-related files to the Amlogic SoC file list.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1c83c26e9..428d88195 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1909,10 +1909,12 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-amlogic@lists.infradead.org
 S:	Maintained
 W:	http://linux-meson.com/
+F:	Documentation/devicetree/bindings/phy/amlogic*
 F:	arch/arm/boot/dts/meson*
 F:	arch/arm/mach-meson/
 F:	arch/arm64/boot/dts/amlogic/
 F:	drivers/mmc/host/meson*
+F:	drivers/phy/amlogic/
 F:	drivers/pinctrl/meson/
 F:	drivers/rtc/rtc-meson*
 F:	drivers/soc/amlogic/
-- 
2.39.0

