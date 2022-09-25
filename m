Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D1C5E963D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 23:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbiIYVu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 17:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiIYVu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 17:50:27 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9F02649C;
        Sun, 25 Sep 2022 14:50:26 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E2675723;
        Sun, 25 Sep 2022 21:50:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E2675723
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1664142626; bh=2gz8NlwBvi1D7MKHV8H4rtXtYCavkjko+Jq9MO/Wf3I=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=pAs17YKiwzv1lh7WkAIuuoguv0dW06nmfNoQUMldKIkAb2+YvTuQMRV7G1l0uByXc
         il9j1sa8agFrA+fHQVnWstzfdjuZW4tHt3/LPazudRDquXHMRqBmbNI4+1i+2mua8Q
         Qj9RvMeGXWZAVZVuwLrm0jErxVLpcdpBygBHM1mPqF8sxcn+wzZzPDB4ikW42opI1C
         R4669hhKQKm/KqW2/3bzv+LMfhC8vkcd4kdiHNGety/XabS7pRDHi34utMSJlyD5oH
         vezsbgr5TZe0s/HcPim/r7cwz8hgWmhTyMemcySduNYLfFfYcRkCHEk9LZVix1MfiS
         Lr6kXQLLh2Pyg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     David Vernet <void@manifault.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v2 6/7] docs: Expand the front-page CPU-architecture
 section
In-Reply-To: <Yy5qknCcImvDLkZ9@maniforge.dhcp.thefacebook.com>
References: <20220922204138.153146-1-corbet@lwn.net>
 <20220922204138.153146-7-corbet@lwn.net>
 <Yy5qknCcImvDLkZ9@maniforge.dhcp.thefacebook.com>
Date:   Sun, 25 Sep 2022 15:50:25 -0600
Message-ID: <87edvzrun2.fsf@meer.lwn.net>
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

David Vernet <void@manifault.com> writes:

> On Thu, Sep 22, 2022 at 02:41:37PM -0600, Jonathan Corbet wrote:
>> Actually show the entries for individual architectures, since otherwise a
>> single line reading "CPU architectures" is not very enlightening.
>> 
>> We should really move all of the architecture directories under an arch/
>> directory, as we do with the top-level directory, but that's a task for
>> another day.
>> 
>> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
>> ---
>>  Documentation/index.rst | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/index.rst b/Documentation/index.rst
>> index 6d01c2e38573..5a700548ae82 100644
>> --- a/Documentation/index.rst
>> +++ b/Documentation/index.rst
>> @@ -93,7 +93,7 @@ Architecture-specific documentation
>>  -----------------------------------
>>  
>>  .. toctree::
>> -   :maxdepth: 1
>> +   :maxdepth: 2
>
> Wasn't this changed from 2 -> 1 in patch 2/7 [0] of this set? If so, can
> we just undo that adjustment and remove this patch from the series?
>
> [0]: https://lore.kernel.org/all/20220922204138.153146-3-corbet@lwn.net/

Yup, that does make more sense.  I plead jet lag...

Thanks,

jon
