Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F810690F4D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 18:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjBIRci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 12:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBIRch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 12:32:37 -0500
X-Greylist: delayed 1214 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Feb 2023 09:32:35 PST
Received: from www.kot-begemot.co.uk (ns1.kot-begemot.co.uk [217.160.28.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E96438B68
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 09:32:35 -0800 (PST)
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1pQASy-007WDm-Nc; Thu, 09 Feb 2023 17:12:12 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
        by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1pQASw-006zQ5-00; Thu, 09 Feb 2023 17:12:12 +0000
Message-ID: <2faee789-80d0-656f-64ce-3e090ba9d7c2@cambridgegreys.com>
Date:   Thu, 9 Feb 2023 17:12:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] uml: vector: fix definitios of VECTOR_WRITE and
 VECTOR_HEADERS
Content-Language: en-US
To:     Carlos Bilbao <carlos.bilbao@amd.com>, richard@nod.at,
        johannes@sipsolutions.net
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230209161916.3729757-1-carlos.bilbao@amd.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
In-Reply-To: <20230209161916.3729757-1-carlos.bilbao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.0
X-Spam-Score: -2.0
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2023 16:19, Carlos Bilbao wrote:
> Fix definitions of VECTOR_WRITE and VECTOR_HEADERS with proper bitwise
> operand for bit shift.
> 
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>   arch/um/drivers/vector_user.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/um/drivers/vector_user.h b/arch/um/drivers/vector_user.h
> index 3a73d17a0161..f7d3956f5c15 100644
> --- a/arch/um/drivers/vector_user.h
> +++ b/arch/um/drivers/vector_user.h
> @@ -68,8 +68,8 @@ struct vector_fds {
>   };
>   
>   #define VECTOR_READ	1
> -#define VECTOR_WRITE	(1 < 1)
> -#define VECTOR_HEADERS	(1 < 2)
> +#define VECTOR_WRITE	(1 << 1)
> +#define VECTOR_HEADERS	(1 << 2)
>   
>   extern struct arglist *uml_parse_vector_ifspec(char *arg);
>   

I need to have a look at the code how it even worked before. Will ack 
after that.
-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
