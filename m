Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C99E66042A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 17:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbjAFQWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 11:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjAFQWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 11:22:23 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9F876232
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 08:22:22 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id u8so1179715ilq.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 08:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKrvk1I9tbRGAfYUm/gW03wBpG8HJIHL12UJBL3z+To=;
        b=fVYFOFMxnEtwpvEBp/4AqzXW+zluAxvyP7nkCgzHEaud074vcfUE3ZncxZDiu7X95Y
         Qy98Xao9awJP3YikhKgBy/5Yb6sDo9m1hKAGo/IeA3Cx6/Kg4W4HTC2zLcjeJWkMb1Im
         rTVHJvkAzBqDRnUIph463le/BMVN4/M1zXZWLO3erBdaDVtiq65WTgncbjmmcEc32q3K
         Hz6F0hnK40L53BbpNNaFjNVOD0pD548PB0sSVQ1il8u7Y7+1ndllfIv0tYnfUb+TA/fy
         /oMH32zZ4x9mDRmgaXHAdmMEPzf5DsMY5/ZgzpHHpBvHs4qbaTB3v3aMC2xDX7OOzDVl
         vHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hKrvk1I9tbRGAfYUm/gW03wBpG8HJIHL12UJBL3z+To=;
        b=o9SjidGJoISK0BgkcvTM4Y/a4TO0YvPrr+k3VQQ1/fEeIjH8PhHLgHiF7RmY3zp+L5
         OoEP6d3q6LorSDpyf63Mmy1n1GOWzkC5nsOCv+xX+SRJoIhkjqWbQqEI1syEDP8EGkiA
         y5w+4HCSI8OjctAqTAtxBzqKsovgBvMJGeNne2jCgw3ZQZnA2YpGUOER05y+TF9h65gp
         nBV8OlZpEZR0PZLK5A9p+YGZHbAIJhFhDTKcQBPUA5NHQbhiKWEtZbb1o019kOR/zegh
         BP7D+26TxqpuIvz0FptBiRP9DaHeEcIWz6/qTByozuhfmT2XAGhEg5C4+F2CW0SzQ48f
         PU8w==
X-Gm-Message-State: AFqh2ko0CgZjg8f4UAQHAaUZjXsXh2xaQUAPC5vLKkDN277/9eYR8Yqc
        xWNQ4ezliR4DaeK90HutYnGKwA==
X-Google-Smtp-Source: AMrXdXvEvPmtIoojIiBL1/kmPeh+ZDUHi3K48RiIHh8gjvbg/izfk3kjc5riyQ4Zp/9jT/vpeURfrw==
X-Received: by 2002:a92:c151:0:b0:303:9c30:7eff with SMTP id b17-20020a92c151000000b003039c307effmr8334031ilh.2.1673022141595;
        Fri, 06 Jan 2023 08:22:21 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a17-20020a92d591000000b0030be6c79645sm469642iln.68.2023.01.06.08.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 08:22:21 -0800 (PST)
Message-ID: <7839c5ff-13d2-9542-546b-d9cd3e527187@kernel.dk>
Date:   Fri, 6 Jan 2023 09:22:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] ARM TIF_NOTIFY_SIGNAL fixup
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

Hi Linus,

Hui Tang reported a performance regressions with _TIF_WORK_MASK in
newer kernels, which he tracked to a change that went into 5.11. After
this change, we'll call do_work_pending() more often than we need to,
because we're now testing bits 0..15 rather than just 0..7.

Shuffle the bits around to avoid this.

Please pull!


The following changes since commit 69b41ac87e4a664de78a395ff97166f0b2943210:

  Merge tag 'for-6.2-rc2-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux (2023-01-02 11:06:18 -0800)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/tif-notify-signal-2023-01-06

for you to fetch changes up to 191f8453fc99a537ea78b727acea739782378b0d:

  ARM: renumber bits related to _TIF_WORK_MASK (2023-01-04 07:55:02 -0700)

----------------------------------------------------------------
tif-notify-signal-2023-01-06

----------------------------------------------------------------
Jens Axboe (1):
      ARM: renumber bits related to _TIF_WORK_MASK

 arch/arm/include/asm/thread_info.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

-- 
Jens Axboe

