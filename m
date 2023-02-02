Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333AE68828F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbjBBPdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbjBBPbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:31:53 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7484D6B378
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 07:31:12 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id m11so2285237pji.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 07:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PISlVXC9RF89UJakg85t893DWznct4a1i3rICMPp0oM=;
        b=r2pu0ik5rcshKfCi5HudJ4D8IAbHz3Tl13IJglk3ABYs6evgGDS2FKxS99RK6Mjr/W
         1I+khjVpKXJJaDfCss3UlSEeyP6qmFzlewl4HHNa3iCk1Lp6TMeQyHz0RvrlO5hBvmNv
         EkMyDw1c33RqBVsEKvZoKTNpzsK/rPBzEHYMD1UA+ZB6H14KMHERY4sg+ES3VZoERKje
         3rkqZ+wbrVmKfToV16ceioyS/gM2tizYyLQfelY42hEPzm2P5hPUcP8mINhh0d0ol6vD
         /sg4fDnpAySsk/G2EGS8OBgwpT934140anf2WMxyRcLAPmrPUDY/GPHNuDcnvu/PBTUo
         5zgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PISlVXC9RF89UJakg85t893DWznct4a1i3rICMPp0oM=;
        b=m/6Lu7jn3sLIIadXojtQaMpX0BxGi0tu2w1Ikk7k7N85GnYpYv/8+j8l5Q+VdXdcND
         pFQYyKUsPkEyk4ykobzjoidGd3zDknjZIV/r8mPjSWl//AQWzRe5e6E/jnnpLYhknWRx
         KlO5Wg9+CdGwla2zIp22Xh0vrssny7jLoDF1rcv336ZwOkgo9rNP50X3WK/QDOxsx4PT
         BwVg9/cF5xcVL0CmIsjXCIY4RwbtrF4eJ8kvEFsjwTM3Bo+Nbcwa+ri0EKlLuOQQ72M5
         lL1Knuy4BC3MXJby3vAG191XTWIE0Jrta4Apv0YfUrEcqiYWIDA13br2L3t22xB5jbqX
         uBMw==
X-Gm-Message-State: AO0yUKWcfL9uF0Stxb8zvaRO56Vf5+5SN/Tkv1NTPFEtuuDQlyIRZg3F
        gSU9w1wFCiKPhYUqdqZ6Qvv1qymD10mAJYKjo+h3UA==
X-Google-Smtp-Source: AK7set/a5Il1eCSTMYunJZFtkX7jHsrbLyrnHBKoE8589hgnsZglb3JMjpVJ32KEJksISbzoQBzs6RjF+QkCQTcNSTU=
X-Received: by 2002:a17:90a:fa84:b0:22c:3590:9661 with SMTP id
 cu4-20020a17090afa8400b0022c35909661mr626924pjb.55.1675351798630; Thu, 02 Feb
 2023 07:29:58 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYuei_Tr-vN9GS7SfFyU1y9hNysnf=PB7kT0=yv4MiPgVg@mail.gmail.com>
 <Y9B4/pR5t2o51coY@monkey> <CA+G9fYtt_FR54zwStiTguiyS0QDHe-x5+2Py9_hvxKAbYHM_fg@mail.gmail.com>
In-Reply-To: <CA+G9fYtt_FR54zwStiTguiyS0QDHe-x5+2Py9_hvxKAbYHM_fg@mail.gmail.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 2 Feb 2023 16:29:47 +0100
Message-ID: <CADYN=9+=p0cYu63feXfZVXZTGruJP_i5dA3AuP0G6Fh_rfQO0g@mail.gmail.com>
Subject: Re: selftests: memfd: run_hugetlbfs_test.sh - invalid opcode: 0000
 [#1] PREEMPT SMP
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Jeff Xu <jeffxu@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Pranith Kumar <bobby.prani@gmail.com>,
        David Herrmann <dh.herrmann@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Feb 2023 at 15:54, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Hi Mike,
>
> On Wed, 25 Jan 2023 at 06:04, Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >
> > On 01/05/23 15:14, Naresh Kamboju wrote:
> > > While running selftests: memfd: run_hugetlbfs_test.sh on qemu_i386 and i386 the
> > > following invalid opcode was noticed on stable-rc 6.1 and  6.0.
> > >
> > > This is always reproducible on stable-rc 6.1 and  6.0 with qemu_i386 and i386.
> > > Build, config and test log details provided in the below links [1].
> >
> > Hello Naresh,
> >
> > I have tried to create this issue a few times without success.  Since I
> > do not have i386 HW, I am using qemu_i386.  If I use the supplied config,
> > my kernel does not boot.  I then try to modify config options which I
> > think are not relevant.  By the time I get to a config that will boot, I
> > can not recreate the issue. :(
> >
> > Just curious if you have any suggestions?  Or, Wondering if anyone else has
> > suggestions on how to proceed?
>
> Please install tuxmake and run attached script to reproduce reported issues,
> $ pip3 install tuxmake

oops, a typo, should be 'tuxrun' not 'tuxmake'.

https://tuxrun.org/

Cheers,
Anders

> $ ./memfd-crash-test-qemu-i386.sh
>
> This script downloads kernel Image and rootfs and runs run_hugetlbfs_test.sh.
> If you have any questions please get back to me.
> For your reference I have attached logs.txt
>
> > --
> > Mike Kravetz
