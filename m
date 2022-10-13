Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7706F5FD409
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 07:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJMFDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 01:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiJMFDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 01:03:30 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D30E104D13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 22:03:29 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id d7-20020a17090a2a4700b0020d268b1f02so3930995pjg.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 22:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOUHW4edaDPc30w4Q72U75HlzxLHjOv/NovN59CFHDo=;
        b=bcVimODQIkTzmBZATGN+HUNmrIPW7jl5u2ZoEq4MhJfe2NQPUGrsODGTaliEVfn120
         ZiEX6ziSF71cpeL2ySmyQh2tnptI2QyBdbEqMjpMVlkVKOPB9TR87Fts6VMHefDWMcY8
         Z/MRIRJxs6TCoEjbVcfXVElblf/eiWrdOgXRLTfKu6NPe7IKRIEt7TKoZnSZ4EGh0d+/
         2m/vRr55Y9IGqZJQMn3tp/61yExuABpZ6waSytwyxjs958AHydI8QUiT1nr7lV4axcL+
         YIu2DdTu1gAGoZ3jAQ2oii+TNrWZvNgczw2ZFVo11hkEsTs3SHLzxHryOJic7KEi8xOs
         eJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kOUHW4edaDPc30w4Q72U75HlzxLHjOv/NovN59CFHDo=;
        b=uluUPVPyycsVtisTEsW1p7DgAKpMjAWwaHCJZNlXTkr407fRRuRUqALiIo2zf+tgra
         /Vf1qpwXV04Ixc4JC4qCY9D6k4Qlhi8ClG2OKsi6zdPaSZUkPWDi+xBgMn3pvCQP92Y9
         lem7y01dtDC+Lh2kflpb3XEjSX0hKDQLRogYy1z1fx6xsM1g5hFdbd5CmRueVKXFB0WN
         x5XbUYcc7gn4OZnXf//oTWqWWfsX5v/NP3iN1oRWwo9qDnfRD14xpXZphtip30mONtUz
         cos2AsGi/I6rwjPx+d3TCOWqPrZMxr3RfeyFOcRYk56SFqwWh1Emg0HUPzwjTQeJzw6/
         iKEw==
X-Gm-Message-State: ACrzQf0WWUzjDrBqKqUCAbo/4W6/bUI5vpy0VzBzxGjb9A8/9A+wg1Jc
        wcfL18vMpRxzXXZho8gBmSs=
X-Google-Smtp-Source: AMsMyM5HrtXYYUPeglv/QrNpQaQjSDvfseDShdHPPKEKELYYob599hfe6Dl7LoTscUY+VaieU/EMZQ==
X-Received: by 2002:a17:902:f707:b0:184:e44f:88cc with SMTP id h7-20020a170902f70700b00184e44f88ccmr4206961plo.42.1665637408464;
        Wed, 12 Oct 2022 22:03:28 -0700 (PDT)
Received: from localhost ([202.173.165.98])
        by smtp.gmail.com with ESMTPSA id b3-20020a62cf03000000b005625ef68eecsm833834pfg.31.2022.10.12.22.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 22:03:27 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 13 Oct 2022 15:03:14 +1000
Message-Id: <CNKJ6FE6U35I.3ERMDQR9MHRLX@bobo>
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Guenter Roeck" <linux@roeck-us.net>,
        "Michael Ellerman" <mpe@ellerman.id.au>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        <ajd@linux.ibm.com>, <aneesh.kumar@linux.ibm.com>,
        <atrajeev@linux.vnet.ibm.com>, <christophe.leroy@csgroup.eu>,
        <cuigaosheng1@huawei.com>, <david@redhat.com>,
        <farosas@linux.ibm.com>, <geoff@infradead.org>,
        <gustavoars@kernel.org>, <haren@linux.ibm.com>,
        <hbathini@linux.ibm.com>, <joel@jms.id.au>, <lihuafei1@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <lukas.bulwahn@gmail.com>, <mikey@neuling.org>,
        <nathan@kernel.org>, <nathanl@linux.ibm.com>,
        <nicholas@linux.ibm.com>, <pali@kernel.org>, <paul@paul-moore.com>,
        <rmclure@linux.ibm.com>, <ruscur@russell.cc>, <windhl@126.com>,
        <wsa+renesas@sang-engineering.com>, <ye.xingchen@zte.com.cn>,
        <yuanjilin@cdjrlc.com>, <zhengyongjun3@huawei.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.1-1 tag
X-Mailer: aerc 0.11.0
References: <87edvhntv0.fsf@mpe.ellerman.id.au>
 <20221012141827.GA2405914@roeck-us.net> <Y0biBtCUtc2mowbQ@zx2c4.com>
 <20221012164452.GA2990467@roeck-us.net> <Y0b3ZsTRHWG6jGK8@zx2c4.com>
 <20221012221615.GA364143@roeck-us.net> <87bkqgmvxl.fsf@mpe.ellerman.id.au>
 <20221013002148.GA535574@roeck-us.net>
In-Reply-To: <20221013002148.GA535574@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Oct 13, 2022 at 10:21 AM AEST, Guenter Roeck wrote:
> On Thu, Oct 13, 2022 at 11:03:34AM +1100, Michael Ellerman wrote:
> > Guenter Roeck <linux@roeck-us.net> writes:
> > > On Wed, Oct 12, 2022 at 11:20:38AM -0600, Jason A. Donenfeld wrote:
> > >>=20
> > >> I've also managed to not hit this bug a few times. When it triggers,
> > >> after "kprobes: kprobe jump-optimization is enabled. All kprobes are
> > >> optimized if possible.", there's a long hang - tens seconds before i=
t
> > >> continues. When it doesn't trigger, there's no hang at that point in=
 the
> > >> boot process.
> > >>=20
> > >
> > > I managed to bisect the problem. See below for results. Reverting the
> > > offending patch fixes the problem for me.
> >=20
> > Thanks.
> >=20
> > This is probably down to me/us not testing with PREEMPT enabled enough.
> >=20
> Not sure. My configuration has
>
> CONFIG_PREEMPT_NONE=3Dy
> # CONFIG_PREEMPT_VOLUNTARY is not set
> # CONFIG_PREEMPT is not set

Thanks very much for helping with this. The config snippet you posted here
https://lists.ozlabs.org/pipermail/linuxppc-dev/2022-October/249758.html
has CONFIG_PREEMPT=3Dy. How do you turn that into a .config, olddefconfig?

I can't reproduce this so far using your config and qemu command line,
but the patch you've bisected it to definitely could cause this. I'll
keep trying...

Thanks,
Nick

[...]
> > > # first bad commit: [e485f6c751e0a969327336c635ca602feea117f0] powerp=
c/64/interrupt: Fix return to masked context after hard-mask irq becomes pe=
nding

