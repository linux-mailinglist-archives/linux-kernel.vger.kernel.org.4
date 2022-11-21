Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40DA631DA7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiKUKFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiKUKFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:05:00 -0500
X-Greylist: delayed 560 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Nov 2022 02:04:59 PST
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE461EEFB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Reply-To:Content-ID:Content-Description;
        bh=OhAv9HhT3JCF0LrLmmieia1a9etGEyC8D5lE+WIuK/8=; b=Gxfx+IGJ86koKmJjUqNLrpPpQ7
        oEqsTcXwXMhKcJ+sG4XC1fHMYL3t1Oai4reOUsMgaq92VsqtL/SbJVXrhPVjQugCmhB7o82+RyDQT
        FAJ+w6z1U6Mb49Z+Qo3DutSBqOe7Zf3IoPxSK9rgz61abnMY4N3+Hipa3pp6QFi4un3JHQqPGVSt5
        2LgN3eJL5XW7/1rdoi74w1IY6aWZhreYX3pqq5M5z/yx6Sm2DWtPebsf/W8gnunLovf4yQCugKnw3
        mgKEs8+dsvsHW0iuxJv2Y1bKBSoLIj5p4P+vz2+0VEsykpbCUqtHBfkYrFjsA7TDKU0XBJHID5DBu
        DzFtOB8g==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
        (Exim 4.94.2)
        (envelope-from <sylvestre@debian.org>)
        id 1ox3WM-000822-TN; Mon, 21 Nov 2022 09:55:23 +0000
Message-ID: <8aa23f88-2986-b90b-0fbe-c2c15251cbe2@debian.org>
Date:   Mon, 21 Nov 2022 10:55:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101
 Thunderbird/108.0
Subject: Re: [PATCH] ARM: Drop '-mthumb' from AFLAGS_ISA
Content-Language: fr
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     Serge Guelton <sguelton@mozilla.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        "kernelci.org bot" <bot@kernelci.org>,
        Sylvestre Ledru <sylvestre@mozilla.com>
References: <20221114225719.1657174-1-nathan@kernel.org>
 <CAKwvOdn67r3ZYb5XZkae3i5797GGV3=8=nLC7kT2d4On3OEm5A@mail.gmail.com>
 <Y3aMxfhBw9YsWiKr@dev-arch.thelio-3990X>
 <CAKwvOdmYO0_m3+uWHe_C=7y1zgePQzc27Kd6Pep7Ja_pgbNPZw@mail.gmail.com>
From:   Sylvestre Ledru <sylvestre@debian.org>
In-Reply-To: <CAKwvOdmYO0_m3+uWHe_C=7y1zgePQzc27Kd6Pep7Ja_pgbNPZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Debian-User: sylvestre
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 17/11/2022 à 23:51, Nick Desaulniers a écrit :
> On Thu, Nov 17, 2022 at 11:34 AM Nathan Chancellor <nathan@kernel.org> wrote:
>>
>> On Thu, Nov 17, 2022 at 11:15:09AM -0800, Nick Desaulniers wrote:
>>> On Mon, Nov 14, 2022 at 2:58 PM Nathan Chancellor <nathan@kernel.org> wrote:
>>>>
>>>> Fixes: 1d2e9b67b001 ("ARM: 9265/1: pass -march= only to compiler")
>>>> Link: htps://salsa.debian.org/pkg-llvm-team/llvm-toolchain/-/blob/17354b030ac4252ff6c5e9d01f4eba28bd406b2d/debian/patches/930008-arm.diff
>>>
>>> Would you mind using
>>> https://salsa.debian.org/pkg-llvm-team/llvm-toolchain/-/blob/snapshot/debian/patches/930008-arm.diff
>>> as the link instead? The link on this commit message is a diff against
>>> llvm-14, not ToT which is currently llvm-16; the context is quite
>>> different as the logic moved source files completely.  Though it does
>>> look like Sylvestre has not yet cut a 16 branch for debian's patches.
>>
>> I would rather use an actual hash to reduce the risk of the link going
>> stale from either a branch rename or file rename/removal. I can use a
>> hash from the snapshot branch instead, if that would work for you?
> 
> It doesn't matter much to me; I trust your judgement; you pick.
> Perhaps that depends if the snapshot branch has stable SHAs or whether
> they change over time? Maybe Sylvestre can comment on that.
Yeah, it can change overtime. I have to rebase them from time to time.

Cheers,
Sylvestre


