Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124316DC589
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 12:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjDJKJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 06:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjDJKJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 06:09:34 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA55F91
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 03:09:32 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id bp17-20020a17090b0c1100b0023f187954acso4016335pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 03:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681121372; x=1683713372;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QEmp0lSStdbKqWXzl5gxerQ4TIQzHhey9TWvVEc/6IA=;
        b=XXgX32mn4y+8njkj3RfhVL9iUkpop22zBOAemvpTl1D/M/SvoWnZLa/htOwBP3cE3J
         JtjpkY9BXgW19HXfsUuSwDz5uBU5y9nVX+MMNQleYPiSXHIVjz48x7Dz/aoOxD+coEyI
         8k82sJGjvfJ4wOBlSA+3HIcPiPJW/Bqnqqq0OA2pojrTf603mZwC5tUVeeVTNAlBQDqI
         cgPskiC8ffHVJWQZFKclVVl+2HmjYXGXkD9DnwZwmQWoU48qJAad2V+y18HAzdm2x0wB
         fsa8zOA2YkRtcrHHJJKT6yw86oqbqmI0/gTlxIHUVQOzPWvcwozPev3dIZ33KXrQeR2U
         Alvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681121372; x=1683713372;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QEmp0lSStdbKqWXzl5gxerQ4TIQzHhey9TWvVEc/6IA=;
        b=yxk21Uba7M3pSmK1KHbCBl2mmKHLbC5Wlc+1q2awNDZnZ1eE/2Phvus5FMaIlFVot7
         wDUjJuiZ4rEjUryfrXoyxlcv1mMCqiURYsjYnaVM7Rp0OgGx0wQwt0f6FZDedQ3aoqIZ
         h/ltroF5/0cLBVYO48waKuPLNKyh69XnOrwtMpse/Q0XmFcwi65hpGJIlzS3S3ly0ear
         FvhtKYJOmF0woBytvRWZ0nbR63C9hHsXVrEjrATqqIzozEhhPMNqfX23qr4O2wNf9v0r
         6ivd8M6OXt0ETq7V/XQFwngxbC4DtbFJ0GTNWxVjSwElc7fvvP0EGET1tQ7WVlnanIUv
         5pHQ==
X-Gm-Message-State: AAQBX9e/8GM6V3wtYWEnE3Se5+qm5zkQxlaolfnAxelL29jOSwOifQYH
        OOCVD79wtA7xCJKeeTtVpNEa1g==
X-Google-Smtp-Source: AKy350ZE+bmVNBlLOjagMfR+lJksJjtQKtz2tDfRSz+9IlhY8kqEPosmQe6maztyHrrb+7Y2Uq0BRw==
X-Received: by 2002:a05:6a20:2926:b0:cd:a358:bb7 with SMTP id t38-20020a056a20292600b000cda3580bb7mr9221616pzf.37.1681121372393;
        Mon, 10 Apr 2023 03:09:32 -0700 (PDT)
Received: from [10.200.10.217] ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id s21-20020aa78295000000b0062dc14ee2a7sm7492087pfm.211.2023.04.10.03.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 03:09:31 -0700 (PDT)
Message-ID: <b1ea2c08-8e88-e04f-417b-4cf0daa417b1@bytedance.com>
Date:   Mon, 10 Apr 2023 18:09:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] maple_tree: Use correct variable type in sizeof
To:     Gang Li <ligang.bdlg@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        David Binderman <dcb314@hotmail.com>
References: <20230410091431.74961-1-zhangpeng.00@bytedance.com>
 <8b5af22d-1612-a2a0-02da-728f1fd57bf1@bytedance.com>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <8b5af22d-1612-a2a0-02da-728f1fd57bf1@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/4/10 17:46, Gang Li 写道:
> On 2023/4/10 17:14, Peng Zhang wrote:
>> The original code is:
>>     memset(pivs + tmp, 0, sizeof(unsigned long *) * (max_p - tmp));
>>
>> The type of variable pointed to by pivs is unsigned long, but the type
>> used in sizeof is a pointer type. Change it to unsigned long.
>>
>
> Maybe add a fix tag?
>
> Fixes: 54a611b60590 ("Maple Tree: add new data structure")

Maybe sizeof(void *) is equal to sizeof(unsigned long)
in most architectures, so I don't know if it counts as a fix.

Thanks.

>
>> Suggested-by: David Binderman <dcb314@hotmail.com>
>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>> ---
>>   lib/maple_tree.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> index 88c44f6d6cee..b06fc5f19b31 100644
>> --- a/lib/maple_tree.c
>> +++ b/lib/maple_tree.c
>> @@ -3255,7 +3255,7 @@ static inline void mas_destroy_rebalance(struct 
>> ma_state *mas, unsigned char end
>>             if (tmp < max_p)
>>               memset(pivs + tmp, 0,
>> -                   sizeof(unsigned long *) * (max_p - tmp));
>> +                   sizeof(unsigned long) * (max_p - tmp));
>>             if (tmp < mt_slots[mt])
>>               memset(slots + tmp, 0, sizeof(void *) * (max_s - tmp));
>
