Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E76642DEF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiLEQwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbiLEQvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:51:15 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EC01F2E0;
        Mon,  5 Dec 2022 08:50:21 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id x28so10717214qtv.13;
        Mon, 05 Dec 2022 08:50:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ooP6fj+0GmW1F+kLFwF8WXE0qvy/S+aOFunMr85EWOs=;
        b=xjL2oVAch+ynpp645Jyu4EZTLTwzskMUGIpk2SQepmsQywq+AzWlieadFiER9VjGZQ
         rg9O5/2bwQRBfHcflmkDeHCIjA6NP+aAGddkLYQmXWFLNWClkA9mah4at5JkbyuSV/4o
         JXKctcAlmW2BpleJMZGIAUiANnksPRGRFonHSMEKWBT7QMdAikOLXipWEEMPmGgqtE66
         JbzSSq4eriPq7lS6g95hz/IqhvW7tasq3wcchm9ODGNbEWI/2P7EuvJAOKClEyAxCbxO
         iG9q8jQ/7zatyoOakawaUSndm9ZkpvInmynT2qbCuciuj91/nGQ5mHHCg5xmQ4q5mtOI
         l1zw==
X-Gm-Message-State: ANoB5pnRtzCemfp2P0yS/lyMg/TeQ9+zxVmCni9xvChrulW7okUyw+PU
        ukUPMUHAlzBXUjPuqGw2bMhOw3l2Cvm0B8MCWO8=
X-Google-Smtp-Source: AA0mqf51jlt7bDB8QTam5qFx79LCOS/GbBm0Ts2vHOL+M9JX3N1U1R/GR1Cv0pNcfPl4kEmurl8ie1jFrVOmPTF2puE=
X-Received: by 2002:ac8:4818:0:b0:3a6:a0d7:e1f7 with SMTP id
 g24-20020ac84818000000b003a6a0d7e1f7mr11624049qtq.153.1670259021043; Mon, 05
 Dec 2022 08:50:21 -0800 (PST)
MIME-Version: 1.0
References: <a202a2ca-6ec7-f87d-f7a1-cc37987532ce@linuxfoundation.org>
In-Reply-To: <a202a2ca-6ec7-f87d-f7a1-cc37987532ce@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 5 Dec 2022 17:50:10 +0100
Message-ID: <CAJZ5v0hyvdDJ=naJZe1dZ=K-wOcFXhOJzOy9jR7_OeZZgbFb-w@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower update for Linux 6.2-rc1
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Renninger <trenn@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 5, 2022 at 5:28 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Hi Rafael,
>
> Please pull the following cpupower update for Linux 6.2-rc1.
>
> This cpupower update for Linux 6.2-rc1 consists of:
>
> - enhancement to choose base_cpu to display default cpupower details
>    instead of picking cpu 0 and failing to show information when it is
>    offline. This change ensure user will see power information on
>    the cpu the tool runs on.
> - adds Georgian translation to cpupower documentation.
> - introduces powercap intel-rapl library, powercap-info command, and
>    rapl monitor. This adds the ability to show the used power consumption
>    in for each rapl domain
>
> diff is attached.
>
> thanks,
> -- Shuah
>
> ----------------------------------------------------------------
> The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:
>
>    Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-6.2-rc1
>
> for you to fetch changes up to 8c37df3d635eac64a8fbb4b26672fb881e0cb673:
>
>    cpupower: rapl monitor - shows the used power consumption in uj for each rapl domain (2022-11-30 16:48:34 -0700)
>
> ----------------------------------------------------------------
> linux-cpupower-6.2-rc1
>
> This cpupower update for Linux 6.2-rc1 consists of:
>
> - enhancement to choose base_cpu to display default cpupower details
>    instead of picking cpu 0 and failing to show information when it is
>    offline. This change ensure user will see power information on
>    the cpu the tool runs on.
> - adds Georgian translation to cpupower documentation.
> - introduces powercap intel-rapl library, powercap-info command, and
>    rapl monitor. This adds the ability to show the used power consumption
>    in for each rapl domain
>
> ----------------------------------------------------------------
> Saket Kumar Bhaskar (1):
>        tools/cpupower: Choose base_cpu to display default cpupower details
>
> Thomas Renninger (2):
>        cpupower: Introduce powercap intel-rapl library and powercap-info command
>        cpupower: rapl monitor - shows the used power consumption in uj for each rapl domain
>
> Zurab Kargareteli (1):
>        cpupower: Add Georgian translation
>
>   tools/power/cpupower/Makefile                      |  15 +-
>   tools/power/cpupower/lib/powercap.c                | 290 ++++++
>   tools/power/cpupower/lib/powercap.h                |  54 ++
>   tools/power/cpupower/man/cpupower-powercap-info.1  |  25 +
>   tools/power/cpupower/po/ka.po                      | 983 +++++++++++++++++++++
>   tools/power/cpupower/utils/builtin.h               |   2 +
>   tools/power/cpupower/utils/cpufreq-info.c          |   4 +-
>   tools/power/cpupower/utils/cpuidle-info.c          |   4 +-
>   tools/power/cpupower/utils/cpupower-info.c         |   4 +-
>   tools/power/cpupower/utils/cpupower.c              |   1 +
>   .../cpupower/utils/idle_monitor/cpupower-monitor.c |   7 +-
>   .../cpupower/utils/idle_monitor/idle_monitors.def  |   1 +
>   .../cpupower/utils/idle_monitor/rapl_monitor.c     | 148 ++++
>   tools/power/cpupower/utils/powercap-info.c         | 117 +++
>   14 files changed, 1642 insertions(+), 13 deletions(-)
>   create mode 100644 tools/power/cpupower/lib/powercap.c
>   create mode 100644 tools/power/cpupower/lib/powercap.h
>   create mode 100644 tools/power/cpupower/man/cpupower-powercap-info.1
>   create mode 100644 tools/power/cpupower/po/ka.po
>   create mode 100644 tools/power/cpupower/utils/idle_monitor/rapl_monitor.c
>   create mode 100644 tools/power/cpupower/utils/powercap-info.c
> ----------------------------------------------------------------

Pulled and added to my linux-next branch, thanks!
