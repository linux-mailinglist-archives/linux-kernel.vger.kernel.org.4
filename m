Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F62C6E3E69
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 06:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjDQENq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 00:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjDQENp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 00:13:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663FC1997;
        Sun, 16 Apr 2023 21:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=cjUNe41VvH2mXa4ae24CHhq9bdg04YCfwHqvB5onTgo=; b=F0O4dzD2dLl6jnX832hST1owNY
        hhB9U224pLbhW/7lkE/7/zwx9TvcLSjPC8w1emeO4hQNAWLEthQ1zYldr7bWwII/vuYX6d4ZdsG2b
        2qFyze5Ab3iQJAwXiJWnJuRMD4i4KV6TAO+UwfnYVN4uts3a/t2PWvXZZQA1D+XS5Qn70Shn8CZ8b
        /17dbuyUHUc/udtgUyyNrC+wCTBtkgGAUjqHEof7Jx4Gl8Eiav50AVeLaeDZWFpR4pqyMQQ9EARBg
        2WiLQAFaw5VRe0C5Qi3sTYDzY8LhcCtzAUf/C6AmjfsZZqvI5g2Xw5ymAVt72gRcbFvGRkIqQbBg6
        dLA6LIvA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1poGFG-00Ep2u-16;
        Mon, 17 Apr 2023 04:13:39 +0000
Message-ID: <5961416c-e5d6-9321-3ae8-f63b70d17d63@infradead.org>
Date:   Sun, 16 Apr 2023 21:13:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] docs: f2fs: specify extent cache for read explicitly
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-f2fs-devel@lists.sourceforge.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230417040308.46621-1-frank.li@vivo.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230417040308.46621-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/16/23 21:03, Yangtao Li wrote:
> Let's descrbie it's read extent cache.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  Documentation/filesystems/f2fs.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index c57745375edb..f68337086dec 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -163,11 +163,11 @@ barrier			 If this option is set, cache_flush commands are allowed to be
>  fastboot		 This option is used when a system wants to reduce mount
>  			 time as much as possible, even though normal performance
>  			 can be sacrificed.
> -extent_cache		 Enable an extent cache based on rb-tree, it can cache
> +extent_cache		 Enable an read extent cache based on rb-tree, it can cache

			 Enable a read extent cache based on rb-tree. It can cache

>  			 as many as extent which map between contiguous logical

I don't know that that is trying to say. Maybe this?

			 many extents which map between contiguous logical

Does it cache many extents or all of them?  If all of them, then maybe this?

			 the extents which map between contiguous logical

>  			 address and physical address per inode, resulting in
>  			 increasing the cache hit ratio. Set by default.
> -noextent_cache		 Disable an extent cache based on rb-tree explicitly, see
> +noextent_cache		 Disable an read extent cache based on rb-tree explicitly, see

				 Disable a read extent cache based on rb-tree explicitly. See

>  			 the above extent_cache mount option.
>  noinline_data		 Disable the inline data feature, inline data feature is
>  			 enabled by default.

-- 
~Randy
