Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E51615422
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 22:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiKAVVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 17:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiKAVVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 17:21:20 -0400
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D787420356
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 14:18:49 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id pyekoYyrKtFxApyekoGquo; Tue, 01 Nov 2022 22:18:47 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 01 Nov 2022 22:18:47 +0100
X-ME-IP: 86.243.100.34
Message-ID: <6ae45ada-19fa-a633-6c60-c715686e4859@wanadoo.fr>
Date:   Tue, 1 Nov 2022 22:18:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 30/30] kstrtox: Remove strtobool()
Content-Language: fr, en-US
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
 <fb186d487370cd4ef70929f03d46cd16be6b9c8d.1667336095.git.christophe.jaillet@wanadoo.fr>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <fb186d487370cd4ef70929f03d46cd16be6b9c8d.1667336095.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MISSING_HEADERS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 01/11/2022 à 22:14, Christophe JAILLET a écrit :
> strtobool() is the same as kstrtobool().
> All uses of strtobool() have been turned into kstrtobool().
> 
> So strtobool() can now be removed as well.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   include/linux/kernel.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index fe6efb24d151..244b92041cb0 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -20,7 +20,7 @@
>   #include <linux/compiler.h>
>   #include <linux/container_of.h>
>   #include <linux/bitops.h>
> -#include <linux/kstrtox.h>
> +//#include <linux/kstrtox.h>
>   #include <linux/log2.h>
>   #include <linux/math.h>
>   #include <linux/minmax.h>

Ouch, the last patch is not what was expected...

I'll send it separately when the other patches are merged.

CJ
