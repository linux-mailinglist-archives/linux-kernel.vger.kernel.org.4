Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A5D5FA2E0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 19:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiJJRqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 13:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiJJRqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 13:46:20 -0400
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A5521241;
        Mon, 10 Oct 2022 10:46:20 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id z18so7545966qvn.6;
        Mon, 10 Oct 2022 10:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7C7u5e8Nz2IfRy9TOym9gQsgg5xXFj4Ow9Lf1Pj+L5I=;
        b=qAwoHIY/e1VXUPeQWAKd9LOiyBgT+GXbZeoCCnuiLuidrz8FkQ39Gnp+M0lJPDstT1
         3PwFisj9/dJfQna4L5eTbmc/Ghi/wkbpSZnGGCnPnndrIshQwKPpooOTcu/1K/OXhy9U
         Mi4E3g1OWMiBABaN3rNpa3+4kXrjmVeDb4jvPm6iwIYTqnxis3c+wbuivUxydLqhn7VT
         QWtmRNWne4WDgKNwrdyTriOKB9a6CrNpeeSdiX8WQfMMJ6/LDHw9rHOd7zbkPABkwrjc
         pTmI78areaklDwGx0H4xqvPw/XCtifSHXpJVNmVdqhUODII2KPma8+r4kejVVpHrnEK+
         DLSw==
X-Gm-Message-State: ACrzQf0Qkq7R1paqClezhRzHzCg9+v7J+llsROtruYX9MAUcCbsto+zS
        Ijw8+mO+BvrX79Pn/svL/35FvWTvw2BTjq1xu6N8l3pe6xE=
X-Google-Smtp-Source: AMsMyM546pfja/b0CWkFvfxrzY7+i6/eLda8E521XucTawcATjGGbeRx9gorSH3nBCO0CuPTgGtTjCYfuIb7oqscoc4=
X-Received: by 2002:a05:6214:f24:b0:4b3:efeb:d800 with SMTP id
 iw4-20020a0562140f2400b004b3efebd800mr7389878qvb.15.1665423979107; Mon, 10
 Oct 2022 10:46:19 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 10 Oct 2022 19:46:08 +0200
Message-ID: <CAJZ5v0gMNxqYjxnWXweqAyc2BQgY0i0QKS60fm6CcYkRNdsh9A@mail.gmail.com>
Subject: [GIT PULL] More power management updates for v6.1-rc1
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
 pm-6.1-rc1-2

with top-most commit f7e6b99f22f22f3630139aeaeecb83d77e47bf9b

 Merge branches 'pm-domains' and 'pm-core'

on top of commit c79e6fa98ca8628556a01fe277022bda64829fdf

 Merge tag 'pm-6.1-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more power management updates for 6.1-rc1.

These update the turbostat utility, extend the macros used for defining
device power management callbacks and add a diagnostic message to the
generic power domains code.

Specifics:

 - Add an error message to be printed when a power domain marked as
   "always on" is not actually on during initialization (Johan Hovold).

 - Extend macros used for defining power management callbacks to allow
   conditional exporting of noirq and late/early suspend/resume PM
   callbacks (Paul Cercueil).

 - Update the turbostat utility:
   * Add support for two new platforms (Zhang Rui).
   * Adjust energy unit for Sapphire Rapids (Zhang Rui).
   * Do not dump TRL if turbo is not supported (Artem Bityutskiy).

Thanks!


---------------

Artem Bityutskiy (1):
      tools/power turbostat: Do not dump TRL if turbo is not supported

Johan Hovold (1):
      PM: domains: log failures to register always-on domains

Len Brown (1):
      tools/power turbostat: version 2022.10.04

Paul Cercueil (1):
      PM: Improve EXPORT_*_DEV_PM_OPS macros

Zhang Rui (3):
      tools/power turbostat: Add support for RPL-S
      tools/power turbostat: Add support for MeteorLake platforms
      tools/power turbostat: Use standard Energy Unit for SPR Dram RAPL domain

---------------

 drivers/base/power/domain.c           |  4 +++-
 include/linux/pm.h                    | 37 ++++++++++++++++++++++-------------
 include/linux/pm_runtime.h            | 20 +++++++++++--------
 tools/power/x86/turbostat/turbostat.c | 22 ++++++++++++++-------
 4 files changed, 53 insertions(+), 30 deletions(-)
