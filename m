Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF2374CA98
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 05:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjGJDdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 23:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjGJDdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 23:33:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2027F93
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 20:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=utufyc0tUqMFhAkg8ykIG85vykqYY+A981nQUeqIPUY=; b=M5JJwDeMd8JQUAWFcRr6HMyOup
        ZJZ/1bpK2p0fkb0i9E0kec3wzRwcQHgbbFQcJndzgZmtdvB4wpGTzUExlwp0oDynijMl8M6h38pCb
        oiSKFQCpJhd3ZGqRuoXdOCiWGgHrUifB9jO6UapPdhwsARXthrJzzODvIVlG0vbG+iRcvZ9jflCju
        n47sy/l+Y7NqVFlvut3DSR8qbgrp794r/P0LPsJfhLv32gxmBoGK43H7SowlRrQIkRLa6QBnwy3Ih
        w754/YlBRHHFCzBCS5Vu+dZD4a3PDTsJgfxygiM0ZT1cRjtz7tQkhJCpqVro+Yr13zYEc7GjOwvWN
        YtztmFGQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qIheT-00AIMV-1Y;
        Mon, 10 Jul 2023 03:33:29 +0000
Message-ID: <1408364e-6b73-7b50-e61c-470f3548a3a7@infradead.org>
Date:   Sun, 9 Jul 2023 20:33:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_kernel=3a_params=3a_Remove_unnecessary_?=
 =?UTF-8?B?4oCYMOKAmSB2YWx1ZXMgZnJvbSBlcnI=?=
Content-Language: en-US
To:     Li zeming <zeming@nfschina.com>, mcgrof@kernel.org,
        linux@rasmusvillemoes.dk, mbenes@suse.cz, rafael@kernel.org,
        linux@weissschuh.net, gregkh@linuxfoundation.org,
        christophe.jaillet@wanadoo.fr
Cc:     linux-kernel@vger.kernel.org
References: <20230711194331.4361-1-zeming@nfschina.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230711194331.4361-1-zeming@nfschina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/11/23 12:43, Li zeming wrote:
> err is assigned first, so it does not need to initialize the assignment.
> 
> Signed-off-by: Li zeming <zeming@nfschina.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  kernel/params.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/params.c b/kernel/params.c
> index 6a7548979aa9..f8837a5f2c3e 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -331,7 +331,7 @@ EXPORT_SYMBOL(param_ops_bool);
>  
>  int param_set_bool_enable_only(const char *val, const struct kernel_param *kp)
>  {
> -	int err = 0;
> +	int err;
>  	bool new_value;
>  	bool orig_value = *(bool *)kp->arg;
>  	struct kernel_param dummy_kp = *kp;

-- 
~Randy
