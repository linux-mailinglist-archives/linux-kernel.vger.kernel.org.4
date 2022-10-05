Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759285F53E2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 13:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiJELoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 07:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiJELnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 07:43:41 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C497A515;
        Wed,  5 Oct 2022 04:41:49 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id z20so8634033plb.10;
        Wed, 05 Oct 2022 04:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=JailJRGGT+MU7QQfQRg334ru/W+CJ+3fnThCLH1Q1Is=;
        b=etWf/YwTE/onzXAMW9jr0SPmueHelVb0TIiTxVJ0R9sEHP89vUF+Pan12qnO/2Cr0e
         v3rdYxnXftQzx1D5AcwV22Tf7RuaydIANjTgg/x5sdyn2dsTaR3ZbhRFWwZDtt1TnKK5
         p3+T7sh3YMzaTZPS8yMpYOOr0DxXi9/fsidxBsTT/yPS69hC5ilUDKR9DiH6oFVmdLen
         6U7n07Td3xFHctcK1ZZC9V6VYz1lAyMkUskKh8swlLeEOrQfayQNY+cPUSuZUNJKs/E5
         5jlNKSuKARSqF5hSM6mDgZX2vtuKj34rQ8uqz7WdmbDjGy7wcXmk3V/0PXBSPSh/DnEI
         UGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=JailJRGGT+MU7QQfQRg334ru/W+CJ+3fnThCLH1Q1Is=;
        b=N9tGy66wrxB5o3DlwtaRYsn7a2/yyeWJlEy2W1gqGvFmtlWFTttb7t6vQXeHGwzjCq
         oQUfqnLzyeqY7bZ8SDmJkFZyBRiihKh7zr9iOGKdhVYLsQFU4WHqJOrWp93C0mXTnoLN
         KhxK9+WZqaqlIgiWdCo3RRuDaH3i82dIrXE+HizASzCeUIFOEP9iOaPuD+wFIvb59ldP
         FNY6nfy5miBcSMaVKFaiX3spP/ZtftpB2A4wJU0/ZnMYxtZ5b/A11x85Eo18AHlGHKnM
         cNiz2t0r7cvEjUZw3zxvs/01TQReTm0p2sL0wOnNTie2FZNRiktbZ79uFq6/D5K47D7D
         laFQ==
X-Gm-Message-State: ACrzQf1hya9FoFztNiHVA2glftJZaL5O4pcvgx2En1hjruuZ7Tp+TguR
        /kmhVEKTbdZPI+DxeRRzS9k=
X-Google-Smtp-Source: AMsMyM69iX/pF2NILOzu2RVcP30i/TQD09jn6dRPAWqxLyf3trFbs0Pj4MNRLj1t4iwMfQxnO4zIWA==
X-Received: by 2002:a17:902:b18e:b0:178:3484:f45e with SMTP id s14-20020a170902b18e00b001783484f45emr31504910plr.166.1664970017218;
        Wed, 05 Oct 2022 04:40:17 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-73-126-108.emome-ip.hinet.net. [42.73.126.108])
        by smtp.gmail.com with ESMTPSA id v9-20020a17090a4ec900b00200b2894648sm979202pjl.52.2022.10.05.04.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 04:40:16 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     sre@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     chiaen_wu@richtek.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 3/3] Documentation: power: rt9467: Document exported sysfs entries
Date:   Wed,  5 Oct 2022 19:37:24 +0800
Message-Id: <40676e2af49dc8d9bdd9c5f80aef3ad0f5b731db.1664997251.git.chiaen_wu@richtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1664997251.git.chiaen_wu@richtek.com>
References: <cover.1664997251.git.chiaen_wu@richtek.com>
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

