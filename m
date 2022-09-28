Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1CB5EDF99
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbiI1PD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiI1PD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:03:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B53A367A8;
        Wed, 28 Sep 2022 08:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=j8dtOkI4/DbIj26pNqdisQlvlJxpcZ2xj3Pqld4MWOI=; b=HpLywNW0Z3W544AcYHbYLNQIwy
        9YZdryN4uy9s6PPfiJF5bJN1fQJkAbuAO42Uys/VjQc8DO30QcxhJTJRrdtyk+J6p7zVcrk7KbC/8
        AXKaStZW15/Y/KX2E3mblk49BOliLtFSxaa7eA2Z51b0oMfkW9ZbXCvN9JyO2yhMV/na1Bbht55r8
        cvYsThs+6xNhBTAtI59F9X3+iUq2XrfXJbj85pOzp5Di8D4SDyCyQt6z38HvjX8xWTP//oVEaL52K
        +DZeErui1JDRlpym3ZRUflYStJMeIHHp+twr/WD+6PwpHOceWQeg9PuwINRZhvx8FqWM+Bjewx4D2
        J30Rf/yw==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1odYan-00GmQE-Di; Wed, 28 Sep 2022 15:03:21 +0000
Message-ID: <14088654-189e-2983-fbdd-d2a28b0b13db@infradead.org>
Date:   Wed, 28 Sep 2022 08:03:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 7/7] docs: add a man-pages link to the front page
Content-Language: en-US
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joe Perches <joe@perches.com>,
        David Vernet <void@manifault.com>
References: <20220927160559.97154-1-corbet@lwn.net>
 <20220927160559.97154-8-corbet@lwn.net>
 <ff413763-6cac-576f-7671-2f883bb56c51@leemhuis.info>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ff413763-6cac-576f-7671-2f883bb56c51@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/27/22 23:21, Thorsten Leemhuis wrote:
> 
> 
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
> 
> The last section (e.g. everything after the semicolon) might not be
> worth it.

I prefer the simple instead of the verbose.

-- 
~Randy
