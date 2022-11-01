Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574D3615560
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiKAW7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiKAW7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:59:12 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9668266B;
        Tue,  1 Nov 2022 15:59:10 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9DA07378;
        Tue,  1 Nov 2022 22:59:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9DA07378
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1667343550; bh=JmKSz1EXF2soYM3nAP/FeBNnUyNfKI5tcZWQF19jA74=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=k5cORtTfPNGBvfEdwmOlSSXT4BXbJwVuoCUSJIF4gKRUdlwCVLgYG5uD4GdwzxelK
         kCwEbaRpm3DvILrOh73PqC02i1voWETvAc4dBe0f/KaMIysQmaCr5iic11aHNVjQ4D
         ZFtr3VK3Lv3tK5sX8iONoW4psgCrEcKlDhhHkgh8hUFAkT2oj5hrwrC7E1Bn+4f6Fd
         XGAQ6od82wnscrimG4HvpGyMQNn5SJBNuBQSUCqJ4YAtHqqyU4lkFCuV4drStRgwQw
         FrarPloFShPucMN7MEIynFbq/QsF9IrLEF9SKJHlDAQ+mk8t7HT5zgn3JOfWIGYETH
         mKoiWbTjKaXKA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bilbao@vt.edu, bagasdotme@gmail.com, willy@infradead.org,
        akiyks@gmail.com, miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH v3 0/2] Documentation: Start Spanish translation and
 include HOWTO
In-Reply-To: <5fd2092e-2f3e-27c0-66a9-94e02efa1e8d@amd.com>
References: <20221024145521.69465-1-carlos.bilbao@amd.com>
 <87wn8ext0m.fsf@meer.lwn.net>
 <5fd2092e-2f3e-27c0-66a9-94e02efa1e8d@amd.com>
Date:   Tue, 01 Nov 2022 16:59:09 -0600
Message-ID: <87edumxow2.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Bilbao <carlos.bilbao@amd.com> writes:

> On 11/1/22 16:30, Jonathan Corbet wrote:
>
>>=20
>>
>> I went to apply this series just now, and got the following from "git
>> am":
>>
>> WARNING: Message contains suspicious unicode control characters!
>>           Subject: [PATCH v3 2/2] Documentation: Add HOWTO Spanish trans=
lation into rst based build system
>>              Line: +estable m=C3=A1s reciente del kernel, y no est=C3=A1=
n interesados =E2=80=8B=E2=80=8Ben ayudar a probar
>>              -----------------------------------------------------------=
----^
>>              Char: ZERO WIDTH SPACE (0x200b)
>>           If you are sure about this, rerun with the right flag to allow.
>>
>> Any idea what the story is there?  Could I get a resend without that
>> problem?
> Just tried to apply git am and didn't get any warning. Maybe you are using
> an extra flag? I'm running with git version 2.34.1. Could you try replaci=
ng
> the offending char with a space? Hopefully that solves it.

I'm sorry, it was b4 that complained, not git.  To see it happen, try:

  b4 am 20221024145521.69465-1-carlos.bilbao@amd.com

There were, in fact, two zero-width spaces in there, and two more in
Junio Hamano's name.  I've taken them all out, and learned all about
searching for weird characters in Emacs as a side benefit :)

Series is now applied, thanks.

jon
