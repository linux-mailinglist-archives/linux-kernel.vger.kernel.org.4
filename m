Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7886910E3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 20:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjBITCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 14:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBITCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 14:02:48 -0500
Received: from www.kot-begemot.co.uk (ns1.kot-begemot.co.uk [217.160.28.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264025ACE2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 11:02:47 -0800 (PST)
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1pQCBu-007WLV-2x; Thu, 09 Feb 2023 19:02:42 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
        by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1pQCBr-0075G5-8A; Thu, 09 Feb 2023 19:02:41 +0000
Message-ID: <cc1d4868-ee89-519b-9415-1ee2f442d73e@cambridgegreys.com>
Date:   Thu, 9 Feb 2023 19:02:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] uml: vector: Remove unused definitions
 VECTOR_{WRITE,HEADERS}
Content-Language: en-US
To:     Carlos Bilbao <carlos.bilbao@amd.com>, richard@nod.at,
        johannes@sipsolutions.net
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230209181638.3781977-1-carlos.bilbao@amd.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
In-Reply-To: <20230209181638.3781977-1-carlos.bilbao@amd.com>
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

On 09/02/2023 18:16, Carlos Bilbao wrote:
> Remove definitions of VECTOR_WRITE and VECTOR_HEADERS since no longer used.
> 
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>   arch/um/drivers/vector_user.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/um/drivers/vector_user.h b/arch/um/drivers/vector_user.h
> index 3a73d17a0161..59ed5f9e6e41 100644
> --- a/arch/um/drivers/vector_user.h
> +++ b/arch/um/drivers/vector_user.h
> @@ -68,8 +68,6 @@ struct vector_fds {
>   };
>   
>   #define VECTOR_READ	1
> -#define VECTOR_WRITE	(1 < 1)
> -#define VECTOR_HEADERS	(1 < 2)
>   
>   extern struct arglist *uml_parse_vector_ifspec(char *arg);
>   

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
