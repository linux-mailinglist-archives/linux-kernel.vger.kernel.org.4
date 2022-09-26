Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E845E9CF7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbiIZJHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbiIZJG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:06:56 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C2A3FA0F;
        Mon, 26 Sep 2022 02:06:51 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1664183208; bh=RuwvdYTue40Ppjb+3cJgTWK/P0AA+gH8pgKbdcDCbis=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=jEaw9gribPaZizwL95XhqNvpGGKOpLeKz7JPj9XYd0tZcE9DiRrfbsAJvYX4Cl0pA
         TseBUVpJ3jrfWEiIKr/DpkoK2nbWbJeVZfWFR2zOif3AQjhpeZ4PsXPKfJOAyMy/El
         QWAc+tsi4qCsOwI9MCgQf7s+cmAv1TOen8250iW4=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: Any interest in building the Linux kernel from a MacOS host?
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <ba821ade-1573-4c35-8fbb-285283817147@app.fastmail.com>
Date:   Mon, 26 Sep 2022 11:06:46 +0200
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        asahi@lists.linux.dev,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <478D9484-E404-4A96-908C-4DE0F7C23997@cutebit.org>
References: <CAH7mPvj64Scp6_Nbaj8KOfkoV5f7_N5L=Tv5Z9zGyn5SS+gsUw@mail.gmail.com>
 <ba821ade-1573-4c35-8fbb-285283817147@app.fastmail.com>
To:     Sven Peter <sven@svenpeter.dev>,
        Nick Desaulniers <nick.desaulniers@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FWIW my current workflow includes building the kernel under macOS, so
there=E2=80=99s some interest from me, but that will pass once the =
porting
project progresses enough. So far I get by with some local duct tape.

> On 26. 9. 2022, at 10:09, Sven Peter <sven@svenpeter.dev> wrote:
>=20
> On Mon, Sep 26, 2022, at 09:51, Nick Desaulniers wrote:

(...)

>> If this might seem helpful
>> to anyone's workflow, I wouldn't mind pursuing this (with some
>> cleanup, sending a more formal patch set).  Maybe this helps us
>> bootstrap or get Linux up and running sooner on these machines?
>=20
> I've been either using a Linux VM or just a bare metal system running
> on these machine for quite a while now to build kernels. This would've
> been useful when I originally started though and VMs weren't working =
very
> well yet so maybe it's still worth pursuing.

I really wanted to do it in a VM as a saner path, but I didn't find
a satisfactory way to share the working source tree between the macOS
host and Linux guest (which wouldn't slow down the build).

Martin

>>=20
>> Take a look at the commit message linked below for the trials &=20
>> tribulations:
>> =
https://github.com/ClangBuiltLinux/linux/commit/f06333e29addbc3d714adb3403=
55f471c1dfe95a
>>=20
>> Thanks,
>> ~Nick Desaulniers
>=20
>=20
> Best,
>=20
>=20
> Sven
>=20

