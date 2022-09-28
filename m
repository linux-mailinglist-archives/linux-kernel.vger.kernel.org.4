Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EF95EE6ED
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 23:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbiI1VAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 17:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiI1VAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 17:00:42 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6291327145;
        Wed, 28 Sep 2022 14:00:38 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 75A822C5;
        Wed, 28 Sep 2022 21:00:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 75A822C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1664398838; bh=4RI4wM+TJla65CJuPoBL1sPjSgcWsteNAy5kYl2GsPE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=j/C4cXQwZDwB8GG3KVDMafRVR0abaf/NyFQLUl0VrInSE1OASlCObqYM3EPjGYzWh
         HmFyx48IQS/P9F9kZuMu2IKiXQVvO0H/rV5sVCdFxGhB0tyV7yhd5Y6k0r74lr6tlr
         msuWY97VCy6yg9GIR4O34q3Aasz1gJt4qo8si9p2SNbFtZl4QGVdWczT58BGp8IKW8
         kbNoNiLrjGcde4If/Ut3/IwTRc4cuEzlqbmsWpHbdvkOlKWeSrh4tz0yFe7fPwAudX
         Gyw1xmNZX76H7tau0yugRsuuPyP5Wobup0qRY/ZbpGfGIYg9fDejXSDjpZUsuebrmF
         Xnep22D+0wieA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thorsten Leemhuis <linux@leemhuis.info>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joe Perches <joe@perches.com>,
        David Vernet <void@manifault.com>
Subject: Re: [PATCH v3 7/7] docs: add a man-pages link to the front page
In-Reply-To: <ff413763-6cac-576f-7671-2f883bb56c51@leemhuis.info>
References: <20220927160559.97154-1-corbet@lwn.net>
 <20220927160559.97154-8-corbet@lwn.net>
 <ff413763-6cac-576f-7671-2f883bb56c51@leemhuis.info>
Date:   Wed, 28 Sep 2022 15:00:37 -0600
Message-ID: <8735cbkydm.fsf@meer.lwn.net>
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

> On 27.09.22 18:05, Jonathan Corbet wrote:
>> Readers looking for user-oriented information may benefit from it.
>> 
>> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
>> ---
>>  Documentation/index.rst | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/Documentation/index.rst b/Documentation/index.rst
>> index 5a700548ae82..85eab6e990ab 100644
>> --- a/Documentation/index.rst
>> +++ b/Documentation/index.rst
>> @@ -76,6 +76,8 @@ developers seeking information on the kernel's user-space APIs.
>>     User-space tools <tools/index>
>>     userspace-api/index
>>  
>> +See also: the `Linux man pages <https://www.kernel.org/doc/man-pages/>`_,
>> +which are kept separately from the kernel's own documentation.
>
> People following that link might be inclined to click on the section 1
> and then find a lot of stuff that has nothing or not much to do with the
> kernel and then might feel lost. So how about a text like this instead:
>
> ```
> See also the `Linux man pages <https://www.kernel.org/doc/man-pages/>`_,
> as that where some of the kernel's documentation is kept. Among it are
> for example descriptions of Linux' `system calls
> <https://man7.org/linux/man-pages/dir_section_2.html>`_ and `devices
> <https://man7.org/linux/man-pages/dir_section_4.html>`_; the sections
> `files <https://man7.org/linux/man-pages/dir_section_5.html>`_ and
> `overviews, conventions, and miscellaneous
> <https://man7.org/linux/man-pages/dir_section_7.html>`_ also contain
> many documents dedicated to aspects of the kernel.
> ```

Honestly, if the landing page for the man pages is not sufficiently
clear to guide readers toward their goal, then I think the fix needs to
be applied there.  Reproducing parts of it on the kernel front page
seems like the wrong solution, somehow...

Thanks,

jon
