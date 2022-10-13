Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFF45FE476
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiJMVuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiJMVtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:49:39 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AD4196B52
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:27 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id t12-20020a17090a3b4c00b0020b04251529so3043744pjf.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=5bR1+Yht9xfXRax4RMKm05njPea5UZM8O/UPeLVANHM=;
        b=ZxsUXrpBugGUYQN9PX7iF7vv1w2rWXtaWVxqs2o3LcV5dlejQE2JdDSDJAanWg2VUx
         nm/NE1vRbN9j0vWfsCiRNC4DhNwhFvOsUnSDW/lt0hrVAcAG0vnJzHMtb8TZAEwJUicJ
         AD6TVm8H9WMQ8c/rtv1+TDsgXcpa7qc8duAqhq6wx7xizxjRwo2HXri3IID1oMQeyJHp
         yINVMRGIN0YZynvw/bF0ZjC0Yd20wC99pUSndXoABnG5DqE+b8MGYObzI9YUMBthCnZf
         eCoLeENLgsTu7P9sOWMgl1N4wZXosgaE8D4WKQ1ntgqhB4YLzQFRWLauNIgAkDAtfpMV
         SvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5bR1+Yht9xfXRax4RMKm05njPea5UZM8O/UPeLVANHM=;
        b=A01CrFUmXq8a1x6kE5U/zE0N7SzSciwFXslV7Yao7GqvNlgrum7S9qOY7ZoeYOYDmQ
         7TC6GtybAPLrnFAY8tw4RjjfKbXPmVKMEn9OfiJWarFrJ+7lDPRWMDpxd0oGKkOlDn/c
         7NCoeOevT57s9usM4enNQ7PXOJveVq/wQ0y8HUSyjd3JKHIDVjUoK30ht/4bNaViHaQq
         lLt68FX3S0JAX5G3pzkA60fi6ZjpMUeqs+lrlkVBJalAPeTamUiPpPFp5rYGvIccEz2E
         tsIlYe1XqgMS+/6/7bQceL3cyML6E1+S/ZutIssl+ShEc9gULUFzHy/euknHtPzzkFmv
         E8+g==
X-Gm-Message-State: ACrzQf2oN3DJFIxwsC3ezf2kyEiVfEnkGSxTxlrqoQnHi3VQsXtfg7+O
        4v2cmFBhXzyUrvLQBmIruwP6UKmJb25BxT4F
X-Google-Smtp-Source: AMsMyM5oq3YvloaagzWejL5pEIb832BNIunnnA8YBFM/2xwuJXQO0BkKwVTC9VVntne1VEMjsoxwYw==
X-Received: by 2002:a17:902:8c92:b0:178:29d4:600f with SMTP id t18-20020a1709028c9200b0017829d4600fmr2038603plo.40.1665697766443;
        Thu, 13 Oct 2022 14:49:26 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id c185-20020a621cc2000000b00561e8bbfa3dsm174332pfc.98.2022.10.13.14.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 14:49:25 -0700 (PDT)
Subject: [PATCH] MAINTAINERS: git://github -> https://github.com for hisilicon
Date:   Thu, 13 Oct 2022 14:46:40 -0700
Message-Id: <20221013214640.31194-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:        linux-kernel@vger.kernel.org,
           Palmer Dabbelt <palmer@rivosinc.com>,
           Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     xuwei5@hisilicon.com, linux-arm-kernel@lists.infradead.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Github deprecated the git:// links about a year ago, so let's move to
the https:// URLs instead.

Reported-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
I've split these up by github username so folks can take them
independently, as some of these repos have been renamed at github and
thus need more than just a sed to fix them.
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cb5edaad8dbf..6f79bdb4ee70 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2158,7 +2158,7 @@ M:	Wei Xu <xuwei5@hisilicon.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 W:	http://www.hisilicon.com
-T:	git git://github.com/hisilicon/linux-hisi.git
+T:	git https://github.com/hisilicon/linux-hisi.git
 F:	arch/arm/boot/dts/hi3*
 F:	arch/arm/boot/dts/hip*
 F:	arch/arm/boot/dts/hisi*
-- 
2.38.0

