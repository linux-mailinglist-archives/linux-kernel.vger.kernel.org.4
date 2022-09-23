Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15DB5E7DD5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbiIWPDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiIWPDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:03:42 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BBE126B72;
        Fri, 23 Sep 2022 08:03:37 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1428C378;
        Fri, 23 Sep 2022 15:03:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1428C378
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1663945417; bh=A0O72tRjDBgujuwz38dOr2piaeqFN+zibaZ3R9pwl+k=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=JFuekg3U+d8YyZp1LeTaV2jTS2GFOP/HAT/7uGmjpqyKJwod4sFKY8VtJXMSHwzsB
         cnrTkYVw+bh/BPyka9Y9yCXdFrIDL0fAls9A95P9xZwnAiCetFnnI3RMbni59dz4E+
         tqxXBeZhfNwjBkY67r5f8mzGw968li418gBmcOoVzzVOZIONwwMM9gqMPOf6wabgwc
         PGAfvIQPIuems7HGF/1rfi+Fc96mns0D0422t7VGefWPn1zNW5VS8TWg44KP5ONXuy
         xbYU/CxdrleNxq9Qg3nsEioGAN7MHkUJbPp73Br963EMgUvngIegm3mDJ0q4H36pHL
         yxxrQyY0hWHsg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thorsten Leemhuis <linux@leemhuis.info>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v2 0/4] Rewrite the top-level index.rst
In-Reply-To: <aa35d204-3033-96f2-ed83-c5034067fe4b@leemhuis.info>
References: <20220922204138.153146-1-corbet@lwn.net>
 <7f02143c-461f-268b-0f17-7fe20a7423d6@leemhuis.info>
 <875yhep5l1.fsf@meer.lwn.net>
 <aa35d204-3033-96f2-ed83-c5034067fe4b@leemhuis.info>
Date:   Fri, 23 Sep 2022 09:03:36 -0600
Message-ID: <87r102nnef.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thorsten Leemhuis <linux@leemhuis.info> writes:

>>  I maintain that the actual users of our
>> docs are primarily kernel developers.
>
> I guess you are right with that, but maybe that's just like that due to
> the docs we have and not the docs we should have (or should aim for
> having in the long run).
>
> IOW: why is the kernel different from say LibreOffice, Firefox, or some
> random command line app: if I look into the documentation (say because
> I'm using that software for the very first time or because I have a
> problem with it after using it for years) I don't expect to see lots of
> docs at the most prominent place that are only relevant for people that
> want to modify said software; I'd expect things like "what is this
> software and how can I use it", "how can I install this software", "how
> can I report a bug", and "what knobs are available to deal with corner
> cases" there.

For better or for worse, our most prominent user-facing documentation is
the man pages, which are not a part of the kernel repository.  (Hmm...it
wouldn't hurt to add a link to them to the front page, if and when a
site with current man pages exists again).

I don't have that much invested in the current ordering, we can
certainly change it - anytime we want.  Anybody else have an opinion on
that topic?

>> I want to do it because it's a clear step forward and has already been
>> pending for a month.  It is surely not perfect, and there will
>> undoubtedly be changes, perhaps big ones, to come, but I cannot imagine
>> a scenario where we want to go back to the mess we have now.
>
> I understand and yes, maybe it's the right thing to do; but OTOH that
> page is a mess for quite a while already, so is it really a big problem
> to just leave it like that for 9 or 10 more weeks while trying to bring
> in a few more people that might be able to directly bring us on a good
> long-term course?

I guess my feelings are that (1) I've had enough promises to help with
documentation over the years to learn not to count on such until said
help actually materializes, and (2) demonstrating what we can do can, I
hope, only inspire people who know more than me to show what we *really*
can do...

Thanks,

jon
