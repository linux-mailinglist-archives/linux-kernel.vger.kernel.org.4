Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8646D5E825F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 21:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiIWTH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 15:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiIWTHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 15:07:55 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D817A124C1C;
        Fri, 23 Sep 2022 12:07:54 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 917C0378;
        Fri, 23 Sep 2022 19:07:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 917C0378
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1663960074; bh=r0cphuT9sy0LG854FWRMQFdQ4M+/STMJSiZPZmg5vr0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=sCzam75V7qvg47+OO6qCpbuIwAcvSKxUG0q4bVkOzOlSz7kVoL4o8C/WefSlQSZ73
         fDleL0Y42TcF+hSTvVMvah1oi9LD9zgF99CPWckd08VVMWH/TpH3MEkIWoDRvB6Ivj
         vwy6y202bS9Ileb37Voel8tr/ghTCkuIXtjeWIdQd67gDcKnATFQI+iUZ8QmV1W7KY
         iqxUqIvz1uF7vAVWrOja5cc85Yx+0/RH4aIeDf3poI0VGWEy2rZx0WTDL9Gi4fDC3o
         Q/OaFJBM4NfmCKKvzi7+jTUSDtEinWsDtGUiSkpdIwQAdOSMpHDcJ+cGZ9eKc1fwcL
         yaAosUoflzs5w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v2 2/7] docs: Rewrite the front page
In-Reply-To: <f5830658-9cd7-4d44-6fd6-d031da1a3442@infradead.org>
References: <20220922204138.153146-1-corbet@lwn.net>
 <20220922204138.153146-3-corbet@lwn.net>
 <f5830658-9cd7-4d44-6fd6-d031da1a3442@infradead.org>
Date:   Fri, 23 Sep 2022 13:07:53 -0600
Message-ID: <871qs19aeu.fsf@meer.lwn.net>
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

Randy Dunlap <rdunlap@infradead.org> writes:

> Hi Jonathan,
>
> On 9/22/22 13:41, Jonathan Corbet wrote:
>> The front page is the entry point to the documentation, especially for
>> people who read it online.  It's a big mess of everything we could think to
>> toss into it.  Rewrite the page with an eye toward simplicity and making it
>> easy for readers to get going toward what they really want to find.
>> 
>> This is only a beginning, but it makes our docs more approachable than
>> before.
>> 
>> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
>> ---
>>  Documentation/index.rst          | 150 +++++++++++--------------------
>>  Documentation/subsystem-apis.rst |  58 ++++++++++++
>>  2 files changed, 111 insertions(+), 97 deletions(-)
>>  create mode 100644 Documentation/subsystem-apis.rst
>
> I don't see a kernel version listed anywhere on the front page
> (maybe it depends on what theme is used?) at
> https://static.lwn.net/kerneldoc/, so I think it needs something like
> this.
>
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst
> @@ -18,6 +18,8 @@ documents into a coherent whole.  Please
>  documentation are welcome; join the linux-doc list at vger.kernel.org if
>  you want to help out.
>  
> +This documentation is for Linux kernel $(KERNELRELEASE).
> +

Ah, it does look like we lost that in the transition; I'll make sure it
gets put back.

Thanks,

jon
