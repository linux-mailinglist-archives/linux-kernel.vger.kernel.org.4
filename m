Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752E66A9E3E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjCCSPW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 3 Mar 2023 13:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjCCSPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:15:20 -0500
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229CD1043D;
        Fri,  3 Mar 2023 10:15:19 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id x3so13654952edb.10;
        Fri, 03 Mar 2023 10:15:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677867317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZOXCrflRhQMmUW+tIHbSaKvgx/y8VeI5EgisM5HGNnc=;
        b=fvq/BKKPpOpnvMWW2yH0D0DOZiO0TZc+f682E3g/ws2400uPnVzNpx72xtxUDJA1eH
         qPx+2hC0McjN4j35XfT1ngSB2mwv+1bUMqFlLaalOvymIdaPDQ5g+aA3HCmmfs3VCzRo
         s2zhuadEb5CcHGHNKeUTF6BGL9gE7snMFVL5yu0kF+GEtW48OR3YLtJVPwP4y+f1aMgj
         a35hUlACj7twSBd1gtHyjYhaf+AVd9nnqZgF8gb5Wx2/y5uKNC7Bk9zVGGKIl8oeO7jQ
         3BlnImJaqNhpNdZFx1QsaPKSaLeV4GXNOa1lhT+Qlt/6OyARCAVyIPi8+YgFZjoZdS5e
         iOdg==
X-Gm-Message-State: AO0yUKXbW1nJgoV5US65UMnamSJPNrfc2CEKkD8y/XZyLtSOSulZeW4X
        vxo35pw5qfIOX89tK4MpH3zshZVUu6YibTQ6/3xH2c4uOfg=
X-Google-Smtp-Source: AK7set82L6KvNUq3P95wNzGcq62Bg/y5lxMirxod6xjElubanyRK9UB4PZxTLbBPDFzi+iQJdpG652EgcH2AakwzC6Y=
X-Received: by 2002:a50:d4da:0:b0:4ae:e548:1c6 with SMTP id
 e26-20020a50d4da000000b004aee54801c6mr1656148edj.6.1677867317524; Fri, 03 Mar
 2023 10:15:17 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 3 Mar 2023 19:15:06 +0100
Message-ID: <CAJZ5v0ivhkBMX_864KbRdZsAN8AD373P-m_Tsb9KZZkGHg0zOw@mail.gmail.com>
Subject: [GIT PULL] More power management updates for v6.3-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.3-rc1-2

with top-most commit 5719638d368f35934d53e4a8c3a2f007c32a1ecf

 Merge branch 'powercap'

on top of commit 2504ba8b01634319a6f95b7fa9bf9c101437e158

 Merge tag 'pm-6.3-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more power management updates for 6.3-rc1.

These update power capping (new hardware support and cleanup) and
cpufreq (bug fixes, cleanups and intel_pstate adjustment for a new
platform).

Specifics:

 - Fix error handling in the apple-soc cpufreq driver (Dan Carpenter).

 - Change the log level of a message in the amd-pstate cpufreq driver
   so it is more visible to users (Kai-Heng Feng).

 - Adjust the balance_performance EPP value for Sapphire Rapids in the
   intel_pstate cpufreq driver (Srinivas Pandruvada).

 - Remove MODULE_LICENSE from 3 pieces of non-modular code (Nick Alcock).

 - Make a read-only kobj_type structure in the schedutil cpufreq governor
   constant (Thomas Weißschuh).

 - Add Power Limit4 support for Meteor Lake SoC to the Intel RAPL
   power capping driver (Sumeet Pawnikar).

Thanks!


---------------

Dan Carpenter (1):
      cpufreq: apple-soc: Fix an IS_ERR() vs NULL check

Kai-Heng Feng (1):
      cpufreq: amd-pstate: Let user know amd-pstate is disabled

Nick Alcock (3):
      cpufreq: amd-pstate: remove MODULE_LICENSE in non-modules
      cpufreq: intel_pstate: remove MODULE_LICENSE in non-modules
      powercap: remove MODULE_LICENSE in non-modules

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Adjust balance_performance EPP for Sapphire Rapids

Sumeet Pawnikar (1):
      powercap: RAPL: Add Power Limit4 support for Meteor Lake SoC

Thomas Weißschuh (1):
      cpufreq: schedutil: make kobj_type structure constant

---------------

 drivers/cpufreq/amd-pstate.c        | 3 +--
 drivers/cpufreq/apple-soc-cpufreq.c | 4 ++--
 drivers/cpufreq/intel_pstate.c      | 2 +-
 drivers/powercap/intel_rapl_msr.c   | 2 ++
 drivers/powercap/powercap_sys.c     | 1 -
 kernel/sched/cpufreq_schedutil.c    | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)
