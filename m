Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0ED6DC1E1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 00:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjDIWTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 18:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDIWTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 18:19:38 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52AEB1;
        Sun,  9 Apr 2023 15:19:36 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 88D4D3F372;
        Sun,  9 Apr 2023 22:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1681078774;
        bh=ywZa4gMVjJ/TgMA3MbzGqeq/4k214O2pnBHSmSdaKn8=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=b/rXpEengsCUfkk+NpMEHK0wKrxJkq6JRuChFDGc22hycOi3tkcJ5xSAbDGEg9iIY
         wcbkt0NrTYHbF1aM3NJlyh/hAGEYBwU5++dWT5MQpSOeVHZOpj5TN7RIK48flJRVBd
         E7aGzH5VKiuoNhBKun+tAJhWBHeXNzsced5dkQyXHX5/NI5rwH9oHsz0OgUc7f59rP
         rTMMEqOXFe9W2GOcE1CYitSRytTD5jhvmpAku/u0MT0hgvu6bUbzm5xV2V3PQB1cK/
         UpHfOGfD5AF8WmkzMd6uTGFTHA3RTXJFMcsH+1ONkSTQmU/7388CshJKxxv5Jk+Jc0
         pH5gSBTiD0E6A==
Message-ID: <2bc5865b-62a5-27a3-63c7-9c4ee9b697aa@canonical.com>
Date:   Sun, 9 Apr 2023 15:19:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH -next] AppArmor: Fix some kernel-doc comments
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20230303012833.57690-1-yang.lee@linux.alibaba.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20230303012833.57690-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/23 17:28, Yang Li wrote:
> Make the description of @table to @strs in function unpack_trans_table()
> to silence the warnings:
> 
> security/apparmor/policy_unpack.c:456: warning: Function parameter or member 'strs' not described in 'unpack_trans_table'
> security/apparmor/policy_unpack.c:456: warning: Excess function parameter 'table' description in 'unpack_trans_table'
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4332
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Acked-by: John Johansen <john.johansen@canonical.com>

I have pulled this into the apparmor tree thanks

> ---
>   security/apparmor/policy_unpack.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
> index cf2ceec40b28..c3f44f1deb07 100644
> --- a/security/apparmor/policy_unpack.c
> +++ b/security/apparmor/policy_unpack.c
> @@ -448,7 +448,7 @@ static struct aa_dfa *unpack_dfa(struct aa_ext *e, int flags)
>   /**
>    * unpack_trans_table - unpack a profile transition table
>    * @e: serialized data extent information  (NOT NULL)
> - * @table: str table to unpack to (NOT NULL)
> + * @strs: str table to unpack to (NOT NULL)
>    *
>    * Returns: true if table successfully unpacked or not present
>    */

