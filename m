Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C3461E802
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 01:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiKGAzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 19:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiKGAzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 19:55:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E152A18A;
        Sun,  6 Nov 2022 16:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=qkPCrvakuWsxBIiqN2P+Ebj3vUfpA6YfwWkFjX3LRwo=; b=a6GWTSWrzhgOW2yIA4hHY4oYDX
        VbNJ8JYcwGp9AbMN/kNObt924s2BWyTPrJprbKchakYzTmHwSAZhXUPje6us5SDmwwcaVzZWrZrIB
        tZ+gW2YDp+lV8459++eUPkveV1SqMPLTjVDcJLiWmc0sfWz9rspnB8JSU3ub1I+FA/a8XyIfX7GU3
        1YI7xZF7gbwI/sXkoQ9dZCPAHrncAhtme1lBej+xtJYK3EtVhDzVhwnXf4QDDSE9zhy8tOgIVUKxn
        AB33imLt49gtqwGnJTebscuVuq0leILQVttUbs9Oj+wF4WP5WALz4vz1BLCia2Pm+7qxODllqzoMj
        XZBbzy1g==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1orqPu-00Aj33-Bi; Mon, 07 Nov 2022 00:55:10 +0000
Message-ID: <55cdacf5-2b0c-3813-d739-b806db65b052@infradead.org>
Date:   Sun, 6 Nov 2022 16:55:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] ARM: omap1: set ARCH_OMAP1_ANY for ARCH_OMAP1
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux-OMAP <linux-omap@vger.kernel.org>
References: <20221106062536.26369-1-rdunlap@infradead.org>
 <62f5b747-4c65-46a6-b04d-1d0fcbadf5c9@app.fastmail.com>
 <Y2eLuf4SCrZ5X+ui@shell.armlinux.org.uk>
 <ab965f39-94b7-4962-a53e-46b88fd6ecae@app.fastmail.com>
 <b764ed1f-263a-47f4-962c-286fcf38fc32@app.fastmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <b764ed1f-263a-47f4-962c-286fcf38fc32@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/6/22 03:32, Arnd Bergmann wrote:
> On Sun, Nov 6, 2022, at 11:37, Arnd Bergmann wrote:
>> On Sun, Nov 6, 2022, at 11:26, Russell King (Oracle) wrote:
>>> On Sun, Nov 06, 2022 at 08:43:50AM +0100, Arnd Bergmann wrote:
>>>> --- a/arch/arm/mach-omap1/Kconfig
>>>> +++ b/arch/arm/mach-omap1/Kconfig
>>>> @@ -49,7 +49,7 @@ config ARCH_OMAP1_ANY
>>>>         select ARCH_OMAP
>>>>         def_bool ARCH_OMAP730 || ARCH_OMAP850 || ARCH_OMAP15XX || ARCH_OMAP16XX
>>>>  
>>>> -config ARCH_OMAP
>>>> +config ARCH_OMAP1_ANY
>>>
>>> This patch can't be right - look at the first line of context above, you
>>> have symbols that select ARCH_OMAP and you've just removed the
>>> definition of ARCH_OMAP.
>>
>> Right, I misread this, I thought this was an 'if ARCH_OMAP' block
>> instead of the Kconfig symbol. Part of the problem is now is
>> possibly that there are two symbols with that name now, I'll have
>> to try to reproduce the problem first and then see what caused it
>> originally.
> 
> It seems the root cause was actually 804f7f19c2e2 ("fbdev: omap:
> avoid using mach/*.h files"), where I started allowing building with
> CONFIG_COMPILE_TEST, but this fails when ARCH_OMAP1_ANY is disabled,
> as Randy correctly found.
> 
> We could tighten this gain by adding something like
> 
>      depends on ARCH_OMAP1_ANY || !OMAP_MUX
> 
> to still allow compile-testing but specifically avoiding the
> broken case. I think we have the same problem in the pcmcia and
> spi-uwire drivers, so maybe something like this would be
> a better approach:
> 
> --- a/include/linux/soc/ti/omap1-mux.h
> +++ b/include/linux/soc/ti/omap1-mux.h
> @@ -302,7 +302,7 @@ enum omap1xxx_index {
>  
>  };
>  
> -#ifdef CONFIG_OMAP_MUX
> +#if defined(CONFIG_OMAP_MUX) && defined(CONFIG_ARCH_OMAP1_ANY)
>  extern int omap_cfg_reg(unsigned long reg_cfg);
>  #else
>  static inline int omap_cfg_reg(unsigned long reg_cfg) { return 0; }

That seems to work. Push it into -next and see what happens. :)

-- 
~Randy
