Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130D2718E31
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjEaWNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjEaWM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:12:58 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BC6E56;
        Wed, 31 May 2023 15:12:34 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 08D7A4025D;
        Wed, 31 May 2023 22:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1685571144;
        bh=+nmIKvT8Ba+dN10imTlWRtRDyfWTnTxdKB1XxYUU3pk=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=f27qCkFfqf3knIJRXDS4D3TcS6NUryEZpa0RCOkMFCOlMLc2YG4Zq+y2qbt6QK72O
         28JPjvDAfFiXWxv6Sj+IHjOCefAUS/8rmI1A6gOhI2lkxVxdmkwlGjpHvuKxON+xLD
         j2ca406SsQe+m6fvjxKYxAAJTL9TZYcV7tOhJzpLjGV9jd/2r/eZEr+v+FLpthkiPn
         e1QoHbeaaBskZcSGMtcMen9y7MOE9xiT6MCQSyzB70ssLo01nL1ql/lZDfWSk5Kttb
         6UaE873H19SvnW5eWSQEDjxzwiAzMC2XESVYnf+WwJd01+oXm0a059JhkmxGJYgc9o
         VP/gxWtc19WEA==
Message-ID: <202ffe3e-689f-d824-1f8c-c9f99835e0b5@canonical.com>
Date:   Wed, 31 May 2023 15:12:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] apparmor: remove unused macro
Content-Language: en-US
To:     "GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, gongruiqi1@huawei.com
References: <20230531111833.144628-1-gongruiqi@huaweicloud.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20230531111833.144628-1-gongruiqi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/23 04:18, GONG, Ruiqi wrote:
> SOCK_ctx() doesn't seem to be used anywhere in the code, so remove it.
> 
> Signed-off-by: GONG, Ruiqi <gongruiqi@huaweicloud.com>

Acked-by: John Johansen <john.johansen@canonical.com>

I will pull this into the apparmor-next tree

> ---
>   security/apparmor/include/net.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/security/apparmor/include/net.h b/security/apparmor/include/net.h
> index 6fa440b5daed..64a0112bf62d 100644
> --- a/security/apparmor/include/net.h
> +++ b/security/apparmor/include/net.h
> @@ -52,7 +52,6 @@ struct aa_sk_ctx {
>   };
>   
>   #define SK_CTX(X) ((X)->sk_security)
> -#define SOCK_ctx(X) SOCK_INODE(X)->i_security
>   #define DEFINE_AUDIT_NET(NAME, OP, SK, F, T, P)				  \
>   	struct lsm_network_audit NAME ## _net = { .sk = (SK),		  \
>   						  .family = (F)};	  \

