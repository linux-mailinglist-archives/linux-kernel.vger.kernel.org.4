Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4A660E63E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 19:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbiJZRO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 13:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbiJZROw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 13:14:52 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4778513EA9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 10:14:49 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id y14so23171977ejd.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 10:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FRxHoxm6P1RvhdSeOwNej3/a2XKscd0zPEdZFSfHcAM=;
        b=fz5My3zIF5XGZhEoSzEVFDLGy9W8SAMCYayn36lNzsdTEetRLrOGWRE0KK72DXBjcB
         WF5v1NCWW97wXQx+n5jTNHG6VdRsSmaKekLetVYqPe/vPeFvqdnLslrO9DpFb7U6dCHv
         Tty1PsNwXDbNr3B+mgyJ92nHDEUkhv2fG9hlgKHXVifi91eVXIg22cjnAyAzuJOWxoYW
         6441COwsIGhicA+ZgODplc2V4XGxhdlabztlCGBNOGZITC7tqHhKPYa4z7yeHfXgQpLO
         NjMNHR8fP8lsaTblgYpxxwYbj/y3o/gvZtP0kN32dT5OA4jB+67JYpkZBTMXoysYSONo
         TrNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRxHoxm6P1RvhdSeOwNej3/a2XKscd0zPEdZFSfHcAM=;
        b=UCxIJTwLS6OauznCfB+gYL1c/03YY8+ckAaCR2Zd1sTEMr8pffqnjaO2O4m39t4/eI
         IyWUaWYedwZjUD/ffyil3L6Ie2I+K1BT/QZk/ury67RDCkAYucEMdbgaOerjAAD02Uz8
         taROcp0ZRoElNNLIDRY8QrIvHMXpU/gI6UGq+zAu7ysTdlDakUbGCOYOOtkRnoztl41J
         ECuHMHGWzlEMeg0WmaXvPdJ21x+SJIbn1WNWqRZ/HObIipskCwZ8Z2wO+U+u+V1KJ80A
         lPEZEmnhNMNDq6qTOIobIpGlV0re0ECAtc/E+5Fra0la+dYv/FFzKehn83VclOtQDdmh
         oLtQ==
X-Gm-Message-State: ACrzQf00KSRTCC3q+PKJnF+XfzXKeZOPEDhE3fe5XFyNQJ7f+Ten2w08
        pSlTx0oiBoKDcOtdcAfsGdg=
X-Google-Smtp-Source: AMsMyM6TgIXHjE8NpfTm6poMbr7co6qgf/WZMc46uMXEicr4AWS5WGVgfcxr6lLz/y58qzTitxtKZw==
X-Received: by 2002:a17:907:7633:b0:7ad:85ee:c66d with SMTP id jy19-20020a170907763300b007ad85eec66dmr1477367ejc.730.1666804487769;
        Wed, 26 Oct 2022 10:14:47 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-178.ip.prioritytelecom.net. [217.105.46.178])
        by smtp.gmail.com with ESMTPSA id b16-20020aa7cd10000000b00461bacee867sm3796683edw.25.2022.10.26.10.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 10:14:47 -0700 (PDT)
Date:   Wed, 26 Oct 2022 19:14:34 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     UMWARI JOVIAL <umwarijovial@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH] Fixed[ERROR:trailing whitespace and braces around scalar
 initializer]
Message-ID: <20221026171430.GA5592@nam-dell>
References: <20221026132838.GA44037@rdm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026132838.GA44037@rdm>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 04:28:38PM +0300, UMWARI JOVIAL wrote:
> Using the checkpatch.pl script, found the below errors and  fixed
> ERROR: trailing whitespace
> CHECK: Please don't use multiple blank lines
> warning: braces around scalar initializer
> 
> Signed-off-by: UMWARI JOVIAL <umwarijovial@gmail.com>
> ---
>  drivers/staging/most/dim2/dim2.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/staging/most/dim2/dim2.c b/drivers/staging/most/dim2/dim2.c
> index 7a5f80e637a0..28259ce05024 100644
> --- a/drivers/staging/most/dim2/dim2.c
> +++ b/drivers/staging/most/dim2/dim2.c
> @@ -987,7 +987,6 @@ static int rcar_gen2_enable(struct platform_device *pdev)
>  		writel(0x04, dev->io_base + 0x600);
>  	}
>  
> -
>  	/* BBCR = 0b11 */
>  	writel(0x03, dev->io_base + 0x500);
>  	writel(0x0002FF02, dev->io_base + 0x508);
> @@ -1084,7 +1083,6 @@ static const struct of_device_id dim2_of_match[] = {
>  	{
>  		.compatible = "xlnx,axi4-os62420_6pin-1.00.a",
>  	},
> -	{},

I'm no expert, but this looks like a null terminator and probably
should not be removed.

Best regards,
Nam
