Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547D26F59FA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 16:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjECO15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 10:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjECO1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 10:27:55 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6635C6180;
        Wed,  3 May 2023 07:27:49 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-94f9cd65b1aso149442766b.0;
        Wed, 03 May 2023 07:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683124068; x=1685716068;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T7or5jhvdguUx7fS3E1q044jm9m/uQJFidlz1pmA1fE=;
        b=XHbgkOgyNpDrjRKUXc3LW2e/Au416ftX17dAteRoutUqOwbue9IJhdj7ZY3lvxxNe2
         8omfEbmWIXX/hvTNywGp0WZeclknDv9birQkJs7pFTQwcKG70S+5Pgqpj29bC0cVbuEa
         75ymF1KsTj9qHo/xrjNil2f2wloUyP+V7Jvq6foQru1WKyX602axmKFdzUZw2odhxE7s
         RQgbq5Dwl87gF0R5s64pwKALOVq+vjyMC6frkq56TaRP91f9/brSSKqyVHSNMUsKfsns
         VxEaKvcglddib9pTDse3Z4+icAkRH9ogI3ojuRwFG9nasp0hbGohQQ5NqCSR/Ri+LvZy
         jOUg==
X-Gm-Message-State: AC+VfDxvKNPqUQGjPwa6gyvVT0fZeho+Ykuumz48fbVpwgTFL/qedg9g
        Gg2rPwN+UDM4iURZ+hCcSCoUsyDm95OAbNhxG42j9CVk6/c=
X-Google-Smtp-Source: ACHHUZ4mQP3ZwE3Ln4aLPo0W7qdiz8bIOhrhdJ1wLlzA2bz2iJ4GA2ym1P2l9b33cIx8T2HuRn/rn09mLTaTbcNfhfs=
X-Received: by 2002:a17:906:2254:b0:92e:f520:7762 with SMTP id
 20-20020a170906225400b0092ef5207762mr5372473ejr.6.1683124067692; Wed, 03 May
 2023 07:27:47 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 May 2023 16:27:36 +0200
Message-ID: <CAJZ5v0jVsrTH6=-YaXfqy3T8Q_mdZ_bDKHigtPXQqLFag8JBug@mail.gmail.com>
Subject: [GIT PULL] More power management updates for v6.4-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.4-rc1-2

with top-most commit 57ea3ab21c14e6f04db2b0878e8a5be644fa3769

 Merge branch 'pm-sleep'

on top of commit 0cfd8703e7da687924371e9bc77a025bdeba9637

 Merge tag 'pm-6.4-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more power management updates for 6.4-rc1.

These fix a hibernation test mode regression and clean up the intel_idle
driver.

Specifics:

 - Make test_resume work again after the changes that made hibernation
   open the snapshot device in exclusive mode (Chen Yu).

 - Clean up code in several places in intel_idle (Artem Bityutskiy).

Thanks!


---------------

Artem Bityutskiy (7):
      intel_idle: use pr_info() instead of printk()
      intel_idle: clean up intel_idle_init_cstates_icpu()
      intel_idle: further intel_idle_init_cstates_icpu() cleanup
      intel_idle: improve C-state flags handling robustness
      intel_idle: fix confusing message
      intel_idle: do not sprinkle module parameter definitions around
      intel_idle: mark few variables as __read_mostly

Chen Yu (2):
      PM: hibernate: Turn snapshot_test into global variable
      PM: hibernate: Do not get block device exclusively in test_resume mode

---------------

 drivers/idle/intel_idle.c | 59 +++++++++++++++++++++++++++++------------------
 kernel/power/hibernate.c  | 15 +++++++++---
 kernel/power/power.h      |  1 +
 kernel/power/swap.c       |  8 +++++--
 4 files changed, 56 insertions(+), 27 deletions(-)
