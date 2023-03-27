Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E173A6CA523
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjC0NFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjC0NFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:05:12 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CF2F9;
        Mon, 27 Mar 2023 06:05:10 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1679922309;
        bh=EhBft7sNwakRLdpX39yVMFqZnYW/lfmJHKEsvTMzAtc=;
        h=From:Date:Subject:To:Cc:From;
        b=oYGplpnO7zHncNS/wEqOM9M2w5JwuoM4MVy0ahNKQIC09HRrzUrei4N2BriEU/XNd
         K1vphGh1A2B87F60ICV6KP/zXuNdDwN+zmGKpn992iqfVIjQanRac+axBLS+HzsZ1y
         yGWW6IctWcD3tLKV3duCOKcog0dlSIKDwysbnyXs=
Date:   Mon, 27 Mar 2023 13:05:02 +0000
Subject: [PATCH] platform/x86: gigabyte-wmi: add support for B650 AORUS
 ELITE AX
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230327-gigabyte-wmi-b650-elite-ax-v1-1-d4d645c21d0b@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAH6UIWQC/x3NQQrCMBCF4auUWTswJlTFq4iLSTpNB2KUpGql9
 O4dXH5v8b8VmlSVBtduhSofbfoshuOhgzhxSYI6mMGR8+TdGZMmDr9Z8PtQDKeeULIaeUEiP1L
 oL+KjBwsEboKhcomTJco7ZxtfVUZd/o+3+7btl3DucoEAAAA=
To:     =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        got3nks <got3nks@users.noreply.github.com>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1679922307; l=1263;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=EhBft7sNwakRLdpX39yVMFqZnYW/lfmJHKEsvTMzAtc=;
 b=PVjXaUaoOayIhaDnqTlwRTAFZLmmPGtJzrUsaFl1pjG+vmV7kaL10FglOKU0PnC1VBR8FhRu8
 uhkv8CXhjsSDsUkkCag/Szqd1lG9rmF2OM/TVCuB37ilgL6an/whOu+
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This has been reported as working.

Suggested-by: got3nks <got3nks@users.noreply.github.com>
Link: https://github.com/t-8ch/linux-gigabyte-wmi-driver/issues/15#issuecomment-1483942966
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/platform/x86/gigabyte-wmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/gigabyte-wmi.c b/drivers/platform/x86/gigabyte-wmi.c
index 322cfaeda17b..078afa98e6c6 100644
--- a/drivers/platform/x86/gigabyte-wmi.c
+++ b/drivers/platform/x86/gigabyte-wmi.c
@@ -150,6 +150,7 @@ static const struct dmi_system_id gigabyte_wmi_known_working_platforms[] = {
 	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B550I AORUS PRO AX"),
 	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B550M AORUS PRO-P"),
 	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B550M DS3H"),
+	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B650 AORUS ELITE AX"),
 	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B660 GAMING X DDR4"),
 	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B660I AORUS PRO DDR4"),
 	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("Z390 I AORUS PRO WIFI-CF"),

---
base-commit: 197b6b60ae7bc51dd0814953c562833143b292aa
change-id: 20230327-gigabyte-wmi-b650-elite-ax-003f0b58e3c3

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

