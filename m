Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34AA6BD55B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjCPQSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 12:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjCPQSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:18:18 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE5AE20F3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 09:17:53 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id o7so2053745wrg.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 09:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678983469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnGsU6JFSIeWNdID12FB+3lEn0m2JgcfHHD3meIAZsI=;
        b=PYadP9ekyEGCylW2GRQ3pf/LJjZDFaUkMC57ZAUny5IFk50dpwV9+LIyXxyHhvKtFn
         sFcgt8/IVKDRc82/7IApBddQ8UWl6WGOlL8IFeDwOaj5ppywY/03mYtQUIgP82cCRq3a
         xF/mQyQX/RqulcevEU/2bOxHcYMaYaET9m6ayB4FoW70f9E7iC3FDqHG5Itb6dsAY+UK
         nHg/ziNzxGHbTPUnp+3REZaD6/XeozvcPts5F4Nf1lvoI29ZDwyNZ6zmjZagAObe6a6i
         UXwiZ0619w2j72D4lfc2PPYQMOX0eRG4BXe5bGSCin0n3DyE2709QO0CnfPEpqCbIvNR
         tslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678983469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YnGsU6JFSIeWNdID12FB+3lEn0m2JgcfHHD3meIAZsI=;
        b=t46Zhizm6pNxjb5IOn0z8omhGUaTkQ1a4kuUCPeS3p+lCfsb3GbzoS++ar4ZXhopaL
         UFokLMvtEl4jWvjh5MpCVADsZDz2O9UvZ5+yoVVYK+zePij9R3Karab2heAYvnru5CJY
         rQ9i01KaQXVvEy2+AQ9ObLL+a/Q8cDtJnFryCn4Lcmnm/IdmOBvq5/rUfV3kCdK8JUY+
         xdV1huAT7W7Mw+5M6V4s7F8pbJ+EFn9rgcKP51r112wuu29GEEM7Y5VxROCz90lcFQqP
         MZbsQeH1C1N1F9GLahnG20SkfYpWbhRpvAfrf6UslAFpKslIaKR4wjuGRXZ/d7vSD0Hc
         Hu8w==
X-Gm-Message-State: AO0yUKX8LJ+yrtBYU+O0wzRTzLlbYmV3zo3ds4KP16ny95jqUC2UCm4x
        MdTbKM1GaxtJg7L1bHaqwoV8y0nJbGk=
X-Google-Smtp-Source: AK7set+LRzqs2N8gMWUgRQG3LYs3C3OUN1xkRS4/cfU0uOfWZ7R01rti5F198UP9X2ffWpyi3fqhpA==
X-Received: by 2002:a5d:6306:0:b0:2d1:531f:a90b with SMTP id i6-20020a5d6306000000b002d1531fa90bmr3639115wru.39.1678983468901;
        Thu, 16 Mar 2023 09:17:48 -0700 (PDT)
Received: from suse.localnet (host-79-35-102-94.retail.telecomitalia.it. [79.35.102.94])
        by smtp.gmail.com with ESMTPSA id a11-20020a5d508b000000b002c55b0e6ef1sm7756941wrt.4.2023.03.16.09.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 09:17:48 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] staging: axis-fifo: initialize timeouts in probe only
Date:   Thu, 16 Mar 2023 17:17:47 +0100
Message-ID: <2162728.C4sosBPzcN@suse>
In-Reply-To: <ZBMxFLtW2ekCvm/s@khadija-virtual-machine>
References: <ZBMR4s8xyHGqMm72@khadija-virtual-machine> <2626731.BddDVKsqQX@suse>
 <ZBMxFLtW2ekCvm/s@khadija-virtual-machine>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On gioved=EC 16 marzo 2023 16:09:08 CET Khadija Kamran wrote:
> On Thu, Mar 16, 2023 at 03:38:03PM +0100, Fabio M. De Francesco wrote:
> > Khadija,
> >=20
> > Just saw your v5 patch and Greg's two replies.
> >=20
> > For v6 you will need to change the subject to "[PATCH v6] staging:
> > axis-fifo:
> > initialize timeouts in init only" to indicate that you are doing=20
assignments
> > in axis_fifo_init().
> >=20
> > Don't forget to extend the version log with "Changes in v6:" and clarify
> > that
> > v5 had a different "Object" (you should probably also add a link to the=
 v5
> > patch in lore: https://lore.kernel.org/lkml
> > /ZBMR4s8xyHGqMm72@khadija-virtual- machine/). When the "Subject" change=
s,
> > readers may not find the previous versions easily.
> >=20
> > On gioved=EC 16 marzo 2023 13:56:02 CET Khadija Kamran wrote:
> > > Module parameter, read_timeout, can only be set at the loading time. =
As
> > > it can only be modified once, initialize read_timeout once in the pro=
be
> >=20
> > Substitute "probe" with "init".
> >=20
> > > function.
> > >=20
> > > As a result, only use read_timeout as the last argument in
> > > wait_event_interruptible_timeout() call.
> >=20
> > This two sentences are not much clear. I'd merge and rework:
> >=20
> > "Initialize the module parameters read_timeout and write_timeout once in
> > init().
> >=20
> > Module parameters can only be set once and cannot be modified later, so=
 we
> > don't need to evaluate them again when passing the parameters to
> > wait_event_interruptible_timeout()."
> >=20
> > > Convert datatpe
> >=20
> > s/datatpe/type/
> >=20
> > > of read_timeout
> >=20
> > of {read,write}_timeout
> >=20
> > > from 'int' to 'long int' because
> > > implicit conversion of 'long int' to 'int' in statement 'read_timeout=
 =3D
> > > MAX_SCHEDULE_TIMEOUT' results in an overflow warning.
> >=20
> > We don't care too much about the warning themselves: I mean, it overflo=
ws
> > and
> > you must avoid it to happen (as you are doing with the changes of types=
),
> > not
> > merely be interested in avoiding the warning. "[] results in an overflo=
w."
> > is
> > all we care about.
>=20
> Hey Fabio!
> Thank you for your feedback. I have understood it and will make sure to
> send them in the next PATCH v6.

Great to hear it!

> > Add also the previous paragraph in the last part of the commit message.
> >=20
> > > Perform same steps formodule parameter, write_timeout.
> >=20
> > And instead delete the this last phrase.
>=20
> Can you please explain the above feedback. I am confused. What should I
> use instead of this last phrase?

Sorry, I made a typo in the sentence above and that may confuse you :-(

I just intended to suggest to delete "Perform same steps formodule paramete=
r,=20
write_timeout.".

In the previous lines I suggested you to merge and rework your entire commi=
t=20
message. If you like it you are left with the following text (that I put fo=
r=20
you between two '"'):

"Initialize the module parameters read_timeout and write_timeout once in
init().

Module parameters can only be set once and cannot be modified later, so we
don't need to evaluate them again when passing the parameters to
wait_event_interruptible_timeout().

Convert the type of {read,write}_timeout from 'int' to 'long int' because=20
implicit conversion of 'long int' to 'int' in statement 'read_timeout =3D=20
MAX_SCHEDULE_TIMEOUT' results in an overflow.".

Just three small sentences are all you need (and don't forget to change the=
=20
Subject - "probe()" -> "init()".

I hope I have been clearer this time.
If not, please ask for further clarification.

Thanks,

=46abio=20

> > > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > > ---
> > >=20
> > > Changes in v5:
> > >  - Convert timeout's datatype from int to long.
> > >=20
> > > Changes in v4:
> > >  - Initialize timeouts once as suggested by Greg; this automatically
> > > =20
> > >    fixes the indentation problems.
> > > =20
> > >  - Change the subject and description.
> > >=20
> > > Changes in v3:
> > >  - Fix grammatical mistakes
> > >  - Do not change the second argument's indentation in split lines
> > >=20
> > > Changes in v2:
> > >  - Instead of matching alignment to open parenthesis, align second and
> > > =20
> > >    the last argument instead.
> > > =20
> > >  - Change the subject to 'remove tabs to align arguments'.
> > >  - Use imperative language in subject and description
> > > =20
> > >  drivers/staging/axis-fifo/axis-fifo.c | 26 ++++++++++++++++----------
> > >  1 file changed, 16 insertions(+), 10 deletions(-)

[snip]

> > >  		=09
> > >  				 >=3D words_to_write,
> >=20
> > What is this? You haven't yet compiled your patch.
> > Any further problems with enabling axis-fifo as a module?
>=20
> Sorry, my bad.  Instead of fixing the menuconfig I used this command to
> remove the warnings:
> make -j"$(nproc)" ARCH=3Darm64 LLVM=3D1 drivers/staging/axis-fifo/
> I thought it is compiling my module correctly.
> But I am working on your feedback. And before sending my next patch I
> will make sure to compile it properly.

When you are done with build, install, and final reboot to test if your mod=
ule=20
can "modprobe" or "insmod" (i.e. link with the running custom kernel you=20
built, installed and boot), try to compare the output of the following=20
commands:

# uname -a
Linux suse 6.2.2-1-default #1 SMP PREEMPT_DYNAMIC Thu Mar  9 06:06:13 UTC 2=
023=20
(44ca817) x86_64 x86_64 x86_64 GNU/Linux

AND

# modinfo <name of the module you are testing here>

I'm running "modinfo kvm" (but showing only two of many lines):

# modinfo kvm=20
filename:       /lib/modules/6.2.2-1-default/kernel/arch/x86/kvm/kvm.ko.zst
vermagic:       6.2.2-1-default SMP preempt mod_unload modversions=20

Can you see that the kernel in "uname -a" and the filename and vermagic hav=
e=20
the same "6.2.2-1-default"? Well, so I'm sure I'm running the right Kernel =
and=20
inserted the appropriate "kvm" module.=20

=46urthermore, before rebooting your custom kernel, you may also look at th=
e=20
directory in the Kernel where you compiled your module and search for "*.o"=
=20
"*mod*" and "*.ko" files. If you have them, you built your module properly.

Thanks,

=46abio



