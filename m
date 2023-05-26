Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C4C712AAE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 18:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjEZQcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 12:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjEZQcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 12:32:18 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50107DF;
        Fri, 26 May 2023 09:32:17 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5147f32df82so124209a12.0;
        Fri, 26 May 2023 09:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685118736; x=1687710736;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XXhdKxqSFYkKSH0aln6Zruim3OwYUDkaSG2oPvequ0Q=;
        b=E7tBbNNi6e2BoeWzw50KrLgVmt4zS+rj3qEKUwcYfve+9or4tM6TZVZRPcmDkG4pIF
         3aIpmguDCe1BX14p6LaJODtSlSe9J3Vr4xU6o7WQullCJbLaIHVLbNxv88joEV+Q6TX/
         PGTIiXO5yUqsR3DhhEjvgPkyuc50ozmZZOzikMQ07hkuJCCBhdOsaX+3mdgvuUhS5Ndu
         XGjEY/kpwvVEPeyY47nP4yH/hatEWbpvl9j0Wf7/CQQWFEnTpHRQ6chdhHI2EFRYY1C4
         P7Ir+sfjKk82LOd4tjJc7HJS2xwXxj7olW+7sutAtBCRqcYZmOV1Urii+MpZFJpmYV6Z
         dVAQ==
X-Gm-Message-State: AC+VfDx272739pZCS4CwC57fR2++ILc41T3dayn8uGJjvDzpPnHCC6Eq
        mK9DVnbnRkExqWiC3eORFtj3EB5MQropiJID3VNskPhqKUw=
X-Google-Smtp-Source: ACHHUZ5xB8PBLY5c725ADRoJAV35GRPW13xpNZv99hwoJn6PUt98y1V/jlsrwPua3ewK6gpSbV/QEo8kALLN47UZ5XE=
X-Received: by 2002:a17:906:729e:b0:94f:66af:b1f7 with SMTP id
 b30-20020a170906729e00b0094f66afb1f7mr2442638ejl.1.1685118735347; Fri, 26 May
 2023 09:32:15 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 26 May 2023 18:32:02 +0200
Message-ID: <CAJZ5v0gV=NM2Tg7x2fEM8imVQ15D5KpZeP+EyaOEnjwPCmF9gg@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v6.4-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.4-rc4

with top-most commit 3bf8c6307bad5c0cc09cde982e146d847859b651

 cpufreq: amd-pstate: Update policy->cur in amd_pstate_adjust_perf()

on top of commit 44c026a73be8038f03dbdeef028b642880cf1511

 Linux 6.4-rc3

to receive power management fixes for 6.4-rc4.

These fix 3 issues related to the ->fast_switch callback in the AMD
P-state cpufreq driver (Gautham R. Shenoy and Wyes Karny).

Thanks!


---------------

Gautham R. Shenoy (1):
      cpufreq: amd-pstate: Add ->fast_switch() callback

Wyes Karny (2):
      cpufreq: amd-pstate: Remove fast_switch_possible flag from active driver
      cpufreq: amd-pstate: Update policy->cur in amd_pstate_adjust_perf()

---------------

 drivers/cpufreq/amd-pstate.c | 46 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 9 deletions(-)
