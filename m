Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DCA5F499D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 21:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiJDTNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 15:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiJDTNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 15:13:18 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C66A6AA3F;
        Tue,  4 Oct 2022 12:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1664910786; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y2/54OphzrUzrBX6aeIwjTWX6IIaINAv6yVDxv2padQ=;
        b=EPTvUEtRBxslETxeZSdXYAZxFyVAHOyiHovTxC4oUbKwQee8L1bv8QPoL4VFSlNmenY4zu
        rMlSB1LADkYC+MXGPeluMEZUhj6NKz571aI/OEyiLlHnXBzQHOp0Jce/ZrRXqxoaejoTCY
        +gy+aUfIhGM6cR4DP7cEL+w2qjG8lsI=
Date:   Tue, 04 Oct 2022 20:12:56 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 01/30] pm: Improve EXPORT_*_DEV_PM_OPS macros
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm <linux-pm@vger.kernel.org>
Message-Id: <KDT8JR.QPETUDEUEUK4@crapouillou.net>
In-Reply-To: <CAJZ5v0i06Nj1+kWDPtok-3vB1UPKfdieux8VrLm21NT0XFCftA@mail.gmail.com>
References: <20220808174107.38676-1-paul@crapouillou.net>
        <20220808174107.38676-2-paul@crapouillou.net>
        <CAJZ5v0h3hf06xQsJGOfOyGbD470jyxkPNuaHP+E-pvXbS6Egxg@mail.gmail.com>
        <HF07HR.3A0DTIDT17IF1@crapouillou.net>
        <20220925155239.7a37c19a@jic23-huawei>
        <CAJZ5v0igQL_766obp2csNCg7b0g3g2+gkuqZXjUNL7Jj9Da7zQ@mail.gmail.com>
        <E1KTIR.IK6LI11BUNDM3@crapouillou.net>
        <CAJZ5v0hW049fh=NebWqCMUzZAU=pfHWEFd-dkegRb4qwuHxSXA@mail.gmail.com>
        <20221001180130.73a26c68@jic23-huawei>
        <02I4JR.BHDWVSR51INT1@crapouillou.net>
        <CAJZ5v0i06Nj1+kWDPtok-3vB1UPKfdieux8VrLm21NT0XFCftA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le mar., oct. 4 2022 at 20:54:28 +0200, Rafael J. Wysocki=20
<rafael@kernel.org> a =E9crit :
> On Sun, Oct 2, 2022 at 1:18 PM Paul Cercueil <paul@crapouillou.net>=20
> wrote:
>>=20
>>=20
>>=20
>>  Le sam., oct. 1 2022 at 18:01:30 +0100, Jonathan Cameron
>>  <jic23@kernel.org> a =E9crit :
>>  > On Mon, 26 Sep 2022 15:35:35 +0200
>>  > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>>  >
>>  >>  On Mon, Sep 26, 2022 at 3:27 PM Paul Cercueil
>>  >> <paul@crapouillou.net> wrote:
>>  >>  >
>>  >>  > Hi,
>>  >>  >
>>  >>  > Le lun., sept. 26 2022 at 14:00:52 +0200, Rafael J. Wysocki
>>  >>  > <rafael@kernel.org> a =E9crit :
>>  >>  > > On Sun, Sep 25, 2022 at 4:52 PM Jonathan Cameron
>>  >> <jic23@kernel.org>
>>  >>  > > wrote:
>>  >>  > >>
>>  >>  > >>  On Thu, 25 Aug 2022 23:42:53 +0100
>>  >>  > >>  Paul Cercueil <paul@crapouillou.net> wrote:
>>  >>  > >>
>>  >>  > >>  > Hi Rafael,
>>  >>  > >>  >
>>  >>  > >>  > Le mar., ao=FBt 23 2022 at 19:47:57 +0200, Rafael J.=20
>> Wysocki
>>  >>  > >>  > <rafael@kernel.org> a =E9crit :
>>  >>  > >>  > > On Mon, Aug 8, 2022 at 7:41 PM Paul Cercueil
>>  >>  > >> <paul@crapouillou.net>
>>  >>  > >>  > > wrote:
>>  >>  > >>  > >>
>>  >>  > >>  > >>  Update the _EXPORT_DEV_PM_OPS() internal macro. It=20
>> was
>>  >> not
>>  >>  > >> used
>>  >>  > >>  > >> anywhere
>>  >>  > >>  > >>  outside pm.h and pm_runtime.h, so it is safe to=20
>> update
>>  >> it.
>>  >>  > >>  > >>
>>  >>  > >>  > >>  Before, this macro would take a few parameters to be
>>  >> used as
>>  >>  > >> sleep
>>  >>  > >>  > >> and
>>  >>  > >>  > >>  runtime callbacks. This made it unsuitable to use=20
>> with
>>  >>  > >> different
>>  >>  > >>  > >>  callbacks, for instance the "noirq" ones.
>>  >>  > >>  > >>
>>  >>  > >>  > >>  It is now semantically different: instead of=20
>> creating a
>>  >>  > >>  > >> conditionally
>>  >>  > >>  > >>  exported dev_pm_ops structure, it only contains=20
>> part of
>>  >> the
>>  >>  > >>  > >> definition.
>>  >>  > >>  > >>
>>  >>  > >>  > >>  This macro should however never be used directly=20
>> (hence
>>  >> the
>>  >>  > >> trailing
>>  >>  > >>  > >>  underscore). Instead, the following four macros are
>>  >> provided:
>>  >>  > >>  > >>  - EXPORT_DEV_PM_OPS(name)
>>  >>  > >>  > >>  - EXPORT_GPL_DEV_PM_OPS(name)
>>  >>  > >>  > >>  - EXPORT_NS_DEV_PM_OPS(name, ns)
>>  >>  > >>  > >>  - EXPORT_NS_GPL_DEV_PM_OPS(name, ns)
>>  >>  > >>  > >>
>>  >>  > >>  > >>  For instance, it is now possible to conditionally
>>  >> export noirq
>>  >>  > >>  > >>  suspend/resume PM functions like this:
>>  >>  > >>  > >>
>>  >>  > >>  > >>  EXPORT_GPL_DEV_PM_OPS(foo_pm_ops) =3D {
>>  >>  > >>  > >>      NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
>>  >>  > >>  > >>  };
>>  >>  > >>  > >>
>>  >>  > >>  > >>  The existing helper macros=20
>> EXPORT_*_SIMPLE_DEV_PM_OPS()
>>  >> and
>>  >>  > >>  > >>  EXPORT_*_RUNTIME_DEV_PM_OPS() have been updated to=20
>> use
>>  >> these
>>  >>  > >> new
>>  >>  > >>  > >> macros.
>>  >>  > >>  > >>
>>  >>  > >>  > >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  >>  > >>  > >
>>  >>  > >>  > > Acked-by: Rafael J. Wysocki=20
>> <rafael.j.wysocki@intel.com>
>>  >>  > >>  > >
>>  >>  > >>  > > or please let me know if you need me to pick up this=20
>> one.
>>  >>  > >>  >
>>  >>  > >>  > Could you pick this one up then, and make a branch for
>>  >> Jonathan?
>>  >>  > >>
>>  >>  > >>  Hi Paul, Rafael,
>>  >>  > >>
>>  >>  > >>  What happened to this in the end?  I can't immediately=20
>> find
>>  >> it on
>>  >>  > >>  any of the pm git tree branches.
>>  >>  > >>
>>  >>  > >>  At this stage in the cycle it would be great if this=20
>> patch at
>>  >> least
>>  >>  > >>  makes the merge window, so we can make use of it next=20
>> cycle.
>>  >>  > >
>>  >>  > > I thought that this would go in along with the other=20
>> patches in
>>  >> the
>>  >>  > > series.
>>  >>  > >
>>  >>  > > I can apply it directly, though, if needed.
>>  >>  > >
>>  >>  > > Thanks!
>>  >>  >
>>  >>  > I think at this point Jonathan can just take it in his tree=20
>> with
>>  >> his
>>  >>  > own patchset. Then I'll rebase this patchset on v6.1-rc1.
>>  >>
>>  >>  Sure.
>>  >>
>>  >>  Jonathan, please go ahead and take the patch directly.
>>  >
>>  > Too late for me to take this for this cycle (I route via Greg KH=20
>> so
>>  > need to have things
>>  > in place a little bit before the merge window).  If Lee doesn't=20
>> pick
>>  > it up, I'll do an
>>  > immutable branch after rc1 is out with just this patch on it, then
>>  > anyone who wants
>>  > it can pick it up.
>>=20
>>  Rafael or Lee, can you take it now?
>>=20
>>  Or is it already too late? :(
>=20
> I've applied this patch as 6.1-rc material, thanks!

Awesome, thanks!

-Paul


