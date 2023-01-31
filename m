Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A04F682184
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 02:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjAaBqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 20:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjAaBqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 20:46:45 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244E41631A
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 17:46:31 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id k6so14621523vsk.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 17:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r0G78tCFuMbUc11f4Np3FVLjYUjXRj+1bSf/D+z772Y=;
        b=mBtK5jkiEPcmqnnUf3pWbeh8X1hzLi8VxrmvPgnBVeR64+mnnmMndwS6dpqTQOgQTV
         GYrR7P3jZQo0pYnE8xyMUtVNrxhSv+1+3CdCnGJjS5kJOjSRSy0v6Su3cI6SYyqauSlB
         vPb8rMkw1MYjQiYj4oaoqHB3JVw4YvTnr2t97GRBiG2II0iD6Qq1DylRNSQrOR5rrmse
         cqXxYh6CCSb4Jd0lCVVJKNNpJGOcQa8yJTUZbSj0XSMK4LNVSLGenAQR4ZBr54k4VZIo
         RCH+zjvb6Bcc9CwtuiKAgBA08gZS+RMrsWymnMqBCPaa1E8w70bbakPcfMlclVt+O1T+
         8ZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r0G78tCFuMbUc11f4Np3FVLjYUjXRj+1bSf/D+z772Y=;
        b=YtoxlNXBcyfGiAcGBmDIPPKMZCqRtdRi8SVzUIDKg4nKfxv0PEdVxkx7upGVT4NlEi
         f0N3pkY0mXVan2JITMLzmEEMddP0ZnfFyHc33G9lkLUV/yzIj6WNmDhuYQNs4epM5s7d
         0F8V66i17XQAgN20E89JiE+1FzeWAsTjmyGplMQhZzN5xpWHhIRPZmYLPcmKeqzyTNmu
         SeXuFvoUBs3kiXCBe1vsacFJqcZyinFhveMyLD5w74qRMbDkkxSGd1QHDBk20JRzhxWq
         O44aNjuA7fCLpSvclea3xD/XWCNlk6my0EeqDVpWv2yZRDQs4b1lq74hJlTAGrLvorE5
         QUqw==
X-Gm-Message-State: AO0yUKVb7kff/cm23KU9BuGc1VqzUOtV9NqF9I39BEK/W8jwaTQ/ypPl
        Tyoop7RoCr/VcRsdrTCe1R6pKevu61FKoatZje1vew==
X-Google-Smtp-Source: AK7set8T18QDx4rAbFvPvwBDlz5oPdhQHy9nhjNv0cUUAZfeKar7Fpa3GKrYmMJRQRPGA3x+F0b5SBaQ6GGUsLHTgr0=
X-Received: by 2002:a67:ecd8:0:b0:3eb:e432:5601 with SMTP id
 i24-20020a67ecd8000000b003ebe4325601mr2837366vsp.16.1675129590180; Mon, 30
 Jan 2023 17:46:30 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6130:1015:b0:559:9619:d862 with HTTP; Mon, 30 Jan 2023
 17:46:29 -0800 (PST)
X-Originating-IP: [24.53.241.20]
In-Reply-To: <Y9bvwz4FIOQ+D8c4@x1n>
References: <CADyTPExpEqaJiMGoV+Z6xVgL50ZoMJg49B10LcZ=8eg19u34BA@mail.gmail.com>
 <Y9bvwz4FIOQ+D8c4@x1n>
From:   Nick Bowler <nbowler@draconx.ca>
Date:   Mon, 30 Jan 2023 20:46:29 -0500
Message-ID: <CADyTPEzsvdRC15+Z5T3oryofwRYqHmHzwqRmJKJoHB3d7Tdayw@mail.gmail.com>
Subject: Re: PROBLEM: sparc64 random crashes starting w/ Linux 6.1 (regression)
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
        regressions@lists.linux.dev,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-29, Peter Xu <peterx@redhat.com> wrote:
> On Sat, Jan 28, 2023 at 09:17:31PM -0500, Nick Bowler wrote:
>> Starting with Linux 6.1.y, my sparc64 (Sun Ultra 60) system is very
>> unstable, with userspace processes randomly crashing with all kinds of
>> different weird errors.  The same problem occurs on 6.2-rc5.  Linux
>> 6.0.y is OK.
[...]
> Could you try below patch to see whether it fixes your problem?  It should
> cover the last piece of possible issue with dirty bit on sparc after that
> patchset.  It's based on latest master branch (commit ab072681eabe1ce0).

Haven't seen any failures yet, so it seems this patch on top of 6.2-rc6
makes things much better.

I'll keep running this for a while to see if any other problems come up.

Thanks,
  Nick
