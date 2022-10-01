Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5047A5F1BC7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 12:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiJAKak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 06:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJAKag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 06:30:36 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514DDBF1DD;
        Sat,  1 Oct 2022 03:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664620224;
        bh=1jutPDHRlPOr8rEfsKfO97RJKs8/j3QxO2kaIL58B8E=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=govxr0P4bnOQ49jS+wfQI5thAkxWeui+SckZ7Bv5XFMW/uxVocJMaLex+yH/uZFsW
         +griCNPu4HFXtZ3U7RmHlSuLneu+AA+hJGnft91UWGJXKAYINHJeFVcKbn5dGHrGiH
         uvyboQ9g1lIeT8JJYwkwm9A07k+1D4paZEqSfXhE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.30.110.10] ([143.244.37.31]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mk0NU-1p2xD53WkS-00kMX1; Sat, 01
 Oct 2022 12:30:24 +0200
Message-ID: <9a2fdff8-d0d3-ebba-d344-3c1016237fe5@gmx.com>
Date:   Sat, 1 Oct 2022 10:30:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info>
From:   "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OIZKgNIoUzfXFxWRgy/Z1vaxIi9zGvMB/YQQlltEGHfMbUXcd3U
 yWf0nypaNJYSt47WpQNIM4TkIjy2jo1eFpwomUnKk9ZzoIbW2QBCe3FGkYdUMfY9gcrlILE
 6qNZOdumdf3Sp4ihXDQwAQx+zCl0RAhmjFaanSY/i+/M5yf73+9nFeKlkBgtJPv89A2tUqL
 YlBih/+zroXZ9c8xSDO3w==
X-UI-Out-Filterresults: junk:10;V03:K0:XzkzykWyZ0s=:ZpHjeAs9hHVfzzZjOsnKoNic
 cuzvCsCDV8Jd8MnT/MFk4BLDcEwigVChYAZ/+8VcNQ26yTkj3A5dTsfLaW5GTfSGqM6qPPyLg
 4etZVPrzlg2YL0OobK5r+Mlt1onRaBPQNb0eTRz2D83/3WHauAzxEJkju4uMH5SJMVIYSvUMy
 c4OjYW3gWyD6pPOOIjqoW7cJKCoPMN9blBBSNxi6pBWd4yAl4mRcPywW0QpUwaF00sHO8mwm3
 ETk7cehpk7E4DFmgmOBEjjf31mysGBVMboqUG9d5griI00T6CJC7nn2f1OQFT0+w251oznGRK
 4/6YhHwKZu58GmLuMoQuFFIcCF7IuCzDBJCSfcOENQdQPmXc6Y5TBksDlUjN/MrzW2wmAyVhh
 9oxJmI57MBnuc181VonHD0b7oQh9pRhboXMC6KI6Ym7jjbzUMu9VWuvJOqm1vNWJM3LsmDpnA
 wj2Cwe1OeQokO3/FQZdPtC6tIPcOEYargvDUI4dk0BtRdPvdqu18cj/XEWHDewXjSJnS/absz
 L0qSZ+CGAGJTPhzUdZHjIv6udMOgxipFd/y4m+v38ljPWICki1En83vMrGPyiuO5+icvH6fqh
 Abw0pcRBOgFxhK9RJNfymxkV3AQMZUOgs8iJdahbk3qCBniyrNKHaNFXMV5wxhqy4MdSVCiui
 qKEFAfFf5dUGLbJYbIRpu56izrwwLPYpUmChFTumltj0EPxoAd/x1BQ+ivU2vCiMHGHQVWoZy
 kyapWIEfBQqVaG/mg3yedrUtb5D6e9ZBGAbKaU4XsvbqBK/HLC1HgYwKOFZucB+Vq82IulI5E
 IeNXB4CPTYoa7uga5UAZlAhe0X5y1eAhlQQHL/qwUlGXEbhpnSNLkZ6mNG46I9/YNUWos/7Ao
 xG7xIMkLR3gFV2yhIYcSpFJ1hxaaF1Tz3ZMoVjN8vcBMHiuCN9/5g3yVik7rbBScasKjQ8mQK
 aPNXADwsbAC8yycoov6tmEU7rCc0D1YKGD3RBAP9SQMWys5zHfBOdcEBikKfnkERQAHVuv9fG
 vM/EqGnOu2W/3ZOo8WYuUQZv38EjNFrK3nuJgnqVbVDhB7wRNYcSGqKaBVCUA4UoFV8U5l/fO
 I95K1ghHkMOgZfTm1XRkGRHMzKPB9IDI0EPiqhrdnPEIRr9MXUIl/74gXG2Rex1JJYd34r1Ab
 d/25OmF9cCj8+4FYI9xEDwxvKGoGEbkSKmjgU3ZeYzWppg==
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are two other issues which absolutely suck in terms of dealing with
the kernel.

- 1 -

I have a 20+ years experience in IT and some kernel issues are just
baffling in terms of trying to understand what to do about them.

Here's an example: https://bugzilla.kernel.org/show_bug.cgi?id=3D216274

What should I do about that? Who's responsible for this? Who should I CC?

And this is an issue which is easy to describe and identify.

- 2 -

Here's another one which is outright puzzling:

You run: dmesg -t --level=3Demerg,crit,err

And you see some non-descript errors of some kernel subsystems seemingly
failing or being unhappy about your hardware. Errors are as cryptic as
humanly possible, you don't even know what part of kernel has produced the=
m.

OK, as a "power" user I download the kernel source, run `grep -R message
/tmp/linux-5.19` and there are _multiple_ different modules and places
which contain this message.

I'm lost. Send this to LKML? Did that in the long past, no one cared, I
stopped.

Here's what I'm getting with Linux 5.19.12:

platform wdat_wdt: failed to claim resource 5: [mem
0x00000000-0xffffffff7fffffff]
ACPI: watchdog: Device creation failed: -16
ACPI BIOS Error (bug): Could not resolve symbol
[\_SB.PCI0.XHC.RHUB.TPLD], AE_NOT_FOUND (20220331/psargs-330)
ACPI Error: Aborting method \_SB.UBTC.CR01._PLD due to previous error
(AE_NOT_FOUND) (20220331/psparse-529)
platform MSFT0101:00: failed to claim resource 1: [mem
0xfed40000-0xfed40fff]
acpi MSFT0101:00: platform device creation failed: -16
lis3lv02d: unknown sensor type 0x0

Are they serious? Should they be reported or not? Is my laptop properly
working? I have no clue at all.

=2D--

While we've been talking about bugzilla I thought it would be pertinent
to bring this up.

Best regards,
Artem
