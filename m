Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE78E65667C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 02:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbiL0Bcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 20:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbiL0Bcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 20:32:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0749389E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 17:32:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F358B8069F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 01:32:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D428DC433F1;
        Tue, 27 Dec 2022 01:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672104749;
        bh=Sm6tXr3yNFCUNf85oYBS5NHm7gc9058DgQHZ5OKhgl4=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=gWDsF8I2kE0GZF4aO2EdWsLiNS5NtwTtwxQTB3yAhqO12ISV6W4rsSjMTLJBcEaAZ
         0MgLOm4J/4dOp1Gn4R04vvttv3Li30uB4zGirFRA+cUcLi9sGbiEm4Diih/sjRcSZv
         xJxOwCRD4bKvXlq01m2MIv/vDwApzdWnfq47bmxEY28kZiUvizPRZWkz/Ol5+XzoLC
         7+3FGsdgD/uwRkYajD3c+1nt32yHqE+08rChi7NLMw5wiS0QH8GiCOxKyo9yi6lW1M
         iyWB/exqhLs+SgvJB2+dg9oZY1OMHP8sYx7+j6tF3pmiKSiAElP7najTDNHoxyEB7Z
         ekDvoKhxO6HaQ==
Date:   Mon, 26 Dec 2022 17:32:28 -0800
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
In-Reply-To: <20221227002941.GA2691687@roeck-us.net>
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com> <20221226195206.GA2626419@roeck-us.net> <CAHk-=whD1zMyt4c7g6-+tWvVweyb-6oHMT_+ZVHqe1EXwtFpCQ@mail.gmail.com> <DA632860-284E-4923-8863-9D2745DD289E@kernel.org> <20221227002941.GA2691687@roeck-us.net>
Message-ID: <D8BDBF66-E44C-45D4-9758-BAAA4F0C1998@kernel.org>
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

On December 26, 2022 4:29:41 PM PST, Guenter Roeck <linux@roeck-us=2Enet> w=
rote:
>On Mon, Dec 26, 2022 at 01:03:59PM -0800, Kees Cook wrote:
>> On December 26, 2022 12:56:29 PM PST, Linus Torvalds <torvalds@linux-fo=
undation=2Eorg> wrote:
>> >On Mon, Dec 26, 2022 at 11:52 AM Guenter Roeck <linux@roeck-us=2Enet> =
wrote:
>> >>
>> >> fs/f2fs/inline=2Ec: In function 'f2fs_move_inline_dirents':
>> >> include/linux/fortify-string=2Eh:59:33: error: '__builtin_memset' po=
inter overflow between offset [28, 898293814] and size [-898293787, -1] [-W=
error=3Darray-bounds]
>> >> fs/f2fs/inline=2Ec:430:9: note: in expansion of macro 'memset'
>> >>   430 |         memset(dst=2Ebitmap + src=2Enr_bitmap, 0, dst=2Enr_b=
itmap - src=2Enr_bitmap);
>> >>       |         ^~~~~~
>> >
>> >Well, that's unfortunate=2E
>>=20
>> I'll look into this=2E
>>=20
>
>I did some more testing=2E The problem is seen with gcc 11=2E3=2E0, but n=
ot with
>gcc 12=2E2=2E0 nor with gcc 10=2E3=2E0=2E

That's what I'd expect: 10 didn't have variable range tracking wired up to=
 -Warray-bounds, 11 does, and we disable -Warray-bounds on 12 because of 3 =
separate 12-only GCC bugs=2E

> gcc bug ? Should I switch to gcc 12=2E2=2E0 for
>powerpc when build testing the latest kernel ?

Sure? But that'll just hide it=2E I suspect GCC has found a way for dst=2E=
nr_bitmap to be compile-time 27, so the size is always negative=2E


--=20
Kees Cook
