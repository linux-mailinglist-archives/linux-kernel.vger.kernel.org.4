Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCA864F788
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 05:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiLQE0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 23:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiLQE0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 23:26:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F270178B4;
        Fri, 16 Dec 2022 20:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=sJfFoYUxM08YrnxAhZ562+wdSnaQJw31EihN3R7RgHo=; b=PUJJ2qjvE0MwkjKeoJ2kfMSx5t
        CWJO0k85y7jJrAGP4ciHkc5nvZsHKu2jOmKlYn40U3lhhopVHdrUsRat1yJb8GdsaC4dGTno1Ka+u
        n2BMCUh2/fY5QJ7A9jc16bSoeLiWqdTz7f3Ianr292xmNwcqnkz5xUuyCBa0k1L3JJsOn5IWIaeqB
        MpZOusrtxK2rgFZuNktx2NJl7/W1Sl/N++Jq4n2HLF6QqqVZVlOaM3j6jGQeMfljq0HYjlYiKiwa4
        5Zz6qqZIQZMQLoVvhOJkuGHYZ26ksdimkqHHBfCI1gE+hZokzIOObRdLmNZsZKAUgr9eE6AVVUaIm
        BV4EKA0g==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p6Ols-005EHm-NU; Sat, 17 Dec 2022 04:26:00 +0000
Message-ID: <d95a2ef4-9a58-6ed7-f073-122d2248e454@infradead.org>
Date:   Fri, 16 Dec 2022 20:26:00 -0800
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



On 12/16/22 19:59, Bhaskar Chowdhury wrote:
> s/sash/slash/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  Changes from V1: corrected the misspelled word

V2 should be a full patch, not just a correction to V1.
IF V1 were applied, then this patch could be applicable,
but then it would be patch 2/2, not just V2.


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
>  "\n"
> 
>  "Different color themes available\n"
> --
> 2.38.1
> 

-- 
~Randy
