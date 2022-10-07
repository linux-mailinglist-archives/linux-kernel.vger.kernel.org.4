Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1065F7E98
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 22:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiJGUT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 16:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiJGUTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 16:19:48 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DDC6438;
        Fri,  7 Oct 2022 13:19:42 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id t4so3516965wmj.5;
        Fri, 07 Oct 2022 13:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dXdIo0hRN02ZPJAwNm3u1mGY1VCoQSfJnTxD1fX9Jng=;
        b=f4Dhz3KLnMyG1se0ROB0KLgh/z01THj8Db76AcdmjTnC2uK4IxwijDA+rhdQlvWrFo
         as2soL2VbAqCJACX/OIdD3SJGs56K3UHlbZGHvlgj9KIXkrO1marHERh0EocA2AUfV+w
         JCjmtbQ4n42G8Y1ep2nhz/wZHf/X0vXMFGwTDmt6z1WajH3TjboaHhi04qyIx+hUxP58
         zeocfn0T4TgS/fqrThbDUPC/yYPKzlu9DmxvYjP6CHK6f4gA6DP/oBv/LbN9k9xQKf4n
         eLm4xTyfhdeNtKdq2w3+USV2pr+qcqW3yTduNEguZ2eeA6BxecATQ7zQ5AB6RTmJrG2p
         A91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dXdIo0hRN02ZPJAwNm3u1mGY1VCoQSfJnTxD1fX9Jng=;
        b=U9J/oB28Qgci4Qwep790DHyIM6cz7PSOeXdDuP6/rX3sKpNKp+9G9gvuWLRmH44t7L
         ooH//0iZLae7uBXKjVofIctzwr54HkPBXSsPjVzqL3sdhi9ZWgHi7RWFPCaRFcvd2Bsn
         xIvDPuXVP4Bjz2RDpbKciRF1g/k92moLKS08BYmoUK+K1xtrwnINuZLZE9BKaJqbY2Ct
         umkSAcpQw4DMaMXMDTvFIPpt9uhndIE3virSAcel6Tqra2RRHzLGvn8cwxjroqTBZGl4
         8fx5o6pIC74qKeC1r10h52jexxkpsiCQ9qLW4mfu97mhWAch8JCXYEiI9NUBQEeF+AaH
         WrpA==
X-Gm-Message-State: ACrzQf0sX2zLtJq7VC3Z9JR4FeUacu3hvPsZo1FcKRjWKJcDENm3WDBz
        uqJmzN8GAGQF1UclSVUkG2vhCQml6r1gY4Au
X-Google-Smtp-Source: AMsMyM42GLUq87Hjpke22vTC+iqQFCJd2ggf7uv2NyWFz9XDILyVkcOiMkcSbVw0aj92CgistYZpLw==
X-Received: by 2002:a1c:3847:0:b0:3c3:8082:a0 with SMTP id f68-20020a1c3847000000b003c3808200a0mr2653304wma.67.1665173981093;
        Fri, 07 Oct 2022 13:19:41 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id d16-20020adf9c90000000b0022dd3aab6bfsm2680205wre.57.2022.10.07.13.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 13:19:40 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: Kconfig: Fix spelling mistake "delibrately" -> "deliberately"
Date:   Fri,  7 Oct 2022 21:19:39 +0100
Message-Id: <20221007201939.2755407-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in a commented section. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 arch/loongarch/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 898263224bbc..903096bd87f8 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -171,7 +171,7 @@ config STACKTRACE_SUPPORT
 	bool
 	default y
 
-# MACH_LOONGSON32 and MACH_LOONGSON64 are delibrately carried over from the
+# MACH_LOONGSON32 and MACH_LOONGSON64 are deliberately carried over from the
 # MIPS Loongson code, to preserve Loongson-specific code paths in drivers that
 # are shared between architectures, and specifically expecting the symbols.
 config MACH_LOONGSON32
-- 
2.37.3

