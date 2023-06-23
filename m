Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6383373BECB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 21:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjFWT3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 15:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjFWT3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 15:29:32 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF842703;
        Fri, 23 Jun 2023 12:29:29 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4AF4435E;
        Fri, 23 Jun 2023 19:29:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4AF4435E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1687548569; bh=htIfBaDnzdpJnh1WUfGNFYFLCBr5jBeV4TBkIKkAvMU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=TlTygBqdYcKD7C1N6NEKfSjAocl1ln450UKc0Fa+sGzErCLN4cKeSmatA7F13AKuo
         FrU/hIIFbnarKTR4aDaiM3hqyGuXAhOTu7kKNksAtg5puqnwTLz/gQmCH4KV5oiW2/
         5Gvfh9kyMxT+JGKybcY9rBRhi1AMS75Y4C6vv0gL7WdMVkMxjrhMi4uzwBjodB46o+
         8EPsIfTDX11THAOxS5xOBKCfKgvVmVM3JvQzdYw6pXC7Oa1EzBd7OW/MRrQ2HbY671
         OWX8e8FDs75uCjp65tm4OEpdPJTt9RIDMVY4bawGdCWCIoXz4fHSEwWga/RfdliC2H
         rzyVjPpwNpZzA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
        Will Deacon <will@kernel.org>, Anshuman.Khandual@arm.com,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH V2] Documentation/arm64: Add ptdump documentation
In-Reply-To: <ZJP9joL+QZiVM9Tg@arm.com>
References: <20230619083802.76092-1-chaitanyas.prakash@arm.com>
 <168736253462.605140.8006082140297031307.b4-ty@arm.com>
 <87ttv0pzt8.fsf@meer.lwn.net> <ZJP9joL+QZiVM9Tg@arm.com>
Date:   Fri, 23 Jun 2023 13:29:28 -0600
Message-ID: <87352im0yv.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Catalin Marinas <catalin.marinas@arm.com> writes:

> Hi Jon,
>
> On Wed, Jun 21, 2023 at 10:04:03AM -0600, Jonathan Corbet wrote:
>> Catalin Marinas <catalin.marinas@arm.com> writes:
>> 
>> > On Mon, 19 Jun 2023 14:08:02 +0530, Chaitanya S Prakash wrote:
>> >> ptdump is a debugfs interface used to dump the kernel page tables. It
>> >> provides a comprehensive overview about the kernel's virtual memory
>> >> layout, page table entries and associated page attributes. A document
>> >> detailing how to enable ptdump in the kernel and analyse its output has
>> >> been added.
>> >> 
>> >> Changes in V2:
>> >> 
>> >> [...]
>> >
>> > Applied to arm64 (for-next/doc), thanks! I did some tidying up, minor
>> > fixes.
>> >
>> > [1/1] Documentation/arm64: Add ptdump documentation
>> >       https://git.kernel.org/arm64/c/a0238ada560f
>> 
>> Note that this will generate a conflict with the arm64 documentation
>> move, which I dropped into -next today.  It's easily enough fixed up
>> top, but if you'd rather carry the directory move in your tree just say
>> the word.
>
> Ah, I forgot about this move. Are you ok to pull the arm64 for-next/doc
> into your tree to avoid the conflict? There's also the arm64
> for-next/acpi-doc branch that you could also pull.

That sounds a bit like the sort of merge-to-avoid-a-conflict that Linus
gets annoyed about.  There's nothing too serious here, I can just warn
him in my pull request.

Thanks,

jon
