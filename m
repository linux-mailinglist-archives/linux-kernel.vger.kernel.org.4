Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A9865651F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 22:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbiLZVWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 16:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbiLZVWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 16:22:16 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2F9BEC
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 13:22:14 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-142b72a728fso13619515fac.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 13:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IzUGFWhYGid1zgVhwB/XIueDra1sXjXvzIRCEZpwkrI=;
        b=euSaQ0XZbdVgujB6+taA3Zgr8jQskPDutHMzIZNA97WokX6Z7EO9/xYaUx1D2kNVwK
         lSSDEUrhxrNtWSyxlVVSvoSOcOx1lYSPzLQN+qOpSqeAU+DmFmW4R15QyFeBEi/S57GO
         QUIni6rbE57chLdwQAr7uYRa53EzabofO/DQvW80dqdqpmYApHJnlo9I7oqR6amoe3Zq
         XdiTuJRYGyLHuzvTgeaSAJVoZD2tXqFmnyTTOily2nt3sTRGFKjpHQ4ehjLyoS6/MOMv
         oAScbZlj16EjFOup0DCzWAMHKtWkwDe9P/B6kvGOEz2lo7g+y6VyGxHgGlgNJBdFC2ZP
         JJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzUGFWhYGid1zgVhwB/XIueDra1sXjXvzIRCEZpwkrI=;
        b=xxpAiZXOg8GP4T0qdXDWfJ65Hf/9LQMK1gWl9cQAm8sqYhZlpgNPz2eAdS0gb6o+y0
         UEBCb+XaTjFVb+eCpk1YyhV8Y520E3te0wICZcQlsnpnaXXspON4To6e7QJbTgv2AVXq
         54fr2xmBteMU61lOkht+C1vygciPM/q/hxuNR04WnzDgzucpjJzQqGGDMECK7vr9mytI
         HPUiQ3+MYMbk6uPNxx/ZXUojjzjwKJi5OhPhK9OYoy/5Z/SCoMUw5A0ZJJ3NucLsnLdX
         skFEzwOSurYcVZ0JQ8jgLbwq9su/DpesO2tfpKB509ZWIQK4EbL5iZdKNupiRq3eLMAx
         xGOA==
X-Gm-Message-State: AFqh2kpUkPF/bwNxqK0ElILrb8PeqxLx2/ucw7xcojCwfjx8zHuGs9j1
        cM6npe11QvxM7V+wywW4FXAqYg==
X-Google-Smtp-Source: AMrXdXsAu/E66CTpcFrq33v8Ys59KpOEu206OI9d1YunRN+n5o3EIqhvqNnmX1gFUU7v828zAuPOuA==
X-Received: by 2002:a05:6870:4b88:b0:148:a7b:15ea with SMTP id lx8-20020a0568704b8800b001480a7b15eamr18066347oab.40.1672089731946;
        Mon, 26 Dec 2022 13:22:11 -0800 (PST)
Received: from eze-laptop ([190.11.62.130])
        by smtp.gmail.com with ESMTPSA id x6-20020a4a97c6000000b004a085ddc771sm4738159ooi.6.2022.12.26.13.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 13:22:10 -0800 (PST)
Date:   Mon, 26 Dec 2022 18:22:05 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Dong Chuanjian <chuanjian@nfschina.com>
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        nicolas.dufresne@collabora.com, sebastian.fricke@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drivers/media/v4l2-core/v4l2-h264 : add detection of
 null pointers
Message-ID: <Y6oQfdveBCZ/EWwI@eze-laptop>
References: <20221226070236.4450-1-chuanjian@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221226070236.4450-1-chuanjian@nfschina.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 26, 2022 at 03:02:36PM +0800, Dong Chuanjian wrote:
> When the pointer variable is judged to be null, null is returned
> directly.
> 
> Signed-off-by: Dong Chuanjian <chuanjian@nfschina.com>
> ---
>  v2: Directly return when pointer allocation fails.
> 
> diff --git a/drivers/media/v4l2-core/v4l2-h264.c b/drivers/media/v4l2-core/v4l2-h264.c
> index 72bd64f65198..0e7b35ae3e94 100644
> --- a/drivers/media/v4l2-core/v4l2-h264.c
> +++ b/drivers/media/v4l2-core/v4l2-h264.c
> @@ -343,6 +343,8 @@ static const char *format_ref_list_b(const struct v4l2_h264_reflist_builder *bui
>  	int n = 0, i;
>  
>  	*out_str = kmalloc(tmp_str_size, GFP_KERNEL);
> +	if (*out_str == NULL)
> +		return NULL;
>  

format_ref_list_p has the same issue.

>  	n += snprintf(*out_str + n, tmp_str_size - n, "|");
>  
> @@ -356,7 +358,6 @@ static const char *format_ref_list_b(const struct v4l2_h264_reflist_builder *bui
>  			       longterm ? 'l' : 's',
>  			       ref_type_to_char(reflist[i].fields));
>  	}
> -

Avoid spurious changes.

>  	return *out_str;
>  }
>  
> -- 
> 2.18.2
> 
