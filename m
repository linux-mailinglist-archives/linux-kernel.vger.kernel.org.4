Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB7F5BBE95
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 17:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiIRPIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 11:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIRPIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 11:08:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEEC20F7D
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 08:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=E0HELhHH1eG5ckbCLVt2Clg1ZVqTrI/9IYz1SGfTF4s=; b=LdSFWGKEUu0aqD0l+62WTR/CBr
        FBwSbNOYSO41A2gQWmegiC+Tc3/jAo2Tl4F6xthIcfyWNQIUq7gUoSGwb0KekINP/MFo7GQbWJQj0
        FoTvexd9SQ54U3+1nVJxOMa7J4jTDkGt+YgkUMPlTJIdxIg5FRhN0DchwDIxsawpoQk0R7+nw2H/C
        rGFLA9TfRP6b5/Ienunp+Eo1MIh5BOt/zTuNUt2AhhOw07Er+wfDog89ROlHtK/JdJIM5tVslJ5lb
        g3NxZcCIjvGKoHTzIZxZh37XFhHf7mkmifWGR5HrIRuJ1+a9hfuTjE4TkJjlq8gOql0jhhJrTWY2S
        klg7CxKQ==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oZvuN-00HQiv-1F; Sun, 18 Sep 2022 15:08:35 +0000
Message-ID: <b38433a9-191f-9ba8-3230-edb962867bad@infradead.org>
Date:   Sun, 18 Sep 2022 08:08:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] mm: fix repeated words in comments
Content-Language: en-US
To:     Jilin Yuan <yuanjilin@cdjrlc.com>, namit@vmware.com,
        pv-drivers@vmware.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20220918100125.25558-1-yuanjilin@cdjrlc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220918100125.25558-1-yuanjilin@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/18/22 03:01, Jilin Yuan wrote:
> Delete the redundant word 'on'.
> 
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
> ---
>  drivers/misc/vmw_balloon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
> index 61a2be712bf7..c2e774f68133 100644
> --- a/drivers/misc/vmw_balloon.c
> +++ b/drivers/misc/vmw_balloon.c
> @@ -736,7 +736,7 @@ static int vmballoon_handle_one_result(struct vmballoon *b, struct page *page,
>   * @p: pointer to where the page struct is returned.
>   *
>   * Following a lock or unlock operation, returns the status of the operation for
> - * an individual page. Provides the page that the operation was performed on on
> + * an individual page. Provides the page that the operation was performed on

This would make more sense to me: (s/on on/on in/)

> + * an individual page. Provides the page that the operation was performed on in

>   * the @page argument.
>   *
>   * Returns: The status of a lock or unlock operation for an individual page.

-- 
~Randy
