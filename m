Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD22E70D144
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 04:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjEWCb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 22:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjEWCb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:31:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964B6CA
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 19:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=ZOQspSM7aS4EVzLLRn9w6q+2NaIG1JVOqGyvI0xvGh4=; b=OlP8Fr3uJUUUbhDOpxiZjOI1v2
        n0z9HfFczjRKrk2/gnm9h0xEwLyO1g3g5K2wj09K93wsdfEqM/FrrpiQYy9iocTUIn6F0kkwLnfhR
        qDxZf6W4A2Oa3Tqh6/owo9EOF2Bm7KO413HjJpX+IIRyfQ2ZrUQnot4VgQ0sGXEuVNjcsPyjFwa2p
        TUh0ei9XnyzNCGnwIe85D/y/hmr3PjUj5smPP/0SUCIYqxR9PZ1bhWzPzyNtLarE38+qUMKl8Jbsz
        GgfL0tIJ9e7/FvLxtfTGkbJpySbD2SNmPZBV1e3OfrBsoT6QpESuVh43VXOrvewafbzfMJZM/ZEMl
        E/95UcvQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1HoY-008h2Y-1y;
        Tue, 23 May 2023 02:31:54 +0000
Message-ID: <6a43717c-a8ed-6af5-ec01-21ee92270ce7@infradead.org>
Date:   Mon, 22 May 2023 19:31:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drivers: mcb: Modify mismatched function name
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        morbidrsa@gmail.com
Cc:     linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20230523023017.41226-1-jiapeng.chong@linux.alibaba.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230523023017.41226-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/22/23 19:30, Jiapeng Chong wrote:
> No functional modification involved.
> 
> drivers/mcb/mcb-core.c:335: warning: expecting prototype for mcb_bus_put(). Prototype was for mcb_bus_get() instead.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=5282
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/mcb/mcb-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mcb/mcb-core.c b/drivers/mcb/mcb-core.c
> index 978fdfc19a06..520160eaa7b1 100644
> --- a/drivers/mcb/mcb-core.c
> +++ b/drivers/mcb/mcb-core.c
> @@ -326,7 +326,7 @@ void mcb_release_bus(struct mcb_bus *bus)
>  EXPORT_SYMBOL_NS_GPL(mcb_release_bus, MCB);
>  
>  /**
> - * mcb_bus_put() - Increment refcnt
> + * mcb_bus_get() - Increment refcnt
>   * @bus: The @mcb_bus
>   *
>   * Get a @mcb_bus' ref

-- 
~Randy
