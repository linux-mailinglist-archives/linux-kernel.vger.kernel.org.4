Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988955F93CE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 01:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiJIXth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 19:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbiJIXsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 19:48:33 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CBA5E327;
        Sun,  9 Oct 2022 16:19:22 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id b4so14714794wrs.1;
        Sun, 09 Oct 2022 16:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mghaGLf5KX9Qfs0Iz/Qckp8O1iPhjUU8SyYtgnIyYlw=;
        b=dhRzvD/4yqkMBcKV+efNcPA7GO65Myp93+r1ESjgatpBSCAUTbaVm1PGqz1t3mamou
         C28uEohp71SA7LyXDC0CUpDHpBnI3uz2zKSSQJ5yMq6+x65p5Q1YTGsQwhEwYKHbZNLt
         XYsei53jUBAEHgicdrD/mTq/VGInuX5J4fXGwl19QOKwLDbC8RCWOTAGT7wef0gLg8K/
         NnSWypcRs3nIqhOeDEeT9CGd6u1FXCu8kptYJcndSCehbR6XxF3mjBmwP1+9DzrSMaEk
         B8CUAU1D0tVus23uRXIRos0pswmCO2chCi+REEvRlS8iNLToLLCMmUsDSttrVcM7rtG9
         jp0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mghaGLf5KX9Qfs0Iz/Qckp8O1iPhjUU8SyYtgnIyYlw=;
        b=dZcOnlEG0MYX36Kh0b68tOOcYoa1OPvtl1UKSbI/4yNMk6MuvVSKPdqpHOKMunfCLH
         FVlW4kchlrELXyISjcYCoUvn/vpR9TQ6ErWMpzBmSKlJrF2lsfbpO3J0vrm2Z1HKKYWh
         jOGdGSe6RRyEPtf5U/sJvd5UbaEYEwELlA3SS0y7B+Sz3Ey+SnlQbHSWX9J7VO4WOjJN
         f1wT5+50tQwVWvjq4M5omEV0/4fUS2+DSODLi1xhPQyORAbiiNyYmWwWF+XN6lu05H5r
         tGcXO/ejYVgvEuB/mSXPWxMwQSkprVHklMXi35yQPLBKjvhAgcq2QWdbWNbNLe0VGKWj
         qOgQ==
X-Gm-Message-State: ACrzQf0zhpEmJjgMvaI3XxkZYPAexqob35uI5I2Y4pIOe6xCfqGG5xT7
        RV5aI1oDk9MtBwMnJySPjwySf+Vhau70xg==
X-Google-Smtp-Source: AMsMyM44oOfh6IAkrJiUiV/0kq4UlKnBSui/8uReXeGJ7huLXKNyZX/PEzEROdYUAPRiOJYNjg4J1w==
X-Received: by 2002:a5d:6dca:0:b0:22c:c6f9:57d2 with SMTP id d10-20020a5d6dca000000b0022cc6f957d2mr9655820wrz.474.1665356459647;
        Sun, 09 Oct 2022 16:00:59 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:e4:5cde:80ab:dfd4])
        by smtp.gmail.com with ESMTPSA id r16-20020adff710000000b0022afbd02c69sm7239689wrp.56.2022.10.09.16.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 16:00:58 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 1/5] arm64: dts: renesas: rzg2l-smarc-som: Drop enabling WDT2
Date:   Mon, 10 Oct 2022 00:00:40 +0100
Message-Id: <20221009230044.10961-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221009230044.10961-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221009230044.10961-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

WDT CH2 is specifically to check the operation of Cortex-M33 CPU and if
used from CA55 CPU would result in an unexpected behaviour. Hence drop
enabling WDT2.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
index c4faff092380..fbbb4f03440b 100644
--- a/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
@@ -351,8 +351,3 @@ &wdt1 {
 	status = "okay";
 	timeout-sec = <60>;
 };
-
-&wdt2 {
-	status = "okay";
-	timeout-sec = <60>;
-};
-- 
2.25.1

