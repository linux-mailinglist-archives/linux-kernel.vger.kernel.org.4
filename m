Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08EA609F82
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiJXK6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiJXK5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:57:31 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E0D53A4D;
        Mon, 24 Oct 2022 03:57:22 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id 4so2229110pli.0;
        Mon, 24 Oct 2022 03:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JailJRGGT+MU7QQfQRg334ru/W+CJ+3fnThCLH1Q1Is=;
        b=PgpRBRAV0VQnb3CsMbkFilLmdJ93zWOEdIjNmUQ+izERRYl7Fm/SF5f61YzXPDYZzP
         u8GGg0HxNzrwDdLYslNmy3wjqXnEt7aAxcuJ1ekzpBIR96KyqwzY6A2KoqgkqnBETRwV
         W1ilOny8va381kPdMXBrs05mZaHvufZnK4NLnzn+l0tnM2tUsfBuTFCBo+r8U0fuhsVZ
         ASZS3dNvaYLwGtMQzB/uQ/f8wZT+RKZBxhMakHC7cbE0l2gNjJl7RY+33rEzxT42r5Fy
         6zjKY9NKgQ5R04H5KE1kZLYNEh8GZEphgPxgiXkTN/BRYHvJoCLwddokfUbxNHa0hhZk
         Dkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JailJRGGT+MU7QQfQRg334ru/W+CJ+3fnThCLH1Q1Is=;
        b=xhLP8FVQNyNh5qtXD93sM5icnYEic3ZRmN6STtouZzXnBszDjDFvaLqD7Tua8XeeOA
         WIpzV2H0b8XmLWJ5yFF3z/F7pSVxLp66EleLnKRmTLQzgHW+RQaJ/yHQSU614f5TQOo9
         wYhi61DaLZd+VWX5ZVAquAbWIl5NON/b049JvS4kXZm0gJEfhW2aN6HxX157i/xXsS9k
         vkUHpBF/DhKN1WUglEIQ567t0DnCV8y51VO1Pgv4oPtNPZ8bvGBiG4iwtvkHQbosiBXH
         pwa+zTUlitPGz+qGExNVy3wlP1y6ol+6HHT/HaKETLZm/xnbSUeZYpdskXECLFP1FX7T
         WEjw==
X-Gm-Message-State: ACrzQf0VGAoWh52ZezD9mSEqcWm+slULS/Gv4XKd5KcKBS1Pb/ghCQI4
        XniU5dYU8gKyQVUSskKOeBc=
X-Google-Smtp-Source: AMsMyM4S5aKg7WdqBIpzwjMK+mTJG8gHvmevQPZDmwNiiIDVqTw4Tvgp3CBuGXvWtpe7G/MAIcwVug==
X-Received: by 2002:a17:903:2286:b0:185:3948:be93 with SMTP id b6-20020a170903228600b001853948be93mr33287486plh.121.1666609032732;
        Mon, 24 Oct 2022 03:57:12 -0700 (PDT)
Received: from RD-3580-24288.rt.l (111-82-141-7.emome-ip.hinet.net. [111.82.141.7])
        by smtp.gmail.com with ESMTPSA id a15-20020a631a4f000000b0045751ef6423sm1366696pgm.87.2022.10.24.03.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 03:57:12 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     sre@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     chiaen_wu@richtek.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 3/3] Documentation: power: rt9467: Document exported sysfs entries
Date:   Mon, 24 Oct 2022 18:55:48 +0800
Message-Id: <77bc3eb3e8ecc6035bd492b801c0bff8fe4212a7.1666633143.git.chiaen_wu@richtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1666633143.git.chiaen_wu@richtek.com>
References: <cover.1666633143.git.chiaen_wu@richtek.com>
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

From: ChiaEn Wu <chiaen_wu@richtek.com>

Document the settings exported by rt9467 charger driver through sysfs
entries:
- sysoff_enable

Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
---
 Documentation/ABI/testing/sysfs-class-power-rt9467 | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-rt9467

diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9467 b/Documentation/ABI/testing/sysfs-class-power-rt9467
new file mode 100644
index 0000000..dd0b962
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-power-rt9467
@@ -0,0 +1,19 @@
+What:		/sys/class/power_supply/rt9467-*/sysoff_enable
+Date:		Oct 2022
+KernelVersion:	6.0
+Contact:	ChiaEn Wu <chiaen_wu@richtek.com>
+Description:
+		This entry allows enabling the sysoff mode of rt9467 charger
+		devices.
+		If enabled and the input is removed, the internal battery FET
+		is turned off to reduce the leakage from the BAT pin. See
+		device datasheet for details. It's commonly used when the
+		product enter shipping stage. After entering shipping mode,
+		only 'VBUS' or 'Power key" pressed can make it leave this mode.
+		'Disable' also can help to leave it, but it's more like to
+		abort the action before the device really enter shipping mode.
+
+		Access: Read, Write
+		Valid values:
+		- 1: enabled
+		- 0: disabled
-- 
2.7.4

