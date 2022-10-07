Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1D95F7E51
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiJGTvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiJGTvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:51:40 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AB2100BED
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 12:51:38 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id y20so3437035qtv.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 12:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfmHuIlDWKa5mG08nVjaMjmVIP8WKHfTsOECxye4kns=;
        b=J+Ngm/hE8MvzHlhFqIDp3/VKr/DF2b3mtIe/2DdeYgrAt0zBTNWkewbTYkZvPdG8Di
         wYXvHLpcrIErjA5wMTNih6QE5uz7GvWMW6S852fItN/eeTQaNyhpZBJeLNNQFnipI6vX
         DQQtgSOXPOGaeOyT8fj1/dgLcIsyEmviwG+dnQcIdO+5oL0sKHikmits0hCMReHzCUo3
         D2LV5P7wNTfv5L2IpkxnZR/GaL6wlFCcXXakjUPSELQeU4Cwx6T/EHSqLEytoWTmfAsm
         dP1S+5EueRgvBUwY9a3Fyunvu7NoxFAJx4VrJThW7jvC/ZE218CDUc0jjlBvcF2DQtbg
         kYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jfmHuIlDWKa5mG08nVjaMjmVIP8WKHfTsOECxye4kns=;
        b=kx9seKWcVRX7F0h+9JJfKmO4Snup3crM13HQhQKEEz0wMJc4orRGqiOuQqoYw688z8
         w5WqOJNHYTjHJ6dfWaKIozb9KYfehT3fXSb8ARBjneWTYU+UIVrWBCzXuXDma88PZeXp
         AdQSFy4rbLEvSnB/AyRsTPAzCuNmPYjQTshPyH/2ACU57P/zC+Yi5+oulvQS87CAgVLU
         hJxgV6Zw9EKrUW0kWgRry0cSiPzWBUKapH7v/AnUxAYHGrkPEmNbz16xC2HAG8B6qjYv
         tZ7stsfC+uDV7tzKNwShYeZ9rE8K3tUs/K+PHpULitQUivGy4s/LoxFEhjbR+q0O3npB
         J0MA==
X-Gm-Message-State: ACrzQf3s0cTe87gQXUzPYzULJ48KLjHKaVrT/jHLwPb3Nvd3fVRlIn6Z
        vD5xLQ3ldmM0goSOAmVX2w==
X-Google-Smtp-Source: AMsMyM5iSQcpjYhWMuvfOhMPYc7VVRGMD60zH8p0g/k1Z40oRw90aen9/3sgpgjgVNSIf2rZU5t+Ow==
X-Received: by 2002:ac8:5e4f:0:b0:388:532a:373c with SMTP id i15-20020ac85e4f000000b00388532a373cmr5845468qtx.90.1665172297120;
        Fri, 07 Oct 2022 12:51:37 -0700 (PDT)
Received: from serve.minyard.net ([47.184.185.126])
        by smtp.gmail.com with ESMTPSA id j4-20020a05620a410400b006a6ab259261sm2944160qko.29.2022.10.07.12.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 12:51:36 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:fa3f:9b5b:700:c1ba])
        by serve.minyard.net (Postfix) with ESMTPSA id 1250B1800BD;
        Fri,  7 Oct 2022 19:51:35 +0000 (UTC)
Date:   Fri, 7 Oct 2022 14:51:33 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, qi.zheng@linux.dev
Subject: Re: [PATCH 3/3] ipmi: fix memleak when unload ipmi driver
Message-ID: <Y0CDRS+ppvKTiGml@minyard.net>
Reply-To: minyard@acm.org
References: <20221007092617.87597-1-zhangyuchen.lcr@bytedance.com>
 <20221007092617.87597-4-zhangyuchen.lcr@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221007092617.87597-4-zhangyuchen.lcr@bytedance.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 05:26:17PM +0800, Zhang Yuchen wrote:
> After the IPMI disconnect problem, the memory kept rising and we tried
> to unload the driver to free the memory. However, only part of the
> free memory is recovered after the driver is uninstalled. Using
> ebpf to hook free functions, we find that neither ipmi_user nor
> ipmi_smi_msg is free, only ipmi_recv_msg is free.
> 
> We find that the deliver_smi_err_response call in clean_smi_msgs does
> the destroy processing on each message from the xmit_msg queue without
> checking the return value and free ipmi_smi_msg.
> 
> deliver_smi_err_response is called only at this location. Adding the
> free handling has no effect.
> 
> To verify, try using ebpf to trace the free function.
> 
>   $ bpftrace -e 'kretprobe:ipmi_alloc_recv_msg {printf("alloc rcv
>       %p\n",retval);} kprobe:free_recv_msg {printf("free recv %p\n",
>       arg0)} kretprobe:ipmi_alloc_smi_msg {printf("alloc smi %p\n",
>         retval);} kprobe:free_smi_msg {printf("free smi  %p\n",arg0)}'
> 
> Signed-off-by: Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index c8a3b208f923..7a7534046b5b 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -3710,12 +3710,15 @@ static void deliver_smi_err_response(struct ipmi_smi *intf,
>  				     struct ipmi_smi_msg *msg,
>  				     unsigned char err)
>  {
> +	int rv;
>  	msg->rsp[0] = msg->data[0] | 4;
>  	msg->rsp[1] = msg->data[1];
>  	msg->rsp[2] = err;
>  	msg->rsp_size = 3;
>  	/* It's an error, so it will never requeue, no need to check return. */

The above comment is wrong, but yes, this is correct.  I'll queue this
and remove the comment.

Thanks,

-corey

> -	handle_one_recv_msg(intf, msg);
> +	rv = handle_one_recv_msg(intf, msg);
> +	if (rv == 0)
> +		ipmi_free_smi_msg(msg);
>  }
>  
>  static void cleanup_smi_msgs(struct ipmi_smi *intf)
> -- 
> 2.30.2
> 
