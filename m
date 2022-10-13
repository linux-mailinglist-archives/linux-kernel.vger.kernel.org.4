Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603455FE47C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiJMVul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiJMVtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:49:45 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7D48E7BA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:24 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id fw14so3182037pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=r9cxOWkaLwUeQEmdWZ6Osr4NdnwOIIR/+4k5UxCClaI=;
        b=mUNW9Hfwh4r9woIBVDSSKaH3GH7eLruLt0mUoX+0umhaCeMBEchty3s5SRxRhZ0Jxo
         2SEE3FdEVA/70VHeJjpWvo5wjQU22J2kTkN03OqqcQDOE1to1VOv5TirFffyuMQCfK+U
         +RZcMNJbwmMzmYlEXJ6VdIfdmnaKFMiai7MBikl8BiqGTQUUX1wFoO9dmwH1RwZI/nL9
         bpBeNo7D2z1tEr8bA6OQnwho5PaLrOabqyP+zK9/kf3lXHO4Gx7kLBX6dBjUlNxRfkZQ
         41YOfqL4H6IIYqZkugr8FncEta/fPAsCwsy89/iAJQNdtZNKMmqiOehDf8jip+bKKwVq
         Bk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r9cxOWkaLwUeQEmdWZ6Osr4NdnwOIIR/+4k5UxCClaI=;
        b=mN4ew8VuwORw5UTptNcj1EyEAl+SKuvvQ0vJ3OhnNdfl6uOF/q2YNez5P2MJoZoQK9
         bgZ3mjuFZ4Tzvgm2y9bzPkX/AzxwlzBzmyLPTvSqBei9BL7mpZS58CI9Lf0J/CO2omiu
         +LkTJWqbY99OQIszI8pbs5mzJsEpHzlfaU9ljKCeED87GDkSsvZI97gk5C6eHIwz2Mbf
         1DMzJaFV5LGXVRk9XVVvLrXVR0I3TylU8tYE+ruFaHCjOJiVN1U0iBIOlY/5Mj2zkFEy
         XZD6+wMwuSPZ7ZpRD8vTj2u6MmqbyFRzJ5tAWVBu21Bh96iCODdxMXmz3fb9Trqffepy
         MI/A==
X-Gm-Message-State: ACrzQf1/X6E+VX3r4GmYBfccNEX5aBugk1e3Dmn0HfMBcUj2l4br6Hhl
        ULuD84ieTg2ui/K/A1KADIwt+ufNok6z/PW6
X-Google-Smtp-Source: AMsMyM49Xf5GbaXV9Mm4DB30QskT8F4+V++emnoaOgpXk9wy9meoGe0wpSTQ4m0Q5+hM7WJJGk5+4g==
X-Received: by 2002:a17:902:724b:b0:183:16f:fae4 with SMTP id c11-20020a170902724b00b00183016ffae4mr2043797pll.88.1665697756603;
        Thu, 13 Oct 2022 14:49:16 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id a24-20020aa795b8000000b005627b3788b8sm153264pfk.181.2022.10.13.14.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 14:49:16 -0700 (PDT)
Subject: [PATCH] MAINTAINERS: git://github -> https://github.com for patjak
Date:   Thu, 13 Oct 2022 14:46:39 -0700
Message-Id: <20221013214639.31034-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:        linux-kernel@vger.kernel.org,
           Palmer Dabbelt <palmer@rivosinc.com>,
           Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     patrik.r.jakobsson@gmail.com, dri-devel@lists.freedesktop.org
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
index 8da92ff58b9d..22a9acc7be07 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6865,7 +6865,7 @@ DRM DRIVERS FOR GMA500 (Poulsbo, Moorestown and derivative chipsets)
 M:	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
-T:	git git://github.com/patjak/drm-gma500
+T:	git https://github.com/patjak/drm-gma500
 F:	drivers/gpu/drm/gma500/
 
 DRM DRIVERS FOR HISILICON
-- 
2.38.0

