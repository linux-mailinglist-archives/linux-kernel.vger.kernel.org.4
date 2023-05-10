Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D599B6FD955
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236209AbjEJIaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236569AbjEJI3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:29:41 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23BB6EAD
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:29:35 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5304913530fso1128065a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1683707375; x=1686299375;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b2xRU4DVxsSVuaC8fjcePTd87ody2pQ2dSAcn+XFykk=;
        b=a9EcfGupB083jY4GqOeLzIHMRrdt1cNg8OmC77bqrteplFqmx2MO0GFZaQU4dMmCMP
         mXfhyxru+aQ+IHX9ktVbTU/6lHYnh40ZaUe8sPzwj/cJTN+4S3/akgmHKpx10lhvuO2u
         /xCDNr7W7evPIpRsnndoFLYfsYJpEjBGNwM+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683707375; x=1686299375;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b2xRU4DVxsSVuaC8fjcePTd87ody2pQ2dSAcn+XFykk=;
        b=gUSQ1wJNJLNRz0OtoznHqBH3ZQaiBWINhmaotjG6RlhNQtYMRJqJTxMBmGzyES7M7p
         hBleXW8BMBdV8R0NP2OW2VtoUvmaR9go4ixD223ukJN0pRhwRFrjezOweZ4CJfQBQo6L
         JFNqrXhi/T6/rPW7aalaBnCU7dUhyhuA7bI1n+CFISTtjFozkjVZfcqirdUtm98Yq7UU
         bepR7k2Q0WW8RgG3+c5IfET+p2qzRiO4F2FTRkkX+kakt9WKU6+OZFtW4AFRvnakSZWi
         6WunrV6VMAZc8kW1H9Wk4N8fO93n/upexBbztP7704fzjHmcy6B0nddUZojpPwZ6R4z3
         QJlQ==
X-Gm-Message-State: AC+VfDyLExT4uL0MASQaXVoPKtgtgQQzAcFVSew9J2BwBtga75WW/9kz
        W7yY+21XeMdlH2pk2I/kEwOpH2qhBM6TT3vyGafzbw==
X-Google-Smtp-Source: ACHHUZ52abw8CG8AO4WTVIvG68uMV9klQ7sKOXFMx834072NH4ooLnUqKw4gA4qMVJEv4mh3ZvjKCt6tnqm7pJOKF2c=
X-Received: by 2002:a17:902:b090:b0:1ac:591b:511 with SMTP id
 p16-20020a170902b09000b001ac591b0511mr13686673plr.36.1683707375254; Wed, 10
 May 2023 01:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230509030705.399628514@linuxfoundation.org> <20230509080658.GA152864@d6921c044a31>
 <20230509131032.GA8@9ed91d9f7b3c> <2023050913-spearhead-angrily-fc58@gregkh>
 <20230509145806.GA8@df3c0d7ae0b0> <2023051025-plug-willow-e278@gregkh>
In-Reply-To: <2023051025-plug-willow-e278@gregkh>
From:   Rudi Heitbaum <rudi@heitbaum.com>
Date:   Wed, 10 May 2023 18:29:23 +1000
Message-ID: <CAG9oJsnr55Atybm4nOQAFjXQ_TeqVG+Nz_8zqMT3ansdnEpGBQ@mail.gmail.com>
Subject: Re: [PATCH 6.3 000/694] 6.3.2-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        ntfs3@lists.linux.dev, almaz.alexandrovich@paragon-software.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2023 at 17:25, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, May 09, 2023 at 02:58:06PM +0000, Rudi Heitbaum wrote:
> > On Tue, May 09, 2023 at 03:56:42PM +0200, Greg Kroah-Hartman wrote:
> > > On Tue, May 09, 2023 at 01:10:32PM +0000, Rudi Heitbaum wrote:
> > > > On Tue, May 09, 2023 at 08:06:58AM +0000, Rudi Heitbaum wrote:
> > > > > On Tue, May 09, 2023 at 05:26:44AM +0200, Greg Kroah-Hartman wrote:
> > > > > > This is the start of the stable review cycle for the 6.3.2 release.
> > > > > > There are 694 patches in this series, all will be posted as a response
> > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > let me know.
> > > > > >
> > > > > > Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> > > > > > Anything received after that time might be too late.
> > > > >
> > > > > Hi Greg,
> > > > >
> > > > > 6.3.2-rc2 tested.
> > > >
> > > > Hi Greg,
> > > >
> > > > Further testing and have seen ntfs3: NULL pointer dereference with ntfs_lookup errors
> > > > with 6.3.2-rc2 (I have not seen this error before.) No other errors in the logs.
> > >
> > > Can you reproduce this without the extern, gpl-violation module loaded?
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Hi Greg,
> >
> > I dropped the bcm_sta and recompiled and commented out the i915.guc=3
> > and was able to reproduce.
> >
> > [   84.745080] BUG: kernel NULL pointer dereference, address: 0000000000000020
> > [   84.746239] #PF: supervisor read access in kernel mode
> > [   84.747599] #PF: error_code(0x0000) - not-present page
> > [   84.748929] PGD 0 P4D 0
> > [   84.750240] Oops: 0000 [#1] SMP NOPTI
> > [   84.751575] CPU: 2 PID: 3176 Comm: .NET ThreadPool Not tainted 6.3.2-rc2 #1
> > [   84.752998] Hardware name: Intel(R) Client Systems NUC12WSKi7/NUC12WSBi7, BIOS WSADL357.0085.2022.0718.1739 07/18/2022
> > [   84.754474] RIP: 0010:ntfs_lookup+0x76/0xe0 [ntfs3]
>
> And do you get this same crash on ntfs3 on 6.4-rc1?  Is this a new
> regression, or does it also show up on 6.3.1?

Tested with 6.3.1 during the day today. No errors, and had been
running 6.3.1 with no issue. Retested with 6.3.2-rc2 and problem
immediately evident. So yes - I believe a regression.

I have built and am now testing 6.4.0-rc1 this evening - no errors so far.

[    0.000000] Linux version 6.4.0-rc1 (docker@1ccd349e2545)
(x86_64-libreelec-linux-gnu-gcc-13.1.0 (GCC) 13.1.0, GNU ld (GNU
Binutils) 2.40) #1 SMP Wed May 10 07:51:37 UTC 2023

> And ntfs, ick, why?  And .NET?  What a combination...

Joys of media players. Test device gets to test exfat, ntfs3, .NET,
and throw in a compile host/GHA runner to put it through paces.

> thanks,
>
> greg k-h
