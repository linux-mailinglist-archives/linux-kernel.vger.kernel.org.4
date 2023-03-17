Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDDD6BEB1C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjCQOZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjCQOZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:25:52 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07916BCBB8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:25:50 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id r4so2834920ila.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679063149; x=1681655149;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2p2CUhIvsIV018a8ZSlFgQ3zlVEcQ2/v9OhzU3Atnhs=;
        b=PCf+H4Nqqd52N4v//r7DysAg/Vcpsa22ZGsVjWanidwqLUnW26KPl1lC4EEa723Q5Q
         1nr+dDLFEYC66wboYQ6QSe8XzZ5NVnjtaxMvfbavlQGLA2/ES6RK1PXU5S+vGdxb8k+F
         H5IKgHmnM34hzjgBPjSQNTWrker2VxSkbCGFfmQrVa4YLkUnLeOhG2U3CrDw8klvRleO
         X3C77RSN2PqedLH0uVlGfGGnKJaXxuZJ/HG6zhjN8ZhDplgHsi3TfYKpJErZYvQaVmyG
         ew1oER4K1lWnaF1Qllu6lbCea1CH0xNlRWFVmbMW2q12C75StvlX1Oftn9nVH22wUu7j
         i+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679063149; x=1681655149;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2p2CUhIvsIV018a8ZSlFgQ3zlVEcQ2/v9OhzU3Atnhs=;
        b=EvLvclSroTwMjWJYNvGjsvq4oLKDWx2UA76gdBsB4fuolXJvOLyPbwNeWQOreETFdc
         p0n8D12kTgTryXbEdcEvLYZrAbB6mWUd9P6H11KUcA3mze8BA4vp02fIRlv51NGwP+di
         vU7Qhvyko3bYinSFoQaIWgDsaYl+nO8+igFEvjgNda2KHu6lE7fbKwvIIER6975TQhOV
         Ddh/Wam0CZXtzArTG6PSblDIa1FKaSIcuXkgrdq7SKl1EHCxgWOZVBPBapVk2t4mSh7C
         y2vCCi5B5bm2imGXJoXFnzhO+OKas1sMl77qwEvJEgTOdJNWxhX75BW+bwIZtA9WkPwY
         OumQ==
X-Gm-Message-State: AO0yUKUBxEQFN/127p9Z25V7k7u8lhbaEFqhGP64J6O60eFnxKeOLuSN
        mfo/XrF/qRD8Gt+HxYEt89iPJWScfO55mRaKDRMTbg==
X-Google-Smtp-Source: AK7set/i6lNRTCFj0GTvMl4IudVQiLW4GHLxlBPyxY/ouyWzURSvJ+jggFHPi3pYbnY/u1nwYyuuLw==
X-Received: by 2002:a92:c266:0:b0:317:36d8:cfc6 with SMTP id h6-20020a92c266000000b0031736d8cfc6mr4372418ild.3.1679063149130;
        Fri, 17 Mar 2023 07:25:49 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id r23-20020a02b117000000b00406328003a4sm724854jah.65.2023.03.17.07.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 07:25:48 -0700 (PDT)
Message-ID: <25fccb43-8338-a690-0009-384dc0640169@kernel.dk>
Date:   Fri, 17 Mar 2023 08:25:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, acme@kernel.org
Cc:     linux-perf-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: NMI reason 2d when running perf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When running perf on my Dell R7525 on a running process, I get a ton of:

[  504.234782] Dazed and confused, but trying to continue
[  504.267843] Uhhuh. NMI received for unknown reason 2d on CPU 48.
[  504.267846] Dazed and confused, but trying to continue
[  504.335975] Uhhuh. NMI received for unknown reason 2d on CPU 48.
[  504.335977] Dazed and confused, but trying to continue
[  504.368031] Uhhuh. NMI received for unknown reason 2d on CPU 48.
[  504.368033] Dazed and confused, but trying to continue
[  504.371037] Uhhuh. NMI received for unknown reason 2d on CPU 48.
[  504.371038] Dazed and confused, but trying to continue
[  504.439165] Uhhuh. NMI received for unknown reason 2d on CPU 48.
[  504.439167] Dazed and confused, but trying to continue

spew in dmesg. The box has 2x7763 CPUS. This seems to be a recent
regression, been using this box for a while and haven't seen this
before. The test being traced is pinned to CPU 48. The box is currently
running:

commit 6015b1aca1a233379625385feb01dd014aca60b5 (origin/master, origin/HEAD)
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue Mar 14 19:32:38 2023 -0700

    sched_getaffinity: don't assume 'cpumask_size()' is fully initialized

with the pending block/io_uring branches merged in for testing.

-- 
Jens Axboe

