Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD2D66AED0
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 00:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjANXfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 18:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjANXfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 18:35:08 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4080BA248;
        Sat, 14 Jan 2023 15:35:07 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x36so1418152ede.13;
        Sat, 14 Jan 2023 15:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWVrESddhMcKV9qP+Dkj74fkQan5eC2qiWVTWYlr+WE=;
        b=aSpgkeU/VZC36HH2IOCrApSC6/dnJxHVVhk/EP4hS7lxvlqwG8haUfghF65tQrDYRM
         bd90WFiY6wgmjeUadxvJRKvRuEKPd4aiNxIT5U/ERvXOpzsNzvMHVfapgUNRI7/rlntv
         7eXneQ577hZthSj4JsI3XGgQrKAsGZQbuBshsyKJPEEYolvoJ/BjgjC0vvhlkWlF+BXf
         vWRO7Dw87Vvap0MZCKCheSMarlo+SqyrU9lpsPABprq5aAgQDbBcWEZUsb1I7Afj4NI4
         X0emxf2gFSLoMKG9/ZLrIiTvqA7OHeRlT35JXqqei8VjHO7sQON83giV9fMVGvVFanQt
         s5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GWVrESddhMcKV9qP+Dkj74fkQan5eC2qiWVTWYlr+WE=;
        b=yaEfFO7/oon/Qq6P6COtr0l3EtjxZ+dBbPqnWQWpVOTPAYnlqC+jML4xD2wOVLfALq
         6ovpjsffffOHWRQ7F4cau8vWG+HEVZfrQ9TykVdItNtN5dGj92fcUfaw/T2k68FPcK/N
         8WvlQDDT3cAsZJ21pzsn9t2Qmay++s38F2vunKUidHStih94eAtz1GR48s06CeD5sIe3
         xd6+P0RAhssZRKTiLR8z4yLlRfK6pc7XTgS9ySqOYAd1ilQTPH8C0Dt3fW/ENpxtpfs/
         grXDXdFytjwBVItno6wXo36yEnTNrj3YbL0h4dOrlPFtFCkw5Jr8+bX9+aM+ZT5oSkor
         nhzQ==
X-Gm-Message-State: AFqh2kr8SQEylwGnjEOiXvbA8UwQUL1KDX1Zw/iuKm0ndWqnl64bjmpB
        pcCquPjYtKdBpwUaXimz4S0=
X-Google-Smtp-Source: AMrXdXuSopPP0FVI3dTqxvJnvWR//Ng9ic9FQLSlfUHndfsNGtoMtLC4QGI5TgHARiRWhJ0kzZHNGA==
X-Received: by 2002:a05:6402:2d9:b0:499:d0e3:7745 with SMTP id b25-20020a05640202d900b00499d0e37745mr14991236edx.14.1673739305751;
        Sat, 14 Jan 2023 15:35:05 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c22-7ae1-c100-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:7ae1:c100::e63])
        by smtp.googlemail.com with ESMTPSA id d7-20020a50fb07000000b0049cbd334b13sm1967620edq.29.2023.01.14.15.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 15:35:05 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        neil.armstrong@linaro.org, devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 2/2] ARM: dts: meson8b: Add more L2 (PL310) cache properties
Date:   Sun, 15 Jan 2023 00:34:55 +0100
Message-Id: <20230114233455.2005047-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230114233455.2005047-1-martin.blumenstingl@googlemail.com>
References: <20230114233455.2005047-1-martin.blumenstingl@googlemail.com>
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

Add more L2 cache properties which are used by the 3.10 vendor kernel
but have not made it upstream yet.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index cf9c04a61ba3..2d80c009bdfa 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -643,6 +643,9 @@ &L2 {
 	arm,filter-ranges = <0x100000 0xc0000000>;
 	prefetch-data = <1>;
 	prefetch-instr = <1>;
+	arm,prefetch-offset = <7>;
+	arm,double-linefill = <1>;
+	arm,prefetch-drop = <1>;
 	arm,shared-override;
 };
 
-- 
2.39.0

