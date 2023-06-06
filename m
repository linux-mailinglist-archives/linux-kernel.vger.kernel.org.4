Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00AE724AB5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238156AbjFFR7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238028AbjFFR7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:59:15 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D3610F8;
        Tue,  6 Jun 2023 10:59:14 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-43c1e5978e4so309766137.1;
        Tue, 06 Jun 2023 10:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1686074353; x=1688666353;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JYq8kaJ2RB9RXyaMdQYUWfY+ygasp2eONssKUmLHTZI=;
        b=hqHBn18UMUosvkpX9pz+Y6rsS4UMWZoFG2VwNtxGnnDpZNq/lhwkRTPbMMqik6EZFe
         5nsTkuXOy9pyW9Zn8xiL1qdjLR0E124veGavMyq3Jy0JqXaie7zbs26oh5UAIMoTc40r
         MFyOp9rg98QbjuujmiyA3JK7SGX1dlSVQUBdQDR1paObBHdMlLyKdp1mecbikUDvmGml
         1KE5kEQn0wNEcpZPJWOsM7IN/tTMK+XQs74/DzA1t8D+aUn4lN+JTY7JXlmzDllxT/f/
         2SJpSZwFtiQ6BSloMPjiHdIvM6qmitvzNwDXl/95QJR6n0THRFzUimQii6+X7xgkKOIw
         MgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686074353; x=1688666353;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JYq8kaJ2RB9RXyaMdQYUWfY+ygasp2eONssKUmLHTZI=;
        b=cFPNqF7cj98LsbPTjy2ftugr8OZoOHaTOZyKBxNSuuye0se3J+NuI1aeCEuCXmtB5p
         q3ZCEGvdaPrG56lSot1fn0izZwfz39PIJnUOChg6Gz0ilBgIbiHaJ8Dc4dsoLvSEypuI
         lY1BViJCAEfTnMy7WdT6G+IZyX4U3+7RtxRWPDnl1cRiIKYPRtVypKDEtcpBeWxj8zTM
         MwqyP6BzpWgrLDKoDhX0mbjy+6wMb22/SKaMVZoUoqIJ0z01dZhNXDiBPOaYehYNc8qb
         KIUf8JbRCSGUIx1KF08RdcUwyjNXndnPKE9v5f4ogk1qCFBloJP1R/fHzozTFJcBvtrQ
         sNmQ==
X-Gm-Message-State: AC+VfDz3budrDEYyrIqQTIgEslbDdP8kxPmymRhQ50LqnynyecNYmumc
        n9DO66qxreP51GjZa2e/s493tmSZ21c7yHeE+RM=
X-Google-Smtp-Source: ACHHUZ6XV7FNTI9IXULFRO/fknoKV1VuqA0s1kTybjmUeeu6wHnvSJtwOFAzTmTqjQKnwmaKZ/PiXmmhlYL6PmX1C34=
X-Received: by 2002:a67:f545:0:b0:43b:15b6:18d0 with SMTP id
 z5-20020a67f545000000b0043b15b618d0mr242299vsn.10.1686074353178; Tue, 06 Jun
 2023 10:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230601190508.56610-1-franziska.naepelt@gmail.com>
 <20230602085902.59006-1-franziska.naepelt@gmail.com> <ZH8mhIrjyBvTF4oZ@debian.me>
 <e39efb7f-5d8f-4433-83b3-8eea8a6c0486@kadam.mountain> <CT5NH4XXIYQF.5XXJE6JA5FZP@suppilovahvero>
 <e44d03cf-9993-483c-b3d4-6185f5c028cc@kadam.mountain> <CT5P0JH7NOTO.3P08AWR6O128R@suppilovahvero>
In-Reply-To: <CT5P0JH7NOTO.3P08AWR6O128R@suppilovahvero>
From:   =?UTF-8?Q?Franziska_N=C3=A4pelt?= 
        <franziska.naepelt@googlemail.com>
Date:   Tue, 6 Jun 2023 19:59:02 +0200
Message-ID: <CAAUT3iPVFZEQE+bFk4HhWbaAtnsbQLYrzggeD2Va4mC0Q09SNQ@mail.gmail.com>
Subject: Re: [PATCH v2] certs/extract-cert: Fix checkpatch issues
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>, keyrings@vger.kernel.org,
        dhowells@redhat.com, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Linux SPDX Licenses <linux-spdx@vger.kernel.org>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di., 6. Juni 2023 um 18:03 Uhr schrieb Jarkko Sakkinen <jarkko@kernel.org>:
> On Tue Jun 6, 2023 at 6:25 PM EEST, Dan Carpenter wrote:
> > On Tue, Jun 06, 2023 at 05:51:09PM +0300, Jarkko Sakkinen wrote:
> > > On Tue Jun 6, 2023 at 4:38 PM EEST, Dan Carpenter wrote:
> > > > On Tue, Jun 06, 2023 at 07:28:52PM +0700, Bagas Sanjaya wrote:
> > > > > On Fri, Jun 02, 2023 at 10:59:02AM +0200, Franziska Naepelt wrote:
> > > > > > The following issues are fixed:
> > > > > > - WARNING: Missing or malformed SPDX-License-Identifier tag
> > > > > > - ERROR: trailing statements should be on next line
> > > > > > - WARNING: braces {} are not necessary for single statement blocks
> > > > > > - ERROR: space required before the open parenthesis '('
> > > > > > - ERROR: code indent should use tabs where possible
> > > > > > - WARNING: please, no spaces at the start of a line
> > > > > > - WARNING: Missing a blank line after declarations
> > > > >
> > > > > Again, write the patch description in imperative mood (e.g. "Do foo").
> > > > >
> > > >
> > > > Why do you care about imperative tense?  Imperative tense doesn't
> > > > matter.  What matters is that you can understand the issue and how it
> > > > looks like to the user.  I was working with a group of foreign students
> > > > and it was painful to see the contortions that they went through to make
> > > > a commit message imperative.  It's like saying "Bake a cake", "Ok, now
> > > > bake it while juggling."  The cake ends up worse.  And the commit
> > > > message end up worse when we force nonsense rules like this.
> > >
> > > How about a simple and stupid reason?
> > >
> > > Usually I write commit message without caring about this. Then I rewrite
> > > the commit message and 9/10 it gets shorter. Based on empirical
> > > experience, imperative form has minimum amount of extra words.
> > >
> >
> > I'm looking through the git log to see if it's true the imperative tense
> > commit message are shorter and better and neither one of those things is
> > obvious to me.
> >
> > This patch had an imperative subject already so it was already kind of
> > imperative.  Does every sentence have to be imperative or can you just
> > add a "Fix it." to the end?
> >
> > I don't want to belittle the challenges you face around the English
> > language but I think students were less fluent than you are.  So maybe
> > imperative tense works for you but it definitely made their commit
> > messages far worse.
>
> Yeah, I was not trying to oppose, just reasoning why I like it more.
>
> For a single patch, this does not really matter anyway :-)
>
> BR, Jarkko

I'm a bit puzzled now since there are different opinions on my patch.
I'm struggling to draw a conclusion whether to split the patch into smaller
single line patches or not.

I'd propose to split it into two patches:
* One for SPDX license tag fix
* One for spacing, tab, blank line, unnecessary braces etc.
And fix the remarks related to SPDX license tag and the use of imperative.

If you agree I'm happy to provide two new patches.

Anyway, as per Dan's proposal I'll continue to work in drivers/staging.

Thanks,
Franziska
