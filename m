Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CEF724877
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 18:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237900AbjFFQDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 12:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbjFFQDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:03:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53E310D5;
        Tue,  6 Jun 2023 09:03:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 422DF60C04;
        Tue,  6 Jun 2023 16:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382D9C433EF;
        Tue,  6 Jun 2023 16:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686067415;
        bh=8ux32c/+XVEBKmqishWBgDV5JYIrpFiRxA/mzTyLgUI=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=eQR7PQqPjKltjxrHubDrbI35A+fxP3AQh6x2EDo9c0HKA2z2EY0sJrBmrwN3rKd3M
         5GZHYeyRriHiIO4EgGkSgP57qZ4I4pMaDkFeRwdAPMcNH/FBI4w75EL37UcMFLf+XJ
         YBYY/GawCjFGACunEld47H3TxG1PLHwtgKY4+ZRI63NlhYJyTdk/MT7X8sb96+Fb55
         c1PK++jvmFNM4iVyxCbSV7OFQbLzeISULEBYB+cV4n+zQaeFghCQiR8tz5sBTv6Smk
         tYDVwni/W9o0EKaOvExqjZvKkxo5NIGiSvE4XrAMVP8G39G52bhJPJ17oq9gl6MHgI
         LOwBky869em6A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 06 Jun 2023 19:03:30 +0300
Message-Id: <CT5P0JH7NOTO.3P08AWR6O128R@suppilovahvero>
Cc:     "Bagas Sanjaya" <bagasdotme@gmail.com>,
        "Franziska Naepelt" <franziska.naepelt@googlemail.com>,
        <keyrings@vger.kernel.org>, <dhowells@redhat.com>,
        <dwmw2@infradead.org>, <linux-kernel@vger.kernel.org>,
        "Franziska Naepelt" <franziska.naepelt@gmail.com>,
        "kernel test robot" <lkp@intel.com>,
        "Linux SPDX Licenses" <linux-spdx@vger.kernel.org>,
        "Linux Kernel Janitors" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH v2] certs/extract-cert: Fix checkpatch issues
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Dan Carpenter" <dan.carpenter@linaro.org>
X-Mailer: aerc 0.15.2-33-gedd4752268b2
References: <20230601190508.56610-1-franziska.naepelt@gmail.com>
 <20230602085902.59006-1-franziska.naepelt@gmail.com>
 <ZH8mhIrjyBvTF4oZ@debian.me>
 <e39efb7f-5d8f-4433-83b3-8eea8a6c0486@kadam.mountain>
 <CT5NH4XXIYQF.5XXJE6JA5FZP@suppilovahvero>
 <e44d03cf-9993-483c-b3d4-6185f5c028cc@kadam.mountain>
In-Reply-To: <e44d03cf-9993-483c-b3d4-6185f5c028cc@kadam.mountain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Jun 6, 2023 at 6:25 PM EEST, Dan Carpenter wrote:
> On Tue, Jun 06, 2023 at 05:51:09PM +0300, Jarkko Sakkinen wrote:
> > On Tue Jun 6, 2023 at 4:38 PM EEST, Dan Carpenter wrote:
> > > On Tue, Jun 06, 2023 at 07:28:52PM +0700, Bagas Sanjaya wrote:
> > > > On Fri, Jun 02, 2023 at 10:59:02AM +0200, Franziska Naepelt wrote:
> > > > > The following issues are fixed:
> > > > > - WARNING: Missing or malformed SPDX-License-Identifier tag
> > > > > - ERROR: trailing statements should be on next line
> > > > > - WARNING: braces {} are not necessary for single statement block=
s
> > > > > - ERROR: space required before the open parenthesis '('
> > > > > - ERROR: code indent should use tabs where possible
> > > > > - WARNING: please, no spaces at the start of a line
> > > > > - WARNING: Missing a blank line after declarations
> > > >=20
> > > > Again, write the patch description in imperative mood (e.g. "Do foo=
").
> > > >=20
> > >
> > > Why do you care about imperative tense?  Imperative tense doesn't
> > > matter.  What matters is that you can understand the issue and how it
> > > looks like to the user.  I was working with a group of foreign studen=
ts
> > > and it was painful to see the contortions that they went through to m=
ake
> > > a commit message imperative.  It's like saying "Bake a cake", "Ok, no=
w
> > > bake it while juggling."  The cake ends up worse.  And the commit
> > > message end up worse when we force nonsense rules like this.
> >=20
> > How about a simple and stupid reason?
> >=20
> > Usually I write commit message without caring about this. Then I rewrit=
e
> > the commit message and 9/10 it gets shorter. Based on empirical
> > experience, imperative form has minimum amount of extra words.
> >=20
>
> I'm looking through the git log to see if it's true the imperative tense
> commit message are shorter and better and neither one of those things is
> obvious to me.
>
> This patch had an imperative subject already so it was already kind of
> imperative.  Does every sentence have to be imperative or can you just
> add a "Fix it." to the end?
>
> I don't want to belittle the challenges you face around the English
> language but I think students were less fluent than you are.  So maybe
> imperative tense works for you but it definitely made their commit
> messages far worse.

Yeah, I was not trying to oppose, just reasoning why I like it more.

For a single patch, this does not really matter anyway :-)

BR, Jarkko
