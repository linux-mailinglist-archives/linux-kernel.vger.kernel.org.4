Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FFF6BEDC7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjCQQMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 12:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjCQQMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:12:48 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289D43FBA1;
        Fri, 17 Mar 2023 09:12:46 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id w9so22491770edc.3;
        Fri, 17 Mar 2023 09:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679069564;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6+rn1YSZmbdUqRFG/vNEu75EzysOAso/oXOoTMRkq2w=;
        b=B6UUMH4j7viakkjBSD6DEvk1LFmOYrUFv12LeLCU/Ta+59K0+gN7WUjR7ScsbNKeek
         Xiw43K6VjOzz4x6B4Y9R+qH7N+eOSwSn1Of1pQ0E6PvGv0Pj8ifEq5oMa6VXOsHpSW8X
         79FU5aveJU4oZ9RsZOLIuiUelvzBCmFsA+MsXdy2SefC/m8gVFPva5YTvS6bLBSY+Ait
         QWfF1YB8/0Z3PLb3xKWH/lsm7x1IPt4tN5RUbus6tKAKs22SMJedjPhufN2lynGvyiKV
         1pE3rtipNce9lt/OCRxGYCtE3yJeG4bIZRn4CtSMeE58Kad7VzLFtjDbV4dCRLBFiD9r
         4ITA==
X-Gm-Message-State: AO0yUKW+U+CmIR3+UrpOHjRVPocqA7AmK8XEt1WBWQuFGqXf3VCemDmW
        evxluayZF89RHEAmdS/aZ/GbFypT6Yay3W7rzxvOyVfd2Dg=
X-Google-Smtp-Source: AK7set8aTYlTuP/LTjAsV0iYNY7A3KgjsTIJEdAjg5Y1tcfhlkASP5RQjJGoxRvAMJO+ECuTInx4eeR1VEWOSfQhXgM=
X-Received: by 2002:a50:d0d3:0:b0:4fa:71a2:982b with SMTP id
 g19-20020a50d0d3000000b004fa71a2982bmr1970762edf.0.1679069564593; Fri, 17 Mar
 2023 09:12:44 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 17 Mar 2023 17:12:33 +0100
Message-ID: <CAJZ5v0haUo_G041D4N7D++MBOHDX=z04sagWMs7BEmV0sjYUDw@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v6.3-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.3-rc3

with top-most commit 1fa9d47baa9e61ff973e03f0ef26f5b78d545e37

 Merge branch 'pm-cpuidle'

on top of commit eeac8ede17557680855031c6f305ece2378af326

 Linux 6.3-rc2

to receive power management fixes for 6.3-rc3.

These fix an error code path issue in a cpuidle driver and make the
sleepgraph utility more robust against unexpected input.

Specifics:

 - Fix the psci_pd_init_topology() failure path in the PSCI cpuidle
   driver (Shawn Guo).

 - Modify the sleepgraph utility so it does not crash on binary data
   in device names (Todd Brandt).

Thanks!


---------------

Shawn Guo (1):
      cpuidle: psci: Iterate backwards over list in psci_pd_remove()

Todd Brandt (1):
      pm-graph: sleepgraph: Avoid crashing on binary data in device names

---------------

 drivers/cpuidle/cpuidle-psci-domain.c | 3 ++-
 tools/power/pm-graph/sleepgraph.py    | 5 ++---
 2 files changed, 4 insertions(+), 4 deletions(-)
