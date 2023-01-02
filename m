Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3415C65B367
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 15:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236190AbjABOg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 09:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236184AbjABOf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 09:35:59 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1BC29A;
        Mon,  2 Jan 2023 06:35:58 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id h185so2560554oif.5;
        Mon, 02 Jan 2023 06:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oldXDimbyQpQ7zpEgLfAQ9A9jkVkeyPyVeSx90WR90g=;
        b=AFap4DC2gK8aOZIgTD18L6fjbI1+0XDHkm9J6PTAyE4o7S59mu9inc4lkWxtnZKy1D
         CNl9KAp2hyPvEbQxgiBRoNKLqxZhP+F6rwP/BIUrNtLnR2T3N7mRjMbeTSB6boUsyQBl
         /pXdP0pM1yY97dR9YT+xRZa3nS7bWJsN4EN6f8QuTH4FCAFfquLALhf1NUi53/QKFzxs
         2MtuIdZNsPKoCxMXt4OMbdPXjZSn/9F0McFdukOEvVZrQBcCQF6AUCu27IKdYPTE9KwQ
         5N8RhfMPGykJ235lQVhg/zs633WCx80WjzYRPx/gEavvLUHuCNIRb932N47a84UP0Sq9
         3oqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oldXDimbyQpQ7zpEgLfAQ9A9jkVkeyPyVeSx90WR90g=;
        b=KEb0yV0RBv3FMRq0YrSEpWpCwiimOS2sMQ61Q9vdrCEPFb0JiQKNmfawBNXh9GCtjk
         Lmln1frdRM9qXACP5XBPrZfkJrS5resd3c3FecgdyKRXuGk8NK29hsy8f4lm8tMjR1/N
         GYURELZmIorHsxMzzJ1MmSusGtRySbIxPQ8PoZe+yzG+x6/uyqcxV+O7mUXI7Rx9cEcU
         qrEf+qCTJORm+yKLi5hAffImgVwgaXnj0TjAiunI9mjZU02xLgBg2heBJvcllG5t9qhY
         2KE+tA+FdnVFnDWDRuHsDZW0NMWoxS5pp9QSfxyKfaXqo+fR1/xA26RENMz396LyYZgW
         PK8w==
X-Gm-Message-State: AFqh2ko8N4TUrq6zWD2eXywvtUWWjnM+xmy7XismslCV94Pbv7z+Mycm
        /d7RkmcJdwc3hxgDCn39UWqnYudiuQ8=
X-Google-Smtp-Source: AMrXdXt8niPHIGc7xRuIs3/6sCnds5wMxcVVOZD0/L9VpRGvlsiVzdjOPRi0lH58mzrLIq8DNj5bqg==
X-Received: by 2002:a05:6808:2c9:b0:35e:b231:1a27 with SMTP id a9-20020a05680802c900b0035eb2311a27mr16695489oid.33.1672670157909;
        Mon, 02 Jan 2023 06:35:57 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:e082:9c8d:c88c:a11? ([2600:1700:2442:6db0:e082:9c8d:c88c:a11])
        by smtp.gmail.com with ESMTPSA id r204-20020aca44d5000000b00354d9b9f6b4sm12015179oia.27.2023.01.02.06.35.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 06:35:57 -0800 (PST)
Message-ID: <a7e15b62-8929-b76e-77d7-42d78aaa02e1@gmail.com>
Date:   Mon, 2 Jan 2023 08:35:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] of: overlay: fix warning being reported as error in
 add_changeset_property
Content-Language: en-US
To:     "Ankit 16. Kumar (Nokia)" <ankit.16.kumar@nokia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1671195782-23078-1-git-send-email-ankit.16.kumar@nokia.com>
 <VI1PR0701MB68298749C8133A7D69CFDBBFC9F09@VI1PR0701MB6829.eurprd07.prod.outlook.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <VI1PR0701MB68298749C8133A7D69CFDBBFC9F09@VI1PR0701MB6829.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/22 02:40, Ankit 16. Kumar (Nokia) wrote:
> 
> The print causes false reporting of the issue which actually is a warning

How did you select the commit in this Fixes tag?

> Fixes: 2fe0e8769df9 ("of: overlay: check prevents multiple fragments touching same property")
> 
> Signed-off-by: Ankit Kumar <ankit.16.kumar@nokia.com>
> ---
>  drivers/of/overlay.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c index ed4e6c144a68..0da39b8461e7 100644
> --- a/drivers/of/overlay.c
> +++ b/drivers/of/overlay.c
> @@ -358,7 +358,7 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
>  	}
>  
>  	if (!of_node_check_flag(target->np, OF_OVERLAY))
> -		pr_err("WARNING: memory leak will occur if overlay removed, property: %pOF/%s\n",
> +		pr_warn("WARNING: memory leak will occur if overlay removed, 
> +property: %pOF/%s\n",
>  		       target->np, new_prop->name);
>  
>  	if (ret) {
> --
> 2.30.1
> 

NACK.  This patch is incorrect.  The reported memory leak is a bug, not a warning.

I'll write up some information about why the memory leak occurs, then reply to this
email with the additional info.

-Frank
