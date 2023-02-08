Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4744468EAA9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjBHJKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjBHJJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:09:47 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A233945F53
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 01:09:27 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id h15so11179020plk.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 01:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTV4gmWFsvat4BGmFQV2nTb2oNRlilhLC12DwTs3rMo=;
        b=HdDnyFzCdX/POmTgcWzRB6xYWvOQdJ7jQbuOwHOWb7iA0vXra2vQRXnkpWR7z2t74Y
         3Zlaha7FPUZQzGF1xBnNBLJH1uc8TPYD7QB48uBMKXo7NL+XQXEsG2K6wrfyIQzfAR7t
         07bgf+DxynKVD3VkeejffIxjmSs2YZmKFtrA0fm41Og9e5f5X/jypxaFAkw2D9v1+Llc
         0zJZGPhm87mHWA1VKyDzXW5rb+AaJU22sOiIMWDURxxiIH4krbnrAthQ2qayGgreXpeq
         k6LaIsrlE8trPEJueZFjVCGGwq4j5uSDym0u/3tnpH5GG6rlIWLUzq4vA2Uza31GgN1H
         YDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DTV4gmWFsvat4BGmFQV2nTb2oNRlilhLC12DwTs3rMo=;
        b=dUJxSj8BfDtN6c5PvRCkbw+RotGBewjPEQbu9cjIQ3MwOJKWLCIn0lBwS+qPnRC0hE
         PeMk2SZ3OqtbpvN8Jy5gMwsXaaVnwuY1UAVPhKrU8mZahu80Nhl+DRAZ4QYz7ykx85wC
         y1o0fv21/tF+hb9IHTaHZHQdyY/eg6OEunvPJoly7mHtQL386NYjHdH6epuzVAqfokhd
         zz8FjzUObvNiOLny7KVKr2/AuyrZWeJBBW+aknIAS1BxodSKD0ZzmMd7lFXw4/9tqyI4
         BftUcuUChNlK413clF++EqLeRIbGHsJzRPgdEATy49O/wxTsn47rbn6khohCWVco+9t1
         yNPw==
X-Gm-Message-State: AO0yUKVEes3vSFL9EvW459g3R6daS80vqdiVQuA/AHhh/eLQy0FfsZtd
        ToMdoHXB1xVlDtXPwm27JgvMM9rUEiuqmwQe
X-Google-Smtp-Source: AK7set8RFe9izhTNSosc9mYm1ynqnJp/Mo8ezAjZeZZbVqMO/Af9xc/RBSZ8Z919OcuG6LH2H9UxHg==
X-Received: by 2002:a17:90b:4f86:b0:22c:4dd3:5c4b with SMTP id qe6-20020a17090b4f8600b0022c4dd35c4bmr8040480pjb.19.1675847367230;
        Wed, 08 Feb 2023 01:09:27 -0800 (PST)
Received: from [10.3.144.50] ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id ne22-20020a17090b375600b00230a3b016fcsm1037996pjb.10.2023.02.08.01.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 01:09:26 -0800 (PST)
Message-ID: <968342d4-3c5a-524e-432e-5c96b3aba827@bytedance.com>
Date:   Wed, 8 Feb 2023 17:09:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [External] [PATCH] erofs: relinquish volume with mutex held
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     huyue2@coolpad.com, linux-kernel@vger.kernel.org,
        zhujia.zj@bytedance.com
References: <cover.1675840368.git.jefflexu@linux.alibaba.com>
 <20230208073206.111814-1-jefflexu@linux.alibaba.com>
From:   Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <20230208073206.111814-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/2/8 15:32, Jingbo Xu 写道:
> Relinquish fscache volume with mutex held.  Otherwise if a new domain is
> registered when the old domain with the same name gets removed from the
> list but not relinquished yet, fscache may complain the collision.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

> ---
>   fs/erofs/fscache.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 8da6e05e9d23..35b2d8b5773e 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -328,8 +328,8 @@ static void erofs_fscache_domain_put(struct erofs_domain *domain)
>   			kern_unmount(erofs_pseudo_mnt);
>   			erofs_pseudo_mnt = NULL;
>   		}
> -		mutex_unlock(&erofs_domain_list_lock);
>   		fscache_relinquish_volume(domain->volume, NULL, false);
> +		mutex_unlock(&erofs_domain_list_lock);
>   		kfree(domain->domain_id);
>   		kfree(domain);
>   		return;
