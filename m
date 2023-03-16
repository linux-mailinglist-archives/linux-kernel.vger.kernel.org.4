Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9561F6BD9D4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 21:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjCPUHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 16:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjCPUHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 16:07:19 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86936FFCE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 13:07:12 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r18so2640329wrx.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 13:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678997231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9ziMByUdjVcuxOVS7P6Nl63kEYULfddQWOptIA46eo=;
        b=QKXngFB7FcpaiH7jG226b42Aot8t8FMJ8C3cVcTgJDmM344bK7NVUupukeh0vcg4Z9
         1mIyzd5+SNdFDgWHhSh36R63dHsH/6Ovvt24Ysi9iLXqnz3r/OowkqiDhvXfl/3FRDgn
         mVIXzelnfBYXyyCUAC5woPOt8i/0ou1PEFK1UJPphQ6j/stARNNxeDr50zyQ4LYqVyI6
         E+Myxfy1oYNTsdM6Xl1X8dIN3veb3Y2z4RVIpBk9EtsxVXMfPjgca80bmYVSNIeyGdvE
         Pots199v0Nm+eOioXoYgVDhIDDl4FObp1m1/vOgtqSeTwmeZpDy9Q+Flnx+bScqhc1wB
         d61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678997231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9ziMByUdjVcuxOVS7P6Nl63kEYULfddQWOptIA46eo=;
        b=befcsVNpinIM30GkLGd7ai5MXrBv9fI6KJcUs9UuHPdRrBNtXSoiytXHOsqdf49Wdh
         IAW8zL+qf98FiddY+BvByTKmcVNxYIucYFDWG1FYknVzu2ZXKhsbc2y9/1VAbzTb0WM/
         dw8WGvBnPJunJvSLOup7iCCtqxL6DrTG5wHlByiLP0G3iJwLKgJ2u6S4rajgjdZPDFOl
         ehbt9wfdBaV10HKJ93UEakMhg8mirUYMS6KzA8fHJFDncH4++kMCWheQcUu1VbJj7aBe
         N1RngUT49zW3tJYn5SMQSmRpSERNeGBr6liN2JDL8H2nRBwGD+oYeXqUZ6LgFhBTS937
         wJyQ==
X-Gm-Message-State: AO0yUKUOa6F2qHh4gN3OsNDAG3mSLsoIhP1xOAXfvgVjM8akz8iN20Lw
        XLnSzXh4sG9k7Q6+UbkVGc1MJ2s7t9M=
X-Google-Smtp-Source: AK7set/3nen9rHtX0+dVEbzbs3rEyAtIebjLrZdlf4w1mK8soQvxo8erQrj2qFS8yKKjB7pl2xE4kw==
X-Received: by 2002:a5d:448c:0:b0:2d0:bba8:38f3 with SMTP id j12-20020a5d448c000000b002d0bba838f3mr5361927wrq.14.1678997231026;
        Thu, 16 Mar 2023 13:07:11 -0700 (PDT)
Received: from suse.localnet (host-79-35-102-94.retail.telecomitalia.it. [79.35.102.94])
        by smtp.gmail.com with ESMTPSA id w2-20020a5d6802000000b002cfe687fc7asm238780wru.67.2023.03.16.13.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 13:07:10 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] staging: axis-fifo: initialize timeouts in probe only
Date:   Thu, 16 Mar 2023 21:07:09 +0100
Message-ID: <2599595.k3LOHGUjKi@suse>
In-Reply-To: <ZBNhXc3sVVLdibUF@khadija-virtual-machine>
References: <ZBMR4s8xyHGqMm72@khadija-virtual-machine> <2162728.C4sosBPzcN@suse>
 <ZBNhXc3sVVLdibUF@khadija-virtual-machine>
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

On gioved=EC 16 marzo 2023 19:35:09 CET Khadija Kamran wrote:
> On Thu, Mar 16, 2023 at 05:17:47PM +0100, Fabio M. De Francesco wrote:
> > On gioved=EC 16 marzo 2023 16:09:08 CET Khadija Kamran wrote:

[snip]

> Hey Fabio!
>=20
> Hope you are doing well. After  spending a lot of time on this I am
> stuck now. Kindly help me resolve this issue or understand it better.
>=20
> Following your instructions I deleted my config file and copied one from
> the /boot/ directory. After that I enabled the dependencies(CONFIG_OF=3Dy
> and CONFIG_HAS_IOMEM=3Dy). I was successfully able to enable axis-fifo as
> a module.
>=20
> I then ran the following commands:
>  - make drivers/staging/axis-fifo/

No, this is not the right command... you are not invoking the linker to mak=
e=20
the .ko object.

Use "make M=3Ddrivers/staging/axis-fifo/"
or "make M=3Ddrivers/staging/axis-fifo/ W=3D1 -j8" (the latter to enable le=
vel '1'=20
warning and run on your 2 * 4 logical cores).

>  - sudo make modules_install install(this command took hours) :'(

This is odd, it shouldn't :-/

As I said in another message, I'll set aside some time to help you check if=
=20
you need to fine tune your VM and Hypervisor configuration.=20

I'm returning on the same subject we have been talked about because you sai=
d=20
at least twice that your builds and install are too slow. We'll try to=20
diagnose it in an IRC session on #kernel-outreachy (I'm pretty sure for the=
=20
first days of next week - I'll send an invite).

> > When you are done with build, install, and final reboot to test if your
> > module can "modprobe" or "insmod" (i.e. link with the running custom=20
kernel
> > you built, installed and boot), try to compare the output of the follow=
ing
> > commands:
> >=20
> > # uname -a
> > Linux suse 6.2.2-1-default #1 SMP PREEMPT_DYNAMIC Thu Mar  9 06:06:13 U=
TC
> > 2023 (44ca817) x86_64 x86_64 x86_64 GNU/Linux
>=20
> The above command works
>=20
> > AND
> >=20
> > # modinfo <name of the module you are testing here>
>=20
> On running 'modinfo axis-fifo' I get error saying module axis-fifo not
> found.

Try again after building with "M=3Ddrivers/staging" (as said above). Don't=
=20
forget to run "make modules_install install" and then reboot into your cust=
om=20
built Kernel, not the distribution's kernel.

While you are there, run "lsmod" to see all loaded modules. Pick one random=
ly=20
from the output list and run "modinfo name_of_the_module_you_want_info_abou=
t".
=20
> > I'm running "modinfo kvm" (but showing only two of many lines):
> >=20
> > # modinfo kvm
> > filename:       /lib/modules/6.2.2-1-default/kernel/arch/x86/kvm/
kvm.ko.zst
> > vermagic:       6.2.2-1-default SMP preempt mod_unload modversions
> >=20
> > Can you see that the kernel in "uname -a" and the filename and vermagic=
=20
have
> > the same "6.2.2-1-default"? Well, so I'm sure I'm running the right Ker=
nel
> > and inserted the appropriate "kvm" module.
> >=20
> > Furthermore, before rebooting your custom kernel, you may also look at =
the
> > directory in the Kernel where you compiled your module and search for=20
"*.o"
> > "*mod*" and "*.ko" files. If you have them, you built your module=20
properly.
>=20
> There is a "*.o" file and "*.mod" file but there is no "*.ko" file in
> the axis-fifo directory.
>=20
> Kindly help me with this.
>=20
> Regards,
> Khadija
>=20
> > Thanks,
> >=20
> > Fabio

Let me know if this time it works.

=46abio

P.S.: Have you had time to read that "Linux Kernel Module Programming" guid=
e I=20
sent you the link of? You can find a lot of information about modules there=
=2E=20
I'd strongly recommend you to read it.=20


