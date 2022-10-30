Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC2C612C4D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 19:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiJ3ShH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 14:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3ShE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 14:37:04 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AEFB1D5;
        Sun, 30 Oct 2022 11:37:04 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id l14so13196967wrw.2;
        Sun, 30 Oct 2022 11:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J+5BMktAWdfToMJ1hbGNlYZD5Qlu0JfVkC/Za08BZ7c=;
        b=lZucQFwMUiiqTnckQYk0BtEzg8Tx46FKrrik/n0DlFfqvcr6eKD29Mh+E+GHXaA8jg
         FT0YsGguBVA/bYI0L4aL4kernwk03SduYoNJxRIcoqAYVbfgZXQoECfFpzery7Ww48az
         9s0sZ8tlCbYSyNpfPziD8Pog7LepHxTkkeNoQ0S08gIQf4pVe2TYWRb5ru7F4b93NVpz
         FOUE3HPTDqmkXi5LyC9mdu15MHL9WIbuH1XhJ56QO5NvbcFaSj5wcME/30bw/YxnLJ6t
         FLe2BTrBl2/OuYNBG998GuXgqY+TWapocl6M6aTobKrpxA8uHSU1UeLHpR/agzFou3ER
         iRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J+5BMktAWdfToMJ1hbGNlYZD5Qlu0JfVkC/Za08BZ7c=;
        b=HTtWB2gxMobPYRXKFLfkAJk/XTgJfZ0h6kKkTVkULo0dK6Nth4SlvxGpWNBPfSFkC8
         BDQsuSHzt2/absOu7WjUqhlGK+E7VOX/FTuoDogIazABWgCLlUdX2wXRHdhZS9ngCdcd
         ug7ToxKFBOM++d5NGMDtFnA5ubflpz5y5GGk5k95rSYiFAGLlAGxzTLle1kGiaM8z2wA
         EwdTn+PIzRQvUi/a/9CMw70r7tuKH8p9E9kTt5KnyS7tF0w4vVvnniOc4/6iQXOID4YP
         UPfGg9CBU5PAlWwMi5zArzgAzzrKmjtXK8O73VAYN+BxYwKtIAOgo0KqvrwXaCZKlHai
         iK+A==
X-Gm-Message-State: ACrzQf0uPeqmsQWLbdNYgPpR9MbTa9ABzKzusmQrPHWge+MPgbT6YKSZ
        MQJLT0LBkpXSIcKABrlwIeg=
X-Google-Smtp-Source: AMsMyM6TOuE20NlQk53uFH4Kp3NVKx69kpi8DKy7vPHScvANWSbp858ehjPjFWT1NZKv4p1V9sTu0Q==
X-Received: by 2002:a5d:498a:0:b0:236:58ef:6796 with SMTP id r10-20020a5d498a000000b0023658ef6796mr5817390wrq.399.1667155022484;
        Sun, 30 Oct 2022 11:37:02 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id bx10-20020a5d5b0a000000b0022e47b57735sm4922159wrb.97.2022.10.30.11.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Oct 2022 11:37:02 -0700 (PDT)
Message-ID: <903ba85a-75fc-ff9e-e0ba-4a1e6161abc1@gmail.com>
Date:   Sun, 30 Oct 2022 19:37:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 2/2] ARM: dts: rockchip: rk3066a: disable arm_global_timer
To:     heiko@sntech.de
Cc:     linux@armlinux.org.uk, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <88e93a81-ef9f-adcc-db83-f8b5ba615c47@gmail.com>
Content-Language: en-US
In-Reply-To: <88e93a81-ef9f-adcc-db83-f8b5ba615c47@gmail.com>
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

Let's disable the arm_global_timer in order to have the DW_APB_TIMER
(rk3066a) selected by default.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

ARM: dts: rockchip: disable arm-global-timer for rk3188
https://lore.kernel.org/linux-rockchip/1492374441-23336-26-git-send-email-daniel.lezcano@linaro.org/

clocksource: arm_global_timer: implement rate compensation whenever source clock changes
https://lore.kernel.org/all/20210406130045.15491-2-andrea.merello@gmail.com/
---
 arch/arm/boot/dts/rk3066a.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index de9915d94..cf8045625 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -653,6 +653,10 @@
 	};
 };

+&global_timer {
+	status = "disabled";
+};
+
 &gpu {
 	compatible = "rockchip,rk3066-mali", "arm,mali-400";
 	interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
--
2.20.1

