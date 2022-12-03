Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E136418B3
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiLCUXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLCUXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:23:22 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC9A175AF;
        Sat,  3 Dec 2022 12:23:21 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id y16so12966499wrm.2;
        Sat, 03 Dec 2022 12:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ivgq95ghXHilfYx7N6xlLPnCx53obJv2fsof4Ef0rkw=;
        b=mRqDNiNyS4Czz+4jlaSsPuH/IE89uTWFcgOBvsuiegQesRkNcHnHJi3sXWWik93Een
         yz3sAX9uX1s4Vv4mhMw+s3XQ8l78fJAJbS3ZPPrm/d1R3tln9y2xX2IIvGWg1JGXPa3N
         GImRjj6eqmKaLgguNw5sSyEOO+DY+jJ7areJn+EukhPbfOkVHbP9kOOdyUKVIZobky+o
         KUZulcskLxWelXCqTJUlwqt6XOYOs8zHUk5UIWmgsyl54V6K5a2AwxYPz8db+kMszcbv
         M+sk6zpwEEGMcgXzVXIBaZiPNi9M1nylfh7HT6ozqWWCzwdrdAXiirKXcdyhbZKirW5I
         UjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ivgq95ghXHilfYx7N6xlLPnCx53obJv2fsof4Ef0rkw=;
        b=MYIwyRPccAwDIIqvODk1AY8Kt32lOusgBQ8oQ+25QMEGRgahMVZpBE0KIPo9C+yar8
         WcFFqJQtzbGnmgnZu0lcWMcY+QS75XaKYbqm0VcityNRDQp7veBDzYdwzpzFKY5N+7en
         zgvtYw1fhoiAjzsszYajfBMWTuflUdfxPAl9vExoYQbuzfzBcj81UGL1k7JL+4+A/b+D
         9ZZ3lcQ3jJlOHxsZIKTJWKn76j6hJ2I4T+b82GvLs7d2T7SL6CkD5XaDnQ+l52DxanBs
         5o2PJ0gSj+DVV3de6xCZfYx+AdEBFt/amOReFaKm5iGa0nqB07BKtweL+Rar2nnGU39j
         5YxA==
X-Gm-Message-State: ANoB5pl3XhtU2NnWO415ZjfYvs09DXvREJvlz/K/zlooPAsdvnX4SBR7
        UqRC/sk+AApwoJkOJ+AFDHz6/adEFpQ=
X-Google-Smtp-Source: AA0mqf6PvQ4fOdkHFl+Csgw266QdH7t4kRleEdJRdXouWZ7YkvN6IUX6AZsnbtDF8zxuWuMoeu1eng==
X-Received: by 2002:a5d:5045:0:b0:242:199a:e067 with SMTP id h5-20020a5d5045000000b00242199ae067mr17233637wrt.148.1670099000028;
        Sat, 03 Dec 2022 12:23:20 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:19 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/41] Document nullability of syscall parameters
Date:   Sat,  3 Dec 2022 21:22:36 +0100
Message-Id: <20221203202317.252789-1-alx@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

This patch set documents which parameters of syscalls accept NULL.
Actually, some syscalls may also accept it (but return always an error),
but per the recent discussion on the glibc mailing list, I decided to
ignore that behavior and treat them as if they were _Nonnull.

So when a function is documented with a _Nullable parameter, it means
that calling the function with NULL is meaningful.

I decided to use one of the Clang qualifiers because the
[[gnu::nonnull]] attribute is not as precise (for example in the case of
pointers to pointers).

I decided to use _Nullable and not _Nonnull because there are many more
functions that don't accept NULL than those that do, so _Nullable is the
least noisy.

When POSIX or other systems are more restrictive than GNU/Linux, I chose
to be more restrictive in the prototype, to avoid confusion (this is
similar to what was done with 'restrict', which was specified if any
system or POSIX used it, even if glibc didn't require restrict --maybe
those were glibc bugs--).


Cheers,

Alex



Alejandro Colomar (41):
  accept.2: SYNOPSIS: Add _Nullable
  acct.2: SYNOPSIS: Add _Nullable
  clock_getres.2: SYNOPSIS: Add _Nullable
  clock_nanosleep.2: SYNOPSIS: Add _Nullable
  clone.2: SYNOPSIS: Add _Nullable
  copy_file_range.2: SYNOPSIS: Add _Nullable
  epoll_ctl.2: SYNOPSIS: Add _Nullable
  epoll_wait.2: SYNOPSIS: Add _Nullable
  execve.2: SYNOPSIS: Add _Nullable
  execveat.2: SYNOPSIS: Add _Nullable
  fanotify_mark.2: SYNOPSIS: Add _Nullable
  getcpu.2: SYNOPSIS: Add _Nullable
  getgroups.2: SYNOPSIS: Add _Nullable
  getitimer.2: SYNOPSIS: Add _Nullable
  getrlimit.2: SYNOPSIS: Add _Nullable
  gettimeofday.2: SYNOPSIS: Add _Nullable
  listxattr.2: SYNOPSIS: Add _Nullable
  mount.2: SYNOPSIS: Add _Nullable
  nanosleep.2: SYNOPSIS: Add _Nullable
  pidfd_send_signal.2: SYNOPSIS: Add _Nullable
  poll.2: SYNOPSIS: Add _Nullable
  quotactl.2: SYNOPSIS: Add _Nullable
  recv.2: SYNOPSIS: Add _Nullable
  request_key.2: SYNOPSIS: Add _Nullable
  select.2: SYNOPSIS: Add _Nullable
  semop.2: SYNOPSIS: Add _Nullable
  sendfile.2: SYNOPSIS: Add _Nullable
  shmop.2: SYNOPSIS: Add _Nullable
  sigaction.2: SYNOPSIS: Add _Nullable
  sigaltstack.2: SYNOPSIS: Add _Nullable
  sigprocmask.2: SYNOPSIS: Add _Nullable
  sigwaitinfo.2: SYNOPSIS: Add _Nullable
  splice.2: SYNOPSIS: Add _Nullable
  time.2: SYNOPSIS: Add _Nullable
  timer_create.2: SYNOPSIS: Add _Nullable
  timer_settime.2: SYNOPSIS: Add _Nullable
  timerfd_create.2: SYNOPSIS: Add _Nullable
  utime.2: SYNOPSIS: Add _Nullable
  utimensat.2: SYNOPSIS: Add _Nullable
  wait.2: SYNOPSIS: Add _Nullable
  wait4.2: SYNOPSIS: Add _Nullable

 man2/accept.2            |  8 ++++----
 man2/acct.2              |  2 +-
 man2/clock_getres.2      |  2 +-
 man2/clock_nanosleep.2   |  2 +-
 man2/clone.2             | 10 ++++++----
 man2/copy_file_range.2   |  4 ++--
 man2/epoll_ctl.2         |  2 +-
 man2/epoll_wait.2        |  7 ++++---
 man2/execve.2            |  4 ++--
 man2/execveat.2          |  3 ++-
 man2/fanotify_mark.2     |  4 ++--
 man2/getcpu.2            |  3 ++-
 man2/getgroups.2         |  2 +-
 man2/getitimer.2         |  2 +-
 man2/getrlimit.2         |  5 +++--
 man2/gettimeofday.2      |  4 ++--
 man2/listxattr.2         |  6 +++---
 man2/mount.2             |  2 +-
 man2/nanosleep.2         |  3 ++-
 man2/pidfd_send_signal.2 |  5 ++---
 man2/poll.2              |  3 ++-
 man2/quotactl.2          |  4 ++--
 man2/recv.2              |  4 ++--
 man2/request_key.2       |  2 +-
 man2/select.2            | 16 +++++++++-------
 man2/semop.2             |  2 +-
 man2/sendfile.2          |  5 +++--
 man2/shmop.2             |  3 ++-
 man2/sigaction.2         |  5 +++--
 man2/sigaltstack.2       |  4 ++--
 man2/sigprocmask.2       | 15 ++++++++-------
 man2/sigwaitinfo.2       |  4 ++--
 man2/splice.2            |  6 +++---
 man2/time.2              |  2 +-
 man2/timer_create.2      |  3 ++-
 man2/timer_settime.2     |  2 +-
 man2/timerfd_create.2    |  2 +-
 man2/utime.2             |  6 ++++--
 man2/utimensat.2         |  4 ++--
 man2/wait.2              |  4 ++--
 man2/wait4.2             |  7 ++++---
 41 files changed, 100 insertions(+), 83 deletions(-)

-- 
2.38.1

