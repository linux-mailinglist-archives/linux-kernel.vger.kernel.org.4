Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4E86C323F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjCUNEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 09:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjCUNEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:04:22 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBFF1448B;
        Tue, 21 Mar 2023 06:04:21 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 9AD47604FA;
        Tue, 21 Mar 2023 14:04:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1679403858; bh=H9dW8BLdpWjGQBRVTnsMabnfla3sgknX41PsonFtjmY=;
        h=Date:To:Cc:From:Subject:From;
        b=RMk3tUC3k3IoIq3gpXDOrMo0E3xMyrR6SHEuXoW7PJOCxXYoZ+FrtbacNuXna+YHz
         kbOBSXo+Lty3p+k30gJujtEHV0fLFa75AljBrq2dvHvVJykLTUqtDfHJG0aaF9XvY2
         vdwYd1HQukLE9FFlym8ZgI0hAQUYc2QDMROWbTi8MKPlp4U0abA8XOHm6VXnQfJ2gr
         bPISyHaUYU2V8+oPqXnuGonXfUry2XGnUkeshr/yxASJAMpbxovSBHpNH3tFywYo1l
         SiEyWSLMBohIecK0M0hGLVTuUfXNsilHkO9tuRXQs8uWUBR4UTqDZ8eaLd3jIMWYg2
         kZapuRaNURN8Q==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dssJpjvpWZxK; Tue, 21 Mar 2023 14:04:16 +0100 (CET)
Received: from [10.0.1.103] (grf-nat.grf.hr [161.53.83.23])
        by domac.alu.hr (Postfix) with ESMTPSA id 573FF604F0;
        Tue, 21 Mar 2023 14:04:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1679403856; bh=H9dW8BLdpWjGQBRVTnsMabnfla3sgknX41PsonFtjmY=;
        h=Date:To:Cc:From:Subject:From;
        b=UHqB5tdnDzvLOSWFpwduXZBPQV6RHKjSAEeVUbiXl9TLJA5XDlI1HpftsHTORHlxZ
         Gff6QJ3UVLCRqE+/ISt5WCeL+eXk775rUb5t+ckhyOzf9BzdvrPl6vUICgmGMijig7
         hWNST8bfHfE75UlCZgKBA8dDe0hrgo+qKLhfcAqkIQAcrly9LrbI5/EIescv2dtEo0
         MRv3qdImzxsONVuHqDYKZ6WtqovcLlyPu4p2jgwxzlQbazAczSbi6pDdioQ1q0hWMC
         3QRC6vxYI2BhXjcaTNIGqjjM50KcMT8PQhbQRso3S4zs00Y55+h6ro4OtT0ZxuD/qF
         8J7J1xRI/4HRw==
Message-ID: <17ab5a21-5512-5388-f9fa-c462b2ebd351@alu.unizg.hr>
Date:   Tue, 21 Mar 2023 14:04:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: BUG: scripts/kconfig/merge_config.sh: typo in variable name
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

There is a typo in variable name in scripts/kconfig/merge_config.sh, with the
script returning:

$ ./scripts/kconfig/merge_config.sh -y -m ../.config tools/testing/selftests/net/config
./scripts/kconfig/merge_config.sh: 148: ./scripts/kconfig/merge_config.sh: Previous: not found

Problem is probably best explained by this diff:

---
diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_config.sh
index 32620de473ad..902eb429b9db 100755
--- a/scripts/kconfig/merge_config.sh
+++ b/scripts/kconfig/merge_config.sh
@@ -145,7 +145,7 @@ for ORIG_MERGE_FILE in $MERGE_LIST ; do
                 NEW_VAL=$(grep -w $CFG $MERGE_FILE)
                 BUILTIN_FLAG=false
                 if [ "$BUILTIN" = "true" ] && [ "${NEW_VAL#CONFIG_*=}" = "m" ] && [ "${PREV_VAL#CONFIG_*=}" = "y" ]; then
-                       ${WARNOVVERIDE} Previous  value: $PREV_VAL
+                       ${WARNOVERRIDE} Previous  value: $PREV_VAL
                         ${WARNOVERRIDE} New value:       $NEW_VAL
                         ${WARNOVERRIDE} -y passed, will not demote y to m
                         ${WARNOVERRIDE}

Hope this helps.

Best regards,
Mirsad

-- 
Mirsad Todorovac
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb
Republic of Croatia, the European Union

Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
