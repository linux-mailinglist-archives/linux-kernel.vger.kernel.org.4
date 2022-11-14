Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61A36275E8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 07:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235734AbiKNG2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 01:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiKNG15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 01:27:57 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E65915A2C
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 22:27:56 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id gw22so9481507pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 22:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edVKh9Op+O4fbx8c27lNfz7OBMxqDGoh5epwUTDxhyg=;
        b=jKL0WGoXUwEiirLo+Dnof9voFYs23D+s69KhG5nPSzZOYKLhVOwH4J4sbxckodK/yf
         E1DUeGKuuoUbbGbaB4BbMtpUNiEzpHE1zxmF44kdJvI8OHoGq6irVju0QpFAIKd7B4Ig
         8HIBCbN5+DxSLG+bHad9ED/ixor09mniNTjSgTvNapGsrMx6+O9X7aOK2NU8E/Da5P+f
         IQZvCYH7z1znuE4N/9y6RdHBnbeXLLdlNYJxxU8gCtYesYfUXonGAgasbb8oNINc9pn9
         xqpPrUAEITwblifMJwOQCigc6cg88UT/kkL91SxCQ5afDrUjZG3SSIqMYgqNgQfBhCHX
         p6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=edVKh9Op+O4fbx8c27lNfz7OBMxqDGoh5epwUTDxhyg=;
        b=TUCn+MUuBS2yydaOmruKh9P7t+RuQKiv7/p9wYnrEawypGFSJcOFBb0XV5eZsr/Q1x
         SOwklrtPofUBEVJjmbRwCwUs/yxkjVCC2TEdKl0RXmhHWAJpCoJ+258A+vHm+cfIqeoB
         dssVDtPRkMZAel4FbV0mKEPANye347vUtFdINVHQbEFABG9RBNfgh10AoIjKwZp4LmQv
         Lgv+Qfu35O+Gk5CEgXMdGk+iOpWJVxHtpx6+zYbqISqfvq5USG33Wo4p2K54oZZMKmuJ
         eqBIGkeuDeEIK1FAB9O9yztByB/0jYbNxBP5RiqGmv/Oie6dy843GHd1bZ61Bx+nVPu6
         /DXg==
X-Gm-Message-State: ANoB5plEO2zWuUYjXP1eRkSqTovNnwpruyKn4+N/V1skNqR9QL/1tg+z
        FDAK1Vh5Lg0pf6Q8xOO/fkLmIvlx66gySQ==
X-Google-Smtp-Source: AA0mqf5768TcOEMO7+Om05LJlg6f4J3HdY9G9/SPzBsI0FrUJ+HWeZl2jdWwlgsaS3L8UZVuQ5ozNA==
X-Received: by 2002:a17:902:f78f:b0:188:a793:4127 with SMTP id q15-20020a170902f78f00b00188a7934127mr12503360pln.135.1668407275773;
        Sun, 13 Nov 2022 22:27:55 -0800 (PST)
Received: from [10.3.156.122] ([63.216.146.190])
        by smtp.gmail.com with ESMTPSA id 23-20020a621617000000b0056b6a22d6c9sm5781388pfw.212.2022.11.13.22.27.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Nov 2022 22:27:55 -0800 (PST)
Message-ID: <1bcb11ad-e2e0-6c0d-659e-1b20b6b99fb1@bytedance.com>
Date:   Mon, 14 Nov 2022 14:27:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [Phishing Risk] [External] [PATCH] erofs: fix missing xas_retry()
 in fscache mode
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, yinxin.x@bytedance.com,
        linux-erofs@lists.ozlabs.org
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org
References: <20221111090813.72068-1-jefflexu@linux.alibaba.com>
From:   Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <20221111090813.72068-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/11/11 17:08, Jingbo Xu 写道:
> The xarray iteration only holds RCU and thus may encounter
> XA_RETRY_ENTRY if there's process modifying the xarray concurrently.
> This will cause oops when referring to the invalid entry.
> 
> Fix this by adding the missing xas_retry(), which will make the
> iteration wind back to the root node if XA_RETRY_ENTRY is encountered.
> 
> Fixes: d435d53228dd ("erofs: change to use asynchronous io for fscache readpage/readahead")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
> ---
>   fs/erofs/fscache.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index fe05bc51f9f2..458c1c70ef30 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -75,11 +75,15 @@ static void erofs_fscache_rreq_unlock_folios(struct netfs_io_request *rreq)
>   
>   	rcu_read_lock();
>   	xas_for_each(&xas, folio, last_page) {
> -		unsigned int pgpos =
> -			(folio_index(folio) - start_page) * PAGE_SIZE;
> -		unsigned int pgend = pgpos + folio_size(folio);
> +		unsigned int pgpos, pgend;
>   		bool pg_failed = false;
>   
> +		if (xas_retry(&xas, folio))
> +			continue;
> +
> +		pgpos = (folio_index(folio) - start_page) * PAGE_SIZE;
> +		pgend = pgpos + folio_size(folio);
> +
>   		for (;;) {
>   			if (!subreq) {
>   				pg_failed = true;
