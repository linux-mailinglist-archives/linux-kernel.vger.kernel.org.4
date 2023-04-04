Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07006D6D06
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 21:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235694AbjDDTRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 15:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjDDTRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 15:17:32 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673C14491
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 12:17:28 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id B7CF55FD03;
        Tue,  4 Apr 2023 22:17:24 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1680635844;
        bh=CA99O3oN+qmsdJNEwWXGj41D6iyd8mkWxcwccxE5ra8=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=s9LX/P19Ikc/up7r1woircu0F9JIZAyEZ2zKv4LPk/86hw3HfsPp/sXOMnToAuDqp
         3yc3dmv0gq/WeQSBcmK2IJRyCqWNEt98EZmZKQK4w6gDozkPV2ziwJC6mOj4maF6/b
         bCY9d1LJ9POyB+WxQ+/F21bdI+zQWoQNB+fp/IQ1UQHCqgCJPLDslIsGLYYw1hUlbV
         k4FDWdy8bsz9q81PJIjBoy0iCVqzOYq0BHiRkTtVcF1gxBc4vTFT9JvJ6Na2gtIXJd
         dZ+7PwPcfPsj5F4lk7MmyPZc2EJEhyHRdKT8OGh6r3kFX80p5ojB5RJdfDdHpzCAN3
         0K1gxPBJRUhqQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue,  4 Apr 2023 22:17:23 +0300 (MSK)
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <krzysztof.kozlowski@linaro.org>, <robh@kernel.org>,
        <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
        <lukas.bulwahn@gmail.com>
CC:     <kernel@sberdevices.ru>, <linux-kernel@vger.kernel.org>,
        <rockosov@gmail.com>, Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: [PATCH v5] checkpatch: introduce proper bindings license check
Date:   Tue, 4 Apr 2023 22:17:15 +0300
Message-ID: <20230404191715.7319-1-ddrokosov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/04/04 17:27:00 #21030910
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All headers from 'include/dt-bindings/' must be verified by checkpatch
together with Documentation bindings, because all of them are part of
the whole DT bindings system.

The requirement is dual licensed and matching patterns:
* Schemas:
    /GPL-2\.0(?:-only)? OR BSD-2-Clause/
* Headers:
    /GPL-2\.0(?:-only)? OR \S+/

Above patterns suggested by Rob at:
https://lore.kernel.org/all/CAL_Jsq+-YJsBO+LuPJ=ZQ=eb-monrwzuCppvReH+af7hYZzNaQ@mail.gmail.com

The issue was found during patch review:
https://lore.kernel.org/all/20230313201259.19998-4-ddrokosov@sberdevices.ru/

Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
Changes v5 since v4 at [4]:
    - only capital OR is acceptable for SPDX per Rob's suggestion

Changes v4 since v3 at [3]:
    - introduce separate pattern for dt-bindings headers following Rob's
      suggestion

Changes v3 since v2 at [2]:
    - replace 'not =~' expression with '!~' to be aligned with other
      checkpatch lines

Changes v2 since v1 at [1]:
    - include/dt-bindings check is aligned to open parens
    - introduce more strict pattern for bindings license:
      /GPL-2\.0(?:-only|-or-later|\+)? (?:OR|or) BSD-2-Clause/

Links:
    [1] https://lore.kernel.org/all/20230317201621.15518-1-ddrokosov@sberdevices.ru/
    [2] https://lore.kernel.org/all/20230320100027.27788-1-ddrokosov@sberdevices.ru/
    [3] https://lore.kernel.org/all/20230320203350.13696-1-ddrokosov@sberdevices.ru/
    [4] https://lore.kernel.org/all/20230331121017.14324-1-ddrokosov@sberdevices.ru/
---
 scripts/checkpatch.pl | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 78cc595b98ce..7d9b63fffa9d 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3710,7 +3710,7 @@ sub process {
 						     "'$spdx_license' is not supported in LICENSES/...\n" . $herecurr);
 					}
 					if ($realfile =~ m@^Documentation/devicetree/bindings/@ &&
-					    not $spdx_license =~ /GPL-2\.0.*BSD-2-Clause/) {
+					    $spdx_license !~ /GPL-2\.0(?:-only)? OR BSD-2-Clause/) {
 						my $msg_level = \&WARN;
 						$msg_level = \&CHK if ($file);
 						if (&{$msg_level}("SPDX_LICENSE_TAG",
@@ -3720,6 +3720,11 @@ sub process {
 							$fixed[$fixlinenr] =~ s/SPDX-License-Identifier: .*/SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)/;
 						}
 					}
+					if ($realfile =~ m@^include/dt-bindings/@ &&
+					    $spdx_license !~ /GPL-2\.0(?:-only)? OR \S+/) {
+						WARN("SPDX_LICENSE_TAG",
+						     "DT binding headers should be licensed (GPL-2.0-only OR .*)\n" . $herecurr);
+					}
 				}
 			}
 		}
-- 
2.36.0

