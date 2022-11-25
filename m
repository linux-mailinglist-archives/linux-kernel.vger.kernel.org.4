Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845D7638DBC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 16:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiKYPvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 10:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiKYPu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 10:50:59 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAE231FB8;
        Fri, 25 Nov 2022 07:50:56 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id x17so7363784wrn.6;
        Fri, 25 Nov 2022 07:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gGtFpd9/hEihcxfaAZXLh+MO2ImBUdS5RPJo51eOJ5A=;
        b=Wd6tMpn1N5SIEtXHFwc1eScSBrFdtSlj2xAcP/GVikTRm1O6CSkkb4tWt9U3NoCIa4
         ijWwVQUGwSEiaT41EnbxqcvBjeBbqgZx07Wf0Z2MhTvq72fA/IaeRK77bTB6tSZsvxD9
         2xKnPOSOK3ua+7nYV3bUIOpZMkWLbqTwnDxvULKNAMT6BN4lAxIrxyeWtc7sX9aJTl5y
         tOqchmZnX90FCKtSOS4kryZ6ll56ip6D7P+r/50tYc/nXW4J+/pDeMDNF3fr/rX9S7Yu
         E7YisrgoDNkwMnZEswLQlMssNyAocughTN01RX8UKLKrGTfi3Ldvr6GSGE2hkDDJ8+32
         nWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gGtFpd9/hEihcxfaAZXLh+MO2ImBUdS5RPJo51eOJ5A=;
        b=0te77cvKCGbeoPQeWjt4H8E5aJWpZrFAWQhlIBrdc6e3X1JWGd7+URKqE92XKuuLIb
         em0P9esUtmCcCsI1BOmtSDstYSpqWArgyOtGXaS4NALp5csbqx0dBpuAThqta4UM+jm0
         wYCQtbDd7JsChomf2QeuB6eU+Z2Bn6UTToG29/zgKAMj4rJ1KbHZnJu/JVBj864JX/0h
         Iqz6UCAeCWHnmBGiIHnlJ/fbmVWnGbEzunO8L480667IIMNwdj4Eg2jThqo/Ufr7a4F1
         ujEA8Z5QBv9Qw827zZjuBV9Hpl6JvXddNUWXlKNV80KkR0EClHXg9gpMVorVKSF4T+IY
         1oiA==
X-Gm-Message-State: ANoB5plaKCyqIBA66qBYiVWVFoDrUXHTk1B2B+IZbUdcZYQJiQHfO83q
        wKGjN91o0mHdZ7dMZ6lMu+Qo7lPyfeo=
X-Google-Smtp-Source: AA0mqf51cWgSgehn/7HYrUUOy965hQUYasigP3oEcbV2hg7FAxvEw+pQQdBzhgOj70jyVM+s/0Hx8A==
X-Received: by 2002:a5d:4308:0:b0:241:e80e:225a with SMTP id h8-20020a5d4308000000b00241e80e225amr9726284wrq.560.1669391454971;
        Fri, 25 Nov 2022 07:50:54 -0800 (PST)
Received: from [192.168.0.14] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id j13-20020adfff8d000000b00241bd177f89sm4050389wrr.14.2022.11.25.07.50.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 07:50:54 -0800 (PST)
Message-ID: <5beff345-84c2-d456-1b7f-05309afa397b@gmail.com>
Date:   Fri, 25 Nov 2022 15:50:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3] device property: fix of node refcount leak in
 fwnode_graph_get_next_endpoint()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com,
        sakari.ailus@linux.intel.com, gregkh@linuxfoundation.org,
        rafael@kernel.org
References: <20221123022542.2999510-1-yangyingliang@huawei.com>
From:   Daniel Scally <djrscally@gmail.com>
In-Reply-To: <20221123022542.2999510-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all - sorry that took so long

On 23/11/2022 02:25, Yang Yingliang wrote:
> The 'parent' returned by fwnode_graph_get_port_parent()
> with refcount incremented when 'prev' is not NULL, it
> needs be put when finish using it.
>
> Because the parent is const, introduce a new variable to
> store the returned fwnode, then put it before returning
> from fwnode_graph_get_next_endpoint().
>
> Fixes: b5b41ab6b0c1 ("device property: Check fwnode->secondary in fwnode_graph_get_next_endpoint()")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---


This looks fine to me (thanks for fixing it), and it works fine on my
Surface:


Reviewed-and-tested-by: Daniel Scally <djrscally@gmail.com>

> v2 -> v3:
>   Add a out label.
>
> v1 -> v2:
>   Introduce a new variable to store the returned fwnode.
> ---
>  drivers/base/property.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 2a5a37fcd998..7f338cb4fb7b 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -989,26 +989,32 @@ struct fwnode_handle *
>  fwnode_graph_get_next_endpoint(const struct fwnode_handle *fwnode,
>  			       struct fwnode_handle *prev)
>  {
> +	struct fwnode_handle *ep, *port_parent = NULL;
>  	const struct fwnode_handle *parent;
> -	struct fwnode_handle *ep;
>  
>  	/*
>  	 * If this function is in a loop and the previous iteration returned
>  	 * an endpoint from fwnode->secondary, then we need to use the secondary
>  	 * as parent rather than @fwnode.
>  	 */
> -	if (prev)
> -		parent = fwnode_graph_get_port_parent(prev);
> -	else
> +	if (prev) {
> +		port_parent = fwnode_graph_get_port_parent(prev);
> +		parent = port_parent;
> +	} else {
>  		parent = fwnode;
> +	}
>  	if (IS_ERR_OR_NULL(parent))
>  		return NULL;
>  
>  	ep = fwnode_call_ptr_op(parent, graph_get_next_endpoint, prev);
>  	if (ep)
> -		return ep;
> +		goto out_put_port_parent;
> +
> +	ep = fwnode_graph_get_next_endpoint(parent->secondary, NULL);
>  
> -	return fwnode_graph_get_next_endpoint(parent->secondary, NULL);
> +out_put_port_parent:
> +	fwnode_handle_put(port_parent);
> +	return ep;
>  }
>  EXPORT_SYMBOL_GPL(fwnode_graph_get_next_endpoint);
>  
