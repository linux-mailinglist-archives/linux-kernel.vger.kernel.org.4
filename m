Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BDA72A852
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 04:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbjFJCV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 22:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjFJCV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 22:21:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F4535A9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 19:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=fdmJPZRe8+HkITnC8ZitGEvL4IYeAWkr326YLsJPLI8=; b=jbz5v5W5H9cr0RElbRycdkdAsp
        ZWz+9LXCHX3n9klar+LqqikJN3687uH3NBti0xD/IRip40gf3WEcw6Oy/CZzydcgN51rbUbJ/6Je7
        hUC9mqN1zof41GNcy5/W1RNWRZ2tOWTYt33VOZdBWIbzR4A2brSZ7aYxO/h9Bt9QiqN9iaYmW7yWo
        hF1IDtCtwJb0xoqLmDBAwynSioP/UiW/Wb4e3faOlzjaOS78Fn/GaJk1ZuiW8CS7JTzSXey5pxW8u
        t/dabYJb/R5Eqta+/+BouRbzCjwjEFlfqUs2d13s0xthIEZEjyNrxo2+fmIl4qHYXL8Zjk3zTmQWc
        8O2d26Nw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q7oEj-00ExOS-2T;
        Sat, 10 Jun 2023 02:21:53 +0000
Message-ID: <a5151e75-cbcc-2c24-06c6-4534f04ba7e1@infradead.org>
Date:   Fri, 9 Jun 2023 19:21:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/4] x86: Introduce
 CONFIG_IA32_EMULATION_DEFAULT_DISABLED Kconfig option
Content-Language: en-US
To:     Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz
References: <20230609111311.4110901-1-nik.borisov@suse.com>
 <20230609111311.4110901-2-nik.borisov@suse.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230609111311.4110901-2-nik.borisov@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/9/23 04:13, Nikolay Borisov wrote:
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 53bab123a8ee..9c32fd720701 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -3038,6 +3038,11 @@ config IA32_EMULATION
>  	  64-bit kernel. You should likely turn this on, unless you're
>  	  100% sure that you don't have any 32-bit programs left.
> 
> +config IA32_EMULATION_DEFAULT_DISABLED
> +	bool "IA32 Emulation default disabled"
> +	default n
> +	depends on IA32_EMULATION
> +

I expected checkpatch to complain about no help text here.
Did it not complain?

-- 
~Randy
