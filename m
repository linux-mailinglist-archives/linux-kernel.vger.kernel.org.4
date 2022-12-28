Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D0D657264
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 04:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiL1Dkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 22:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiL1Dkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 22:40:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5466E53
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 19:40:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 598F5612E4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 03:40:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98716C433D2;
        Wed, 28 Dec 2022 03:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672198830;
        bh=ha35eFq9jwy11rw0xahqaZm/PgmnOe7c6uOAQU9WB38=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=n4Wd48Eg2+48RDcgI04y8/tNSQ12+0Hp+7D+d5qHOQqirvdCs4KE8qvP5PZTRvSCB
         zAFdUWZtTSoejc/5ZICjJnBqj30JeO4KX/bNOSoiRJHwW18ixLpUs7xU06eMiti5bt
         v84GCfKx8UyD0XBeF6bjBrNkioEgEmebgFijv7S/xRS68Ea9pMKTPlh3EJ7jRtNa+4
         o9+/9yzZLKGKqE566BauV2w3g+NhmI4I1yKFvhtgiCHGFjwtyprjpJnyDq/hBFp6EL
         8q1fuVjBENpTBvZGPR5lup+GUtMkTUlAkBH6AImyoFBho1T4wFO1VyFtcAEZp9k/DX
         QMe7iI6cHZdhA==
Date:   Tue, 27 Dec 2022 19:40:30 -0800
From:   Kees Cook <kees@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: Linux 6.2-rc1
User-Agent: K-9 Mail for Android
In-Reply-To: <20221227055212.GA2711289@roeck-us.net>
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com> <20221226195206.GA2626419@roeck-us.net> <CAHk-=whD1zMyt4c7g6-+tWvVweyb-6oHMT_+ZVHqe1EXwtFpCQ@mail.gmail.com> <DA632860-284E-4923-8863-9D2745DD289E@kernel.org> <20221227002941.GA2691687@roeck-us.net> <D8BDBF66-E44C-45D4-9758-BAAA4F0C1998@kernel.org> <20221227055212.GA2711289@roeck-us.net>
Message-ID: <DE30CDA1-CFF4-49FE-B653-F4CA831EAA12@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On December 26, 2022 9:52:12 PM PST, Guenter Roeck <linux@roeck-us=2Enet> w=
rote:
>On Mon, Dec 26, 2022 at 05:32:28PM -0800, Kees Cook wrote:
>> On December 26, 2022 4:29:41 PM PST, Guenter Roeck <linux@roeck-us=2Ene=
t> wrote:
>> >On Mon, Dec 26, 2022 at 01:03:59PM -0800, Kees Cook wrote:
>> >> On December 26, 2022 12:56:29 PM PST, Linus Torvalds <torvalds@linux=
-foundation=2Eorg> wrote:
>> >> >On Mon, Dec 26, 2022 at 11:52 AM Guenter Roeck <linux@roeck-us=2Ene=
t> wrote:
>> >> >>
>> >> >> fs/f2fs/inline=2Ec: In function 'f2fs_move_inline_dirents':
>> >> >> include/linux/fortify-string=2Eh:59:33: error: '__builtin_memset'=
 pointer overflow between offset [28, 898293814] and size [-898293787, -1] =
[-Werror=3Darray-bounds]
>> >> >> fs/f2fs/inline=2Ec:430:9: note: in expansion of macro 'memset'
>> >> >>   430 |         memset(dst=2Ebitmap + src=2Enr_bitmap, 0, dst=2En=
r_bitmap - src=2Enr_bitmap);
>> >> >>       |         ^~~~~~
>> >> >
>> >> >Well, that's unfortunate=2E
>> >>=20
>> >> I'll look into this=2E
>> >>=20
>> >
>> >I did some more testing=2E The problem is seen with gcc 11=2E3=2E0, bu=
t not with
>> >gcc 12=2E2=2E0 nor with gcc 10=2E3=2E0=2E
>>=20
>> That's what I'd expect: 10 didn't have variable range tracking wired up=
 to -Warray-bounds, 11 does, and we disable -Warray-bounds on 12 because of=
 3 separate 12-only GCC bugs=2E
>>=20
>> > gcc bug ? Should I switch to gcc 12=2E2=2E0 for
>> >powerpc when build testing the latest kernel ?
>>=20
>> Sure? But that'll just hide it=2E I suspect GCC has found a way for dst=
=2Enr_bitmap to be compile-time 27, so the size is always negative=2E
>>=20
>dst=2Enr_bitmap is initialized with SIZE_OF_DENTRY_BITMAP,
>which is defined as:
>
>#define NR_DENTRY_IN_BLOCK      214     /* the number of dentry in a bloc=
k */
>#define SIZE_OF_DIR_ENTRY       11      /* by byte */
>#define SIZE_OF_DENTRY_BITMAP   ((NR_DENTRY_IN_BLOCK + BITS_PER_BYTE - 1)=
 / \
>                                        BITS_PER_BYTE)
>
>((214 + 8 - 1) / 8 =3D 27, so dst=2Enr_bitmap is indeed compile-time 27=
=2E
>
>Not sure how would know that src=2Enr_bitmap can be > 27, though=2E
>Am I missing something ?

I think it's saying it can't rule out it being larger? I=2Ee=2E there is n=
o obvious bounds checking for it=2E Perhaps:

if (src=2Enr_bitmap > dst=2Enr_bitmap) {
    err =3D -EFSCORRUPTED;
		goto out;
}


-Kees


--=20
Kees Cook
