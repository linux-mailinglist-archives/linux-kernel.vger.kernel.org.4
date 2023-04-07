Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB3A6DB5B9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 23:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjDGVLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 17:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjDGVLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 17:11:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066229EE0;
        Fri,  7 Apr 2023 14:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=cFXDWcTfTcXM5Yf65+stWvf5R1WyNTnh7fSbYMiLCyM=; b=OS483UuG3RWKtFZ9Cg1ZTlTALc
        bs16Wo0+sXOUKgLF0VZHfWCcgirjHP9dfgGZ0NueO5HLvwlViyIi26lCM6RPkW0L1aBwdZA9750eu
        imIo9ocw47NdfMteaGpg5C8iV+Gz7haBmHTCtYz/IZhShlhjTxZhOqZyDoqYBt2qgWVtXar1yCsXq
        BS8IjzqI0XCK9xZz1dXu93xVEbzGb/NZl0LNlKYGPESFVT2FmiHiHBi+duij6YSpBkkfa/w98yrXO
        Q9cVCvwRwUWEIGsmRgv4hmS4kQi0h4PE1MuYPI6uNMW1IYm2H3/fXYeKqfkdP3HDP+sdtHA3JhUqU
        bE6Ul6eQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pktMD-00B9SO-35;
        Fri, 07 Apr 2023 21:10:53 +0000
Message-ID: <a05558c3-8d5c-c389-ba4c-be134c75ac1c@infradead.org>
Date:   Fri, 7 Apr 2023 14:10:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] parport_pc: don't allow driver for SPARC32
Content-Language: en-US
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-parport@lists.infradead.org
References: <20230406160548.25721-1-rdunlap@infradead.org>
 <alpine.DEB.2.21.2304062039260.44308@angie.orcam.me.uk>
 <20230406203207.GA1534216@ravnborg.org>
 <alpine.DEB.2.21.2304062144520.44308@angie.orcam.me.uk>
 <20230407200313.GA1655046@ravnborg.org>
 <alpine.DEB.2.21.2304072142290.62619@angie.orcam.me.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <alpine.DEB.2.21.2304072142290.62619@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/7/23 14:01, Maciej W. Rozycki wrote:
> On Fri, 7 Apr 2023, Sam Ravnborg wrote:
> 
>>>> Randy's suggestion is fine, as we avoid building parport support
>>>> for sparc32. If someone shows up and need parport support
>>>> for sparc32 then we could look into how to enable it.
>>>> Until then, we are better helped avoiding building the driver.
>>>
>>>  I disagree.  Why artificially prevent perfectly good hardware from 
>>> working with a perfectly good driver especially as the fix is just a 
>>> trivial exercise?  And I offered a solution.
>>
>> There is no sparc32 with a PC style parallel port, so the parport_pc
>> have no value for a sparc32 machine.
> 
>  There are PC-style PCI (and PCIe) parallel ports in the form of option 
> cards being sold; I have one in my RISC-V machine (and I had to go through 
> the hassle of figuring out why the heck I am not able to select the driver 
> in configuration; a situation analogous to what Randy's change wants to 
> arrange).  You can plug one into any machine that has PCI slots and my 
> understanding from Linux Kconfig files is there are such 32-bit SPARC 
> machines in existence or the dependency on PCI wouldn't offer the driver.  
> Otherwise just don't enable CONFIG_PCI for 32-bit SPARC.
> 

If there are 32-bit Sparc machines with PCI slots, we must not have any
users with parallel ports or we should have heard about it IMO.

>  Apologies if I wasn't clear enough with my reasoning, although I think 
> the lone presence of the PCI dependency in Kconfig ought have to make it 
> clear.
> 
>> The sparc32 machines have the parport_sunbpp driver for their parallel
>> port.
> 
>  That's an onboard device or an SBus option card though, right?
> 
>> An alternative fix, and better I think, would be to audit all archs
>> and let the relevant ones select ARCH_MIGHT_HAVE_PC_PARPORT, so we
>> avoided the ugly "|| (PCI && !S390 && !SPARC32)" case for PARPORT_PC.
> 
>  It's only S390 that is special in that it has a limited set of specially 
> crafted PCI options it can ever support (or so I am told; something about 
> the firmware or suchlike).

From my reading, if a Sparc32 machine has a PCI port, it might be able to
have a parallel port. However, even with Maciej's suggested code change
instead of my patch, the ebus code is not being compiled for Sparc32 -- only
for Sparc64, so more changes are needed beyond Maciej's suggestion.

But the documentation that I found refers to Ebus on Sparc4 machines.

>  Any other platform that has PCI slots will handle PC-style PCI parallel 
> port option cards just fine, as long as it supports PCI I/O read/write 
> commands (some systems such as POWER9 machines don't; Niklas Schnelle has 
> been recently working on a generic way to exclude drivers for devices that 
> require PCI port I/O from being offered with systems that have no support 
> for PCI port I/O).
> 
>  Let me know if you find anything here unclear or have any other questions 
> or comments.

/me wishes that we had a Sparc maintainer.

-- 
~Randy
