Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB165BF4F0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 05:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiIUDsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 23:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiIUDsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 23:48:09 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219EB7C1FA;
        Tue, 20 Sep 2022 20:48:08 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id h188so4649584pgc.12;
        Tue, 20 Sep 2022 20:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=2WkMhi2PBahvt2cU0dj162qjUJrLStIdvT7p6uWkrUE=;
        b=Z0zXDBvXjBVpJoMipaRL9hM4+ogpJ+Ip+xjgKON4ZlKP2lSqrp4XUSxbeTth0j4mLw
         obChTqq4ri2e5Ky14XJouoxJEbdAzcApTRuWpgD+iNT14nVLGlodnd9AIklapmZXNoSg
         51C4eMOunjZhc574m7YREX/CTe1JeM2Nbn9cCnio77/KkqUC/kUdO3EE9hPGj07IU6wy
         2c1SZePZ56gIo4A+Vhe0ppq9QmrlK4jYDp2WEblxhc0aUKUetkxiNTZawIJmtYCVJPto
         ljFX0L5Fre+AfgTFViHiRduLmhfM8jp5KnRMVq/lnjTCV/2n24eW5hv9YttQBBqt6fOn
         hoxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=2WkMhi2PBahvt2cU0dj162qjUJrLStIdvT7p6uWkrUE=;
        b=n4vGqWAcNnN+O+KFp+03IgSbzGxJWP3LeW1x/MfrC04GQaycVMeJD7BVOhwwvwWUZv
         azw2l1+pEcga22cxMB1ENKJWEbVIJD31K86BRidekAgJWWC9Vz3/49mxOl4AmOHzvtWv
         jtrXkKVNVYNAU9yQZYREN17gWjv/OvH0cn59UbhbOPsNCNcRqISqzmmNGOF58ZbQWFZw
         rQ/Rhqasu98B9G7bB9cCgpIVFwSxFJvE7XzqKeujHpcz+1uNvjrQSXgPPUxO1waddNyF
         JtL+QBPCp/jPWdXalUkU3tYzoLs4uu5/7hhdGZIXNwAXdfJGciSiHFPHc3vUq2LJL/xt
         y2zg==
X-Gm-Message-State: ACrzQf25lCGJ5EagkLXTPEVP9D92CR7eaSo+n4Jgzy5w/W3RIZWpuAmL
        56WElOaC/miJmUAqQHcb97KMzTErVso=
X-Google-Smtp-Source: AMsMyM6Bp5zAGM3JgAYoajfa3/r96VTHm9fA/edH/jgWLlF6d4DHd2nVLO557tODnaQ5PZeBN6LmMw==
X-Received: by 2002:a05:6a00:170b:b0:547:3e11:914f with SMTP id h11-20020a056a00170b00b005473e11914fmr26594834pfc.34.1663732087464;
        Tue, 20 Sep 2022 20:48:07 -0700 (PDT)
Received: from carrot.. (i118-19-12-172.s42.a014.ap.plala.or.jp. [118.19.12.172])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902e54a00b00176ca74c58bsm686016plf.245.2022.09.20.20.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 20:48:06 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] nilfs2 minor amendments
Date:   Wed, 21 Sep 2022 12:48:01 +0900
Message-Id: <20220921034803.2476-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

Hi Andrew,

please queue the following changes for the next merge window.
Both are minor coding-level fixes by users of a robot reporter.

Minghao Chi (1):
  nilfs2: delete unnecessary checks before brelse()

ye xingchen (1):
  nilfs2: Remove the unneeded result variable


Thanks,
Ryusuke Konishi
--
 fs/nilfs2/btree.c   | 6 ++----
 fs/nilfs2/segment.c | 4 +---
 2 files changed, 3 insertions(+), 7 deletions(-)

-- 
2.34.1

