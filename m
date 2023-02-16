Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C067698C08
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjBPFdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBPFdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:33:01 -0500
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB0AB76D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:32:56 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id i4so634707vkn.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20210112.gappssmtp.com; s=20210112; t=1676525575;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HsyCa4qZ8zblrP/1Ar6ck7otvAlYM3tSElZO/ohODIw=;
        b=g0EYq17FgxoqVL/d7fMXR4B6DGC6hhBHpL1ZZImljOc2NBjdOjtF8scC80uHUxYsTb
         7JceBBk7mVYMbucjsbGpW2JxQm3EkkPLDGWoamxFQPGfB7RMkW0Yo3N7OEiV/OmoqjHb
         TeUXxCtYZDKZiQlR6GW+oa1kHpwaBr8tsTRv6GzJcC82XQ5Rj5VoiptGOyplYaz/OMnP
         MCN1QzrOE0b/E46yqKwHDzOxfxBWIxBFvgWQeaOFQyVC3I3vJ66858RAqo67VmiVqsPh
         hzwt6BrSKSIflhQGLunbJVoSeyF02glS8s1+kGVWSKxCObxIEPvLYGWAdbM91fLIIikP
         3Mww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676525575;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HsyCa4qZ8zblrP/1Ar6ck7otvAlYM3tSElZO/ohODIw=;
        b=lLu0mRbj5Uo6O6XoHQpSA8/kkAmtWv+Gk9grWtgHEkLQz8CggX7CmKlLpg5nNqsgtO
         LuaSF05jxFmb7KXd3Pyz6WRVxTJaUlKpnG311c4lJ/toCy0TOAaE7WbDI7kOSdAWPxzC
         m6rPwZZA8zuUICJ7TQPP1Q8+EPuX6c72l6LkQkpN9KnsXcwS+kZJhA4DcgnJcR0P8XK5
         6ZTb/lA5N8flCKRzTO1hLIFhYV5Ym/AHBT7Esd6d9vcmAcGlUQpkTB+BIQVIhm15Pwgw
         YYZ7RxkPvcJr7hqNTPqTDhUU+5DMk9blLrS0PYhEWqqNKcgtFWplB8UVXpEJ7LEKZ5Vx
         r6EA==
X-Gm-Message-State: AO0yUKXiCr7GoUNZkgUYJD7Vm2vVoB7M8wHcUNeFhEOzZfc/hdqb35im
        rFB53ufZBQDtUix+vBTzcTgWCdi8vcG1mbsqzDYYPje/MT8mi32A
X-Google-Smtp-Source: AK7set91SDBSprweROGSxFxvLHWRk6jWUA2ecvsXeu63BHrYuvcpU7xhxeS85kaGX682U26mJFQir1lcf8IBn9uPEcI=
X-Received: by 2002:a05:6122:1462:b0:401:a48d:3d with SMTP id
 r2-20020a056122146200b00401a48d003dmr718120vkp.14.1676525575513; Wed, 15 Feb
 2023 21:32:55 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6130:1015:b0:559:9619:d862 with HTTP; Wed, 15 Feb 2023
 21:32:54 -0800 (PST)
X-Originating-IP: [24.53.241.2]
In-Reply-To: <Y+z4XlhDzokAMTI1@x1n>
References: <CADyTPExpEqaJiMGoV+Z6xVgL50ZoMJg49B10LcZ=8eg19u34BA@mail.gmail.com>
 <Y9bvwz4FIOQ+D8c4@x1n> <CADyTPEzsvdRC15+Z5T3oryofwRYqHmHzwqRmJKJoHB3d7Tdayw@mail.gmail.com>
 <91b38494-f296-d01d-3b98-6bc51406cad0@leemhuis.info> <Y+z4XlhDzokAMTI1@x1n>
From:   Nick Bowler <nbowler@draconx.ca>
Date:   Thu, 16 Feb 2023 00:32:54 -0500
Message-ID: <CADyTPEzcJxgFgQAwopsHz3b-e+hmHJqidpjzDhow8KkkAyyo8g@mail.gmail.com>
Subject: Re: PROBLEM: sparc64 random crashes starting w/ Linux 6.1 (regression)
To:     Peter Xu <peterx@redhat.com>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-15, Peter Xu <peterx@redhat.com> wrote:
> On Wed, Feb 15, 2023 at 03:49:56PM +0100, Linux regression tracking
> (Thorsten Leemhuis) wrote:
>> On 31.01.23 02:46, Nick Bowler wrote:
>> > I'll keep running this for a while to see if any other problems come
>> > up.
>>
>> Nick, I assume no other problems showed up?
>>
>> In that case Peter could send the patch in for merging. Or did you do
>> that already?
>
> Thanks for raising this again.  Nop, I'm just waiting for a final ack from
> Nick to make sure that nothing went wrong after the longer run.

Oh, yes, it wasn't so much a "run" as just continuing to use the
computer normally.

Everything seems stable enough.

Cheers,
  Nick
