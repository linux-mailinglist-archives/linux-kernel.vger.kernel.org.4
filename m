Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6988365BB3E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 08:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbjACHan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 02:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236920AbjACHa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 02:30:27 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A4ADEF6;
        Mon,  2 Jan 2023 23:30:25 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id fz16-20020a17090b025000b002269d6c2d83so532842pjb.0;
        Mon, 02 Jan 2023 23:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgJSdtU2k5DHs16MCkmtC7fasexNDJAPB3/Jh9qcLJg=;
        b=SdwB+zDXEaHU4oZBTmY3m+dKSnLVICNSo4jmK0Sm24mrrb221JNuCBqCCuiMucr0xs
         rTq5xyPdch4Bb7MwXhY8jg3U8MnxIUQhZKdk2MyCXQJMSTxwg3A6C6JknW5BZJC5ocrL
         eMep2xFGfKWN1G+v49tZjvM17vX7lnhw9roGcsmJxC0wUNSW3ZhLnbaptQC1ZGk6fQ+p
         AGBUb8EgZMjJ6sKwTecymAD2bInIbhWF94NzQNB56qRBBTCWH5q2mt+9rM/D1GxtOU1D
         Cya0XlIbbj7JsZsHLEkxh/Nnc+QWkL1MVKHHmrHJjYwalKcfCcojchmmu6nyun02AMBi
         zQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgJSdtU2k5DHs16MCkmtC7fasexNDJAPB3/Jh9qcLJg=;
        b=tLTk9G2QBp3HiO6qEoWZA1VeNEUpGfysxT5GFw3MnTWSng72Y1UTFHsDliAsYba1f0
         L+3NVu6qQ/NMSSbPn5yycYZYubou9/BND0T0tpqhSXjC9ucjn+j1vqHTYQFegiKh6FZx
         M1yAW5+/50hzpaoPLujSuiDrgmN4iL2zXiFakxzUftkqQZyXfRryUvumKLHEn2mVlI6A
         2sFgUotnxLYaYPQbYguaFbQLfb7xZ9ilWvNbExctIQoA1cn+aRXXD8QlMs0D4mYaxGWV
         zwqVML/EFj5sjkLdBw1A1uF0H87gNXLaDvXZiYw9nOSQsTGEtvEALN8H6rrFn8atxLPM
         5n7A==
X-Gm-Message-State: AFqh2kqcURzshbTFJeApu4T0JGi3Qv1rKMrGriBJkZN6Qs0FtnRZg0qA
        5iKro7euCBdx8Z6/2BfoI7s=
X-Google-Smtp-Source: AMrXdXvUuXdKoMPhYrQ4CL42w/GutPax/jxQe+hCIf8hVLahv8NxGX+p3w2jRq7WDBOq0mI81Pz20w==
X-Received: by 2002:a17:903:181:b0:191:1b93:e391 with SMTP id z1-20020a170903018100b001911b93e391mr59557428plg.63.1672731024733;
        Mon, 02 Jan 2023 23:30:24 -0800 (PST)
Received: from RD-3580-24288.rt.l (42-73-255-34.emome-ip.hinet.net. [42.73.255.34])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902684400b00189f69c1aa0sm21449839pln.270.2023.01.02.23.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 23:30:24 -0800 (PST)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     sre@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     chiaen_wu@richtek.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 RESEND 3/3] Documentation: power: rt9467: Document exported sysfs entries
Date:   Tue,  3 Jan 2023 15:29:58 +0800
Message-Id: <9dfc9e50a96cac7f0ef9e3d40cee3ef42b2f9034.1672730839.git.chiaen_wu@richtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1672730839.git.chiaen_wu@richtek.com>
References: <cover.1672730839.git.chiaen_wu@richtek.com>
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

