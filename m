Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7829605597
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 04:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiJTCnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 22:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiJTCnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 22:43:02 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129BF193741;
        Wed, 19 Oct 2022 19:43:01 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y1so19012544pfr.3;
        Wed, 19 Oct 2022 19:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HdycwA4FR5vNtX+7nFM1KQuIbhzsWKkIyNCEoTxZqj4=;
        b=WoV/wKOqLYiqQq1ulcH8t/cuwosFM5L9AWFxS+1A/2aZHrK0wSvKRwtntvRSgCCitU
         iLX423YiB7fSNb3qLYBsKlCp2c+pCm0Ien021Fs2GCpM0Gq/VjFF8qKOe7fkDQChESs1
         gmlyTyuQBttLFj63/rf/Zt8RxErSlp7uhSMXARmVs+7YWwcjmMF1P3idXFNpBBJXyIx6
         u4HLoaM5bp8TMjANqMdsy6G9yCjVF2+sSsFp8AUo64nftOQ1xFt3BD7HicUV1Rdns5rc
         rFkzEC8hlpQLLH5/XP0B/YA/ydf2bbKF4MG8ZL7ewEBTnIdOd9IPGoN1+bukQAsh0cZS
         vuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HdycwA4FR5vNtX+7nFM1KQuIbhzsWKkIyNCEoTxZqj4=;
        b=wupPXFBulGyDr1usj+kv5zFZS1deG2FeCq3NgaRRItIqUy+Fan0R4iRFrDSNhnmdtY
         p++zUDPLwrByVis5buizJNwfjEWlKiAqOdyz1maLrRviSRlYJQ3GgnVFYU0V5aZZ7dm0
         ICP4Lt75y2nThrAVtbFHr10wd/SWoMTX80TtDN30Di/q5gkbZSspuCOe+WSgfvZUjfMd
         9rGy2XhYLG5ZTJdM2/uiztLAqXAvVw8qDpeZSMRNnVo7UVbVxwdUYiYvP+o5ERFk2+fA
         RcEyEyrb3EcDaktwWlUdyj1ygPHZoNwJsr7GtWXdjPhYr6KcNxOzrUF+A8lSmbJR+2rv
         a8oQ==
X-Gm-Message-State: ACrzQf2avj4rwjpTH2jYgTYeLsA7W+pPezpFvhaBF1Lwm2sxuShMCk79
        Ru4QMWNn3AxrRtNGPi8DuoEc3cWUCcE=
X-Google-Smtp-Source: AMsMyM4Qjye2YdXz9uR9CmaBtlMnavuQS2qTpRq4bLpPBIjQkV+e/vwHXkmRdORkxY1JqZtga5umbw==
X-Received: by 2002:a65:5801:0:b0:45d:bbd8:e872 with SMTP id g1-20020a655801000000b0045dbbd8e872mr9520474pgr.343.1666233779853;
        Wed, 19 Oct 2022 19:42:59 -0700 (PDT)
Received: from carrot.. (i220-108-44-211.s42.a014.ap.plala.or.jp. [220.108.44.211])
        by smtp.gmail.com with ESMTPSA id s5-20020a625e05000000b005631f2b9ba2sm12330626pfb.14.2022.10.19.19.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 19:42:58 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] MAINTAINERS: git://github.com -> https://github.com for nilfs2
Date:   Thu, 20 Oct 2022 11:42:55 +0900
Message-Id: <20221020024255.5000-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

Github deprecated the git:// links about a year ago, so let's move to
the https:// URLs instead.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Reported-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
Link: https://lkml.kernel.org/r/20221013214638.30933-1-palmer@rivosinc.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
Please queue this like other similar fixes.

Thanks,
Ryusuke Konishi

MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ca063a504026..c3382e7e89ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14524,7 +14524,7 @@ L:	linux-nilfs@vger.kernel.org
 S:	Supported
 W:	https://nilfs.sourceforge.io/
 W:	https://nilfs.osdn.jp/
-T:	git git://github.com/konis/nilfs2.git
+T:	git https://github.com/konis/nilfs2.git
 F:	Documentation/filesystems/nilfs2.rst
 F:	fs/nilfs2/
 F:	include/trace/events/nilfs2.h
-- 
2.34.1

