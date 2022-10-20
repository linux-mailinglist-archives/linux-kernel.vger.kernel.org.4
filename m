Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1213C6059DF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiJTIdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJTIdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:33:25 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7862A18C950
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:33:21 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id az22-20020a05600c601600b003c6b72797fdso1624178wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8No91Jlr62TzzqqG4EX/7FEyIOABJR/Luu7N+fsFjr8=;
        b=kMV7arw3FQxfaczzkgEp3/SYzecH/x101eVMQHcCw4jW1if+tUYJ2cI+Vo9kz3g+8L
         vkzqIFVyteWNVErEGTBAkz6qmhPRbW9YphziunO///SmA2vTnR/6uK1cmvvdUveS4y7a
         2S3MEaVtKXnx2ZGYB1CYfEdjUS8j5GapXYCB0j+aHq9On0IoQj4H+cfo2sOCn5HS9phg
         5yHKRAYoZvFNBAZmlfTNHOu8eLY6GUP29tYWImu1pY8Y2vUwyXr5edSq09IisTT+oNZa
         Pkm5jcvV13Nk66NNvz4Zk5lyNcjsny/NEWlDGV0A9qqQCzX7SzQKYgDrtX+Ga/q53StG
         1sWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8No91Jlr62TzzqqG4EX/7FEyIOABJR/Luu7N+fsFjr8=;
        b=lvc+XGEeEpQHZuOqp0hKHXkLG3ACCBcmYT7kV4khor8h5gC2ZctjfPewU1upjWZISZ
         gxu+As5z0vve8K9VSCPavWQmng7u1OVdqLmXyVXPb6N5toYPBWGGY6qth4Xvrs7Cnrzz
         4ysPia5Z/5ELFH6LXxQCB4Vo2s0X5zQrTthTFshNAlQYm69xORbz3msvWpxDzzV+6w02
         gqNYjz4y3jUknW1o60q+ZdAvtW2dYms3rUzgl7O4YTApjw0+mRXdIGR6FTOajdOxKwi1
         f7azYjId1qrql6tmpqb72ejGTClzOBvhaCIHguVhqWwwN4AcY9gb7CLTO/xchB+kWp26
         MkLA==
X-Gm-Message-State: ACrzQf1V4mFj2Y44Areh/2YB/vbXJ/HRg/SNZN+evMOh99sL7UR7Cz0q
        C7zDYmNJwb8wxdRm1xc7nS2B0NG73mip3g==
X-Google-Smtp-Source: AMsMyM7xtCUDicS9AVRBxr/kOxnNo2jMiXOXtCv0qEiWNiYI4Stm+Ybr63U8IdF3BiFuBmhqGs5E6w==
X-Received: by 2002:a05:600c:314f:b0:3c6:f3fa:cfec with SMTP id h15-20020a05600c314f00b003c6f3facfecmr14834261wmo.68.1666254799058;
        Thu, 20 Oct 2022 01:33:19 -0700 (PDT)
Received: from localhost ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id p10-20020a05600c358a00b003bdd2add8fcsm2253725wmq.24.2022.10.20.01.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 01:33:18 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     wangjianli <wangjianli@cdjrlc.com>, dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: Re: [PATCH] input/serio: fix typo in comments
In-Reply-To: <20221019123049.26196-1-wangjianli@cdjrlc.com>
References: <20221019123049.26196-1-wangjianli@cdjrlc.com>
Date:   Thu, 20 Oct 2022 10:33:17 +0200
Message-ID: <87wn8u99o2.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 20:30, wangjianli <wangjianli@cdjrlc.com> wrote:

> Delete the redundant word 'in', and add a word it.
>
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/input/serio/q40kbd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/serio/q40kbd.c b/drivers/input/serio/q40kbd.c
> index bd248398556a..ebc9f9941be0 100644
> --- a/drivers/input/serio/q40kbd.c
> +++ b/drivers/input/serio/q40kbd.c
> @@ -81,7 +81,7 @@ static void q40kbd_stop(void)
>  
>  /*
>   * q40kbd_open() is called when a port is open by the higher layer.
> - * It allocates the interrupt and enables in in the chip.
> + * It allocates the interrupt and enables it in the chip.
>   */
>  
>  static int q40kbd_open(struct serio *port)
> -- 
> 2.36.1
