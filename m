Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635EF6910B2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjBISt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjBISt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:49:26 -0500
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5C35BA7F;
        Thu,  9 Feb 2023 10:49:25 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id da9so2885210edb.12;
        Thu, 09 Feb 2023 10:49:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s0wOVGEIsqozoWOqa7C2Q6mCdmU8Ss82AAfVmyTj+0M=;
        b=AJQRgYC+Ufj/JzrXmcq1Kwa8DyzvWsbASvzWWGXsKdPy1dIt1IRsv/m328NRPX2ejY
         Ho8IPvZUrzLTZG6g9WfshNsxsskIPrz0+lz+tT/is34WoIvtjEjHKXWs7DKQ3yLoi6d6
         5gCHw0QPtrHP8YqO7K56IMJre9dDEQUBqejIsfrtVEWIyDZTLkMV4Ph6dZDr7lMDNwc7
         R2a1AdKJ/D6semWFMYcXRXMEd8bg3yfbBY9Q1lleALudt+2S3ov13T9j4nMpm/R9ANBQ
         Ec0JN3UBnBurZe//cZCf0JMQNywtEHIUE956CvDPZXZtcjPbnF2beYbP+cmzr2uTFnhq
         ed/w==
X-Gm-Message-State: AO0yUKVCcz2cBafr41NzpJTb3MGe0Ak4Jv+3SP5n7rd9v/8+jF0HiqSf
        TFIiBmCt/eZ6hHNY0M2GQWXTRnlIAHgKgUak/0wWWZOL2mo=
X-Google-Smtp-Source: AK7set9ov9+rSfAaPORjLy/MeCU8pxpZbv3V2FAKicwYFX3a3irzKTKzTBYLwasFwCS6STBpJmcc+sUyKA/rsrq/WOA=
X-Received: by 2002:a50:d0ce:0:b0:4ab:255e:5ada with SMTP id
 g14-20020a50d0ce000000b004ab255e5adamr308135edf.6.1675968564039; Thu, 09 Feb
 2023 10:49:24 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Feb 2023 19:49:12 +0100
Message-ID: <CAJZ5v0iTBJNNxKs86LjTVfer6aqqPYhOuZP04FC-zcq3CWfv8Q@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v6.2-rc8
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
 pm-6.2-rc8

with top-most commit 918c5765a15420ad60730fbe5b5b67beb74ca7b6

 Merge tag 'cpufreq-arm-fixes-6.2' of
git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm

on top of commit 4ec5183ec48656cec489c49f989c508b68b518e3

 Linux 6.2-rc7

to receive a power management fix for 6.2-rc8.

Fix the incorrect value returned by cpufreq driver's ->get() callback
for Qualcomm platforms (Douglas Anderson).

Thanks!


---------------

Douglas Anderson (1):
      cpufreq: qcom-hw: Fix cpufreq_driver->get() for non-LMH systems

---------------

 drivers/cpufreq/qcom-cpufreq-hw.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)
