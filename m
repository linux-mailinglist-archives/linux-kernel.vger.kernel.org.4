Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE236647FFF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 10:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiLIJQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 04:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiLIJQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 04:16:20 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB531B9C2;
        Fri,  9 Dec 2022 01:16:18 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id gh17so10064217ejb.6;
        Fri, 09 Dec 2022 01:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFKTxSskKkvNwPaluwiCksazhwpmGkKKYy4t6/+aZ2c=;
        b=epzyxHkp1surXXNxxf+GWa7hiZthLFue3Ia5s8TjtkbP/cgWI3x+PphCZEX+il/i3r
         G6u2PFhnEAeif/3Sznlt2N96aSdrD+NeTuT8rl56g/7xEyvuM21TwiDPz0J6ulxwWEu5
         mEsXKIvJ6SOdw1b8BavY5Zv8LedPzfN+z1kCsb93AHZXmE8ygQp8wyNjxYpB4wKEUpLF
         60w3WDoC6Pggee+euhLLMWQPGV6NIJdKfSKXY0y3BMUgx9wueT2nx6QZHL0c5DLYw0vV
         zR6n2hT2XdYB5YzAzoZPMqAI2CjuIYoa480s4LHavvobC9JaRVqhvQSzMQ/B5rgKrBZw
         N72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFKTxSskKkvNwPaluwiCksazhwpmGkKKYy4t6/+aZ2c=;
        b=CutY27cv1mMI2L+tunYCtiH4hdqbpR/oACyNKrj6HyS8N7KkSWQn+d6MnZqrljCLdO
         MBY/u+rei4uhCG1GKzFzE64/zNqCLDpxHOF0fUxsbc850wMnKFCYovik/UznKaTZPo8M
         1wcvX/glBhxlqQjR//xXnVGxtbbl5k3yKrCxijTmBlpADHMupnNcL0euuWsO38rDEdu8
         OR/VJrpCu4lj4HAvBUgWVtjM9hSNIucq51692J421gjq4Z+Msx9mtMZSk/zIyv7PK2OV
         4ZkIHP6oQH/1o1qPfpDRh5sTtKaOyCxJzYO45PxvTZv4MR1klDosf59qoNQNxo/tKXKp
         gxuQ==
X-Gm-Message-State: ANoB5pktXyt8dMMb0QtFhr1quwfngJmx6i9YazoGU1yTk31FbDj1LDAb
        hr9hsM8YUzqT66tbi/d+X8U=
X-Google-Smtp-Source: AA0mqf7OuGVGyXKcpxVk4I6erdRtNX4a2sFcYN4q8GjeOa83/tpjUDa+hHFYA5K58XISOngaQOPEDA==
X-Received: by 2002:a17:906:9f23:b0:7c1:1ad9:e5b0 with SMTP id fy35-20020a1709069f2300b007c11ad9e5b0mr4261790ejc.33.1670577376973;
        Fri, 09 Dec 2022 01:16:16 -0800 (PST)
Received: from felia.fritz.box (200116b826756500611a29889499a521.dip.versatel-1u1.de. [2001:16b8:2675:6500:611a:2988:9499:a521])
        by smtp.gmail.com with ESMTPSA id u17-20020a1709061db100b0079dbf06d558sm314354ejh.184.2022.12.09.01.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 01:16:16 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] scripts: headers_install.sh: remove left-over due to now gone pktcdvd shortcomings
Date:   Fri,  9 Dec 2022 10:15:54 +0100
Message-Id: <20221209091554.22403-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f40eb99897af ("pktcdvd: remove driver.") removes the pktcdvd driver,
including the config CDROM_PKTCDVD and CDROM_PKTCDVD_WCACHE, and the uapi
header file.

Remove some further unneeded left-over due to now gone pktcdvd shortcomings
in the headers_install.sh script.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 scripts/headers_install.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
index 4041881746ad..ad5930cab251 100755
--- a/scripts/headers_install.sh
+++ b/scripts/headers_install.sh
@@ -86,7 +86,6 @@ arch/x86/include/uapi/asm/mman.h:CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 include/uapi/linux/atmdev.h:CONFIG_COMPAT
 include/uapi/linux/eventpoll.h:CONFIG_PM_SLEEP
 include/uapi/linux/hw_breakpoint.h:CONFIG_HAVE_MIXED_BREAKPOINTS_REGS
-include/uapi/linux/pktcdvd.h:CONFIG_CDROM_PKTCDVD_WCACHE
 "
 
 for c in $configs
-- 
2.17.1

