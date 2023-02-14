Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEC8696671
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbjBNOT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbjBNOTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:19:49 -0500
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9A3DD;
        Tue, 14 Feb 2023 06:19:46 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id u21so17632269edv.3;
        Tue, 14 Feb 2023 06:19:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sPhHywWh4t/1jMzIeFH4cVr3Xwf75pR89Y7MgMRkSis=;
        b=wbXUg2x1G/f+bgiPLqgnJtqN6zD4XnU1Nhm352GmE0Mluk4GhnsU/nBzfr7BIbQpk3
         55ugOFz6SxT3OpAMUjZkwV+zb8fahLVz5wtDtZO0unKzdlkIX0Z6HFKytotSXHhemMC0
         WdcgOV05w2o5J2Y2VTSsJDdL5WCJ1bT7e9fe6JDJHSGmoxiEufyRRy3khPpzcfjtO7Ke
         HUnWu8Ag0XS10Tuz8ZhbSPudQ2qu6j9lqA7nz6HWtlAbCZmClXh0tx0hfVXZLCjyG/Tz
         sbnwx/OGrlvQnrsfKy25oarSpmWk8Qe1tJRzY1BXhglsxXmZ7ENjqa+UgUI6Q1tliE45
         rm5w==
X-Gm-Message-State: AO0yUKVFkIYM0m4yK22yCI8F8b1IUY8YE1SKlaDTUaqbFD+RUfJIXJGD
        IaRWQqnDu5DqRr6Af7bc2HbShwYA5f/o6FNAc4y/cTcF6Uw=
X-Google-Smtp-Source: AK7set/xEIBc+/8n8v7Btu7EUkswYrGl/BnTHRPBRtEX01/TnF4RPf78KpxCRfLWAMfPVrDWNOoonwJo9mPHWLaUlgA=
X-Received: by 2002:a50:bace:0:b0:4ac:ce81:9c1d with SMTP id
 x72-20020a50bace000000b004acce819c1dmr1046273ede.0.1676384384773; Tue, 14 Feb
 2023 06:19:44 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Feb 2023 15:19:33 +0100
Message-ID: <CAJZ5v0h6j8mphAxBdCWYVbbaYXO9Et+u82nWhi0hY5sNvkMCzQ@mail.gmail.com>
Subject: [GIT PULL] Additional power management fix for v6.2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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
 pm-6.2-rc9

with top-most commit 6f098cde9df2c86d60db727d6270272751943674

 cpufreq: qcom-hw: Add missing null pointer check

on top of commit ceaa837f96adb69c0df0397937cd74991d5d821a

 Linux 6.2-rc8

to receive an additional power management fix for final 6.2.

This adds a missing NULL pointer check to the cpufreq driver for Qualcomm
platforms (Manivannan Sadhasivam).

Thanks!


---------------

Manivannan Sadhasivam (1):
      cpufreq: qcom-hw: Add missing null pointer check

---------------

 drivers/cpufreq/qcom-cpufreq-hw.c | 2 ++
 1 file changed, 2 insertions(+)
