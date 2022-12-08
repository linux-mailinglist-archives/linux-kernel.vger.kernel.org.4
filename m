Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DA3646C02
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 10:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiLHJhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 04:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLHJhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 04:37:02 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6FB59FFA
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 01:37:01 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so2950694wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 01:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Wk7+i0C/FWEnPCeIRF23zs5aw223SpiGHR62WUI0pA=;
        b=S/ZRMUYscgN7PwFNXP6eiKHyPpzRzt/H+F6Y0JzP8DT/XhoxoACVk2xE653w1CIyUP
         6jWQIEa3zfyqh1Sh8XZ3brRt/eXLpja3ZSgaEJXbXqPX2YFnBFr8opdXue+TBRZZ8XYl
         HWK6KXOJ3yzrG/Tffknu7bxi2KxPP4L8OZURZmnJ+ckl8PL2W2ObwuBs52NLq7uhV7u4
         eYC7f0sMBtTlkhrXKKq5zeSW58yUGmjVL/ZEbysMpRf4Ivf37TmROB0pu682pqpMJvta
         0Tpm0vWohE0VYrc80MCFOOJwDWvmbBxNSNwd3tOpOvSVJhT/HxgQKGsBU1P6Tm+vmC/P
         Fm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Wk7+i0C/FWEnPCeIRF23zs5aw223SpiGHR62WUI0pA=;
        b=msYeQf/BlVtuCurJfrF985IHfejkkjM7WsbFpEuQ2U+rqW/qpE4IARQmaVvFcZlE5a
         WLxxOMijK9EiWlNSH75HDY7hSohfu+nZwqYRbT2lBebn0LkSX/t9jHy9q+l4ogstvuzH
         kDYmIPmH+JrlBqep9Zf5CdC/oAcQMPSNErhygxefRZ9jiLHwOxWHF7oMwSZv4On/gpNw
         qCROvYvOH8Tm9uVmoRDMEUyUKYoSWjvXLN4nKatJVaa3PEFjgw5NsBmtxh6ISc73gNOH
         M7YPmok+j+OKvZ21e9rQJ0CyPExf/4bx5P3PZbK5DF3oR1eXzg09I1V62wSbJhwJCQIw
         vrOQ==
X-Gm-Message-State: ANoB5pm3eOeKFQE8VyMcJDiu76ir2tBUaHxC51k6So9lbpJS4vCglP9C
        iBg74aVvWdECVbmnOJ7eBL9hnC37Y71CTEyp
X-Google-Smtp-Source: AA0mqf7nPhTl/OBwrtfB1SU92fVjJcQqVpKX6rUXLGgxV8LV9fXuR+r2CN5Zmpws7gZEiGUzMiB+pA==
X-Received: by 2002:a7b:ce0e:0:b0:3d1:cae5:efe9 with SMTP id m14-20020a7bce0e000000b003d1cae5efe9mr11693567wmc.158.1670492220314;
        Thu, 08 Dec 2022 01:37:00 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k10-20020a056000004a00b002365730eae8sm21772828wrx.55.2022.12.08.01.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 01:36:59 -0800 (PST)
Date:   Thu, 8 Dec 2022 12:36:56 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Matt Jan <zoo868e@gmail.com>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 2/3] staging: vme_user: replace 'unsigned' with 'unsigned
 int'
Message-ID: <Y5GwOELXuuGDPilx@kadam>
References: <20221208091117.GA95220@zoo868e>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208091117.GA95220@zoo868e>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 05:11:17PM +0800, Matt Jan wrote:
> Update the bare use of "unsigned" to the preferred "unsigned int".
> 
> Signed-off-by: Matt Jan <zoo868e@gmail.com>
> ---
>  drivers/staging/vme_user/vme_bridge.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vme_user/vme_bridge.h b/drivers/staging/vme_user/vme_bridge.h
> index e17a8f7de165..9a127f6fefca 100644
> --- a/drivers/staging/vme_user/vme_bridge.h
> +++ b/drivers/staging/vme_user/vme_bridge.h
> @@ -84,7 +84,7 @@ struct vme_error_handler {
>  	unsigned long long end;		/* End of error window */
>  	unsigned long long first_error;	/* Address of the first error */
>  	u32 aspace;			/* Address space of error window*/
> -	unsigned num_errors;		/* Number of errors */
> +	unsigned int num_errors;		/* Number of errors */

Now the comment is not aligned correctly.

regards,
dan carpenter

