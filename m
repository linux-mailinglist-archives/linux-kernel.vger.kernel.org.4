Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4F66F9125
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 12:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjEFKdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 06:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjEFKdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 06:33:20 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDF972BA
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 03:33:19 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-54f9e2d0714so3969917b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 03:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683369198; x=1685961198;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pu7agQuYInO0yxZQecLTsewqB2PE2KJ8IfPCfiCnNHk=;
        b=3Kyv4bY+c218oKiE6dBD03v3LZEd7lL9KvnXZSdggGiOlrmbSKizXs8YzQ1bnwxbS8
         6w6eJVaiUo6pbFEh+cUBHB9+At0oIPc4TY3MarDY53xW4dxckH41DpmZRhuvf14d5Xlg
         KJtNGtHZR0T9g/fgwncr7jxPAYQdxepxWWk1cZPZxg292wqBJdkLV2LNdsXdUL8I58ip
         /pGX37rxXbtVeFapS5TxsAfmtazv88fwyDt/QOAlnGaGYJ9lNp8s+xARJApWhGWdMw3q
         BtNuXyUI582O7BGjrZjepVHK0ppin5OxSvR23QDdyckqtBGAWn19v8/naONu0D+HNsbR
         X7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683369198; x=1685961198;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pu7agQuYInO0yxZQecLTsewqB2PE2KJ8IfPCfiCnNHk=;
        b=ZDtaQ7A40MDWK1l/1iarEhOH97y0B4F5S3eBlB0Cr4DE/NLMyVwdLTh3NsHYMEzNZE
         VIMZuEF0+UnX4igiksFGOC0QUi4bz027GAur7iQE/cCJk1nkodlQ4QQW2CoHmjOzlN0z
         8PsqykPub07TbtXWn7HJdcZF+wuChM2gH6mbVgav8wVCGVuZK4vOxJEB40ZGTeFPJ+Zh
         q1zff/JZc7+2uK58TUErYq+o2anloojGe8nQUUxG7MQkna8qhjNcPiUbpbASttyi2L8k
         XRp7JJxtx/TqBiA6cmIUsZzwFCTYgKyna93nrvDAr59dCCR3PmxyeokIjkcg6M+BUZLr
         nEFg==
X-Gm-Message-State: AC+VfDzDiDmVgzIYNLks0cYK4EOo4PKeiSgbDVwjxi7ZBsIaDMjyo/Z/
        5cTknGFbhyNzXueggGijOBcBUg==
X-Google-Smtp-Source: ACHHUZ7LvNkLRWgY+wEuQgeLj+Ofpal2XloJPvG9p4IBbDjjrgCYbAdpByUumjxvWNyNY2AMIt2dXw==
X-Received: by 2002:a81:1d07:0:b0:55d:7fd0:e3b9 with SMTP id d7-20020a811d07000000b0055d7fd0e3b9mr4673857ywd.1.1683369198504;
        Sat, 06 May 2023 03:33:18 -0700 (PDT)
Received: from [172.20.2.186] ([12.153.103.3])
        by smtp.gmail.com with ESMTPSA id k4-20020a0dc804000000b00555ca01b115sm1051375ywd.104.2023.05.06.03.33.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 03:33:17 -0700 (PDT)
Message-ID: <26aba1b5-8393-a20a-3ce9-f82425673f4d@kernel.dk>
Date:   Sat, 6 May 2023 04:33:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Pipe FMODE_NOWAIT support
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's the revised edition of the FMODE_NOWAIT support for pipes, in
which we just flag it as such supporting FMODE_NOWAIT unconditionally,
but clear it if we ever end up using splice/vmsplice on the pipe. The
pipe read/write side is perfectly fine for nonblocking IO, however
splice and vmsplice can potentially wait for IO with the pipe lock held.

Please pull!


The following changes since commit 457391b0380335d5e9a5babdec90ac53928b23b4:

  Linux 6.3 (2023-04-23 12:02:52 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/pipe-nonblock-2023-05-06

for you to fetch changes up to afed6271f5b0d78ca1a3739c1da4aa3629b26bba:

  pipe: set FMODE_NOWAIT on pipes (2023-04-25 14:08:59 -0600)

----------------------------------------------------------------
pipe-nonblock-2023-05-06

----------------------------------------------------------------
Jens Axboe (2):
      splice: clear FMODE_NOWAIT on file if splice/vmsplice is used
      pipe: set FMODE_NOWAIT on pipes

 fs/pipe.c   |  3 +++
 fs/splice.c | 34 ++++++++++++++++++++++++++++++----
 2 files changed, 33 insertions(+), 4 deletions(-)

-- 
Jens Axboe

