Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F41E675F20
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 21:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjATUw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 15:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjATUw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 15:52:56 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CB89771;
        Fri, 20 Jan 2023 12:52:54 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id x7so5113757qtv.13;
        Fri, 20 Jan 2023 12:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=4YE+s5X2faO+oNvk5Zur/4aie0pupo0tvZpYYK61fck=;
        b=V0zyASfriUPFws6w7byT4ZFBoa40/J1+JfEdlIo84bAtK6+QaCh2iiSEO8iysVM6v1
         CBXE4E2HnDkAfh8h2q3n0N9TB0HX6S3FXVoMmMZl8txw9dX43RXQNcHsqrIq60vMWzOH
         lr4RUpQ6rjEkN/Mopr5BPSXmImw8d3zm2jKNSjdpu7NTTdFitcFOy6lCbzn7I8OuGbig
         FlmP3knfkGvsj1YTresbpRBJpfY4zZ2hhrJsQGGQibznbHPd1Tiy7gbNcq3PxrNI9m0G
         2mXJ9PM1nT4GMDYZEc/ecCKA/Tukj5yxNIMBgsSApXdVBi3UyLAU2WMG666ozYNrXhWx
         irYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YE+s5X2faO+oNvk5Zur/4aie0pupo0tvZpYYK61fck=;
        b=sJSBPe9w6S7VT9Zlq8//Gjs6EylmEGPQkyLoaIj5FwcnESAqluq5bAsUZygk1+BcEa
         +Ng+I35pn7JLAKKNC1CM16TQk83u641xYvfwp1rPNOoAIKNjvUQeRDWtbFNPZtpezl4L
         abSpj20WMRvrFWFkn50qv6ez8/EuI38iXnVmy28AbCffrpRG/H8ZVv+YKuitPEvwcwUR
         /LoPDifQ5qsDhw9jfGiSDYFcqnGujYxBq7M8jiY24dB/QzoANEm4T0fY61C/+Zhh8dyo
         LTnWzp8oUEdXXfx/Ole/ewrl4e1hUkvIp37cadb+ZC7ZlWRz04KpaTz3zWd0TkRVDK2U
         WVZw==
X-Gm-Message-State: AFqh2ko14jTv2m8B20v0t4sXD/4EyanyF1NHvdbpoxB37YZE4yNQr9S2
        8ucW1rRB0118+weuvuPWN6A2rwvlosQ=
X-Google-Smtp-Source: AMrXdXvY9EytmieB+K34iSci8Ih2uasXzCsPnH0ZoVDLaTByHoHGIG74SXHDYxmGhoqGoQ+kbBZomw==
X-Received: by 2002:a05:622a:5a91:b0:3b6:414f:c2ba with SMTP id fz17-20020a05622a5a9100b003b6414fc2bamr23374386qtb.38.1674247972954;
        Fri, 20 Jan 2023 12:52:52 -0800 (PST)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-14-76-71-123-7.dsl.bell.ca. [76.71.123.7])
        by smtp.gmail.com with ESMTPSA id o5-20020a05620a2a0500b006fcc437c2e8sm27381717qkp.44.2023.01.20.12.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 12:52:52 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia Poulin <kcarcia@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [ANNOUNCE] rt-tests-2.5
Date:   Fri, 20 Jan 2023 15:52:20 -0500
Message-Id: <20230120205220.26218-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We haven't had a release in awhile. There aren't a large amount of
changes here but two significant changes include a fix from John Stultz
to prevent threads from being affined when -a isn't set, and an enhancement
from Crystal Wood that adds nanosecond resolution to oslat. Sebastian
Siewior added a change for determining the number of active CPUs on a system, since calling numa_num_task_cpus() seemed to be giving him inaccurate numbers on certain machines. There are also some clean-ups from Leah Leshchinsky and myself.

Enjoy!

Bug reports and patches are always welcome.

John Kacur <jkacur@redhat.com>

To fetch

Clone
git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://kernel.googlesource.com/pub/scm/utils/rt-tests/rt-tests.git

Branch: main

Tag: v2.5

Tarballs are available here:
https://kernel.org/pub/linux/utils/rt-tests

Older version tarballs are available here:
https://kernel.org/pub/linux/utils/rt-tests/older


Crystal Wood (1):
  oslat: Add command line option for bucket width

John Kacur (7):
  rt-tests: Remove arbitrary num of threads limits
  rt-tests: hackbench: Add error checking to connect and getsockname
  rt-tests: hackbench: Fix compile comparison of different signed ints
  rt-tests: hackbench: Fix compile warning about fall through
  rt-tests: rt_numa.h: Remove unused paramter max_cpus
  rt-tests: hwlatdetect: Fix incorrect comment about testduration
  rt-tests: Change to version v2.5

John Stultz (1):
  cyclictest: Fix threads being affined even when -a isn't set

Leah Leshchinsky (2):
  rt-tests: hwlatdetect.py Covert to f-strings
  rt-tests: hwlatdetect: Update to integer division

Sebastian Andrzej Siewior (1):
  rt-numa: Use a reasonable default max CPU value.

 Makefile                       |   2 +-
 src/cyclictest/cyclictest.c    |  10 +--
 src/cyclictest/rt_numa.h       |   3 +-
 src/hackbench/hackbench.c      |  17 +++--
 src/hwlatdetect/hwlatdetect.py |  79 +++++++++++------------
 src/lib/rt-numa.c              |  11 +++-
 src/oslat/oslat.8              |   9 ++-
 src/oslat/oslat.c              | 110 +++++++++++++++++++++++----------
 src/pmqtest/pmqtest.c          |   2 +-
 src/ptsematest/ptsematest.c    |   2 +-
 src/sigwaittest/sigwaittest.c  |   2 +-
 src/svsematest/svsematest.c    |   2 +-
 12 files changed, 158 insertions(+), 91 deletions(-)
