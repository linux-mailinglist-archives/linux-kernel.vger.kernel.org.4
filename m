Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A9D644E7D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 23:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiLFWUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 17:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiLFWUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 17:20:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2925632B95
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 14:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=rWZngcPAlXTsiQ+bv+9VkztCnXXPBTgUPIZ018Wiqcw=; b=VA19G7chEWZIoyWbloQ+9FwSP6
        z8Z8gdlkz6nrj9IEk+o3YnrbSo/uuyep9Amip0UDxEPAy4K2QEP89rTO5AyNEmpKdCIlKKMKg5mlF
        WcVnOM9elnXnnta8Xxu98Czl0rqC0KfgXML1lbbNcXtToR9jBgj9gwY10THS6FJsxru2R8BO3k5dY
        nSS24IRBLojPjUnmKf6kPCEV5ymS3PxgfGg75S2KRKZxUESMsqhBE18GSH5/J/4ftmeJx25grl/2/
        uvPKh4nbDMte1z43S6ljkLGCynTLzpj5yC/EXsMJrZduP/BhrapwHwyR5Ci1ZVcxz4sw6jqMMr7LQ
        jnUME1uA==;
Received: from c-67-160-137-253.hsd1.or.comcast.net ([67.160.137.253] helo=[10.0.0.152])
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p2gIg-003yiu-Kd; Tue, 06 Dec 2022 22:20:30 +0000
Message-ID: <053d7bf2-9bf3-a71c-5713-7cce19413c37@infradead.org>
Date:   Tue, 6 Dec 2022 14:20:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] mux: remove the Kconfig question for the subsystem
Content-Language: en-US
To:     Peter Rosin <peda@axentia.se>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CA+55aFyJkpSa6rwZ-5xTihfGiNC_T0oL6txrodYBEo2-0O=p7g@mail.gmail.com>
 <1499156564-29458-1-git-send-email-peda@axentia.se>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <1499156564-29458-1-git-send-email-peda@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry to drag up such an old thread, but: (please see below)


On 7/4/17 01:22, Peter Rosin wrote:
> The MULTIPLEXER question in the Kconfig might be confusing and is
> of dubious value. Remove it. This makes consumers responsible for
> selecting MULTIPLEXER, which they already do.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/mux/Kconfig | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
> 
> On 2017-07-04 08:00, Linus Torvalds wrote:
>> On Jul 3, 2017 22:53, "Peter Rosin" <peda@axentia.se <mailto:peda@axentia.se>> wrote:
>>> But ok, is something like this what you wanted?
>>
>> I *think* this week just result in an empty menu if there are
>> no drivers selecting it.
>>
>> Shouldn't the 'if' be outside the menu? But I didn't test
>> anything, since I'm not in front of my computer any more..
> 
> Right, the previous patch also had the problem that it removed
> the MULTIPLEXER option completely and was therefore total crap.
> 
> I have tested this patch more thoroughly and it should be a
> definite improvement. Sorry for the noise...
> 
> Cheers,
> peda
> 
> diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
> index 7c754a0..19e4e90 100644
> --- a/drivers/mux/Kconfig
> +++ b/drivers/mux/Kconfig
> @@ -2,20 +2,11 @@
>  # Multiplexer devices
>  #
>  
> -menuconfig MULTIPLEXER
> -	tristate "Multiplexer subsystem"
> -	help
> -	  Multiplexer controller subsystem. Multiplexers are used in a
> -	  variety of settings, and this subsystem abstracts their use
> -	  so that the rest of the kernel sees a common interface. When
> -	  multiple parallel multiplexers are controlled by one single
> -	  multiplexer controller, this subsystem also coordinates the
> -	  multiplexer accesses.
> -
> -	  To compile the subsystem as a module, choose M here: the module will
> -	  be called mux-core.
> +config MULTIPLEXER
> +	tristate
>  
> -if MULTIPLEXER
> +menu "Multiplexer drivers"
> +	depends on MULTIPLEXER
>  
>  config MUX_ADG792A
>  	tristate "Analog Devices ADG792A/ADG792G Multiplexers"
> @@ -56,4 +47,4 @@ config MUX_MMIO
>  	  To compile the driver as a module, choose M here: the module will
>  	  be called mux-mmio.
>  
> -endif
> +endmenu


How does a user enable any of the 4 drivers in drivers/mux/Kconfig unless
some other totally unrelated driver has just happened to select MULTIPLEXER
so that the mux driver menu is visible to them?

I was just about to send a patch (basically a revert but I didn't know it
until I looked up the git blame history/hash for 4c19c0ec73241:
  mux: remove the Kconfig question for the subsystem

Thanks.


-- 
~Randy
