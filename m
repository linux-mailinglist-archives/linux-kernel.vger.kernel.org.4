Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757516C0DF0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjCTKAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjCTKAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:00:46 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A938446BB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:00:39 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id E93D65FD16;
        Mon, 20 Mar 2023 13:00:36 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1679306436;
        bh=+AlvPPz3WwkMxZ6jkBwUTQE4LbckvPytF6kchrIlEqA=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=rGBce1OsE8g/ESJq9qPf09s/UcT7yJz220f2y91WnnltXq/b4OUr1VlJqK/LNjxe0
         jtMP2rKi+nQTjnBkmkVdl1uYkYM26Y+7HVSjFGN/oGiiLsMXrjZBOsRHpPjLxVGflV
         xcgWK/lmdmMEkr1zk5Pl6uyH9zFxD9ye+wJ01GMJa3cTukyfIy4MK1AoTw6nOq8dow
         8yqn4K7ypEMp6JyMUtgp4SAnBtFjCan8jHA+EcijnUQuA0iFY4AjAx6BVqiX+/itHz
         +gyGjOXcIMNUv/kh4JlJczlvdwBx0oUjgYII0Yxl0ovUYZeBBKS/sgwxmvlc+O6r+w
         WaclSE0Mu5bZw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 20 Mar 2023 13:00:35 +0300 (MSK)
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <krzysztof.kozlowski@linaro.org>, <robh@kernel.org>,
        <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
        <lukas.bulwahn@gmail.com>
CC:     <kernel@sberdevices.ru>, <linux-kernel@vger.kernel.org>,
        <rockosov@gmail.com>, Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: [PATCH v2] checkpatch: add missing bindings license check
Date:   Mon, 20 Mar 2023 13:00:27 +0300
Message-ID: <20230320100027.27788-1-ddrokosov@sberdevices.ru>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/20 04:57:00 #20976224
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All headers from 'include/dt-bindings/' must be verified by checkpatch
together with Documentation bindings, because all of them are part of
the whole DT bindings system.

The requirement is dual licensed and matching pattern:
    /GPL-2\.0(?:-only|-or-later|\+)? (?:OR|or) BSD-2-Clause/

The issue was found during patch review:
https://lore.kernel.org/all/20230313201259.19998-4-ddrokosov@sberdevices.ru/

Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
Changes v2 since v1 at [1]:
    - include/dt-bindings check is aligned to open parens
    - introduce more strict pattern for bindings license:
      /GPL-2\.0(?:-only|-or-later|\+)? (?:OR|or) BSD-2-Clause/

Links:
    [1] https://lore.kernel.org/all/20230317201621.15518-1-ddrokosov@sberdevices.ru/
---
 scripts/checkpatch.pl | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 78cc595b98ce..de669d29f60c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3709,8 +3709,9 @@ sub process {
 						WARN("SPDX_LICENSE_TAG",
 						     "'$spdx_license' is not supported in LICENSES/...\n" . $herecurr);
 					}
-					if ($realfile =~ m@^Documentation/devicetree/bindings/@ &&
-					    not $spdx_license =~ /GPL-2\.0.*BSD-2-Clause/) {
+					if (($realfile =~ m@^Documentation/devicetree/bindings/@ ||
+					     $realfile =~ m@^include/dt-bindings/@) &&
+					    not $spdx_license =~ /GPL-2\.0(?:-only|-or-later|\+)? (?:OR|or) BSD-2-Clause/) {
 						my $msg_level = \&WARN;
 						$msg_level = \&CHK if ($file);
 						if (&{$msg_level}("SPDX_LICENSE_TAG",
-- 
2.36.0

