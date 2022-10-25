Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA1D60D109
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbiJYPxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbiJYPxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:53:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3435717A03D;
        Tue, 25 Oct 2022 08:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=sdZai5OuyvgiiYOGQtylQK/l1MPc09h76lOcP8HbHAw=; b=VRdIUPTyhexHHGeVgMGNsslYeo
        V0nEXK8WaZxbfOL9WXSnwQedK2iGh98AbLF1WBgVoX8PcUZ8vBt59USfx66i98PQkzrL1jwDyN3e3
        D6+4JXZf2sg/TPV45xfK1+93KyqqHzhpdm0Cy9kKw8BUPQYQxH+8ykqJqd90caejWeOJztdYaDVJT
        XDf+A69m4thnAN8Zs4rIlRJQI8RgAJt5GCa9yKrK+f4E03jf5IYKEnNq2Mpw81vNX03JsZXfnY9FJ
        Uf2otbwxiaZ2qy2CicYnKoxzwJKWsITGO2QZIHcY21t2aLYCCqTbAh/koqxzYIMYSWgL+LQV9hPyQ
        lWPzmGvQ==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onMF9-006C0T-KC; Tue, 25 Oct 2022 15:53:31 +0000
Message-ID: <07daad5e-b32b-4e53-6f07-d050e7755aec@infradead.org>
Date:   Tue, 25 Oct 2022 08:53:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] audit: Fix some kernel-doc warnings
To:     Bo Liu <liubo03@inspur.com>, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221025060333.4295-1-liubo03@inspur.com>
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20221025060333.4295-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/24/22 23:03, Bo Liu wrote:
> The current code provokes some kernel-doc warnings:
>     security/lsm_audit.c:198: warning: Function parameter or member 'ab' not described in 'dump_common_audit_data'
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  security/lsm_audit.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> index 75cc3f8d2a42..ea5d35dce674 100644
> --- a/security/lsm_audit.c
> +++ b/security/lsm_audit.c
> @@ -190,6 +190,7 @@ static inline void print_ipv4_addr(struct audit_buffer *ab, __be32 addr,
>  
>  /**
>   * dump_common_audit_data - helper to dump common audit data
> + * @ab : the audit data to fill
>   * @a : common audit data
>   *
>   */

-- 
~Randy
