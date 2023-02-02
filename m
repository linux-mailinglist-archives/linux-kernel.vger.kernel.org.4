Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5316687540
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 06:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjBBFbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 00:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjBBFa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 00:30:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCF181B15;
        Wed,  1 Feb 2023 21:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=ZPQzhV0HW/GkMC3pgyG/LRDCfcUyGJYA+kbVjtGg9Ic=; b=WBhN9OYoVQjKfQcZdE0C9wjRKN
        CPkmVoTPk6b6ZHkmQ/YZiE6IWWhF1ffhNs+qbwA0XHQi373PEZKqRYDmslluYThBf/C//0DmSV0La
        lLsSRxerOclMyTrkmtQTbkMMif4T7Zr5ahMOBL8dJxbd25PLzT+vDb1ZXatbhRk7yBG+H/vhMkx3U
        lI46OUAXJ2QR94JPbU8I2nL3oMSd20I53ClEkpyFo8xkUAxW6s6T02VD0QUUH7LnVxnZClkPho18u
        Kt9FCGsT6arK0+aHAjfeJ2deh6s5ar6lOAFe7dKz8mJoOMFu0Xqg8knjNUReEYFCz8P0+4PhIPScE
        vsq/I9bg==;
Received: from [2601:1c2:d00:6a60::9526]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNS9V-00ERX0-S9; Thu, 02 Feb 2023 05:28:54 +0000
Message-ID: <fea8991d-6405-56ff-d7cb-9662f4359809@infradead.org>
Date:   Wed, 1 Feb 2023 21:28:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] >>>>>>>>>>>>>>>>>>>>>>>>> BLURB <<<<<<<<<<<<<<<<<<<
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230202052813.27427-1-rdunlap@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230202052813.27427-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,SUBJ_ALL_CAPS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops. not completed. I'll resend it. Sorry for the noise.


On 2/1/23 21:28, Randy Dunlap wrote:
> 
> ../arch/sh/include/asm/checksum_32.h: In function 'csum_and_copy_from_user':
> ../arch/sh/include/asm/checksum_32.h:53:14: error: implicit declaration of function 'access_ok' [-Werror=implicit-function-declaration]
>    53 |         if (!access_ok(src, len))
>       |              ^~~~~~~~~
> 
> Fixes: 7fe8970a78a1 ("sh32: convert to csum_and_copy_from_user()")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: linux-sh@vger.kernel.org
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  arch/sh/include/asm/checksum_32.h |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff -- a/arch/sh/include/asm/checksum_32.h b/arch/sh/include/asm/checksum_32.h
> --- a/arch/sh/include/asm/checksum_32.h
> +++ b/arch/sh/include/asm/checksum_32.h
> @@ -7,6 +7,7 @@
>   */
>  
>  #include <linux/in6.h>
> +#include <asm-generic/access_ok.h>
>  
>  /*
>   * computes the checksum of a memory block at buff, length len,

-- 
~Randy
