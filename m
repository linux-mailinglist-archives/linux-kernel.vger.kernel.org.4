Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F217397B4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 09:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjFVHBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 03:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjFVHB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 03:01:29 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765AF10F8;
        Thu, 22 Jun 2023 00:01:27 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 3454F5C006E;
        Thu, 22 Jun 2023 03:01:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 22 Jun 2023 03:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687417284; x=1687503684; bh=XuIRhzWY9Y3nU
        ys0sFqucjCSGmg4/nWPkpQ4qhtrDFA=; b=LnfiqT1mNH+G8dW2zx9DPayKghTuu
        XItKBkqTyuT+pgcLksCbNvMXX8s3ZNY+XWSulbYhL2wxFepUUIK4QAx9JIqQrGT1
        XJMXENJwQQFa+qSWZ9uIiEjCnJX7y11Koi4+Sy4rWvIEXr6OexYccBYpwK22I2rN
        laXt6q7C1HlYwQLn4HleW6ruzR+HALq80AjHAoorru557BD6z6ScDXhG+2vEHaUX
        0fcFABYVQq4DInnJwSg7DZCQ5d+UcqCwLyb+11jf2Zny8PRRais5ntm1uLfERvoc
        ED08Zuo6jq8CUtUvBsPwIO9pXtHjUj00Fcur/JrJ/AWwVIbbG3DqHhRzg==
X-ME-Sender: <xms:w_GTZBCf0ygrvp68_rbW_paUYiVEuumBweOh-rfbXqIS8AiCgSAnZw>
    <xme:w_GTZPg1uU29_ayGWkjg2prYmRcGf3m18a9EwQKLBr7pI343ylQHa9hDsK-wTqaoo
    8ULY22hUQsdj8hrxDU>
X-ME-Received: <xmr:w_GTZMkiWUYeFBoovLAfrX6N7PtjtR096Eqv5NZYoYUOB48NxV-XzcaMM_EBr0bcCSJXux1v_NPts2WYQ2QM1SPQalgGehyxlyU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeegtddguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhn
    ucfvhhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrf
    grthhtvghrnhepfeeiheejvdetgfeitddutefhkeeilefhveehgfdvtdekkedvkeehffdt
    keevvdeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhugidqmhei
    kehkrdhorhhg
X-ME-Proxy: <xmx:w_GTZLzRY63t83cwMeCrxhJPyPdDJYs7tlzz8twLjBDWdhrM_N87yA>
    <xmx:w_GTZGT5gh8QrZZccrVah0Kvu66n1ziHeRpURLfPLcadCesFtbKIgA>
    <xmx:w_GTZOaj6jfFtTGDePwQufYvEdmoR8PDhr0q3XaeXqXAEgG7qFQF5w>
    <xmx:xPGTZDJWO0WdIK2ylmI6Ke6hMymCFqnjbZJUoswIcYVJagKrjDJKgw>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jun 2023 03:01:20 -0400 (EDT)
Date:   Thu, 22 Jun 2023 17:02:10 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Theodore Ts'o <tytso@mit.edu>, Jonathan Corbet <corbet@lwn.net>,
        tech-board-discuss@lists.linux-foundation.org,
        Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Linux Contribution Maturity Model and
 the wider community
In-Reply-To: <2023062144-hefty-why-305d@gregkh>
Message-ID: <04cd7204-cdee-c333-8815-57acbab82721@linux-m68k.org>
References: <20230620212502.GI286961@mit.edu> <5490402b-8b9f-f52d-3896-41090e639e51@linux-m68k.org> <2023062144-hefty-why-305d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023, Greg Kroah-Hartman wrote:

> On Wed, Jun 21, 2023 at 11:51:19AM +1000, Finn Thain wrote:
> > > You appear to have a very different model of how non-profits might 
> > > approach the Linux kernel --- could you go into more detail about 
> > > why they might want to contribute to the Linux kernel, and how we 
> > > might encourage them to contribute more engineering effort?
> > > 
> > 
> > Sure. Here's a recent example, in which a not-for-profit volunteer 
> > might have been granted an opportunity to work upstream: 
> > https://lore.kernel.org/all/129c9d5e-213a-80c9-092e-dc1dcf38ae3e@linux-m68k.org/
> > 
> > The driver in question may may not be commercially viable, but that 
> > doesn't matter, if the intention is to foster new maintainers and 
> > increase the talent pool. And the problem ostensibly being addressed 
> > in the Linux Contributor Maturity Model is a shortage of maintainers.
> 
> I would NEVER recommend ANYONE picking up obsolete hardware and trying 
> to get it to work to maintain the driver if NO ONE is actually using the 
> stuff.  That should not be for a not-for-profit to maintain as 
> obviously, no one uses it.
> 
> It's up to those that need/use the code to help maintain it, don't ask 
> not-for-profit groups to maintain and support code that no one uses, 
> that's a sure way to waste resources all around.
> 

Actually, that patch was offered without any prompting from me. But you're 
quite right -- I would have prompted it, had I had the oppportunity.

> So that's a good example of how our ecosystem works properly, if no one 
> needs the code, it gets dropped.  Don't ask for it to come back without 
> real users who are invested in it please.
> 

You mentioned wasted resources. If you want to generate e-waste, remove 
drivers from the kernel. If you want to prevent e-waste, add drivers for 
obsolete hardware and then watch the user count climb from zero as devices 
get pulled from drawers and dusted off.

Anyway, your reaction is an interesting example of strong feelings in the 
community as to how contributed code should or should not be used. E.g. 
some get upset if their code runs on weapons systems, others get upset if 
the latest release might not run on suitable hardware in the immediate 
future. Some add or remove licence terms according to their convictions.

If there was consensus, it might be feasible to give a formula for 
"recognized usage" which could be quantified. From there we could create a 
kind of heat map to show which commits, maintainers, processes, models, 
modules etc. were the most "useful" within some time interval.
