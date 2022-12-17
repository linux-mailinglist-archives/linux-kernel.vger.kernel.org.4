Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A4A64F782
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 05:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiLQETO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 23:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiLQETL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 23:19:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C2C2529C;
        Fri, 16 Dec 2022 20:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=+yJgFL5TBnDB0fCklDyR9MMDGqTBDzeplYDVKMb9W14=; b=pNVRcFD1oh4CXpQcRMj3B7iDNP
        3ENfSqCqHttDDfkqoqNP9WUQDpjabtb46TkxAaTkk2eeqD9lNQVImbPoOFoHMMi3iD50zkEYIF04D
        juorrIdvadq5JENu92r2yGOAZFgnoojHqfjYOwUFJUZkrsTf4+j4dQWAHSXcGhA3x8EiId5RSspmo
        JmsGEyWAeCZqnchcPwhv0zrvf4iRfYOkTsDYwcMe5hERMXG8BaabV3hGbd+aXYKAVglw/E90iDabr
        ZlL6ExGxwt79Eli2fahsGJkHNmY+f1m8+/3OozXPmW7oe9OvOBR/ZPPwp5kR7WyDhdU68kFN41g+j
        JXryC61w==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p6OfF-005AmR-6m; Sat, 17 Dec 2022 04:19:09 +0000
Message-ID: <b58264d1-9b77-677b-04a9-59f14a195dea@infradead.org>
Date:   Fri, 16 Dec 2022 20:19:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH V2] scripts: kconfig: Corrected the misspelled word in
 kconfig help text
Content-Language: en-US
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, masahiroy@kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221217035919.19855-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20221217035919.19855-1-unixbhaskar@gmail.com>
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

Hi--

On 12/16/22 19:59, Bhaskar Chowdhury wrote:
> s/sash/slash/
> 

That correction is good...

> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  Changes from V1: corrected the misspelled word
>  scripts/kconfig/mconf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
> index 93dc4850ff2a..a82cac8916ab 100644
> --- a/scripts/kconfig/mconf.c
> +++ b/scripts/kconfig/mconf.c
> @@ -164,7 +164,7 @@ static const char mconf_readme[] =
> 
>  "Search\n"
>  "------\n"
> -"Press forward sash(/) anywhere will bring up search dialog box\n"
> +"Press forward slash(/) anywhere will bring up search dialog box\n"

That sentence could be better. Either
s/Press/Pressing/
or
s/will/to/
but not both of those -- just one of them.
And then s/bring up/bring up a/.

>  "\n"
> 
>  "Different color themes available\n"
> --
> 2.38.1
> 

Thanks.
-- 
~Randy
