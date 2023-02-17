Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD8069A2EE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 01:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjBQAaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 19:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjBQAa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 19:30:27 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB3034022;
        Thu, 16 Feb 2023 16:30:26 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8AF5E2ED;
        Fri, 17 Feb 2023 00:30:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8AF5E2ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1676593825; bh=IPkIzJ6RsuEEgaqZNxiZrcDInYONFkZL3WGC1ruybMo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=XxDB/h8e8Q9yvGXZfm+omUkKZ/GAVnBQanaG4U5wFw9k6IRfG4VLkXRsHzE9qtjph
         GwSJt+VnsQufLa0po+1sRf3emwh5kE166mUr92djEmhlXF0Xa24EXdc5C7ey6fVzWZ
         X1TA1wm04uApeLyJp5kBmA/Xf1GLIdmwW1QqzeF6rd87DJpPK0uxOAWePwIbSwNBdA
         0lXCcC0oL4U8TqqMNxSzBU1sJDZk+bdXp6SkPSPzxaYWKSVbFTUEH0XueCyGt6imZG
         6NucNPqQ6DYb9goOIdFR4H1WXMIg9aUvldn+5dgR20/CAZ0EWvXT7Wm40Y1qP36M4U
         OzcCiR04cJaMQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, Greg KH <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v2] docs: describe how to quickly build a trimmed kernel
In-Reply-To: <8cfcf069d48c1b8d7b83aafe0132f8dad0f1d0ea.1676400947.git.linux@leemhuis.info>
References: <8cfcf069d48c1b8d7b83aafe0132f8dad0f1d0ea.1676400947.git.linux@leemhuis.info>
Date:   Thu, 16 Feb 2023 17:30:24 -0700
Message-ID: <873575gmlb.fsf@meer.lwn.net>
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

Thorsten Leemhuis <linux@leemhuis.info> writes:

> Add a text explaining how to quickly build a kernel, as that's something
> users will often have to do when they want to report an issue or test
> proposed fixes. This is a huge and frightening task for quite a few
> users these days, as many rely on pre-compiled kernels and have never
> built their own. They find help on quite a few websites explaining the
> process in various ways, but those howtos often omit important details
> or make things too hard for the 'quickly build just for testing' case
> that 'localmodconfig' is really useful for. Hence give users something
> at hand to guide them, as that makes it easier for them to help with
> testing, debugging, and fixing the kernel.
>
> To keep the complexity at bay, the document explicitly focuses on how to
> compile the kernel on commodity distributions running on commodity
> hardware. People that deal with less common distributions or hardware
> will often know their way around already anyway.

So this seems generally good though - as is my usual style - if it were
mine I'd be trying to find a way to make it significantly shorter.

I could certainly bikeshed a lot of things - I'm not convinced about the
whole shallow-clone business, for example - but I'll try to restrain
myself.

> The document heavily uses anchors and links to them, which makes things
> slightly harder to read in the source form. But the intended target
> audience is way more likely to read rendered versions of this text on
> pages like docs.kernel.org anyway -- and there those anchors and links
> allow easy jumps to the reference section and back, which makes the
> document a lot easier to work with for the intended target audience.

I do wonder if all that back-and-forth actually makes things easier, and
it definitely impedes use of the RST file.  I recognize that you're
trying to do something a bit different here, though, and don't want to
get in the way of the experiment.  Given the purpose, though, I do have
a couple of little thoughts:

- Somewhere at the top of the RST file should be a prominent link to the
  rendered version, presumably on kernel.org.  It could perhaps be in an
  RST comment that doesn't show up in the rendered version, saying
  "perhaps you really want to read this ----> over there".

- Eventually we should probably make the link to this document more
  prominent on the front page - once we've figured out what we're doing
  there :)

Anyway, those quibbles aside, I think we should probably just apply this
after the merge window.

Thanks,

jon
