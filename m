Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90C969FE6B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 23:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbjBVWXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 17:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjBVWXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 17:23:45 -0500
X-Greylist: delayed 904 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Feb 2023 14:23:40 PST
Received: from matoro.tk (unknown [IPv6:2600:1700:4b10:9d80::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE128A71;
        Wed, 22 Feb 2023 14:23:39 -0800 (PST)
DKIM-Signature: a=rsa-sha256; bh=VS1HHbC0iO2PhRUGrVGHMgzgjQpr4xymHa7Uw4M10ho=;
 c=relaxed/relaxed; d=matoro.tk;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@matoro.tk; s=20221223; t=1677102747; v=1; x=1677534747;
 b=kHy0L+6PSCGXbbCQrkUJJSQowAkx1/SguKsqaxuLitimADUym+pMI4IAH+DgVRWkw19dG+48
 APcKIAfPxczX79TfXx/LOk1T4Iw/hwbZRTeMiTSPYLLwVKecYP84HobDAPSmaDE7TD1JCy/F4XD
 uJwMwUhnpr/XrV6LBFWX3sbByYObIyuWAaAhg77U1Ao9xUKQcanHjdxTaEkVg+X7BAi+RObRDDk
 7flKmHTQf8Y9uWMHzMwUZCu8ucGZTjUjEFf/7OuRwAkMaGnv8mVoLKMlRpvTGRp1M03RhFv9Je5
 UPXr8ZHm3GzYuWwsJlg+6DZvYhXzJ+AHWIkIR1hmf1AcmMylQphdch6XRrGaiVaaIdC0D0FtzaR
 PXZ9nW85XJPA2XlGvcQ6nWkAbtHaSuihZYMEvMFDPOP0EcH9r+JAg52ZB1GiNDs2uHUBvzHToes
 NfWzDzieRRP+7v5OjKU5si4Te8uYfA/38+FEJEZOVmm7uVeBLTYfibFmc+NNDUO7+CTcDLj/IFu
 tooLJbJ8cLBKx17BV0c0Q9ZU1uZQmlrlBKI0gc9Nm9kdg/XiQqnRl4BD1Z0jcESaVtis/JUU+GF
 jcWbFMeb4wpyRNtjOF6433YTFgq1DZEHF3cYUVchhGP6Of4NyG32c7tOBzCwDiYyDCifHn5xwiy
 cqkPKZj22xY=
Received: by matoro.tk (envelope-sender
 <matoro_mailinglist_kernel@matoro.tk>) with ESMTPS id 10abfbb5; Wed, 22 Feb
 2023 16:52:27 -0500
MIME-Version: 1.0
Date:   Wed, 22 Feb 2023 16:52:27 -0500
From:   matoro <matoro_mailinglist_kernel@matoro.tk>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Matthew Wilcox <willy@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-ia64@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Retire IA64/Itanium support
In-Reply-To: <77ff2776d99286eac6eefecb1903b96899d0ff62.camel@physik.fu-berlin.de>
References: <20230215100008.2565237-1-ardb@kernel.org>
 <534469b750e1847e1645f9ae5ed19dcc80b82be6.camel@physik.fu-berlin.de>
 <CAHk-=wjEmZ19T4XpVb0_Hacm53xJG_w5ygcuorwC0xBoT-myUA@mail.gmail.com>
 <SJ1PR11MB6083F7F30FE9ED8F39FA1F85FCA39@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAHk-=wj9RkLN+GpYcFmsd8tze6zYL7MMkNpvdKbETQnqYm+Hwg@mail.gmail.com>
 <77ff2776d99286eac6eefecb1903b96899d0ff62.camel@physik.fu-berlin.de>
Message-ID: <1d5b903ef5e5b5f83feee241fb0cbcca@matoro.tk>
X-Sender: matoro_mailinglist_kernel@matoro.tk
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-15 18:13, John Paul Adrian Glaubitz wrote:
> On Wed, 2023-02-15 at 12:08 -0800, Linus Torvalds wrote:
>> But when it's actively known to be broken and nobody has time or
>> interest to look at it, at that point the "it doesn't look any more
>> painful than other architectures" becomes kind of moot.
> 
> Let me look after it in the weekend and let's see whether we can 
> unbreak
> it. I don't think there is really a big issue. The last time we had a
> similar issue was the regression introduced by 974b9b2c68f3 which got 
> fixed
> with the simple fix in bd05220c7be3.
> 
> It's probably similarly trivial to fix the current regression.
> 
> Adrian

Just for reference, this specific bug does not seem to be universal, but 
possibly only applies to a specific configuration.  I have observed no 
problems with 6.1 on my rx 2800 i2 and just booted 6.2 with no issues.  
Please feel free to try out my kernel config here:  
https://dpaste.com/43CACUUG8.txt

A possible guess is initramfs-related, as according to your logs on the 
Debian ML the hang happens shortly after initramfs unpacking, and I do 
not use an initramfs.
