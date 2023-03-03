Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C6C6A9E50
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjCCSRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjCCSRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:17:47 -0500
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A80428220;
        Fri,  3 Mar 2023 10:17:44 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id ay14so10113493edb.11;
        Fri, 03 Mar 2023 10:17:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677867463;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m4nA4C+gRuMTVvdcG+3PWDPw/zIFM2JIlWdsATL8TAA=;
        b=a7AXt5rd2/pVqXk2LgdLDMG6Lbvfa0uVNNJzfPcXbAPYI233hyOWDJRqxwOD5IqZco
         IQ+6A4e8JyMH1TYvb7vJMP26Ojev2Kswlu9zBNEe8TFfIBiFjIOZfT1ljOuOZgbp0gGI
         T2/thMUgAfV1IftEpU7rj2YxeEKnuu6He0dSpIKvvaQdt9CWFRQH142ynrJBc0pvr91v
         RSFdALyGSF44ek2zFweRsSXZtlpT5/jPrgNUfBM83sKta2kGYTz+52UNwDSTz65b1RB4
         1vPD1449Io+wMvkxXUYNapkb9jcYk6DezmiZezJq9e0xbkC4mRlnkubqGFppl4Hm6t+n
         pcXQ==
X-Gm-Message-State: AO0yUKWZ8oNVlMv1OQqbSj+78RFe/9aosRspz+QRTWK5N8zb9XQepj9g
        UvfpYiUtcVY/JQVRHuydDQRQpD6I2CN9yFfJQshsDhSip8U=
X-Google-Smtp-Source: AK7set+CgIek+NWNj5GW0WpxVH6kyB7q+vk6lZ51O3BOnyF/0nOxIRblRW0gB9wL5uZsJkB8WskmXWbgImEQ1b8XKFY=
X-Received: by 2002:a17:906:a4b:b0:879:9c05:f5fb with SMTP id
 x11-20020a1709060a4b00b008799c05f5fbmr1329358ejf.5.1677867462935; Fri, 03 Mar
 2023 10:17:42 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 3 Mar 2023 19:17:32 +0100
Message-ID: <CAJZ5v0jaLbB5Ems_SNY_Q8nnkMw7__68_J7=mXJUj6acmYmEEg@mail.gmail.com>
Subject: [GIT PULL] More thermal control updates for v6.3-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
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
 thermal-6.3-rc1-2

with top-most commit 1467fb960349dfa5e300658f1a409dde2cfb0c51

 thermal: intel: BXT_PMIC: select REGMAP instead of depending on it

on top of commit 1b72607d7321e66829e11148712b3a2ba1dc83e7

 Merge tag 'thermal-6.3-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more thermal control updates for 6.3-rc1.

These fix two issues in the Intel thermal control drivers.

Specifics:

 - Fix an error pointer dereference in the quark_dts Intel thermal
   driver (Dan Carpenter).

 - Fix the intel_bxt_pmic_thermal driver Kconfig entry to select REGMAP
   which is not user-visible instead of depending on it (Randy Dunlap).

Thanks!


---------------

Dan Carpenter (1):
      thermal: intel: quark_dts: fix error pointer dereference

Randy Dunlap (1):
      thermal: intel: BXT_PMIC: select REGMAP instead of depending on it

---------------

 drivers/thermal/intel/Kconfig                   |  3 ++-
 drivers/thermal/intel/intel_quark_dts_thermal.c | 12 ++----------
 2 files changed, 4 insertions(+), 11 deletions(-)
