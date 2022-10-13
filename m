Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417C95FE46C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiJMVtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiJMVtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:49:13 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602A236BC2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:05 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id p3-20020a17090a284300b0020a85fa3ffcso6129621pjf.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=RgNk1ETBPOa9yz0k9jyUF6Cc6gSoPtgdmCE8/BS2378=;
        b=sj++0I0kbSN7WpQQYBu55qv2g26Mf6lkRPeIJSJ5m+h6QyDVUvvt0GzpmGHOe6NFWn
         LPdJAazcHO0/u+ukM61Dkhe9jQxwy/XHYjoQ0Glg+ZEE9iFytLr0HDG5sk0EvQ3zZnNJ
         v6Y+t9gGqiUlgjuyIkfTmDUvY+YvFX42RjfPnK3WwfQfmorcTvXocBPzhZtbrLBm1qg9
         dcHpyqwkZsfURN2LpVzZydDywPWchgun4J8Fuv7JLMt4EI/EqnvGgp3O7Xaiq5wejz8O
         rtajYTBvV+KmKM8a7oMLpffkR7dcKvUDUXg9wjUHiQBcThkVey5z7ot43mtsQ0MarxRU
         S4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RgNk1ETBPOa9yz0k9jyUF6Cc6gSoPtgdmCE8/BS2378=;
        b=b5RmnVYKq4Qn+zJAa3j7QGLQcXpyx4mcYzlWuu63hCJaCWlmtT3efN2ZAwHteFpd9F
         2Hf/qOmA2U0KJ+agYWz26PMdfJsUC67buSoGeP/dmfP3viEW9jrnRn9Kh+E3Yu5zr/8n
         t3bpPIKmopJZdxg/S40MpvCt+sJxJbxoUjlg8o8e4sKq72XJVW/ldv+nm/nanECzGua4
         3CwCk9fHCqerD0wSa8SxNN5MNGUeYO2wEurOlCm/TcxtvsjekzPtlY/Tfdo4qNlYNWrv
         FhisTF7Z8AMJHK9hkGrQ+sCeM2DbpOjnZHOXOCuy9e8KOfQhURFNpQML9Fc9CZwwXvhJ
         souw==
X-Gm-Message-State: ACrzQf3SF+PQ/BCpc4s+Lzmt1lSBPMdlqtxEngeOUqlshNs8ubPuQfLE
        Y/0QLOrlcrDZ4ywYGSsxHl6nbi4fEeRO4L7z
X-Google-Smtp-Source: AMsMyM70aA5zNtl3QFmiuuOzeNJFe8y6YAT0notYjMhEh0rpERQI+H1wvkfePIekznZyV6Azj6/7yg==
X-Received: by 2002:a17:903:234f:b0:17f:6711:1f9f with SMTP id c15-20020a170903234f00b0017f67111f9fmr1784352plh.32.1665697744099;
        Thu, 13 Oct 2022 14:49:04 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902dacd00b00176a715653dsm306193plx.145.2022.10.13.14.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 14:49:03 -0700 (PDT)
Subject: [PATCH] MAINTAINERS: git://github -> https://github.com for hzhuang1, rjarzmik
Date:   Thu, 13 Oct 2022 14:46:37 -0700
Message-Id: <20221013214637.30853-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:        linux-kernel@vger.kernel.org,
           Palmer Dabbelt <palmer@rivosinc.com>,
           Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, linux-arm-kernel@lists.infradead.org
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
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7b5e1953b718..4a028f494fb0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16585,8 +16585,8 @@ M:	Haojian Zhuang <haojian.zhuang@gmail.com>
 M:	Robert Jarzmik <robert.jarzmik@free.fr>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-T:	git git://github.com/hzhuang1/linux.git
-T:	git git://github.com/rjarzmik/linux.git
+T:	git https://github.com/hzhuang1/linux.git
+T:	git https://github.com/rjarzmik/linux.git
 F:	arch/arm/boot/dts/pxa*
 F:	arch/arm/mach-pxa/
 F:	drivers/dma/pxa*
-- 
2.38.0

