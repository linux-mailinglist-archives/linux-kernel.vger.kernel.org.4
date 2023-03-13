Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113166B6CD1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 01:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjCMA33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 20:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCMA31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 20:29:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D29827D44;
        Sun, 12 Mar 2023 17:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=nXZ9rdcqLaPJ1KeuZUENg8YV+RzqEJnAkngGLrLX0nA=; b=Wq3uHc/WLNSlwf7JcOCLYKJgZ5
        0gbbVhncnxU5HatnjF86V96ER86r1YDWCRwtGZGMn2ttq2eDpsxDxvSlxCwPugFou+QEQyLxOj8wx
        zkoORAYxsgyHLPpVirgFH8JRRxYa96aaw++MZDHzBbXNv9taYRUj8pNwt7sVNw3Lzdj2NTvjyV2W/
        rP9OZ+plhrskK/FpQ0DyHcdMEZ6OzBAo/9pc+A9CuYGnenWkKuthPCh3OjAEv7U0jkBMXdBOZmUNl
        6TWsgz/IntuSGDxCxf3gAEozCGAW+UoUPIp0kM1371/Fp1aOGSKwh0ZJiMYlVzte2NWvC2mPRYohm
        6mku2bKA==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pbW45-003t29-7r; Mon, 13 Mar 2023 00:29:25 +0000
Message-ID: <26a291d8-49c0-e5af-846b-1e29f8266ba9@infradead.org>
Date:   Sun, 12 Mar 2023 17:29:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 2/3] menuconfig: reclaim horizontal space
To:     Alexey Dobriyan <adobriyan@gmail.com>, masahiroy@kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230311114248.36587-1-adobriyan@gmail.com>
 <20230311114248.36587-2-adobriyan@gmail.com>
Content-Language: en-US
In-Reply-To: <20230311114248.36587-2-adobriyan@gmail.com>
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

Hi,

On 3/11/23 03:42, Alexey Dobriyan wrote:
> Draw the menu box from position (0, 2) so that there is less unused
> space available. Horizontal is not _really_ important but on small
> terminals maybe it is.

ISTM that the first sentence goes with patch 3/3. ??

> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
>  scripts/kconfig/lxdialog/menubox.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/scripts/kconfig/lxdialog/menubox.c b/scripts/kconfig/lxdialog/menubox.c
> index 5c3addad89b0..5eb67c04821f 100644
> --- a/scripts/kconfig/lxdialog/menubox.c
> +++ b/scripts/kconfig/lxdialog/menubox.c
> @@ -184,7 +184,6 @@ int dialog_menu(const char *title, const char *prompt,
>  		return -ERRDISPLAYTOOSMALL;
>  
>  	height -= 4;
> -	width  -= 5;

How does this work?  In my test patch, I changed 5 to 4 to recover/reclaim the
shadow line.  To my surprise, I don't see any negative issue with this change,
but I am perplexed by it.

Anyway, it worked in my testing.

Tested-by: Randy Dunlap <rdunlap@infradead.org>

>  	menu_height = height - 10;
>  
>  	max_choice = MIN(menu_height, item_count());

Thanks.
-- 
~Randy
