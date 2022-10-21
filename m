Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48738607E68
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 20:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiJUSul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 14:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiJUSui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 14:50:38 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E574815ECD8;
        Fri, 21 Oct 2022 11:50:36 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id c23so2225501qtw.8;
        Fri, 21 Oct 2022 11:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Eysv7zcSaSmjCvoZiMko9/clmFPR09HgvorThEzAV0=;
        b=S4m9G1sdLkl++/6A1p3gOqjIBLu33U00XFFTtKvG0OXF3dCt0WLSnEW6lvauAZ70Yk
         9bbzIIn6mZER1HP+RQyiyrgtFSKAddIHRXQhBkCtoNlbV1PNN+4Px46NERwqSZ7h2Q7R
         LHhl0Cf1gNn1vxfw4pm7uS8736fl8CKuLQaPO/1XROuXdyeXkznQbCrKtZwGPpgqLoKd
         Rku50zpwxMTgcMsXpsDCFJbnQ9nmQPJuku6caW09H4zeJlPitTRSXE67Zn8UPiF84+/a
         IbphoZRTpiErTB3+bpoqXSNXXGcyBJ/mxvt7L+Y/tRDgsSYWixAxGL+YyntW6vhyi8KS
         9Pcw==
X-Gm-Message-State: ACrzQf1II+KnGc42jH/YYkhv5U7BuqxzEnkyDyOjR+X4NXVdrHw24hlK
        SeFEv0P7Uex5mkhvoLbjrbo6jIOV9IgHizRwMDk=
X-Google-Smtp-Source: AMsMyM5e+TniKndwbNXCbDzhIwBmyhaEQoSjPqDh5pNbiCMZ6yY6II5GFaDaxfQpgF3yKgw6iTR1JgSS1EG7EoEKF8Q=
X-Received: by 2002:a05:622a:11c7:b0:39c:b4bc:7030 with SMTP id
 n7-20020a05622a11c700b0039cb4bc7030mr17834072qtk.17.1666378236106; Fri, 21
 Oct 2022 11:50:36 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 Oct 2022 20:50:25 +0200
Message-ID: <CAJZ5v0hE31BLmRR9w6u5+vrEEc3QjkaOpUPaCo6QcdJCFez0Rg@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v6.1-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.1-rc2

with top-most commit a6991d623de02c42c44ddfffde66ec18608069d3

 Merge tag 'cpufreq-arm-fixes-6.1-rc' of
git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm

on top of commit 9abf2313adc1ca1b6180c508c25f22f9395cc780

 Linux 6.1-rc1

to receive power management fixes for 6.1-rc2.

These fix some issues and clean up code in ARM cpufreq drivers.

Specifics:

 - Fix module loading in the Tegra124 cpufreq driver (Jon Hunter).

 - Fix memory leak and update to read-only region in the qcom
   cpufreq driver (Fabien Parent).

 - Miscellaneous minor cleanups to cpufreq drivers (Fabien Parent,
   Yang Yingliang).

Thanks!


---------------

Fabien Parent (3):
      cpufreq: qcom: fix memory leak in error path
      cpufreq: qcom: fix writes in read-only memory region
      cpufreq: qcom: remove unused parameter in function definition

Jon Hunter (1):
      cpufreq: tegra194: Fix module loading

Yang Yingliang (4):
      cpufreq: dt: Switch to use dev_err_probe() helper
      cpufreq: imx6q: Switch to use dev_err_probe() helper
      cpufreq: qcom-nvmem: Switch to use dev_err_probe() helper
      cpufreq: sun50i: Switch to use dev_err_probe() helper

---------------

 drivers/cpufreq/cpufreq-dt.c           |  6 ++----
 drivers/cpufreq/imx6q-cpufreq.c        |  4 +---
 drivers/cpufreq/qcom-cpufreq-nvmem.c   | 25 +++++++++++++------------
 drivers/cpufreq/sun50i-cpufreq-nvmem.c |  9 +++------
 drivers/cpufreq/tegra194-cpufreq.c     |  1 +
 5 files changed, 20 insertions(+), 25 deletions(-)
