Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DA8636593
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 17:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238164AbiKWQUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 11:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238502AbiKWQTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 11:19:51 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF21A8B13D;
        Wed, 23 Nov 2022 08:19:47 -0800 (PST)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3FAF5784;
        Wed, 23 Nov 2022 16:19:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3FAF5784
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1669220387; bh=p2jCbyCV2oIQ5C1HbwF0RWpixGZZVd27v8qiNOJaCWA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=BjV3WjHI6eMmR44/z1LbUaiaHTkTBn7aSjrAEuxPt9hrTmIEqTukZW9zRIqTkPB1A
         TzrKixT1FHzsWztSdpoWbiuD0yCapBrVK0sNWPyn/Z8W/RjDRXYEjqvwINnJ3J+9p+
         ohkUcRG+bSj2ErZSnwNjL8KSh2IDLIALf8sJdxbwKqqT8ypMoXwlAM9gDl+qcXHhUa
         uVxWVwIWgkUSHrO4vT0YPNd8JP7EcErbcqWLxsdRPyBK2qwzVu8GAmdqP+T+3B4xnb
         L72oIJgSPRBtPwxO0vu8OHnkqbPhHEqEcJmzHkTWoJrj1iX+c/lHai9ZAAepViMuPW
         F97PM9ASutkKg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        bilbao@vt.edu
Subject: Re: [PATCH] docs/sp_SP: Add process coding-style translation
In-Reply-To: <3ca31647-3f19-a9ca-c6b9-d6eba2014f2f@amd.com>
References: <20221115184737.712625-1-carlos.bilbao@amd.com>
 <87bkp09fkc.fsf@meer.lwn.net>
 <3ca31647-3f19-a9ca-c6b9-d6eba2014f2f@amd.com>
Date:   Wed, 23 Nov 2022 09:19:46 -0700
Message-ID: <87edtt8wyl.fsf@meer.lwn.net>
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

Carlos Bilbao <carlos.bilbao@amd.com> writes:

> On 11/21/22 3:13 PM, Jonathan Corbet wrote:
>> Carlos Bilbao <carlos.bilbao@amd.com> writes:
>> 
>>> Translate Documentation/process/coding-style.rst into Spanish.
>>>
>>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>>> ---
>>>  .../translations/sp_SP/coding-style.rst       | 1315 +++++++++++++++++
>>>  Documentation/translations/sp_SP/index.rst    |    1 +
>>>  2 files changed, 1316 insertions(+)
>>>  create mode 100644 Documentation/translations/sp_SP/coding-style.rst
>> 
>> So I'm kind of slow, I'll admit...but I have finally noticed that you're
>> not preserving the directory structure used for Documentation/ as a
>> whole.  Is there a reason for that?  We've been (slowly) working to
>> organize our docs in a reader-friendly way, it seems unfortunate to lose
>> that for the translations...?
>
> Yes, you're correct. The order I was following was: "If I didn't speak
> English, what document would _I_ like to see translated next?". The coding
> style directives seemed to me like the most important thing next in line. 
> Following this logic, I was planning on translating
> process/email-clients.rst next.
>
> What would be better? Perhaps the documents of process/ in order of
> appearance? I don't know what would be preferable in terms of organization.
> Perhaps we have some data on most consulted docs for the Documentation
> website?

I think I didn't express myself clearly...I don't really care about the
order in which you do the translations, whatever you think is best is
fine there.  What I was asking about is the *directory structure* of the
results.  Thus, for example, I think that this translation should end up
in .../sp_SP/process/coding-style.rst.

See what I'm getting at?  The directory structure of the translations
should really match that of the documents they are coming from.  Or, at
least, so it seems to me.

Thanks,

jon
