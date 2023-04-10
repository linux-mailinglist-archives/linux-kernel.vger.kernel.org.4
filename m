Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBCC6DC553
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 11:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjDJJrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 05:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJJrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 05:47:19 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028D2194
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 02:46:52 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g3so4908938pja.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 02:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681120011;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iXhZnKodLTUc/nB3/7RH8sJdp5VIQv7yGdDQoWkeAAo=;
        b=j/cmmPBHNe1gay8QbALFy+tmMeVONQCUxgAH2i6+aOtIn7IyShW+wW3eERUHjhTZ2a
         yfi9+2WQNTVRIUG4wn7vydcfY6ePK5FSXWYV4xUveYzrGOOko4xZ9VucG9DW0Xs+X0h4
         0dgyhtig8KaVgIpX2y67yFbzqxDXPH/0Q2Nzm4+e1xH8Na17Mji40B0Ox5aKAeDPLzwH
         MhEagoIHVGMGDHobwKByZSQnQlmse26h3CJQqDC/FFaC674PkQw1pNly/r+CMVlijcun
         YuTbpMhUvcNdaRzYXYH58aCb4ve/HmgpFDnwEl1YiBOpnCPyQCuHspwZLKx88mGbIUzg
         OE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681120011;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iXhZnKodLTUc/nB3/7RH8sJdp5VIQv7yGdDQoWkeAAo=;
        b=p9J0atdcig0SDalJnC/797fIjQoJEZo0WNIQHwRejLqI91Wc+6/+xQl9nZbowbe0f7
         Sq7f3IbTUHcCoVU1lLfrfqiR0f1E6TlvtuvBYIlCtLZqUDw+j4OlYmb9sS8Pu7POsyqg
         nsYF8Byk5MoE0qbcRoagg7sMaPaOIUKwNYLkkUrS7oQmUR6xhCBDcfBebsAT0spo35Gv
         A5jiGBLFrgRMmr1d6erffxSYOAJy9SJIl+DJVdk+pSmniTjpncsM50SGj/cDI9kjAsPT
         MDMXrFhCgD54VmgS7hifaP76jc19gEyapcLrL8j4FMAErQazJ0O2KfRwDWlkxJqgwwBF
         1IjQ==
X-Gm-Message-State: AAQBX9cee9EQRv4r1vViTfjPwFuLdNa/0HfqUbbLmVvRJIP+DfXM/jx/
        OPHrlGlMZg72l4Mu8fJY6qKUKZGzkaTaajZKpyuU+A==
X-Google-Smtp-Source: AKy350Y8zzmAIGxu/G3CFKW3fTvY5ItJNi92RKW8sJGkQ4BmZWPgyZ5eY54N4Pk4XPYMPowRfYigNw==
X-Received: by 2002:a05:6a20:ba90:b0:db:9726:8e46 with SMTP id fb16-20020a056a20ba9000b000db97268e46mr6532199pzb.54.1681120011450;
        Mon, 10 Apr 2023 02:46:51 -0700 (PDT)
Received: from [10.2.117.253] ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id n188-20020a6340c5000000b0050bc03741ffsm6693968pga.84.2023.04.10.02.46.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 02:46:51 -0700 (PDT)
Message-ID: <8b5af22d-1612-a2a0-02da-728f1fd57bf1@bytedance.com>
Date:   Mon, 10 Apr 2023 17:46:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] maple_tree: Use correct variable type in sizeof
Content-Language: en-US
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        David Binderman <dcb314@hotmail.com>
References: <20230410091431.74961-1-zhangpeng.00@bytedance.com>
From:   Gang Li <ligang.bdlg@bytedance.com>
In-Reply-To: <20230410091431.74961-1-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/10 17:14, Peng Zhang wrote:
> The original code is:
> 	memset(pivs + tmp, 0, sizeof(unsigned long *) * (max_p - tmp));
> 
> The type of variable pointed to by pivs is unsigned long, but the type
> used in sizeof is a pointer type. Change it to unsigned long.
> 

Maybe add a fix tag?

Fixes: 54a611b60590 ("Maple Tree: add new data structure")

> Suggested-by: David Binderman <dcb314@hotmail.com>
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>   lib/maple_tree.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 88c44f6d6cee..b06fc5f19b31 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -3255,7 +3255,7 @@ static inline void mas_destroy_rebalance(struct ma_state *mas, unsigned char end
>   
>   		if (tmp < max_p)
>   			memset(pivs + tmp, 0,
> -			       sizeof(unsigned long *) * (max_p - tmp));
> +			       sizeof(unsigned long) * (max_p - tmp));
>   
>   		if (tmp < mt_slots[mt])
>   			memset(slots + tmp, 0, sizeof(void *) * (max_s - tmp));
