Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B65169D333
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 19:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjBTSt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 13:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbjBTStg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 13:49:36 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AF91E9F9;
        Mon, 20 Feb 2023 10:49:00 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id bh19-20020a056830381300b00690bf2011b2so321637otb.6;
        Mon, 20 Feb 2023 10:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dp9FA0RvdgxvVZhfm9R2KGLFsqWa4RXhCmE9KXcq+cs=;
        b=CPicpEjuNiPzLxDIkzhnkE1I5W9ZZP3oBvECpcvd+X+0jnurW4jKG1R/pnA59+QIUk
         km3NMqnjsGkEDCzl6Ke3REvKnOB3vongF5sRv+ANxQa5QV/xfPn7kdP6hu/Kl+nq0jLn
         T7sx0BbE8lLMpbARkG/84/UPp2KvAb9EdM+tckWM3lYaQFyd/RVJAzN5UcERoBXkeTPm
         xPtNabn0cFnMEIkRw6ZImwYTV1iaV1++tFFtRfPn3u6d3eM8pgL9iTy1mI9Q6dH6TAYV
         wrjYfkuLGfeiJMsHCcsoAJttuI2HI87wBaSgnvMpRyT/v20hABBdJkik9MGztdsrLgtk
         W5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dp9FA0RvdgxvVZhfm9R2KGLFsqWa4RXhCmE9KXcq+cs=;
        b=qcwleeucLqhmrtS4nSvtSoPICryAARZl0SeZLq+jMzh+NzDPCGanP1mVPaeNTJJoKp
         17wOUTbRHIfYLsOD47gbX3RkOo97EaN5ibi7o3etIxL0gvf9KAxS90DJ1GHAwE/7S+b7
         b86J2oMU6G2bUsXslS4YcHKHQdoZ9jQM0nUOB6rSvmcWC9K2A0EokLbbyU+c5kgJEcQR
         wrlG1byIjQ3zqTxzDb7ltY/PyYzB7sAAfOwQyHxjUkMB5Wzj4EZatG5ZUjvIyYKaNTD8
         ccgXudfGyUdlk4KTHPhVL0I5GtILX3UZKgZq9cQ2mUOZFh1nZ583HFSFNq4BP+Mb/R/S
         p7Ng==
X-Gm-Message-State: AO0yUKVbZSs8PkYLWcGvObVP+FKnBy7Q1mpm9FJPp5hM0GlxQyZHyur5
        8ZwLFOdixDP4A36l2jPYvfM=
X-Google-Smtp-Source: AK7set/1HBaSRcuvDF94MEmuuDb4BY1XA0yEYH480iBvBiMnJBbHcZ/hQE8hMs0Fj83hj9msF5bOpg==
X-Received: by 2002:a05:6830:3101:b0:68b:cdd3:3b93 with SMTP id b1-20020a056830310100b0068bcdd33b93mr6960472ots.26.1676918933968;
        Mon, 20 Feb 2023 10:48:53 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:e458:3986:a974:9501? ([2600:1700:2442:6db0:e458:3986:a974:9501])
        by smtp.gmail.com with ESMTPSA id n4-20020acabd04000000b003645b64d7b3sm5218893oif.4.2023.02.20.10.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 10:48:53 -0800 (PST)
Message-ID: <ac009137-dcc3-849a-cc97-96268d692c68@gmail.com>
Date:   Mon, 20 Feb 2023 12:48:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH][next] of: dynamic: Fix spelling mistake "kojbect" ->
 "kobject"
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230220144422.873356-1-colin.i.king@gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20230220144422.873356-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/23 08:44, Colin Ian King wrote:
> There is a spelling mistake in a pr_err message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/of/dynamic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> index 12aa99018969..07d93753b12f 100644
> --- a/drivers/of/dynamic.c
> +++ b/drivers/of/dynamic.c
> @@ -350,7 +350,7 @@ void of_node_release(struct kobject *kobj)
>  		if (!IS_ENABLED(CONFIG_OF_UNITTEST) ||
>  		    strcmp(node->parent->full_name, "testcase-data")) {
>  			dump_stack();
> -			pr_err("ERROR: next of_node_put() on this node will result in a kboject warning 'refcount_t: underflow; use-after-free.'\n");
> +			pr_err("ERROR: next of_node_put() on this node will result in a kobject warning 'refcount_t: underflow; use-after-free.'\n");
>  		}
>  
>  		return;

Reviewed-by: Frank Rowand <frowand.list@gmail.com>
