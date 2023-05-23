Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E3C70E778
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 23:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238636AbjEWVjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 17:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238377AbjEWVjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 17:39:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5123011A
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 14:39:22 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba83fed5097so414428276.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 14:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684877961; x=1687469961;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DYoP+7y3H6KxflmECkTj0wmu7P4fg+DdkxFWOe2r+Gw=;
        b=k422eVrA6fDyydzitMAUgA2r/qnrQx3xF/tcqF59GxVqCShRzRg+N7Wq9rm5NbQfWW
         z5e4qyiz3RDva2Adh70L+JCtIsFJYG8aickJkoE550FSPN29CkPxC5rPZyfxZSyS1E2F
         UK/7GXhsUVEOGD13zSi5LxupV6swxC/PTX/cqV+07xqwkczw/291xohgRVSL+A4+oH3v
         ien9Ol3VSQjSSLXfXe/RPaLDPNwIIBUXaTZQkjfWJArf6QeTyxwlPcB0T3wMG9spdZjQ
         fJL4oADoF5YbWWX2Fe+mm+vB282fG6Kmr/bGIYTDl9mlt/SgcdV7AXH5t0dXoBmmCZA7
         /2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684877961; x=1687469961;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DYoP+7y3H6KxflmECkTj0wmu7P4fg+DdkxFWOe2r+Gw=;
        b=JJ1ziXscigvCbhAl1/GZtWvV8yBWT3FgkAg4mk4TUXbfubzOuLACaff0R9dNWwdbm8
         Gb7wtGsYKUW1njpVhXvliLRSkuAn2WvBKKziEXmmgK43g2Krz5XZhA9HMMzIOyRFx3tq
         /ESnb3c4ycEddm2UnNpuQhQd5AsLDTZEqM/TIdbEKvPb6e68rA15V1ATT5D6wRNeLLBm
         Az6Az42CeQwBDLOg5kMjxskVsxXIbXhLBhHLXy6SsKa10BiBQv7T41e2Yc8w3CWjGZAT
         pg2bev2DuhjF+sprQB4ODDx4mP63i9K4jd1tsLgbMdC0MDjRGXdx2Zh1wRgU/dznQwI7
         7WPA==
X-Gm-Message-State: AC+VfDw+F8yYnYk9h/Bk+kf2QtHjKUtQTD7CmvzxcWngO2bupdRuCEwo
        0YBR8M1gEnbW1kuHd1oK/CAAZn6RY+sTnQ==
X-Google-Smtp-Source: ACHHUZ4KOVqeROcsaIln6n/RyrzYJhz0YdaKsjzfxCm5OaISXvJWu4eXlRwxUTJ/QOJv0yXbMHASyg02e/yptA==
X-Received: from pranav-first.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:390b])
 (user=pranavpp job=sendgmr) by 2002:a5b:909:0:b0:ba8:736a:5bec with SMTP id
 a9-20020a5b0909000000b00ba8736a5becmr9228478ybq.6.1684877961612; Tue, 23 May
 2023 14:39:21 -0700 (PDT)
Date:   Tue, 23 May 2023 21:39:10 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Message-ID: <20230523213912.4006380-1-pranavpp@google.com>
Subject: [PATCH 0/2]
From:   Pranav Prasad <pranavpp@google.com>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pranav Prasad <pranavpp@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds fatal error checks for pm8001 driver
functions pm8001_phy_control() and pm8001_lu_reset().

1. Added a fatal error check in pm8001_phy_control().

2. Added a fatal error check in pm8001_lu_reset().

Changyuan Lyu (1):
  scsi: pm80xx: Add fatal error check for pm8001_phy_control()

Igor Pylypiv (1):
  scsi: pm80xx: Add fatal error check for pm8001_lu_reset()

 drivers/scsi/pm8001/pm8001_sas.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

-- 
2.40.1.698.g37aff9b760-goog

