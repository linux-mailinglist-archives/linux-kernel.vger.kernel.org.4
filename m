Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EA87060C5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjEQHH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEQHH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:07:57 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85981110
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:07:55 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-253340db64fso538051a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:07:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684307274; x=1686899274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1S6C7UJ7C3ix2ULoyU4X3+nn65qw+zwXqYKGbJZ+jiw=;
        b=Uck3ixr64YNoZ/WBP8hRahmhLdk8aY+Ztc4Sz3AKUfx/UWQKYfEnj365uX8ySuCviR
         t8RfpZPkpaYkLlMNG7cOsRcyKxp42DUVQVYlGLh+Rk4VSd/94p3qwZ37CgVpTN4eN9zI
         zB5SGAYiiFb5tDVdFjMAFPM/8SAKSwvyXJkXhR3totI3yzdZKOccb24q9Oh/panN3aeF
         8xQh1UvF5Jbebl3PBpuGL/bZoOFanek2tKutP7FkZYENJVHo0/AMFLpC8Xfhed2L2gkW
         gybWyaJVKTj/LjNDxHK+vZ0lRW/EWzK1kdusmEIxGeXGtCfpzmQI71llluq/ukYAyjCw
         95LQ==
X-Gm-Message-State: AC+VfDzDfdP8uY2CHSwM6jSY4R32DYK2+OUotwm1/oejxtPr95aV/ULr
        45EmZdpQ8Zxmy4sfQe/I2PTmMZZoOTA=
X-Google-Smtp-Source: ACHHUZ7gP4FtZbfRxqTkCnO5n8lbjXiUTmJTIRTbYCJ/FEuD+M+noeodyusKmCzm8156hBUdG2qUPQ==
X-Received: by 2002:a17:90a:9292:b0:253:2995:f4a6 with SMTP id n18-20020a17090a929200b002532995f4a6mr4325551pjo.38.1684307274455;
        Wed, 17 May 2023 00:07:54 -0700 (PDT)
Received: from localhost.localdomain ([211.49.23.9])
        by smtp.gmail.com with ESMTPSA id nl9-20020a17090b384900b0024e2230fdafsm790962pjb.54.2023.05.17.00.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 00:07:54 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     brauner@kernel.org
Cc:     anton@tuxera.com, linux-ntfs-dev@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, bagasdotme@gmail.com,
        akpm@linux-foundation.org, Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v2] ntfs: Add myself as a reviewer
Date:   Wed, 17 May 2023 16:07:39 +0900
Message-Id: <20230517070739.6505-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm volunteering to help review patches for current unmaintained
ntfs filesytem.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e2fd64c2ebdc..c2cecb2059d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14928,6 +14928,7 @@ F:	drivers/ntb/hw/intel/
 
 NTFS FILESYSTEM
 M:	Anton Altaparmakov <anton@tuxera.com>
+R:	Namjae Jeon <linkinjeon@kernel.org>
 L:	linux-ntfs-dev@lists.sourceforge.net
 S:	Supported
 W:	http://www.tuxera.com/
-- 
2.25.1

