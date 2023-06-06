Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374B27246D0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbjFFOvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238405AbjFFOvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:51:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188B8172C;
        Tue,  6 Jun 2023 07:51:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D5E66348F;
        Tue,  6 Jun 2023 14:51:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1D2C433EF;
        Tue,  6 Jun 2023 14:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686063074;
        bh=nfqOrjU8YRBzYZiLUr/vnc22t/tHDv39YnrTW/1MP5A=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=iB9nsuxVxWHVvdY0/JHlwVIYsWD9VFHeair/EbUwpuTkIOxqpf1RIo7cX1G+D9dZ7
         hmZB456oL67+hgnuiA/CVjQ/xF8gLKCtfm0gxC3pYbP867oNSE4D5Vft8Qs7y6yNu2
         rHpGt3J+/w/LmNRqS5ysLIYxCu/8wqDOwWBT4owdlCBx263u+KsUzllvENM0Qv1oxv
         qUhMnqAietjxVR08RvuZ/qYjnVjvAX//1dvQhVBSBhejRKAwXVEuXqTRGhp0WMUMaY
         DN5sx1oP5C+OUqDMKFnYmdj3ZzLar4VC/2TMZihmmb5l+8pjBjp17gEsCl72/56yTA
         qobBoutoqIn0A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 06 Jun 2023 17:51:09 +0300
Message-Id: <CT5NH4XXIYQF.5XXJE6JA5FZP@suppilovahvero>
Cc:     "Franziska Naepelt" <franziska.naepelt@googlemail.com>,
        <keyrings@vger.kernel.org>, <dhowells@redhat.com>,
        <dwmw2@infradead.org>, <linux-kernel@vger.kernel.org>,
        "Franziska Naepelt" <franziska.naepelt@gmail.com>,
        "kernel test robot" <lkp@intel.com>,
        "Linux SPDX Licenses" <linux-spdx@vger.kernel.org>,
        "Linux Kernel Janitors" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH v2] certs/extract-cert: Fix checkpatch issues
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Dan Carpenter" <dan.carpenter@linaro.org>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>
X-Mailer: aerc 0.15.2-33-gedd4752268b2
References: <20230601190508.56610-1-franziska.naepelt@gmail.com>
 <20230602085902.59006-1-franziska.naepelt@gmail.com>
 <ZH8mhIrjyBvTF4oZ@debian.me>
 <e39efb7f-5d8f-4433-83b3-8eea8a6c0486@kadam.mountain>
In-Reply-To: <e39efb7f-5d8f-4433-83b3-8eea8a6c0486@kadam.mountain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Jun 6, 2023 at 4:38 PM EEST, Dan Carpenter wrote:
> On Tue, Jun 06, 2023 at 07:28:52PM +0700, Bagas Sanjaya wrote:
> > On Fri, Jun 02, 2023 at 10:59:02AM +0200, Franziska Naepelt wrote:
> > > The following issues are fixed:
> > > - WARNING: Missing or malformed SPDX-License-Identifier tag
> > > - ERROR: trailing statements should be on next line
> > > - WARNING: braces {} are not necessary for single statement blocks
> > > - ERROR: space required before the open parenthesis '('
> > > - ERROR: code indent should use tabs where possible
> > > - WARNING: please, no spaces at the start of a line
> > > - WARNING: Missing a blank line after declarations
> >=20
> > Again, write the patch description in imperative mood (e.g. "Do foo").
> >=20
>
> Why do you care about imperative tense?  Imperative tense doesn't
> matter.  What matters is that you can understand the issue and how it
> looks like to the user.  I was working with a group of foreign students
> and it was painful to see the contortions that they went through to make
> a commit message imperative.  It's like saying "Bake a cake", "Ok, now
> bake it while juggling."  The cake ends up worse.  And the commit
> message end up worse when we force nonsense rules like this.

How about a simple and stupid reason?

Usually I write commit message without caring about this. Then I rewrite
the commit message and 9/10 it gets shorter. Based on empirical
experience, imperative form has minimum amount of extra words.

I came up with this convention first when submitting patches to x86, and
over time it has started to make sense to me.

Especially for multi patch sets too verbose language tends to be super
tiring for non-native English speaker. One should optimize the language
in those: say *exactly* what is needed, and not more. If this not the
case, I tend to move these patch sets very last in my queue.

It's not a "punishment". It's more like that I really have to take the
time to read the prose...

BR, Jarkko
