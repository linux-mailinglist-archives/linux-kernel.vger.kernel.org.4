Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B9C5FCE84
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiJLWfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiJLWfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:35:31 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376DDCF866;
        Wed, 12 Oct 2022 15:35:29 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 29CMZ1Mn009182;
        Thu, 13 Oct 2022 07:35:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 29CMZ1Mn009182
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1665614102;
        bh=pFBEWxEfl0ENXdCP63hjCsmK0QAgrGmw7omrl10dSXU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jV50O0Re+obngdx9A6ffb18I8QqYGAg3I1ndpPlbZ6U0BkyvQkPD/L2nsFHboFviF
         0HPJxe4tkUNRHILdqkd84C+5yNv5YcfQeU1DnBRDRdY4Fp7LJQSAmZeZs3VWjidoLy
         qBbMA2iPIdAU7hVQvW226xJGT3q7gACYfxYTQupRI0C8D5XJY4SdUo9bfKS6hBHflu
         i/dyV2arYnckhDytU/PsuXIaPV45/sASqoXFdUPFV42GkK/EuJSPZAHkX2mDkHP+4+
         AQb0Iewuz7YsPLbF+hVYRADHdtRq/CEewJhGKe3qUi1jlLAbuweghuNm7Dx0GV+nzD
         XHRpnCk4mUVAg==
X-Nifty-SrcIP: [209.85.208.170]
Received: by mail-lj1-f170.google.com with SMTP id bs14so237178ljb.9;
        Wed, 12 Oct 2022 15:35:01 -0700 (PDT)
X-Gm-Message-State: ACrzQf2iu9PPMFKHePJ+GJ0aBPmIpNkPQzTdb7KNvLysb5eHM/a0X6aT
        p0gvISkDc1iHY4hGe+aOf1OpTApfutDPcBl3STc=
X-Google-Smtp-Source: AMsMyM6cVX06c2qKPXV4ljIqp3j6qM9rC/QxNZITwygCT2i3B45ajQFjmTIOvbW2SS/8HUfdOb9shUYn2JdA6f5xuFs=
X-Received: by 2002:a2e:80d6:0:b0:26f:b481:7ebd with SMTP id
 r22-20020a2e80d6000000b0026fb4817ebdmr5099867ljg.276.1665614100020; Wed, 12
 Oct 2022 15:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <20221013091722.72263dca@canb.auug.org.au>
In-Reply-To: <20221013091722.72263dca@canb.auug.org.au>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 13 Oct 2022 07:34:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNASCFVxGV0e1DbnJzrtRJs_iuMsL6Q-2oxpoRMaSK5U1ZA@mail.gmail.com>
Message-ID: <CAK7LNASCFVxGV0e1DbnJzrtRJs_iuMsL6Q-2oxpoRMaSK5U1ZA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the kbuild tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Jun Lei <Jun.Lei@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Zeng Heng <zengheng4@huawei.com>,
        Wenjing Liu <Wenjing.Liu@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 7:17 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the kbuild tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
>
> Exposed by commit
>
>   61168a974a16 ("Makefile: add implicit enum-conversion check for compile build")
>
> We don't add compiler flags that produce more warnings/errors without
> first fixing the known problems.  This was the example of what would
> happen that was cited in the commit message.
>
> I have used the kbuild tree from next-20221012 for today.
>
> Is this new stuff really destined for 6.1?
>
> The actual error was caused by commits
>
>   5fc11598166d ("drm/amd/display: expand dml structs")
>   d478667253f9 ("drm/amd/display: use odm combine for YCbCr420 timing with h_active greater than 4096")
>
> which entered Linus' tree during this merge window.
>
> --
> Cheers,
> Stephen Rothwell


Or, if it is not too late,
can you revert only commit 61168a974a16?


I will drop it for tomorrow's linux-next.




-- 
Best Regards
Masahiro Yamada
