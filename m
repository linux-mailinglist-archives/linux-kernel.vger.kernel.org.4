Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFB45F3637
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 21:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiJCTUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 15:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJCTUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 15:20:09 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D001834E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 12:20:08 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-131ea99262dso11810450fac.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 12:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=9K17YJn6Np23zeiW/E3dhUfsLZOcCAtvJyQ15VB5VuE=;
        b=HhZm2uykD1m1vLQixXLpV1DMvTtcOqG8GszWTKTLYzqnf+mAW6m5qpIolJs9lroD/1
         QweX5P628FeHP1E+M94jY+8OEn6t8hqgO9OCMhzjYt78ockafnGtJM0vWPqfvKJ5t08e
         6M87LNFhrLodzYanr0Sy2LnTKgfOK/ItxgMgMUIIfN5PcFOLGgn8VyfqFcyLEbyU1xUJ
         OnBx6isVISXlQRfLUl5Yff9pRAX64Q5xTh55k2b7JvSsXdD+ZzGptp8IEiCuv+bw+Sgi
         TkmHfT9iIzRU0e5yJtyT0nNG0Ix41oLz+9Hxg/zB4iyvxVaYIjZvZFzWBM/XKGsafVPJ
         yfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=9K17YJn6Np23zeiW/E3dhUfsLZOcCAtvJyQ15VB5VuE=;
        b=EgpY9BtMXzf8UbEINUTOYgZRQyLnec6y3U2DjTgc+Kkr3vgx0Pfk3WtN4cPEIjSIU6
         v+Uuo9NYosjuZr7ZnRPJ/SNQ/2zRMKhZRFol8wVsr9rh3mWgf4XavWnYxt88S4w2A4wJ
         1QHcsZU6NX5qwoTMYvzUwiE9ExZydRMpqXidK7/Fkavvx93ScABQ8rn3Mdn8SAR/qU9v
         RqTxwrtvGrbhzPsTFLSr4SjQZex4qnrnirZ8qgSDWavuFQQ0hmqrWIBMhfaP+kppyHcH
         G4K1D5ZPyPayiT7dEEqLRta4j5fVLupef8LNiXZaZJrifc0PTjydjGLGl0Efc8qw/J39
         H5Og==
X-Gm-Message-State: ACrzQf12uXUUjyrh6XZRvtHD7e8z1GMqJxYmQRo4rumlmX5NE3dqtJG2
        4BcfjL2JOgk5RCVU5KvHBNn1y1bBbIsQPvMuKljwWoB+6rJN
X-Google-Smtp-Source: AMsMyM5il5LIfc7Y0PRw8xuRwkVSi6pALIg74xVZJMMxNW8V7EM3YRfgsCHOX+04tJIuGcZqNH4Wa4k2sFjfDSaV62Q=
X-Received: by 2002:a05:6870:41cb:b0:131:9656:cc30 with SMTP id
 z11-20020a05687041cb00b001319656cc30mr6146840oac.51.1664824807712; Mon, 03
 Oct 2022 12:20:07 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 3 Oct 2022 15:19:57 -0400
Message-ID: <CAHC9VhTEHLd-PVLArOH20UGaB21JJzz5nT54VFegF23631QSxA@mail.gmail.com>
Subject: [GIT PULL] Audit patches for v6.1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Six audit patches for v6.1, most are pretty trivial, but a quick list
of the highlights are below:

* Only free the audit proctitle information on task exit.  This allows
us to cache the information and improve performance slightly.

* Use the time_after() macro to do time comparisons instead of doing
it directly and potentially causing ourselves problems when the timer
wraps.

* Convert an audit_context state comparison from a relative enum
comparison, e.g. (x < y), to a not-equal comparison to ensure that we
are not caught out at some unknown point in the future by an enum
shuffle.

* A handful of small cleanups such as tidying up comments and removing
unused declarations.

-Paul

--
The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

 Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   tags/audit-pr-20221003

for you to fetch changes up to 934f70d9d498a7fffd611edf48356698f1d72e91:

 audit: remove selinux_audit_rule_update() declaration
   (2022-09-07 11:30:15 -0400)

----------------------------------------------------------------
audit/stable-6.1 PR 20221003

----------------------------------------------------------------
Jilin Yuan (1):
     audit: fix repeated words in comments

Richard Guy Briggs (3):
     audit: audit_context pid unused, context enum comment fix
     audit: explicitly check audit_context->context enum value
     audit: free audit_proctitle only on task exit

Xiu Jianfeng (1):
     audit: remove selinux_audit_rule_update() declaration

wuchi (1):
     audit: use time_after to compare time

kernel/audit.c   |  8 +++-----
kernel/audit.h   |  4 +---
kernel/auditsc.c | 10 +++++-----
3 files changed, 9 insertions(+), 13 deletions(-)

-- 
paul-moore.com
