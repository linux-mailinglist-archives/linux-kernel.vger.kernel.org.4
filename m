Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748F06C456B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjCVIyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjCVIyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:54:21 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2A61E1E0;
        Wed, 22 Mar 2023 01:54:16 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 5B831604EF;
        Wed, 22 Mar 2023 09:54:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1679475254; bh=VfhdcFBWULfAZ/qwiEOseRLcXnbwsFd18Pjz+M3TCc8=;
        h=From:To:Cc:Subject:Date:From;
        b=wkMOGi/00s79rq50fdK+Z6Qih1FbK2y0Vxe502O3thuSZtl1DbULKIgrBLKJPFUUv
         noFnI6xTAEw6YjgiLAE22/E+6uiXBs6Q0+PF4B9wXdkJPViDVwgsILDGaa4E0x3MjJ
         D7jggWx4LYrid8jUWnG+LZS5opEm2W2+91aYtUC1TNWPb3pPZCunLGh476wJ6VCBZm
         VGhpv5WEuQPBipK9Bkfc/ORCycwJB05WFdRpukajhsCDIKMMducqrVThgdx6b6m/uF
         xU2LyPCVaaiw+TAggoTHqeIZLejl58bwA+kqiPEAnt6dsY1xmIohv8v2qct0dkrxAG
         Vq7PjHMIZ5U1Q==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id K7iL_P7vZHDk; Wed, 22 Mar 2023 09:54:12 +0100 (CET)
Received: by domac.alu.hr (Postfix, from userid 1014)
        id 57243604F0; Wed, 22 Mar 2023 09:54:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1679475252; bh=VfhdcFBWULfAZ/qwiEOseRLcXnbwsFd18Pjz+M3TCc8=;
        h=From:To:Cc:Subject:Date:From;
        b=tKOS93bNP5HI87T8Wl/lzJgcI2FKmdYw+dtcakVNUscnLkmtt6Lfe1Sy5itZNFoWE
         xHnUoXY3fK2rvCYi8Yn5zrraEpuIvLpdMnKmbPhcVYmH8ormjoYsYb7OrqxEe0QrXG
         JAi5WbVdeSqKTDB/e+GOUusyXqMynpo/y9VZaFA+kUqeIZKY68h1DUk5MXQl0CueGu
         0PSoafhdzSiu792QjIrVi0AKGnyHEH71Xads3xCXDAdCYibDmxAUs+r+xUvjwStjHj
         y0ZL3+YVFbtRN+Eld4OvYUxCNlC7HJDJ41yDS23dvb8minAqSQSX/rzP1wq0eHwLoB
         +P5ERdSJZI/yg==
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Mark Brown <broonie@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: [PATCH v1 1/1] scripts: merge_config: Fix typo in variable name.
Date:   Wed, 22 Mar 2023 09:51:07 +0100
Message-Id: <20230322085106.16629-1-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

${WARNOVERRIDE} was misspelled as ${WARNOVVERIDE}, which caused a shell
syntax error in certain paths of the script execution.

Cc: Mark Brown <broonie@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-of-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
---
 scripts/kconfig/merge_config.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_config.sh
index 32620de473ad..902eb429b9db 100755
--- a/scripts/kconfig/merge_config.sh
+++ b/scripts/kconfig/merge_config.sh
@@ -145,7 +145,7 @@ for ORIG_MERGE_FILE in $MERGE_LIST ; do
 		NEW_VAL=$(grep -w $CFG $MERGE_FILE)
 		BUILTIN_FLAG=false
 		if [ "$BUILTIN" = "true" ] && [ "${NEW_VAL#CONFIG_*=}" = "m" ] && [ "${PREV_VAL#CONFIG_*=}" = "y" ]; then
-			${WARNOVVERIDE} Previous  value: $PREV_VAL
+			${WARNOVERRIDE} Previous  value: $PREV_VAL
 			${WARNOVERRIDE} New value:       $NEW_VAL
 			${WARNOVERRIDE} -y passed, will not demote y to m
 			${WARNOVERRIDE}
-- 
2.30.2

