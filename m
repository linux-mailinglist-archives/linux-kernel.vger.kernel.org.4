Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96480632A9F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbiKURQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiKURPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:15:44 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE2AD92CD
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 09:13:47 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id q9so11920183pfg.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 09:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xtv4h9c3AldnpSSbBkhgTkQdjwq0G0RPbTNhSWZQ0dw=;
        b=TOb6az3jRFkBe4X0HzQjP8GYDWWbHNFZ9MxWe2M6asN1VtdRiqKVEQROwPVhV+vczh
         sNa8toL8xN+dXKiEB2JyK6nWXEZAngN9NOKmaKn1PqZsvQgW4W8jXV5COsjCdfg/KgV/
         leOYIAnsVphTKt477QZtn/rV7TmS9Xyazf8h0V0VZy6fboV5bzuzgcfZOtfnEpyUze3W
         I9nAtf114C+ajWnYbP3b1K3nOeeUcElzvtqJp38XCz8NlQPnH2bulpdxpmcWIu8YRupm
         wNf60n23jRVSe03sA1pbkic2zuMvh+jfu9FICnmFbCdIYsiG6Y3sy2BeYM9NoPYpJF+t
         YPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtv4h9c3AldnpSSbBkhgTkQdjwq0G0RPbTNhSWZQ0dw=;
        b=EvAuYm7AX2xM2vLMKaLtUDRl+y0Vbc6XYR6UeJFmYVQNawBn1Hlkj7OghZucyaqbaK
         DQx0GS00SUV/eFz/AwpJxYGjXfIuj2jYC5hYyeTfBbv1iG9lI5AUF1zmKDFpC2AxBgWC
         6rQ8v9K+0KkbWytERcSXCagAXMXwRqAEe3sg+6ltowYTboeq1aktyI+gTlvJxfkZLmfn
         AdY/tgOWlTA5IGzEPUrkaiLQ2QIMU70GGiE5udk3pfE28gf+ZLYCtDtHSzuI4c/o2127
         HEp+zOTM6JXDQTfz6qVFINeUzBSIPW1hnp+L9HPX7fL5OyTvi9I65omScFNeiEpHiBQx
         BvfQ==
X-Gm-Message-State: ANoB5pkgskDvUgYtEywqtSmsXn9WDF4OIqnMuCDGeclX1MVvctrUdvWY
        /Aj8CjrBJFeRABRF/OZ8L3q+jw==
X-Google-Smtp-Source: AA0mqf5h12so7YydnNjvEbSQjdg3H+com4vquDXfsPBsWVFlFdqUZ7jZvjbRyDwyIU4nzD2d27WLvw==
X-Received: by 2002:a63:da4d:0:b0:46b:3c3d:f618 with SMTP id l13-20020a63da4d000000b0046b3c3df618mr4676440pgj.423.1669050827057;
        Mon, 21 Nov 2022 09:13:47 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:8b90:bf06:8462:1d8b])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902b78500b001891177cb48sm5406001pls.140.2022.11.21.09.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 09:13:46 -0800 (PST)
Date:   Mon, 21 Nov 2022 10:13:44 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ye.xingchen@zte.com.cn
Cc:     andersson@kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] remoteproc: core: Use device_match_of_node()
Message-ID: <20221121171344.GA457869@p14s>
References: <202211171541061366938@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211171541061366938@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 03:41:06PM +0800, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Replace the open-code with device_match_of_node().
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/remoteproc/remoteproc_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Applied.

Thanks,
Mathieu

> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index cb1d414a2389..11c165ddf1fc 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -2112,7 +2112,7 @@ struct rproc *rproc_get_by_phandle(phandle phandle)
> 
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(r, &rproc_list, node) {
> -		if (r->dev.parent && r->dev.parent->of_node == np) {
> +		if (r->dev.parent && device_match_of_node(r->dev.parent, np)) {
>  			/* prevent underlying implementation from being removed */
>  			if (!try_module_get(r->dev.parent->driver->owner)) {
>  				dev_err(&r->dev, "can't get owner\n");
> -- 
> 2.25.1
