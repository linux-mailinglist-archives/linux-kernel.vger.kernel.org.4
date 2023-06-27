Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C7473F0A3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 03:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjF0BtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 21:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjF0Bst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 21:48:49 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDDE1701;
        Mon, 26 Jun 2023 18:48:48 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id D6E005C01E4;
        Mon, 26 Jun 2023 21:48:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 26 Jun 2023 21:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1687830527; x=1687916927; bh=XVzYIeQy8/TNTff2J5SjjLTTLWxENUsswH0
        8mHorDqY=; b=Ja1NYfvmSLrwC83DRWjbIp5XdjAh0n+Q/7S9f7tISKx37mUJ9xJ
        s4WEUxH+KjToyS4xM4RyJj5+nKI0Vj5bDFZAiiJOMCg3QIgOYwj/Y01tsMBFI7RT
        PjLMVbvVUs5iwDUN1grMyqv52d2scvTG6HYjNIR2Te3UyOBLl/Pd98VyUErAaP/B
        IWusewKVMBGGrYtOzdaBdVAKM7W9uNM8QzUHtai3nxXtreUza0xyhwtSskr0JqSv
        RcIbnE3BGWVoOsIjl1dhRAz6tW34aOR+BpKbNK2j3UF+bXQhBuuZmzclyBskAzdY
        c8MZaak3o9tiQ+P06VMhVzpjEqme9TThY1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1687830527; x=1687916927; bh=XVzYIeQy8/TNTff2J5SjjLTTLWxENUsswH0
        8mHorDqY=; b=YU3sek6CkQ83uDGINE5llUaCUxrtWvJoaSDn6zGhlLNO5L5p+xy
        V/1iDSfJjJIIuPe8wwXnM5fhIFRz3ZCQf4f1VzL9BoKevx1U1U1VQMZQBAQK54NH
        QgFcHuDOC+3JEa34saGJAHFo8othDHYAk5bM45elKz0Nh0pSHBa9f9Pg8hYL9Lo7
        iMgF7zzS+tQCzuhpJhnCL7YjsDicBO8O5huwynMLNOHJsk01hMfPKTg4214c3MTt
        LC8C8PxSfmEmyewsRzi/kCx6VuksbSJGQGiO74C5/P5CZr1Czr8bOZpAbmgDHK4r
        f2f6HvmZFBDc7VtRhr78L21UxaeEM/XOFtw==
X-ME-Sender: <xms:_z-aZBSqTV7jLVGWk_OsBwlPzqRB_0nXMPL4b9pf8hLsm0kXryhzqA>
    <xme:_z-aZKx-RVhKfxb2LaEpJ_KWPrZ-lOlXBa2PixbqCBVZSiD7JocPoO_4vRZ7jVpwP
    9iu4ThlWArP>
X-ME-Received: <xmr:_z-aZG3PVetcpEQnbYi8KUq8aqd0HDrvyur4R_Va0LPiMRikcMK7M5AnhdjeuR3ksnFEbe3JjcfwWrfIZIiNkytsjAr8hB9BIt6sL6jQMoBF8ajQIeE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeehgedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epuefhueeiieejueevkefgiedtteehgfdutdelfffhleeflefhudeuvdefhfeghfehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:_z-aZJCrRE8gAbmNdUpoILgbyg16VuoxWJY8QhGed6ZN_3xzbYbNtw>
    <xmx:_z-aZKgwZLfGkQD-JCMVDpA39fbOHN1_aKDc4Gh_SWjHT55SzBeXgg>
    <xmx:_z-aZNpDJiWvsfhYy5zW1y7BLMDz2IMSY1zfeGE-xBzqSkXZ1Cu7dg>
    <xmx:_z-aZLuKPajAR8ICwN31oaC2hvr6PgiBZTYecuNhj0VkwCC8lEJO9Q>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jun 2023 21:48:44 -0400 (EDT)
Message-ID: <d01379c1-46d9-af26-21a1-1312a51920fa@themaw.net>
Date:   Tue, 27 Jun 2023 09:48:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH 13/79] autofs: switch to new ctime accessors
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        autofs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
 <20230621144735.55953-12-jlayton@kernel.org>
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <20230621144735.55953-12-jlayton@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/623 22:45, Jeff Layton wrote:
> In later patches, we're going to change how the ctime.tv_nsec field is
> utilized. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks fine to me.

Please feel free to add my Acked-by or even Signed-off-by as

you need dictates.


Ian

> ---
>   fs/autofs/inode.c | 2 +-
>   fs/autofs/root.c  | 6 +++---
>   2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
> index affa70360b1f..47e3054b29dc 100644
> --- a/fs/autofs/inode.c
> +++ b/fs/autofs/inode.c
> @@ -370,7 +370,7 @@ struct inode *autofs_get_inode(struct super_block *sb, umode_t mode)
>   		inode->i_uid = d_inode(sb->s_root)->i_uid;
>   		inode->i_gid = d_inode(sb->s_root)->i_gid;
>   	}
> -	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
> +	inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
>   	inode->i_ino = get_next_ino();
>   
>   	if (S_ISDIR(mode)) {
> diff --git a/fs/autofs/root.c b/fs/autofs/root.c
> index 93046c9dc461..4c0fc0f8d688 100644
> --- a/fs/autofs/root.c
> +++ b/fs/autofs/root.c
> @@ -600,7 +600,7 @@ static int autofs_dir_symlink(struct mnt_idmap *idmap,
>   	p_ino = autofs_dentry_ino(dentry->d_parent);
>   	p_ino->count++;
>   
> -	dir->i_mtime = dir->i_ctime = current_time(dir);
> +	dir->i_mtime = inode_ctime_set_current(dir);
>   
>   	return 0;
>   }
> @@ -633,7 +633,7 @@ static int autofs_dir_unlink(struct inode *dir, struct dentry *dentry)
>   	d_inode(dentry)->i_size = 0;
>   	clear_nlink(d_inode(dentry));
>   
> -	dir->i_mtime = dir->i_ctime = current_time(dir);
> +	dir->i_mtime = inode_ctime_set_current(dir);
>   
>   	spin_lock(&sbi->lookup_lock);
>   	__autofs_add_expiring(dentry);
> @@ -749,7 +749,7 @@ static int autofs_dir_mkdir(struct mnt_idmap *idmap,
>   	p_ino = autofs_dentry_ino(dentry->d_parent);
>   	p_ino->count++;
>   	inc_nlink(dir);
> -	dir->i_mtime = dir->i_ctime = current_time(dir);
> +	dir->i_mtime = inode_ctime_set_current(dir);
>   
>   	return 0;
>   }
