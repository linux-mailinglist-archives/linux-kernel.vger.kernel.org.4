Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0EB6AABB0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 18:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjCDRxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 12:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCDRxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 12:53:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B68A65BB;
        Sat,  4 Mar 2023 09:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=xZTmoleW7FP5ovDXeTN6JxR74OpGXjb86TMIZ9sGbx0=; b=Z2Z+2m69CL8eMLKiFkM8s1tvwV
        Ct+wMQfuqPwt6AtbsSbB66rbDkBOai/WVP+HDrBH9qkbqf3Culdmtg5oWsdqZVeXbZrveIFd/s7vH
        Wp+oxrGn9YfRIy0xW0/vNimn5XpgCrRWo+h2rxc/SCW+XebOEduNAOhwKZ5iNVNPTQOKp5j5hbE8Z
        sgbbRKq76v6UJ33vpEK2xVkD/zWbpnvdcrEEQSb3i9L79C5YGiUKJ8a3w0hIJdRABZRjW7AWUrKNz
        5igzo8mkddkQBTypQlGdbtbBecnVBTIf7LakCpGiBVRJ6TjMS8reIy/d2RfNph9qG28wgRzgdqE6w
        JnyDsa5Q==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pYW3z-009Nj0-K3; Sat, 04 Mar 2023 17:52:55 +0000
Message-ID: <ae258f1e-5c44-d349-4704-fbf5c7c28b85@infradead.org>
Date:   Sat, 4 Mar 2023 09:52:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] menuconfig: reclaim 1 more vertical line
Content-Language: en-US
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <94a94ef4-9d55-4293-8363-3c0243eceae1@p183>
 <8a8c8ed8-f322-4024-9433-3a9cb524484e@p183>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <8a8c8ed8-f322-4024-9433-3a9cb524484e@p183>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/4/23 08:56, Alexey Dobriyan wrote:
> Empty line after legend is waste, use it for config options.
> 

I don't see an empty line after the legend. For me this patch
truncates the menu_instructions[] text from 4 lines to 3 lines,
dropping good/useful help text.

menu_instructions[] was already truncated before this patch
(in an 80x30 size terminal window).

What size terminal are you using?

> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  scripts/kconfig/lxdialog/menubox.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/scripts/kconfig/lxdialog/menubox.c
> +++ b/scripts/kconfig/lxdialog/menubox.c
> @@ -185,7 +185,7 @@ int dialog_menu(const char *title, const char *prompt,
>  
>  	height -= 2;
>  	width  -= 5;
> -	menu_height = height - 10;
> +	menu_height = height - 9;
>  
>  	max_choice = MIN(menu_height, item_count());
>  

-- 
~Randy
