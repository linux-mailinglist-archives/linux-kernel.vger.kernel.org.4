Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76215744D8D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 14:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjGBMPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 08:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjGBMO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 08:14:58 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEBC120
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 05:14:57 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-666e64e97e2so1865856b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 05:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688300097; x=1690892097;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DntoVejHzUbHw/NVUKBMPCnwyUmjZxJJvZNMunsjz2U=;
        b=TZ0auGwBpAA34z5ux4Ti1uCBf+dNqx1vvBq47z1hhYWQtFwFH6M5xKYRmFCgSkKhwF
         R/3cCHwkK4lbwe1K3Nm+4mi1p8U45QsjC7kSMiwh9u60KGr/PnZ5Lim3fNrdVDDDpFhC
         xzI09Feq19Xpx6f6lxSOGEKHeaih+WeBR5IappNLR+PNvBZXcKQIzJhLvasFO9v8a3aB
         YgKfpvHcWZE0aWlMVhyAkwgOjw0UG+hM4y/qGTfpeKj/II6oXr7bKlz10JhdmlDSIAhl
         gdJyNdzMKyLA3jnI/qImrgeQmrpOw80oIQ/TiFg7K+UTBHgfWiz6AqADNHIMSavQ5NFn
         sOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688300097; x=1690892097;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DntoVejHzUbHw/NVUKBMPCnwyUmjZxJJvZNMunsjz2U=;
        b=hwCAUdZ6fntDr70pE2d2elgsxy7rBTZpz858yL8LKKFDigrmbBFGnwFpTWk3O05L1P
         h7jrRSbtzjYeR8Bjr5/BMZCzznAbhPavQb0iEi1BVIxRBmCEPD9PQReL1ADbvSYlXSxE
         lhP2gboi4+XJdsvS4wtmwcVhKvB8gxdP0g9nVwHx+1YtFLeaVWZsTpsJUprER7U91XXL
         CxiSO9R1wteJJLv2NKPb7L9GST2sVT5vekau5x05wYRPTMI5gCtBX37JAiESK7Hd0cS5
         unKoJQUIQk+csNVntYSMCn6DBQy+wNysoX2lto2HdwxtDUWdytml1jd8Yazh9Khwc5GK
         SpzA==
X-Gm-Message-State: ABy/qLY2BBiKYs4web8rngya0PR4tEyrqDrH2OQesGRKcBFaQonCkh3v
        JNkSCDnBy5P5b6JpSZ6gQhh2FZ/uuc4=
X-Google-Smtp-Source: APBJJlGYLwl9SAOzS6EirIrfOIWXQT6mVPsrD5EOuD1iouxZhpiFuZrjPUk5Docf0ium9XGDiOH45Q==
X-Received: by 2002:a05:6a00:1891:b0:64a:2dd6:4f18 with SMTP id x17-20020a056a00189100b0064a2dd64f18mr9674054pfh.13.1688300097163;
        Sun, 02 Jul 2023 05:14:57 -0700 (PDT)
Received: from zephyrusG14 ([103.251.210.195])
        by smtp.gmail.com with ESMTPSA id e25-20020aa78c59000000b006732786b5f1sm11185655pfd.213.2023.07.02.05.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 05:14:56 -0700 (PDT)
Date:   Sun, 2 Jul 2023 17:44:51 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, ivan.orlov0322@gmail.com
Subject: [PATCH 0/4] Trivial code cleanup patches
Message-ID: <cover.1688299890.git.yogi.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variables in function _rtl92e_dm_check_rate_adaptive 
to avoid checkpatch complains.

The patches are required to be applied in sequence.

Yogesh Hegde (4):
  staging: rtl8192e: Rename variable currentRATR
  staging: rtl8192e: Rename variable targetRATR
  staging: rtl8192e: Rename variable LowRSSIThreshForRA
  staging: rtl8192e: Rename variable HighRSSIThreshForRA

 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 38 +++++++++++-----------
 1 file changed, 19 insertions(+), 19 deletions(-)

-- 
2.34.1

