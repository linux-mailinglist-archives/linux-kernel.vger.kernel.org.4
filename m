Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B7C606DCA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 04:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJUCbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 22:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJUCbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 22:31:08 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C206A17A96B;
        Thu, 20 Oct 2022 19:31:07 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.47.134.47])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id E3B7F43229;
        Fri, 21 Oct 2022 02:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1666319466;
        bh=W5ttTTvJhQt4iDiuMC26FByAMmCEgx3KWUE5L8KpP7U=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=OZT2127MI30oLkHN/HfKdTDGLMQt/MK5TuvwgCWwAj6Y8lIcGkdXKQzGvR5yDb5L9
         IXkTdgEr+p1xmSr8IuySgzBLW9dpj7MdvNxhm3PH56L512Lemuzi0PEz7AnuDUQOjU
         E4y8uICB1YV/2d9UeuVNxiQh366wAp8hQT0/tbasa0tucRuRXwMeEjqCWyonmfCiND
         JonsSQuXW++EJ28lMTDmjrjFHd6Tt9ikqdS247nJVjOR48gqDMW2sgdYG1P1Zuj1Qh
         DFPV3+uOnKBsDTXI32vCQeCS6ExXPoOyM5P3GlE3ySqtgRc7yyUozP9IPOONiLMoLX
         t/NSPIHdKXHNg==
Message-ID: <d39df9d7-fc54-7e9b-d4ce-5c0d4fc455d4@canonical.com>
Date:   Thu, 20 Oct 2022 19:31:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH -next] apparmor: Fix spelling of function name in comment
 block
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20221014084255.26103-1-yang.lee@linux.alibaba.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20221014084255.26103-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/22 01:42, Yang Li wrote:
> 'resouce' -> 'resource'
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2396
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

I have pulled this into my tree

Acked-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/apparmor/resource.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/apparmor/resource.c b/security/apparmor/resource.c
> index ed543f4edfd9..d7dbacc9a369 100644
> --- a/security/apparmor/resource.c
> +++ b/security/apparmor/resource.c
> @@ -66,7 +66,7 @@ static int audit_resource(struct aa_profile *profile, unsigned int resource,
>   }
>   
>   /**
> - * aa_map_resouce - map compiled policy resource to internal #
> + * aa_map_resource - map compiled policy resource to internal #
>    * @resource: flattened policy resource number
>    *
>    * Returns: resource # for the current architecture.

