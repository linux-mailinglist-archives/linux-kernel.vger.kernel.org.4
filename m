Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843FF698327
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 19:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjBOSUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 13:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjBOSUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 13:20:49 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1D525E0E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 10:20:48 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id mg23so12443419pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 10:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ngfthk39UuE8LQIlzioHOnXbEp30RrwAPLvsiKFP2/k=;
        b=Fdkqv8o31HwSzEZhT/7++HjFN/ca0KGhqpZfla2Uh8lxNnFLbWHg45ymP16VxoWoUq
         OqWGkfrjODXnZS9gfM8xg2r3bc8dzYDUmqJUlbNPhpZKwKN48dRfVU8kwEYCc95q6EZc
         Gr0fzgwyCpK2UaoVOr5UVvnbCkOB1eLtbbaJIBg0W2pjupRlnTac9qa3GS1Wi/ChAAUQ
         cdCCPo70P8D3TmUBRd30U8AMzJkAdRLSwZ55MAsGf+qLN8CMChya4L5VRjSU1H4hhllY
         0Ou0ZvosxC2RTCFIzvx+MTPViltu6P2anvPFwXIYwJD4I5BpPDv7nHn9BasrCONt8MN5
         sXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngfthk39UuE8LQIlzioHOnXbEp30RrwAPLvsiKFP2/k=;
        b=upWKrFqCmYlFF6hMm3vAcAYSsK1lv08AFot2tLqB+TA/9G4YzULFvm837fgjmKCdlf
         hb6zU6GGVBhwzM8wS42S2oNLJmY7k63PMHeN9lkgTPpZM+gsOZ/CguLNWmQ//CWqR/y9
         1ewy9Dafhz4FD0ow7HYfZ+pJxO1jgpOcun3Xj74+/dXWveXcDPKWKTZ0yMxzliRK9amr
         bUqfiQ25P5cMJ2G9M7B4SFju/12+sNVqQQNkD0qluU86ZyN5jcq0Wtkj00e0cQAglicw
         YCKJLZkMoifL3afZDu3YMPm6Wy0punTeok5ZGJwoH1OOtFiur5QImxhK9UzntNx1jA1e
         DvtA==
X-Gm-Message-State: AO0yUKWGqtVkDZnbDuZF63bUQWIvy8OXxheIIASAjuEbn0hsNhKiXMWb
        WKtRApyiI05lAdA1PcvtaAcHTlTjZVm3BOQzBLU=
X-Google-Smtp-Source: AK7set9AiHG6VEF7zzAidh3sLglj/Q5j2ZXAY20OV0sjtR6hhQ7FBFxoNcgKwkmJU5FLhKjtsQKjBw==
X-Received: by 2002:a05:6a20:2443:b0:be:d368:5c7f with SMTP id t3-20020a056a20244300b000bed3685c7fmr3181285pzc.41.1676485247569;
        Wed, 15 Feb 2023 10:20:47 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id j4-20020aa78dc4000000b00590163e1762sm12011772pfr.200.2023.02.15.10.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 10:20:47 -0800 (PST)
Date:   Wed, 15 Feb 2023 10:20:47 -0800 (PST)
X-Google-Original-Date: Wed, 15 Feb 2023 10:20:45 PST (-0800)
Subject:     Re: [RFC PATCH 0/5] Retire IA64/Itanium support
In-Reply-To: <CAMj1kXFmZYmrZB7QyLCu3rpkChat=PVqPHsOi+HuWRj-FZ2S-g@mail.gmail.com>
CC:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        Arnd Bergmann <arnd@arndb.de>, tony.luck@intel.com,
        jrtc27@jrtc27.com, glaubitz@physik.fu-berlin.de,
        willy@infradead.org, Marc Zyngier <maz@kernel.org>,
        linux@roeck-us.net, Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ia64@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     ardb@kernel.org
Message-ID: <mhng-5f83e606-a48d-4d18-bae1-20a6cc01952e@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2023 09:00:28 PST (-0800), ardb@kernel.org wrote:
> On Wed, 15 Feb 2023 at 17:50, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> On Wed, 15 Feb 2023 02:00:03 PST (-0800), ardb@kernel.org wrote:
>> > The IA64 port of Linux has no maintainer, and according to a report from
>> > its only remaining user [0], it has been broken for a month and nobody
>> > cares.
>> >
>> > Given that keeping a complex but unused architecture alive uses up
>> > valuable developer bandwidth, let's just get rid of it.
>> >
>> > This supersedes my patch proposing to mark it as 'dead', which received
>> > no replies from anyone that wants to keep it alive. [1]
>> >
>> > [0] https://www.spinics.net/lists/linux-ia64/msg21926.html
>> > [1] https://lore.kernel.org/all/20230128122904.1345120-1-ardb@kernel.org/
>> >
>> > Cc: Jonathan Corbet <corbet@lwn.net>
>> > Cc: Arnd Bergmann <arnd@arndb.de>
>> > Cc: Tony Luck <tony.luck@intel.com>
>> > Cc: Jessica Clarke <jrtc27@jrtc27.com>
>> > Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>> > Cc: Matthew Wilcox <willy@infradead.org>
>> > Cc: Marc Zyngier <maz@kernel.org>
>> > Cc: Guenter Roeck <linux@roeck-us.net>
>> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> > Cc: linux-ia64@vger.kernel.org
>> >
>> > Ard Biesheuvel (5):
>> >   arch: Remove Itanium (IA-64) architecture
>> >   kernel: Drop IA64 support from sig_fault handlers
>> >   Documentation: Drop IA64 from feature descriptions
>> >   lib/raid6: Drop IA64 support
>> >   Documentation: Drop or replace remaining mentions of IA64
>>
>> Not sure if I'm missing it in the diff, but it looks like there's also a
>> bunch of "#ifdef __ia64__" and "#ifdef __IA64__" type code spread
>> throughout the kernel.  I didn't look at the actual diff, but it's in
>> files that aren't showing up in the diffstat.
>>
>
> Thanks for taking a look. It seems I indeed missed a couple.
>
>> Just "git grep -i __ia64__" lists a bunch.  I didn't look at all of
>> them, but at least spot checking include/acpi/actypes.h looks like it's
>> a real Itanium workaround.  If the arch goes, it's probbaly worth
>> removing those too?
>>
>
> The ACPI code is synced with another project, so I didn't touch it.
> Same goes for some other header files where IA-64 is referenced, e.g.,
> in the PE/COFF header stuff.

Thanks, I didn't know that.  Pretty sure there's some scattered in 
drivers, but...

>> There's also some mentions of "Itanium" in Documentation outside that
>> don't look like they got caught here.  Not sure if they'd be worth
>> getting rid of, though as they could still be useful examples.  The
>> blurb in Documentation/memory-barriers.txt looks pretty port-specific,
>> though.
>>
>
> Yeah, I don't think it is necessary to rewrite history soviet-style,
> so some remaining references are fine IMHO.

That seems reasonable to me -- assuming the port goes the rest is just 
dead code so it'll filter out over time (presumably all over userspace 
too, which will take a while).
