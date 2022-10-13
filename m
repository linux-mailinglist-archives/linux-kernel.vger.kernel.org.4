Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAA75FD436
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 07:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJMFWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 01:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiJMFWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 01:22:20 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62563C7079
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 22:22:19 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id l4so846080plb.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 22:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KUigR7SJ7uFyr2yNbxpVBZqM/PTPgSSjnaooqgXQb4=;
        b=mDoghLF0CDSCPU4++bngkMIB3aPLTW4HOAtQe7zp1ltS3uBufcMoVWGDWMQyreLZCU
         yRFG6g2e1dv8StaRvGI1qiKcrVTtrdTgcObGTzaOyaRQdVRCmjZmXJA8P3jC/CbzchDb
         ch7WseAve+DRjfS54Oh1FMXR3TZtPI/r+xMlZqk5CPCEObseWIVTOL4MJgjGposWh41z
         xkmywKUlppn7VdLluqfkeGMXA3picuSrIEgPWd39GfFSPlAN+zF3m/IJpWBk6/Vnv4u9
         wsRZ4opeub7nggQVoOG3g6g7MiWnrORIzTEyL6E+iQESVjoKJxN2xvEX+Vb4SZuwXvZv
         z74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5KUigR7SJ7uFyr2yNbxpVBZqM/PTPgSSjnaooqgXQb4=;
        b=BcNRHbFkAd2zUeC4/dN5K9oC3gsgp+VirVBXkyASEFnurQzBmN2bDGhfh8g4An5oCd
         GaPafK48oCT5m+daetrwPYeijNjkqDxEOG5i1KCRi5eBwSUWXe4u4a+1G46jO8ehmNoJ
         O9oq2iRvQ3PL3vkzWPpwXp2hr4FQZjsoDMfeRomzH1Jlx+nnonXluBkkY/4hJm5DrGlG
         8h6fk9P9WhPNHcX6nuWjFuu2PL+uLPnm0c9t2v/RiUt60Oy8aP7UHM6SjpGTF12zcxSw
         xZqHUchRQJCbUlczqo+B0KFw7GXjyCdvFS5PTi08zAE5I3pR5w14XxwfTu+rVM5L16Sl
         JyXg==
X-Gm-Message-State: ACrzQf3JJfXDSx5oYXkkyOQzh4M2G5Orr2v+VpfxWr2shIWXUs050khN
        oXGrcAR8dIzZfvRj8hGSd6psYDBiWyCdOg==
X-Google-Smtp-Source: AMsMyM4IE0OtdgMomYoWq+tu6m77qqVcqsJKqjqKRhI/OJqvgva+src7nCKPmMXCXbDUsqYT+YODkQ==
X-Received: by 2002:a17:902:e982:b0:17f:ca1f:aa44 with SMTP id f2-20020a170902e98200b0017fca1faa44mr32495020plb.76.1665638538944;
        Wed, 12 Oct 2022 22:22:18 -0700 (PDT)
Received: from localhost ([202.173.165.98])
        by smtp.gmail.com with ESMTPSA id h185-20020a62dec2000000b00561c6a4c1b0sm847441pfg.176.2022.10.12.22.22.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 22:22:18 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 13 Oct 2022 15:22:05 +1000
Message-Id: <CNKJKV3GCTGF.18JF410CFEKR3@bobo>
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

Okay I reproduced it, just takes a while to hit.

Thanks,
Nick
