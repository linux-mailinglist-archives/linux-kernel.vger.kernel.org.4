Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7715F620917
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 06:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbiKHFtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 00:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbiKHFtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 00:49:43 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB62F2E9CD;
        Mon,  7 Nov 2022 21:49:36 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 136so8639117pga.1;
        Mon, 07 Nov 2022 21:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgJSdtU2k5DHs16MCkmtC7fasexNDJAPB3/Jh9qcLJg=;
        b=O1WXNYXCeEv11oFl6wIZZZ2CfjeZzVTv7ojV+HM4+LbUW7uYiHRmAH3LvXHHmjAwof
         7fokGGn27suaU4Vxmk/khPxN5qjLva7maF103xU9SC3l8dLVaX1Wt/WXIGfwy6gVZIaw
         7NKY7opDTR8F1Do3bWWPk53El4G5AaJQk21jRVAUxE//2sqnYCT/zZ7CPAU40+wNf4Uj
         Z3XpmkONp/CoX2IIg8jAJIZ5Uz51E2ESybP3mau7yjDmOaqIz8aWMyb0VHN1A8svaq3T
         DOjthhm1tBfcMH0RRHC7FZ4Cfwf0p4gIok42r5XZxRQf4QoSbi0fv18bdfCDUYNiYakJ
         E51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgJSdtU2k5DHs16MCkmtC7fasexNDJAPB3/Jh9qcLJg=;
        b=o6yqSrg7bZaj/csEuDx72IeGGrRF9JYRenkNPEF5S+k6A5ZXac3T+a/q9aaMMrLuh6
         SuKq6RtNFLn1JGinQXgmhPB3im8g8EMoW/QTO+yPt6Sp0AhGQNCIvXzvuulEHYvIL+Qg
         Ly5tgRdtNp1l0GFmx6mVyCR+nRgXe7WZF3s3+spYQwCuDy/AgMj4/8XlXpKigEhCUOOD
         uyzzSwh5G2e2+Co5IMicfKg0gik742JHlnDifbCHC7uWKioZi1tJaks8Kcuep7ZCsdfj
         3KgxJ3aEnlmejV+2+xbYelLvE3GIRGCpf5oVQsjwX4SfDB6pbNb1EQxZOI/m28YeBIlC
         2Trg==
X-Gm-Message-State: ACrzQf298NQvg8vPiOb6y9wrNLTmNb8wJkKq+ZUJdiiGyGLhb2cSZFrU
        riUfTtahn0G5uFf+smVA8xQ=
X-Google-Smtp-Source: AMsMyM6DJ/t8gVDmyoGQbU9iX/WuaAVtDMwQihMbaK87v5/uOFTU5EuTfc/6T+QpN+Gckj72BNFHMg==
X-Received: by 2002:a63:224f:0:b0:438:cdf9:ef63 with SMTP id t15-20020a63224f000000b00438cdf9ef63mr941336pgm.345.1667886576519;
        Mon, 07 Nov 2022 21:49:36 -0800 (PST)
Received: from RD-3580-24288.rt.l (42-72-183-173.emome-ip.hinet.net. [42.72.183.173])
        by smtp.gmail.com with ESMTPSA id q10-20020aa7982a000000b005618189b0ffsm5482163pfl.104.2022.11.07.21.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 21:49:36 -0800 (PST)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     sre@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     chiaen_wu@richtek.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 RESEND 3/3] Documentation: power: rt9467: Document exported sysfs entries
Date:   Tue,  8 Nov 2022 13:48:56 +0800
Message-Id: <3e22d5b2f59134e7c4a2d3c32db2132cc30b76dd.1667886055.git.chiaen_wu@richtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1667886055.git.chiaen_wu@richtek.com>
References: <cover.1667886055.git.chiaen_wu@richtek.com>
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
 .../ABI/testing/sysfs-class-power-rt9467      | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-rt9467

diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9467 b/Documentation/ABI/testing/sysfs-class-power-rt9467
new file mode 100644
index 000000000000..dd0b962f6fd4
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
2.25.1

