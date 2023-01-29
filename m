Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBA467FFC0
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 16:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbjA2PEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 10:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbjA2PEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 10:04:43 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283B61E9E9;
        Sun, 29 Jan 2023 07:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1675004677; bh=4jrPQunuxuiB0eXyNSnLg5DAL4du4RKWiXJDWj48ScQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=ret9eSyrY4ldDebnL0lUtrtE/S7uFAmoF2LlozbctRQ6GyXLwbiM5tusM/9w0iG6G
         pkahQ+a+wFat97al5vekNz9ixdOBarMF+PGuR57+/ypfddrhjONZXiiPY8SV6NEpzz
         yRWRTMRDmirz5iW6PUxoJcOEIEQZjlROzFQETL+cfU93R7kcb+2zOUjkEaEYsfAc9F
         Sawo/SYJtR30ZUiJ0laDjDbqg6IBshFeTNliLsJ0ReuJ9jpQPhVreP7QNuFF4+fOww
         xxRnIBjxffqYi9yz6Q/EhxXunaj3F9gpMHyG8vHmYa5/D9bJoaj9YyDHdxrI+RVLZn
         4E6wKimSEPmKg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.193]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MA7GM-1pWcZD1dVK-00BcTh; Sun, 29
 Jan 2023 16:04:37 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] scripts: kernel-doc: Remove workaround for @param... syntax
Date:   Sun, 29 Jan 2023 16:04:35 +0100
Message-Id: <20230129150435.1510400-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9vZVQ0xybHF13EjRMUHbJl3XT9TEgx/ZUcDRfFJSFOnRWZuSYu3
 ggnTIE/TmhdsLD3ovH6TRkIHnYBl9K6UKaEyZ2yscnpgJI7XLd0ZqrNLBD0ZSuIPay1xxOf
 lwa4WuQIq3A67ShTWcQNydwbD6MZkfkNC4q8sQOGBu61BtTrYZvfckz9b1BiJju/1fKAvqK
 bt48BOsciEbWE2jgsdTJA==
UI-OutboundReport: notjunk:1;M01:P0:X07j5CW3+E4=;gwAtE4sDFy2xg/jUx29Rdar6Txy
 /kNXmCr9NwkdAHuuBMPhQR3mhPl27T3oRHkhRBcY6WoN+Hcm/eJ55pId3tqS7+nOTWIrYkLup
 +ZuM60sVKKdMjgC4yjfmDdbyvrkqq5tH/PoMdNhzWA7/+xOxYRb4S6v+3V/km5YBI5OjaNArh
 CorSuHIHjTFgZ8wby5Fl8V1VgBeVGqwY3SrJTbyXx4dYsefFiUCDGLBvifG9fBTk35eA+WeZG
 q2bqx1TjV3RcKUv6Ue5AC6UUOGBjSKlHr1LTes55CMuXFudNtpTGqkpuqPYLxQksPc92zkeLT
 5X3MDEzVXZjCbAeJ0FMGgNX9jbpToNGD6YC8PPKeYTRmDgAI69TWzx5FHW3FshFOollVm9QrO
 mG/UyfwzQOU6gTlR4e3uJ8kx5pgX+NH12TBuOzlw/g4QTT0NLG2R+ZdQQCkUElY5dt35v/TC3
 KPR70g8Ht6yuCDxmaNU2lKjrhKQMxg77UDT0KTReS2Tt444AYGUoh/1/o93hiGZgSV6jLXiDl
 Jkobhvd7YPT7pHXOm1VBX3fUYc+4R1HvbD0Pn0TmNxFTS0XVYufzTnFs0L1W1VHy6bt9ldJMa
 4FQ+MKcOT7hkE/bUkuX69zFSMcEN+5swrHWhEt9aZHyPSvDO4yXdDkcrSY58J5kIlzS1vawRp
 FSieVzmbhc+4Ips2KIhhiy4dE0K02kPlG5Q1fcJUNscf1iR/frzsEImCxLglIahVkGZzJ+ObG
 5iReV3imLjC8T/YKzISdw0Fd3Rdj/sNgmFn/fXstxbwBQtPL5jwH5BehakuOEXEbeM31ZDiQ5
 +1P9mRnh1gBa/CGPJp0KxFJ1CUBp3wRws1rjPkfAFmF/+F3tzdWi4X2eEybfbT+B1/KQdjwuT
 vhz103rJgR4X6lPaMOmsHD0YP5TC5iof19X53zR1rji5DzIOgSTyj4dXMqy9lZcnfOoMMj++D
 kvi54/9bSv9bNSRmdJLoureyES0=
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 43756e347f21 ("scripts/kernel-doc: Add support for named variable
macro arguments") improved how named variable macro arguments are
handled, and changed how they are documented in kerneldoc comments
from "@param...", to "@param", deprecating the old syntax.

All users of the old syntax have since been converted, so this commit
finally removes support for it.

The output of "make htmldocs" is the same with and without this commit.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 scripts/kernel-doc | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 54b0893cae666..5cf38abdaf9da 100755
=2D-- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -2079,17 +2079,6 @@ sub process_name($$) {
 sub process_body($$) {
     my $file =3D shift;

-    # Until all named variable macro parameters are
-    # documented using the bare name (`x`) rather than with
-    # dots (`x...`), strip the dots:
-    if ($section =3D~ /\w\.\.\.$/) {
-	$section =3D~ s/\.\.\.$//;
-
-	if ($verbose) {
-	    emit_warning("${file}:$.", "Variable macro arguments should be docum=
ented without dots\n");
-	}
-    }
-
     if ($state =3D=3D STATE_BODY_WITH_BLANK_LINE && /^\s*\*\s?\S/) {
 	dump_section($file, $section, $contents);
 	$section =3D $section_default;
=2D-
2.39.0

