Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CF06D352F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 03:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjDBBqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 21:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDBBqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 21:46:31 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1186BDBE6;
        Sat,  1 Apr 2023 18:46:30 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso27258717pjb.3;
        Sat, 01 Apr 2023 18:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680399989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Bb8e+yvqbOsaU3lAGqJyEfpetYx3Zam8q/Ik/zjoW0=;
        b=XNvF/LzfVH1AX+2s5DHymZ+Fv+4BPpj48mrxKGgWLnyJB+5xxmP/iVG5W6NXRkqufF
         iYTNCXGFg/W6f/N1sgRe0dtXFxyOgkcABZRBl9aFpE6dsGUJ0Ivdkl8QAFxlK+K6lzqW
         YInuQr5TsqV7mA3lEkk2/cBe3Rx/OJku9wJ42d2s5I+5bh75YN/AVuqpDnvzsDK2Y4Fd
         Jrq/7MNOvEVLwGieXyArtXyXK6iuv1dQ4JYMbF9f+MrSzZFNNj/ICvdv1JKmVmhZnhK0
         +tUIOPD/gOkIIGhxa37ea2NPDR0HnDiR+2ilanUs/dYv5WXDOIM7TrIOcywW6/qMtoBH
         +pOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680399989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Bb8e+yvqbOsaU3lAGqJyEfpetYx3Zam8q/Ik/zjoW0=;
        b=N8+UQAWivC05OkFO8sr4wWmIYI5UZmzu09pzGu5H+Z3qDaaWtG4RXoryUWU5dL3FeS
         16+oc06w8rRKBcdEbbnXvZdJUwZYob1hX0b4C1eRA+zkv92UET8o9gsrJ8N7NMw5Qvzf
         URFpITuJFv0VpnQ4cyM8iwaREyka7dxRkcCPFXN9drHOJwwtZD9RRcWwV6tCrNIHd+1J
         X1vu2rh8fROmiQaoTnH5vHO7kDGTK5xqVLU3aurg0TEfWAbIodCzYTJ0wopBWsO8XkTD
         RqGc1MYESjXpPNUIdQLyxrW0vP6T500mm1tCzch8MeZTWssjWHrzXX9lhXJl4InpZZL8
         K8yA==
X-Gm-Message-State: AAQBX9cobwjUH7qa4Ba+TqgF23dl0R2nqWUH5u7AZjaryrTZeH9wHXCZ
        AoV+upUHAcU6W6Cx9JJ1OVg=
X-Google-Smtp-Source: AKy350aJ6H/Yx3AC2upO019FO/x1hb8yP7V8EQkhbobcviHgBAb/tn32j+OqQk2fXLezOuEWtu9OXw==
X-Received: by 2002:a17:90b:4a02:b0:234:ba34:71bf with SMTP id kk2-20020a17090b4a0200b00234ba3471bfmr36096554pjb.1.1680399989417;
        Sat, 01 Apr 2023 18:46:29 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:ac04:c59e:2de:5791])
        by smtp.gmail.com with ESMTPSA id s17-20020a17090a881100b002372106a5casm3717345pjn.44.2023.04.01.18.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 18:46:28 -0700 (PDT)
Date:   Sat, 1 Apr 2023 18:46:25 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] Input: cma3000_d0x - Clean up some inconsistent indenting
Message-ID: <ZCjecTFJKnsiwJmT@google.com>
References: <20230322064158.4043-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322064158.4043-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiapeng,

On Wed, Mar 22, 2023 at 02:41:58PM +0800, Jiapeng Chong wrote:
> No functional modification involved.
> 
> drivers/input/misc/cma3000_d0x.c:328 cma3000_init() warn: inconsistent indenting.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4588
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/input/misc/cma3000_d0x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/cma3000_d0x.c b/drivers/input/misc/cma3000_d0x.c
> index e6feb73bb52b..c444a44e4576 100644
> --- a/drivers/input/misc/cma3000_d0x.c
> +++ b/drivers/input/misc/cma3000_d0x.c
> @@ -325,7 +325,7 @@ struct cma3000_accl_data *cma3000_init(struct device *dev, int irq,
>  	input_dev->open = cma3000_open;
>  	input_dev->close = cma3000_close;
>  
> -	 __set_bit(EV_ABS, input_dev->evbit);
> +	__set_bit(EV_ABS, input_dev->evbit);

We should simply remove this, as input_set_abs_params() will set EV_ABS
bit for us.

>  
>  	input_set_abs_params(input_dev, ABS_X,
>  			-data->g_range, data->g_range, pdata->fuzz_x, 0);
> -- 
> 2.20.1.7.g153144c
> 

Thanks.

-- 
Dmitry
