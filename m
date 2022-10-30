Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C39612C4B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 19:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJ3SgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 14:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJ3SgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 14:36:05 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A0F63A1;
        Sun, 30 Oct 2022 11:36:04 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z14so13160128wrn.7;
        Sun, 30 Oct 2022 11:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrNDCNfu7ZM4dOdnaJgxpzE77S3pvCYPnM96o3tk4S4=;
        b=AESNzqeJiKxl1IxfOpqDJ2H1k/FRxBVPKro5eYOHHM7YpejXu7wLw3XOsL4rcocAqt
         5CBNVZuVo9U9RGv65pOt8JvncjL6DOzu8ewmJgjqYdEITbpmC24ZhA4J2eRj0uMC92oU
         kKCNJpj9IMx3QJnhwgSuovtvkatUDaylF6zWEP27DBgfsnRTSzraLU04DgTfidfcBFtj
         aa3bTLTL1b7ZFVRJCmava3N+zAGXEsDEkcqxOe8aqzIa8dvo98G/PMMHQZOZDZXNqjPV
         Wrr70cJD+JKlPw/jpGogsEbebHhKKy/cXwHi9coZR8wI4znmZ5r7x+Wo0Hh0hG2nQFKe
         SQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lrNDCNfu7ZM4dOdnaJgxpzE77S3pvCYPnM96o3tk4S4=;
        b=qSMNpvZeZGXXuY62iVZPlc662C2kFoxufRW2wi1aDXip0OloVDbtlPy6BJFA8Nc8sC
         u/yNQlhvERCmdssv+G0QYdgujcWWnNOyH054GWRIAb46cXoqJm5VibsbkA7ElhxapUfI
         KWzgPJP4j8dsoMPJznBzKZDlEIKvS+zVAEB6/evFJMmdgeo6++xOexBpZ084ipowzV1K
         /4EQGWeulwz8A/aT/hACunKpLl/210I0qvp65+j9dNLsYft9USmMXvFDTjvlrfyQlkRZ
         rKI2XXjAm5Qu5InQfJKm1li3zzOZVEVfU9+F74xGK7aP+oBr/vAuHrdEH2lhfoge6oYB
         ndyA==
X-Gm-Message-State: ACrzQf1I7/L9vwHOrz74ARiYXZx3E9Kxru9CMbT6jNb+FzdSz2LXiS/i
        otAp4QBlJ5gVpx4wY1gq/U9QKEiAh2k=
X-Google-Smtp-Source: AMsMyM6v15LvKnbZgCTZa8QwRsmiIY1KiecD0neqjsDCxkPUaoE2bVtKJxbo/R4DpSUL7JsqKoUpCg==
X-Received: by 2002:adf:fc12:0:b0:236:9b2e:4843 with SMTP id i18-20020adffc12000000b002369b2e4843mr5535390wrr.620.1667154963240;
        Sun, 30 Oct 2022 11:36:03 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q8-20020a5d5748000000b0023677081f3asm4835322wrw.42.2022.10.30.11.36.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Oct 2022 11:36:02 -0700 (PDT)
Message-ID: <88e93a81-ef9f-adcc-db83-f8b5ba615c47@gmail.com>
Date:   Sun, 30 Oct 2022 19:36:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 1/2] arm: rockchip: Kconfig: remove select ARM_GLOBAL_TIMER
To:     heiko@sntech.de
Cc:     linux@armlinux.org.uk, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Content-Language: en-US
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

The clocksource and the sched_clock provided by the arm_global_timer
on Rockchip rk3066a/rk3188 are quite unstable because their rates
depend on the cpu frequency.

Recent changes to the arm_global_timer driver makes it impossible to use.

On the other side, the arm_global_timer has a higher rating than the
rockchip_timer, it will be selected by default by the time framework
while we want to use the stable rockchip clocksource.

Let's disable the arm_global_timer in order to have the ROCKCHIP_TIMER
(rk3188) or DW_APB_TIMER (rk3066a) selected by default.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

ARM: dts: rockchip: disable arm-global-timer for rk3188
https://lore.kernel.org/linux-rockchip/1492374441-23336-26-git-send-email-daniel.lezcano@linaro.org/

clocksource: arm_global_timer: implement rate compensation whenever source clock changes
https://lore.kernel.org/all/20210406130045.15491-2-andrea.merello@gmail.com/
---
 arch/arm/mach-rockchip/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index b7855cc66..0432a4430 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -15,8 +15,6 @@ config ARCH_ROCKCHIP
 	select DW_APB_TIMER_OF
 	select REGULATOR if PM
 	select ROCKCHIP_TIMER
-	select ARM_GLOBAL_TIMER
-	select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
 	select ZONE_DMA if ARM_LPAE
 	select PM
 	help
--
2.20.1

