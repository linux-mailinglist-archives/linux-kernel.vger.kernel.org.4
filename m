Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0245F70250D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239998AbjEOGlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238286AbjEOGlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:41:37 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676C910F0
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:41:32 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f4271185daso80389755e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684132891; x=1686724891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4JUV54jxuxM8izW+Nmy6rQqIr/WYQkWVKP15cwdksrA=;
        b=ZVkveGWgomXKeIlwVTMBphGGgTimP7KoAgnn6TYC98GBR/DnLjwjAYhnzwNZUwErpo
         9NLxbZyAsZ721Id6dA8lGXvm9ZZty7hy7ReNT/0SEWkwtRKmmw++jWKmE3Ox3m421YWZ
         ey3gCZyRa0fpZ8EsDVIVS5F0YmjpWuzttOwMdIG2Des4gfjA2b41pNwD9/36fTUm9ABA
         F+TFSQjW0EuiRStiru9w4G3OVLnzP1jj2Sa4P8RT3sd8wm3Qi/xv9r/DGcsQ0W3CAgXU
         eXYI/CD5IrYp5c/BeVHF4V0GAkukRwkcufmAJOAEaTnOHiQtOF0W0i6e5ZwW+GqupTvA
         N7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684132891; x=1686724891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JUV54jxuxM8izW+Nmy6rQqIr/WYQkWVKP15cwdksrA=;
        b=E64w/GVMsSXfokX/5ue7BgP3IoSsTg0asuugERVHnkOpreD1WqfOQVmbrPTgTBe5dr
         hcY0tfxtsPbiWu8PzwE+y1TjVfcqc7T7Jj9MoA+JLQNzq6hY29aPliAZN55y+PLAQgNw
         +8UM9dGdE2UIlsSlniG8/8Gw/rchwSJ0ncQfgGmx/Ex4in0qA6Chly/iTyi0SoOjupp0
         vrrfy83Lp+gDn6AWxWGVyDTnbSwHvmfR7CBCba7RfwK65rNwLL9QSYIuHtqI+ajv5spH
         9r9l0zJz5Dq6/9UoE2iccFLygifJOEjB+mbXJyfqdRFKfZNl/n9puGxDTQ9TEwTLs05f
         JnWA==
X-Gm-Message-State: AC+VfDyg3bcyphm1ds7nakHqLoVvC5YjrIkff71ZhoJAymjmbxV5NsUq
        igfpVaat5h4SV6u1AAuKKEnMsQ==
X-Google-Smtp-Source: ACHHUZ5QccdWX15ir5CHShRduqKeviU8fkV9rD4pasaLI5GVhsdy/9fKc7RdjErEbgvhePQDsLWlSA==
X-Received: by 2002:a1c:f204:0:b0:3f3:f7f0:2203 with SMTP id s4-20020a1cf204000000b003f3f7f02203mr21849565wmc.12.1684132889995;
        Sun, 14 May 2023 23:41:29 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id e26-20020a05600c219a00b003f50d6ee334sm961890wme.47.2023.05.14.23.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 23:41:28 -0700 (PDT)
Date:   Mon, 15 May 2023 09:41:18 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Deepanshu Kartikey <kartikey406@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: rts5208 :rtsx : fixed  a brace coding style
 issue
Message-ID: <0ef95ba5-e001-4dec-a834-cb81a9b35ec8@kili.mountain>
References: <20230514030940.4820-1-kartikey406@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230514030940.4820-1-kartikey406@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2023 at 08:39:40AM +0530, Deepanshu Kartikey wrote:
> Fixed  a coding style issue
> 
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  drivers/staging/rts5208/rtsx.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
> index 2284a96abcff..0ab9355873f7 100644
> --- a/drivers/staging/rts5208/rtsx.c
> +++ b/drivers/staging/rts5208/rtsx.c
> @@ -399,10 +399,8 @@ static int rtsx_control_thread(void *__dev)
>  				chip->srb->device->id,
>  				(u8)chip->srb->device->lun);
>  			chip->srb->result = DID_BAD_TARGET << 16;
> -		}
> -
> -		/* we've got a command, let's do it! */
> -		else {
> +		} else {
> +			//we've got a command, let's do it!

Don't change the comment style for no reason.  Try to be consistent with
the rest of the file.

regards,
dan carpenter

