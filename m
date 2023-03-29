Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64AF6CF2AE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjC2TDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjC2TDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:03:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEC71BEC;
        Wed, 29 Mar 2023 12:03:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D881261DF4;
        Wed, 29 Mar 2023 19:03:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F66C4339C;
        Wed, 29 Mar 2023 19:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680116625;
        bh=YGgwaQb1Yr5alEBeh50oaFn8YhIPQRRHYUsEM/NJD3o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P2lmP8E33IXjzH4K/gd1MewJa5cVRw06HgrDUFB8rL+9UUFDaxSX79kGtHk15qHfn
         +AwnoYTQBJ/Fmq9qyUoqwY5uO7vhVqhVwIwsssSN36Yx1Fe4kLS6uSB2Bdi+yGyoXp
         +1yjYxdMyzRnXwkd20epYnEARRcYGiCp8pAOhzokhfC3/VHMkKsQsxf54yq0d4USwd
         8Qw+FGDGlFfaSh47rGbT8hCClgnnu3NTb+hyqEvS2eMDfxx31h4wbbIDB3TiPbTIam
         jcQOW6J9fNlXYb5A4gCakILz3mNRadydpZ8ucamPdndMjbpnY9809tMjYE65hkhFN9
         /jjSO07Lvxl3g==
Received: by mail-lj1-f181.google.com with SMTP id e9so1969009ljq.4;
        Wed, 29 Mar 2023 12:03:45 -0700 (PDT)
X-Gm-Message-State: AAQBX9eslECyDJW4PHzFT9rZZNQWFmXi87YoL/EkYly07tkAk5N7tDzw
        MRvm61g4XmRtUDhswzYbAQKHc0G1QEnkxkSJd8o=
X-Google-Smtp-Source: AKy350axvSqGy7GyrH8RKgEAR0+nNstDei6hLLlElkZD93z6FpVGXFrT2U64o7wib0jSGOlS/1QRWOI3Dofy8a+cm0s=
X-Received: by 2002:a2e:6a0d:0:b0:295:93eb:e790 with SMTP id
 f13-20020a2e6a0d000000b0029593ebe790mr6348106ljc.5.1680116623266; Wed, 29 Mar
 2023 12:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de> <6ee3b703-2161-eacd-c12f-7fa3bedf82dc@web.de>
 <49adf0c8-825a-018f-6d95-ce613944fc9b@web.de> <CAPhsuW7JZDps_fTHyCabjfG4YjzDVEW_41u6d+9mdc2CAJv_Kw@mail.gmail.com>
 <2fbfc20a-71ee-ddaa-19d8-7beed559b491@web.de>
In-Reply-To: <2fbfc20a-71ee-ddaa-19d8-7beed559b491@web.de>
From:   Song Liu <song@kernel.org>
Date:   Wed, 29 Mar 2023 12:03:30 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6pEK6mQbo=F7DWPhCW1ePkKP2WM8saoeAfMOCSF3CdOA@mail.gmail.com>
Message-ID: <CAPhsuW6pEK6mQbo=F7DWPhCW1ePkKP2WM8saoeAfMOCSF3CdOA@mail.gmail.com>
Subject: Re: [0/2] md/raid: Adjustments for two function implementations
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org, linux-raid@vger.kernel.org,
        Coly Li <colyli@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Maciej Trela <Maciej.Trela@intel.com>,
        Neil Brown <neilb@suse.de>, Shaohua Li <shli@fb.com>,
        cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,URI_DOTEDU autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 10:32=E2=80=AFPM Markus Elfring <Markus.Elfring@web=
.de> wrote:
>
> >>   raid1: Fix exception handling in setup_conf()
> >>   raid10: Fix exception handling in setup_conf()
> >
> > The two functions look good to me as-is. I don't think anything is
> > broken except that the code analysis tool complains. I don't think
> > it is necessary to make these changes.
>
> Will development interests ever grow also for advice from another informa=
tion source?
> https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a+g=
oto+chain+when+leaving+a+function+on+error+when+using+and+releasing+resourc=
es#MEM12C.Considerusingagotochainwhenleavingafunctiononerrorwhenusingandrel=
easingresources-CompliantSolution%28POSIX,GotoChain%29

While I understand "goto chain" is a good pattern for error handling, I am
not convinced it is a better approach here. Specifically, the goto chain is=
 so
long that it is hard to maintain. This also adds overhead for users of
git-blame. Therefore, I would rather keep these two functions as-is.

Thanks,
Song
