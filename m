Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1A56C6EBB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjCWRYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjCWRYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:24:37 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAB226C33;
        Thu, 23 Mar 2023 10:24:24 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1331B378;
        Thu, 23 Mar 2023 17:24:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1331B378
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1679592264; bh=//3s1kNIJ9QPM6gGRiXVa2F3NjAwTCsMDusmBfTtjFE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=SFTbwfM0BbTQG2drexoM1kMwQ+S+ZKd03rJtU4NE0/XZOzcqs2uAjhVo+MLFYB/KQ
         aEy9jPLFZHn5T6CFcbpPayks0UZV8J0jaajG/+vmd0YjdGcBKEr/mHwMI/aYRQstZ0
         c5yMGGYu0B0SqF+si6WrK/rJKFy0DGyj4SQIF/yXGl4rGpWlBEh5AHwXn2g0kAGj6S
         8vlDGldRZop4zJnofiuMmH/DW8vGszwir+KGp40dMAXbVjUFtw8ab5vWzZMBfobXBh
         doIlJE4IAAE9HO7Pc/VRaeWpCrlWLG5jUelA8JsFmTOTJ16WYefDIffv1xFqbHWJnm
         M8tVgHBj4homg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
Subject: Re: [PATCH v3] docs: describe how to quickly build a trimmed kernel
In-Reply-To: <165bd284-580d-df03-ab04-f5214b1e6be4@leemhuis.info>
References: <1a788a8e7ba8a2063df08668f565efa832016032.1678021408.git.linux@leemhuis.info>
 <87a60frxk0.fsf@meer.lwn.net>
 <d233a796-1cb8-a9b3-5a50-043dd2f98b3e@leemhuis.info>
 <87edpomtzn.fsf@meer.lwn.net>
 <165bd284-580d-df03-ab04-f5214b1e6be4@leemhuis.info>
Date:   Thu, 23 Mar 2023 11:24:23 -0600
Message-ID: <87jzz7creg.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thorsten Leemhuis <linux@leemhuis.info> writes:

> I currently can't really see the need for another book/top-level
> directory and to be honest it's by far my least favorite solution among
> the options on the table.

Well, it was just an idea that crossed my mind as I was thinking about
this stuff...it doesn't appear to have inspired a lot of enthusiasm.  So
never mind that for now, I guess...I reserve the right to come back to
it in the future once we're getting overwhelmed by these things :)

> I'm taken back and forth between the other two options (e.g. put the
> text in Documentation/admin-guide/ or
> Documentation/admin-guide/tutorials/). Maybe I prefer the latter a
> little bit more.

Let's just put it in admin-guide, I guess, though the fit feels a bit
awkward.  If we get more tutorials, we can make a separate section in
index.html, I don't think we need another subdirectory there at this
point.

Did you have further tweaks, or should I take v3?

Thanks,

jon
