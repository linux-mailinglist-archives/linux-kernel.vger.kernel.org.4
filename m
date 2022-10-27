Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A083960FB1C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbiJ0PDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbiJ0PDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:03:32 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1724718E2AD;
        Thu, 27 Oct 2022 08:03:30 -0700 (PDT)
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 29RF2pNW008705;
        Fri, 28 Oct 2022 00:02:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 29RF2pNW008705
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1666882972;
        bh=qJl833vkhGJzJSQ8btO7eRg7ndYpAfbrbnuTzDCIijU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QV/QUbsvjAImYnNfHxzdaGUEfjsrAAcMSfwlRxtgmQcfqXc+c1Oio4c6vcgNyP4NL
         FKrjWxXbF9lfOCEPHOd63Cn2RuFuiI+8WXgpyozSEsBviqx9Dsc+/7rTd1BuuMsoq7
         zgN2FxvwyH2aaOY91OG4KcnPxQNrU3Fe9GffnTXnGSEZb/wdUQhk7dD6BKrqdYODqN
         bjI97rFDftQ1JUwX+47QWUZTGZauDpAXRq6Qh11bHPtyTmcdwKsyucpnsOrier+DN5
         1JP15vwvqki2fxopQRI559+bH4QVKCKYiMzTwYbOdRweLC5IIzFk7+SmXLq0SCj8Av
         dozPuogVSS71w==
X-Nifty-SrcIP: [209.85.160.41]
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-13b6c1c89bdso2347804fac.13;
        Thu, 27 Oct 2022 08:02:52 -0700 (PDT)
X-Gm-Message-State: ACrzQf1gCBUzR2eNcUgQ+F5Hge/t8+7LKKWqWp1fuI1JSpYIpYYrUDZx
        twNrOIo6u/hG9Dmkf8ImGZJbsMQ1FZXhCgYvoPs=
X-Google-Smtp-Source: AMsMyM4LpxjYQpXQm8IFgQLzWrUCCDqX+RmL6tpFVSGEyWqLSPvxV5xSgSk1qdpHaEzz14GjB661Ld2Ytb79Os9kgNY=
X-Received: by 2002:a05:6870:c58b:b0:10b:d21d:ad5e with SMTP id
 ba11-20020a056870c58b00b0010bd21dad5emr5787160oab.287.1666882970929; Thu, 27
 Oct 2022 08:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20221023124810.51b1201b@canb.auug.org.au> <a49605d6-6e1f-78c8-9774-423891089052@linux.alibaba.com>
In-Reply-To: <a49605d6-6e1f-78c8-9774-423891089052@linux.alibaba.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 28 Oct 2022 00:02:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNARMwzYag=t_0D0Vf14h22NU+RsuqnMve_akOew10On=Wg@mail.gmail.com>
Message-ID: <CAK7LNARMwzYag=t_0D0Vf14h22NU+RsuqnMve_akOew10On=Wg@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the
 kbuild-current tree
To:     Dan Li <ashimida@linux.alibaba.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
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

On Mon, Oct 24, 2022 at 3:34 PM Dan Li <ashimida@linux.alibaba.com> wrote:
>
>
>
> On 10/22/22 18:48, Stephen Rothwell wrote:
> > Hi all,
> >
> > Commit
> >
> >    9a21115ca50e ("Documentation: kbuild: Add description of git for reproducible builds")
> >
> > is missing a Signed-off-by from its committer.
> >
> > Also, I am guessing (I haven't actually done the build, yet) that this
> > will produce a new build warning from (e.g.) "make htmldocs", as the
> > underlining of the new "Git" header line is longer than it should be.
>
> Oh yes, I didn't see a warning when compiling, but it should be aligned
> here, sorry for the typo.
>
> To Masahiro:
> Do I need to submit a V2 to remove the extra underscore here? I'm willing
> to if needed :)
>
> Thanks, Dan.
>
> >


No, worry.


Just in case, the following is what I applied locally.



index 13397f38c358..f2dcc39044e6 100644
--- a/Documentation/kbuild/reproducible-builds.rst
+++ b/Documentation/kbuild/reproducible-builds.rst
@@ -120,7 +120,7 @@ kernel versions by including an arbitrary string
of "salt" in it.
 This is specified by the Kconfig symbol ``CONFIG_BUILD_SALT``.

 Git
------------------------
+---

 Uncommitted changes or different commit ids in git can also lead
 to different compilation results. For example, after executing






-- 
Best Regards
Masahiro Yamada
