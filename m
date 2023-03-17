Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E6C6BF236
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 21:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjCQUQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 16:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjCQUQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 16:16:39 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD8A618A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:16:35 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 5C2195FD4F;
        Fri, 17 Mar 2023 23:16:33 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1679084193;
        bh=TyaOVLlVY2asue8yP9ZJWJeqyi9V7IO1gcIFeqpZ2sc=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=de4bKrOhQCOw+ptf3iKrNoZuUKSPs6n+YHVuzXAzEiUPX9J0b3mpgJ2WGaG5A+Qx6
         0fPgP7O5NliAKZvwXWp45n4GTd2qVlOtphs//Ds80EAO9GR/sbsiYKV/fgy0xwd3+P
         A8C9Dfc45tQI3VCvB7t3M302KJXtBMSZmbw3hJtcHY00sM1b4QNwGoyfNv+RjgllNC
         h9vDqacdHaH0aSaI1XoSFG44HjWlOSGvVphZWKZdjb+wnmwqwjtU0eDtitT8pzTXub
         LwSh0HC0mJ7Tr98Ai6UncrGg/DdSM1LrZxffFSrW6zsjKfGhhVypN7L3M4TDMkGAPM
         OlFkpECcVbcHw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri, 17 Mar 2023 23:16:31 +0300 (MSK)
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <krzysztof.kozlowski@linaro.org>, <robh@kernel.org>,
        <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
        <lukas.bulwahn@gmail.com>
CC:     <kernel@sberdevices.ru>, <linux-kernel@vger.kernel.org>,
        <rockosov@gmail.com>, Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: [PATCH v1] checkpatch: add missing bindings license check
Date:   Fri, 17 Mar 2023 23:16:21 +0300
Message-ID: <20230317201621.15518-1-ddrokosov@sberdevices.ru>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/17 17:26:00 #20964929
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All headers from 'include/dt-bindings/' must be verified by checkpatch
together with Documentation bindings, because all of them are part of
the whole DT bindings system.

The requirement is dual licensed and matching string:
    'GPL-2.0-only OR BSD-2-Clause'

The issue was found during patch review:
https://lore.kernel.org/all/20230313201259.19998-4-ddrokosov@sberdevices.ru/

Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 78cc595b98ce..2d12d39992cb 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3709,7 +3709,8 @@ sub process {
 						WARN("SPDX_LICENSE_TAG",
 						     "'$spdx_license' is not supported in LICENSES/...\n" . $herecurr);
 					}
-					if ($realfile =~ m@^Documentation/devicetree/bindings/@ &&
+					if (($realfile =~ m@^Documentation/devicetree/bindings/@ ||
+					    $realfile =~ m@^include/dt-bindings/@) &&
 					    not $spdx_license =~ /GPL-2\.0.*BSD-2-Clause/) {
 						my $msg_level = \&WARN;
 						$msg_level = \&CHK if ($file);
-- 
2.36.0

