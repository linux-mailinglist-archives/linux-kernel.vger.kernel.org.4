Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C803A68B0F5
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 17:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjBEQex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 11:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBEQev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 11:34:51 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7F317CF7;
        Sun,  5 Feb 2023 08:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=LB294Uf35XLOlIGZgL5S9Cwdh56i6WvdNULkVbiX7AA=; b=1aKv3SlahvSTuW7BDtWUECJTxX
        e73r7HYi6S2M7tEFzMYmSDVX2ilc7skzeda0Nuj3P0SK5bjlHjolO7Cq5ILQMwy9sOdLlBL2Xmuud
        sW1IJFGDh2G0woyCgSFwGqArYcFKvHIo0cjL8FejMWFQmUGVyE+VS/1G79nsCFA+TSEjMVJD5z6zj
        hQ1NndN1Eh/8lDirkW1wNZ/EBI1mRFgeoFJ7UVkBumUalkQx+JhgHcRVbn9VTle72mxHDdIEP/4xc
        jRpqwTkRoQKWcA8ttkm2zqx1jzgQCSYoEG+0Bo+AqqXLPl/+4prpoW83XdnpIzsYBYvzniaDYhRQK
        +kgnUisA==;
Received: from [2601:1c2:d00:6a60::9526]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pOhyb-006Z77-QY; Sun, 05 Feb 2023 16:34:49 +0000
Message-ID: <a809e2f8-4c11-e4b5-9bf1-a2b67077a1d1@infradead.org>
Date:   Sun, 5 Feb 2023 08:34:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] parisc: update kbuild doc. aliases for parisc64
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
References: <20230205010425.11932-1-rdunlap@infradead.org>
 <CAK7LNAQ0-i_CciUELv+G9imYL-JA1LLiqRYYbj_N0jJZ2Ro-Mw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAK7LNAQ0-i_CciUELv+G9imYL-JA1LLiqRYYbj_N0jJZ2Ro-Mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/5/23 05:19, Masahiro Yamada wrote:
> On Sun, Feb 5, 2023 at 10:04 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> ARCH=parisc64 is now supported for 64-bit parisc builds, so add
>> this alias to the kbuild.rst documentation.
>>
>> Fixes: 3dcfb729b5f4 ("parisc: Make CONFIG_64BIT available for ARCH=parisc64 only")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
>> Cc: Helge Deller <deller@gmx.de>
>> Cc: linux-parisc@vger.kernel.org
>> Cc: Masahiro Yamada <masahiroy@kernel.org>
>> Cc: linux-kbuild@vger.kernel.org
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: linux-doc@vger.kernel.org
>> ---
>>  Documentation/kbuild/kbuild.rst |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff -- a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
>> --- a/Documentation/kbuild/kbuild.rst
>> +++ b/Documentation/kbuild/kbuild.rst
>> @@ -160,6 +160,7 @@ directory name found in the arch/ direct
>>  But some architectures such as x86 and sparc have aliases.
>>
>>  - x86: i386 for 32 bit, x86_64 for 64 bit
>> +- parisc: parisc for 32 bit, parisc64 for 64 bit
> 
> 
> 
> 
> 'parisc' is not an alias since it matches the arch/parisc/
> directory, is it?

True. I'll correct that.
Thanks.

 
>>  - sh: sh for 32 bit, sh64 for 64 bit
>>  - sparc: sparc32 for 32 bit, sparc64 for 64 bit
>>
> 
> 

-- 
~Randy
