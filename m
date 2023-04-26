Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42086EECE5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 06:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239371AbjDZEHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 00:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjDZEHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 00:07:04 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8778410FE
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 21:07:02 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-63b5c4c769aso8544138b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 21:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682482022; x=1685074022;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gze4HRwVJ4Vf3cIE27SdvNKePaqdVml5/K3XVwc++08=;
        b=kVMkIoM9vHxXoqqTn0Pkpo8cvgaOpwmRogFt+eyNcYMIfAXLjY8rcGv2RaG0kvL9+4
         ma9BTcdYWRYy7bMMxgOhTYU0u2n5jZYM91YS9tK7NOCoiYKSOtud9FVhxvKoY8Ui2CJf
         3NS5d7EPoMLYA/E/ZDqvI5to9Je43HIw+jPp4O2oVSCi7HRHGUXt2Iv8jh/KzCgJnFBB
         u0nNLlG8FwWIjC5iz1ZCoPP/knN2o/lVokfmx6jlc+kFVfUCFybuz3MOgdm13lyl7CrC
         BVjJ05PMa5T7fphRV4y59Pj1eu97np/FIRb8SOjTjPk1anDaH8nnzdZcobz0kVApnHrc
         F/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682482022; x=1685074022;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gze4HRwVJ4Vf3cIE27SdvNKePaqdVml5/K3XVwc++08=;
        b=C29Wgae3y23M2FgpugWwKohn23uf6KtLv5R4I9tzeEJLj8ky0VI87Bxqge2kc3kJaf
         C385aN7C8lHFUAHTaJxlNO3KlObToOE+w02GLNMabv4tJWlA5iiWuD5Oguy7tfsal0JO
         bmttKTBY0I2bP8bfNGTgCRT7Gp5oA9t7mR+ONhku7xXY6ZSah8YvIvEdVG1NEcmYXMRe
         yzwGqGIoj69m7dJkTz/qzJMGUaGfJegXexWCWuqXadMHH0sHDR8HWKW5kAOxPkxAPac0
         s9VO7RyPDWi+XPhqZgA1SpwBMK2pRm4YqVzPRYtSYr7+Sw3ZixCmQHdo9hVQYLLcjy9a
         y+TA==
X-Gm-Message-State: AAQBX9exVzfOJf/BNJwk4feOLS+Q7odP7SOgEPvxb/J8YCehicz0pKoC
        iAtLKxWDEVxrD5FUXsfxsBw=
X-Google-Smtp-Source: AKy350YBWiwpnir4ymwvk/sdSgW7SVTB/EYSfKSecg93G943wRMlQZbG+0jnhk01PWLdG6Aa4j24TA==
X-Received: by 2002:a05:6a20:12c5:b0:f3:256:24d3 with SMTP id v5-20020a056a2012c500b000f3025624d3mr18911672pzg.11.1682482021970;
        Tue, 25 Apr 2023 21:07:01 -0700 (PDT)
Received: from [10.200.11.252] ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id t23-20020a6564d7000000b00524dde7231dsm6823197pgv.9.2023.04.25.21.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 21:07:01 -0700 (PDT)
Message-ID: <e0f268f7-d939-8732-af47-a9cd01025afe@gmail.com>
Date:   Wed, 26 Apr 2023 12:06:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH 01/34] maple_tree: Fix static analyser cppcheck issue
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        David Binderman <dcb314@hotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
 <20230425140955.3834476-2-Liam.Howlett@oracle.com>
From:   Peng Zhang <perlyzhang@gmail.com>
In-Reply-To: <20230425140955.3834476-2-Liam.Howlett@oracle.com>
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
> Static analyser of the maple tree code noticed that the split variable
> is being used to dereference into an array prior to checking the
> variable itself.  Fix this issue by changing the order of the statement
> to check the variable first.
>
> Reported-by: David Binderman <dcb314@hotmail.com>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Reviewed-by: Peng Zhang<zhangpeng.00@bytedance.com>

> ---
>   lib/maple_tree.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 110a36479dced..9cf4fca42310c 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -1943,8 +1943,9 @@ static inline int mab_calc_split(struct ma_state *mas,
>   		 * causes one node to be deficient.
>   		 * NOTE: mt_min_slots is 1 based, b_end and split are zero.
>   		 */
> -		while (((bn->pivot[split] - min) < slot_count - 1) &&
> -		       (split < slot_count - 1) && (b_end - split > slot_min))
> +		while ((split < slot_count - 1) &&
> +		       ((bn->pivot[split] - min) < slot_count - 1) &&
> +		       (b_end - split > slot_min))
>   			split++;
>   	}
>   
