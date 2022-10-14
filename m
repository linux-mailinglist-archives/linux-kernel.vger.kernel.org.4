Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D89F5FE663
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 02:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJNAmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 20:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJNAmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 20:42:19 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FC11A20B3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 17:42:17 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id l4so3306856plb.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 17:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RZ9Odp9syNPbwC22Wi+SygyyKEt4gF3XO1cVxBF/O4w=;
        b=C1XvBNyCYqLXWpDkFNrLmIaRadIHMr1HbFkoLGikscFTKaTCEEE6OmwFxTz0A2dpIv
         PZv3m0MnIsEE6MNUNzAFiUjeFSkYfB1FR4VOJ92m/0rRipYBUFQoSncsq3Qzq6fJP4gy
         HwR0g9U7LkKNj5Alk5u4Srk2k7lXPGlsyp/nH2cypFb6C9QSnReegH+CFvVh16KzohUa
         rakDx2zaeKjYeRjLshawTNC7Gcby20p7YkwYIIReo5dn3R5MAFdqHXnIM+FewWeTMsxR
         CkR9K8S5Y5YEHkLiLTqGFbSx/WBB8KKAvN0FVVkDjt4fkMAhY6hePp3VpH7fqfBsq2k8
         2asA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RZ9Odp9syNPbwC22Wi+SygyyKEt4gF3XO1cVxBF/O4w=;
        b=mJr51BBob4jiOVkFGVWjDKWem9E79EwXTjoB6y1XhtKAa4xtQDOmd5YM23LJIjvVrF
         aTqK3p+gZOFZ4uaihd9yDlM87VlSlwNmZk6csTQh3oYPBrkoU5O1WwNId3ZOmSyoe+/X
         hjbSO+QjmebvT7GFefwhJDsuRtUMN31p3pCh8af/+nTX8PxowykuCCAC9ksEgl5xxh9q
         odbbVTsmWefRCwkEe8rRN8OS21/seL+Zmor0NGTHGcng/yoo2mxvAslxNdwusF4P9tRj
         KAwzyqjzpZu7xDX1bQG8ky0PBh6kp4tAHYNG+hFS6L086GYZSkcFCmF3MRyo0YRnG/1R
         x2Zg==
X-Gm-Message-State: ACrzQf3fetYSPcrGtZ1Vv4/Mi25TO7Y4dKuyOKO1o7+l28I2AbJ8SrOC
        DhiPoCKl5oir/PJG2Tb7rn1BuF2gmA4=
X-Google-Smtp-Source: AMsMyM6d1SBkiU7m5RX1Mz+tQm3FpDVnGXTC2xRSU1ZD+dd6FakN4QRc8I+mpfLRRbYO3hGIkh6egw==
X-Received: by 2002:a17:90a:e7c8:b0:20d:6c60:c38 with SMTP id kb8-20020a17090ae7c800b0020d6c600c38mr2759559pjb.26.1665708136716;
        Thu, 13 Oct 2022 17:42:16 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:9d46:4d21:46d:8e9])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902da8500b00177f32b1a32sm390156plx.271.2022.10.13.17.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 17:42:15 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH] MAINTAINERS: update the 'T:' entry for xtensa
Date:   Thu, 13 Oct 2022 17:41:50 -0700
Message-Id: <20221014004150.2470359-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All development activity for xtensa architecture have been routed
through the github.com/jcmvbkbc/linux-xtensa tree for the last few
years. Update the 'T:' entry in the MAINTAINERS file to reflect that.

Github deprecated the git:// links about a year ago, so let's move to
the https:// URLs instead.

Reported-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 72b9654f764c..98cf4476d135 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20097,7 +20097,7 @@ M:	Chris Zankel <chris@zankel.net>
 M:	Max Filippov <jcmvbkbc@gmail.com>
 L:	linux-xtensa@linux-xtensa.org
 S:	Maintained
-T:	git git://github.com/czankel/xtensa-linux.git
+T:	git https://github.com/jcmvbkbc/linux-xtensa.git
 F:	arch/xtensa/
 F:	drivers/irqchip/irq-xtensa-*
 
-- 
2.30.2

