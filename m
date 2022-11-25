Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D401863890D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiKYLtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKYLtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:49:09 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338C52181A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:49:08 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id d6so6496248lfs.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qEeTFgj6vtT8z9vOAzPfVZVEyvXymEWt+IDPrKUsU7Y=;
        b=B4AuyHeU250ikjrEPn9GPuTChIwjk4npQjcZwnS5jcaOJPAoAgPFPi/K4lGY33Y0vR
         ptevEnkh0nxKd7XGEStpO5LoXn26Bpa9tZuDsQHSxAhq+hEb6atqVKxsm/rPk0E3ROpv
         jPEyRHk6chBfszmlGT4pkpOjGghwARnvwW8Dkui7+dUgw9hx+StyEHMu9yxEQ3YUb/Zd
         GZQxjeatjx7LHANIgGvRc1BEu6oTe9D/nZ7BQqDKfXe6tGelvv2u49ncg7WwuU3MCxwo
         Rs1p73ZnxvgiKYe57AaDxGFsw7UgLKfHqxqkNt/169v5gdDdVTa+WEQMKkut0UEv8hjb
         XITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEeTFgj6vtT8z9vOAzPfVZVEyvXymEWt+IDPrKUsU7Y=;
        b=h7rbmeZrOjOj2Xph0YZQ5IvGATiJBJYGzj774Ea6P8zjawad1RABKh7kj8znwibr+u
         WWRcfGPYUQhk0U46lAHJQBNklr0ZYuOlXaHf/vIxzDZ0FYJao1EHmYcvJKoejXIq3Qey
         16eNTO1Ru+OryXmGR8ER+oqZlJRY19IW6jF3nlB0rH/SRkoJk67QRSZJpSmzR6BpHFm+
         oWYuvRfXk9C6myP1LLlNjJ3fhyFKp3MLZwOCnh1SPuIwpQrSTySLNmGB0KR4hACq3TNx
         zJ9cuyoKhn0GNK71jNYJJt2X2AJSP9ziTaw4Tr3b72MukqHzp43DOSNIBu0wDV3Pa3HA
         7vyQ==
X-Gm-Message-State: ANoB5pmVxMO5+K1jpI2qp6qNPsv/ojG4KDLJFMnKN+896CQItbXztNB1
        H98rlaralmKtHgzVg6hkhZE=
X-Google-Smtp-Source: AA0mqf7zYcxxJfmxkfye5xKy3CmTBgFFoMZREedCoqU9op1U7gaG0Gu66/5ECHk/a0scqUhCCOndGQ==
X-Received: by 2002:a05:6512:715:b0:4b4:e552:5638 with SMTP id b21-20020a056512071500b004b4e5525638mr4607720lfs.287.1669376946303;
        Fri, 25 Nov 2022 03:49:06 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id p8-20020a2eba08000000b002776eb5b1ccsm340479lja.4.2022.11.25.03.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 03:49:05 -0800 (PST)
Date:   Fri, 25 Nov 2022 14:49:03 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        error27@gmail.com, ntb@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NTB: ntb_tool: Add check for devm_kcalloc
Message-ID: <20221125114903.dby6ysdr5qkeo5ay@mobilestation>
References: <20221122033244.5777-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122033244.5777-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 11:32:44AM +0800, Jiasheng Jiang wrote:
> As the devm_kcalloc may return NULL pointer,
> it should be better to add check for the return
> value, as same as the others.
> 
> Fixes: 7f46c8b3a552 ("NTB: ntb_tool: Add full multi-port NTB API support")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Right. Thanks!
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

> ---
>  drivers/ntb/test/ntb_tool.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
> index 5ee0afa621a9..eeeb4b1c97d2 100644
> --- a/drivers/ntb/test/ntb_tool.c
> +++ b/drivers/ntb/test/ntb_tool.c
> @@ -998,6 +998,8 @@ static int tool_init_mws(struct tool_ctx *tc)
>  		tc->peers[pidx].outmws =
>  			devm_kcalloc(&tc->ntb->dev, tc->peers[pidx].outmw_cnt,
>  				   sizeof(*tc->peers[pidx].outmws), GFP_KERNEL);
> +		if (tc->peers[pidx].outmws == NULL)
> +			return -ENOMEM;
>  
>  		for (widx = 0; widx < tc->peers[pidx].outmw_cnt; widx++) {
>  			tc->peers[pidx].outmws[widx].pidx = pidx;
> -- 
> 2.25.1
> 
> 
