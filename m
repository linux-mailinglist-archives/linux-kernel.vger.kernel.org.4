Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688EB6F04DE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 13:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243336AbjD0LTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 07:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243413AbjD0LTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 07:19:47 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CE54C27
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 04:19:42 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d2e1a72fcca58-63d2ba63dddso6519109b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 04:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682594382; x=1685186382;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lugMEjPyNs4wx1BEsCrvxYBx5QxmgCHFZRpu6mcr7o=;
        b=GLsccxubBow2ZwGx20DaXcH4DodwggWSSDfMgWUn81JSLDiyryr9XVbmX45slwBn1f
         Qt9xAUN5Iv2KeeWt6r585MH0+iCJDK6mIWBD//Cq4zuxgkBnFeNpoGosi33SJhieHylO
         FRz1GOkKSSUkSh8pKhGAVxb9NzXESOD9LCuLO7kGqnKnOCQrfMnEHKGFR3e9H1DIw6GX
         LMngrbxAF5pQk0x7m7bMoODZc+xwhvTuMWDCY9Oq+zk3fgm08x3S56fMGLArhIPRkIeK
         RlzC8I2uV0MgB1h+1Qpp6eg6JwOkaFFqtvsr7REmLno+TRpyyms/tfwwuGcDYgVzjgx7
         4kKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682594382; x=1685186382;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+lugMEjPyNs4wx1BEsCrvxYBx5QxmgCHFZRpu6mcr7o=;
        b=UqhXe+tM6VrwkrdjzHVGuOgTq8n/5RA6grRNKxDZSZ0OQ8t7IvZZsnFn2TEDY/Nbla
         9p8x7Uhw4NRIZ//PStg0Ge+hNfbFtdT6CnDWppj9WRBSfuht0dxKR3UOxF1M0bKJ3NCf
         iuvFaJcStgZ/q4qrhJ4MF3JAOavWAcATq4Qbhf8TFZ419cmsSbZeBhIVGIaEX7iRZc5G
         1z5tBjwLPAaGdprnTC5J9rJiFkinkLzoe90sRZJc8FwvCQ/3lb8isycqpQ4zrMnBtCWl
         SHojS1IXBCv89fu4O4NEfdW5+Y5IinvNtqTvrYfua7rWyMrat46M4RmgY2w43xBQa6LS
         pAGQ==
X-Gm-Message-State: AC+VfDzisNs+Lj3gxB5CPYR/CaVywxGRqSg/cNXCt7s8ScijevZeiFzf
        6BPKvNW8jAX+8ZPSXVfwIw4=
X-Google-Smtp-Source: ACHHUZ6vMN5OPIVrNE1wbW+smYmnuHLGFzPTcfgCx7+5t9SbrwM9vpLfZLq9tkKZMK9sj/IP0oMsKw==
X-Received: by 2002:a05:6a20:728a:b0:ec:a118:6471 with SMTP id o10-20020a056a20728a00b000eca1186471mr1477996pzk.50.1682594381996;
        Thu, 27 Apr 2023 04:19:41 -0700 (PDT)
Received: from [10.200.10.82] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id k128-20020a632486000000b00502ecc282e2sm11407200pgk.5.2023.04.27.04.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 04:19:41 -0700 (PDT)
Message-ID: <578db833-e20a-cec8-c00f-5cd1e8959ccf@gmail.com>
Date:   Thu, 27 Apr 2023 19:19:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH 25/34] maple_tree: Clear up index and last setting in
 single entry tree
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
 <20230425140955.3834476-26-Liam.Howlett@oracle.com>
From:   Peng Zhang <perlyzhang@gmail.com>
In-Reply-To: <20230425140955.3834476-26-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/4/25 22:09, Liam R. Howlett 写道:
> When there is a single entry tree (range of 0-0 pointing to an entry),
> then ensure the limit is either 0-0 or 1-oo, depending on where the user
> walks.  Ensure the correct node setting as well; either MAS_ROOT or
> MAS_NONE.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>   lib/maple_tree.c | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 20f0a10dc5608..31cbfd7b44728 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5099,24 +5099,25 @@ void *mas_walk(struct ma_state *mas)
>   {
>   	void *entry;
>   
> +	if (mas_is_none(mas) || mas_is_paused(mas))
> +		mas->node = MAS_START;
>   retry:
>   	entry = mas_state_walk(mas);
> -	if (mas_is_start(mas))
> +	if (mas_is_start(mas)) {
>   		goto retry;
> -
> -	if (mas_is_ptr(mas)) {
> +	} else if (mas_is_none(mas)) {
> +		mas->index = 0;
> +		mas->last = ULONG_MAX;
> +	} else if (mas_is_ptr(mas)) {
>   		if (!mas->index) {
>   			mas->last = 0;
> -		} else {
> -			mas->index = 1;
> -			mas->last = ULONG_MAX;
> +			return mas_root(mas);
Why we call mas_root() to get the single entry stored in root again?
I think it's not safe. In RCU mode, if someone modify the tree to a 
normal tree(not a single entry tree), mas_root() will return a address.
So, this may cause a race bug. We can return entry directly.
>   		}
> -		return entry;
> -	}
>   
> -	if (mas_is_none(mas)) {
> -		mas->index = 0;
> +		mas->index = 1;
>   		mas->last = ULONG_MAX;
> +		mas->node = MAS_NONE;
> +		return NULL;
>   	}
>   
>   	return entry;
