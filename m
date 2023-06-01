Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709AE71944A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 09:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbjFAHaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 03:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjFAHaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 03:30:18 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B0BFB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 00:30:16 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QWyTH4prsz4x3g;
        Thu,  1 Jun 2023 17:30:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1685604612;
        bh=mTuWQ6XrAwLtgrVCKqHX0Awwg82dw3fzJo1p5TuAc1M=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=QVG5fuZeCFjvAu67mCOoWVFuCwv7UHY0FRhkkOcWRGbsXUsURxHN7oWINLODsw3Pa
         6IYgwTq0/fS/4coE4nwsew1Tt02PKnwhpDTDwvzQmIvCh/f9fNhf9kfkeyVegO/jcP
         XoLDDnwYo2fyBf0cdnOg3fj4VZIVD2Q1/Twy4UEfwkr173fITVAfLr3C4vTeJEsCNS
         kDClqSRr77P3UH21+NN04oFxie1tmU9yllnyrWknE/zp5/BSeEk6dbNY5kCo/nQAeJ
         GsvCrgh3IBcxueYMi1uYP846flz4YaWkgUedQ26WxZAG5jpdowqE6ANyU4xKwGsyNn
         hjBpaTK7V7kuQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org, Finn Thain <fthain@linux-m68k.org>
Subject: Re: [PATCH] MAINTAINERS: Exclude m68k-only drivers from powerpc entry
In-Reply-To: <CAMuHMdUbVmjcYyXmparBm6pQwu3q7HpTKsKfi_aAHGOSX97MUw@mail.gmail.com>
References: <20230531125023.1121060-1-mpe@ellerman.id.au>
 <CAMuHMdUbVmjcYyXmparBm6pQwu3q7HpTKsKfi_aAHGOSX97MUw@mail.gmail.com>
Date:   Thu, 01 Jun 2023 17:30:10 +1000
Message-ID: <87pm6fhc71.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:
> Hi Michael,
>
> CC Finn
>
> On Wed, May 31, 2023 at 2:50=E2=80=AFPM Michael Ellerman <mpe@ellerman.id=
.au> wrote:
>> The powerpc section has a "F:" entry for drivers/macintosh, matching all
>> files in or below drivers/macintosh. That is correct for the most part,
>> but there are a couple of m68k-only drivers in the directory, so exclude
>> those.
>>
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>
> Thanks for your patch!
>
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -11916,6 +11916,8 @@ L:      linuxppc-dev@lists.ozlabs.org
>>  S:     Odd Fixes
>>  F:     arch/powerpc/platforms/powermac/
>>  F:     drivers/macintosh/
>> +X:     drivers/macintosh/adb-iop.c
>> +X:     drivers/macintosh/via-macii.c
>>
>>  LINUX FOR POWERPC (32-BIT AND 64-BIT)
>>  M:     Michael Ellerman <mpe@ellerman.id.au>
>
> LGTM, as there are already entries for these two files under
> "M68K ON APPLE MACINTOSH".
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks.

cheers
