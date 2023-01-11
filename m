Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805EC666617
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 23:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236026AbjAKWTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 17:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbjAKWSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 17:18:53 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4912BB8;
        Wed, 11 Jan 2023 14:18:49 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2DBFD5BF;
        Wed, 11 Jan 2023 22:18:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2DBFD5BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1673475529; bh=/K4sL0TMtuBdfBzxvBFB/mX5IHPqC4o8gznOoJH7K5A=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=cJGKmAwrxJFo9I4um3T8p74hzX3FppSTL+NWVDpfdm59YGBr6IY1LUs65YK8ATLCB
         aaMIB9H9Euv0x+rrNDtYOL4UUnnTCcsduhCNIrPoCChv/4xbO9r5BALZCLGhHXg52D
         AC7OIk04LgZVpDP2hFsvvtd67cA6U/1au5MrIsBLIc9icEWX5ElR20OCwxIa5n0NiX
         5tm4t77ZGfCa4hs4VcFGVusfuGpI5eQDR4LsxFjJSjyfIJXr2JTXZIIytjTEgxWZ0n
         NWvSctPipfsk7Emq9z97gLWrYyt8/R0KWmJt4jpIGusa0bd8jF2mO6sNn5n77m5FHq
         IBfi3r7rU3vgg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH] docs/conf.py: Use about.html only in sidebar of
 alabaster theme
In-Reply-To: <4b162dbe-2a7f-1710-93e0-754cf8680aae@gmail.com>
References: <4b162dbe-2a7f-1710-93e0-754cf8680aae@gmail.com>
Date:   Wed, 11 Jan 2023 15:18:48 -0700
Message-ID: <874jswyat3.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akira Yokosawa <akiyks@gmail.com> writes:

> "about.html" is available only for the alabaster theme [1].
> Unconditionally putting it to html_sidebars prevents us from
> using other themes which respect html_sidebars.
>
> Remove about.html from the initialization and insert it at the
> front for the alabaster theme.
>
> Link: [1] https://alabaster.readthedocs.io/en/latest/installation.html#sidebars
> Fixes: d5389d3145ef ("docs: Switch the default HTML theme to alabaster")
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>

This seems like a good fix, applied, thanks.

> I noticed this (kind of) build regression while trying to compare
> the alabaster theme with the other themes.
>
> I must say that the current html documentation at
>
>     https://www.kernel.org/doc/html/latest/
>
> is almost unusable in site navigation. Once I jump from the top page
> to somewhere, I'm at a loss. I can only go back to the top page,
> or go back to the previous page with the help of the browser. 
> (Of course, as I know the directory structure under Documentation/,
> I can navigate manually, but that's not nice!)
> I think it should at least have the same set of links as those
> the classic theme provides.
>
> Having read [1] and its surrounding documentation (for the first time,
> I must confess), the alabaster theme sounds (somewhat) unique in
> customizing sidebar and related links.
>
> But before looking further into alabaster, I'd like to know why
> you picked alabaster among those themes which come with Sphinx.
> Could you elaborate?

I picked it because it looked a lot cleaner than RTD, better supported
small-screen devices, and was the Sphinx default.  Like so many
things, it was done in a bit of a hurry and I cannot claim to have
thoroughly considered all of the alternatives.  I was hoping that people
would respond to the RFC if they had a better idea :)

If there is a better theme to use as the default, we can consider
changing it again; I don't think there is much cost or inconvenience
involved.  I do want the default theme to be one of those bundled with
Sphinx, though, rather than requiring it to be installed separately.

That said, I have no objection to adding configuration support for other
themes as well, should people want to use them.

Thanks,

jon
