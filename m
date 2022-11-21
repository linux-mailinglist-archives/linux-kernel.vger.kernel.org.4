Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE8063186C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 03:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiKUCA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 21:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiKUCAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 21:00:24 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A44E18B0D;
        Sun, 20 Nov 2022 18:00:24 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id n188so7699387iof.8;
        Sun, 20 Nov 2022 18:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xggRaS5UNqwaVE+Kvx6ewI9lR4TfRIRa8mzj1osKdw8=;
        b=X/bFIPPT9/oSix+mDpkAcD4ROPq+lAUpgqEVvw3CeakV0KjGma8OHCY0oJ7jc2CAKD
         gnOv2+BrIp4yzLgUE26BXu4nWpcHdZOXd8wSG/BA/SoaIqxbbQH/FHSXmiJLqoI6/aQS
         3AfNTh4nSlnxwBFDsOJnNTgb++gs+A9pRXEVC+vGHkYFFWj57HadDgNehSUVB+h80Hau
         r/B25BE+jl45MjX5PIy6KpMtukHJ5XfZrkmrourLbYq/SonmHRDNkcm0tZQWlhmO4saz
         npSWutCCppti6vQDv0jcwrunbzF1BJKZvmyJCpJKDYHs/5IEKmqqT09fjBZBYE/UrPvr
         Scsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xggRaS5UNqwaVE+Kvx6ewI9lR4TfRIRa8mzj1osKdw8=;
        b=GL2OudVaBv3d9+5KfzfAgbIqzkkSW8JNmcabk5kLurLR50QBfOd2hTOv9l3R8FYBjP
         maPGQhPloDBSgVR8I/ru7gSEHASCZd6/8O0tXOz3/HeDj1hcUFsceqAYr9WePqjiP+Le
         hua2WhE9scSkq+BY17UsxBpj3prywhIKT+1Df4T13QzbQL4ccpQPKdDMgGOK/4PXu2fb
         S6BEfp4u7L7FC6ALtlZUFXNXjqiXLz+dmhM7YXcM/iJ7IOYRzByGV2ONv7K7FJ6DU8X+
         hlLOrnbrTYJ8zauJFkkSLMyYT7BI9+0EMIWKSJrCTl950pIFMYZhXMDnSHHFt7/wxGcz
         1H5w==
X-Gm-Message-State: ANoB5pkUeappcAvYoh+yeTQr9H26jqHOBCsZDrDZfAXj51qxov4tiyaB
        WKzdxU7k7q2PbJKhtUsRKI3xU9bweUk=
X-Google-Smtp-Source: AA0mqf5eyBLtjjAcyN1HolhDfODa02iOhn1V5VaDyU4U7aJQOk+rBDNLWMvXQIwlTYCQ4RYVsYyh+A==
X-Received: by 2002:a02:6d6f:0:b0:375:c16b:7776 with SMTP id e47-20020a026d6f000000b00375c16b7776mr7263485jaf.54.1668996023437;
        Sun, 20 Nov 2022 18:00:23 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:799e:a547:4c2f:ec44? ([2600:1700:2442:6db0:799e:a547:4c2f:ec44])
        by smtp.gmail.com with ESMTPSA id x15-20020a026f0f000000b0037fbfe86e77sm827295jab.3.2022.11.20.18.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 18:00:22 -0800 (PST)
Message-ID: <8c8124c1-2de6-adfd-3e4b-766c653ebe2d@gmail.com>
Date:   Sun, 20 Nov 2022 20:00:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] of: overlay: fix memory leak in add_changeset_node()
Content-Language: en-US
To:     Zeng Heng <zengheng4@huawei.com>, pantelis.antoniou@konsulko.com,
        grant.likely@linaro.org, robh+dt@kernel.org
Cc:     liwei391@huawei.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221118105308.370474-1-zengheng4@huawei.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20221118105308.370474-1-zengheng4@huawei.com>
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

On 11/18/22 04:53, Zeng Heng wrote:
> In of_changeset_action(), we have called of_node_get() to increase
> refcount of a node.
> 
> Therefore, when tchild (duplicated by __of_node_dup()) is done,
> of_node_put() needs to call and release the device_node.
> 
> Otherwise, there are some memory leak reported about the node:
> 
> unreferenced object 0xffff88810cd1e800 (size 256):
>   backtrace:
>     kmalloc_trace
>     __of_node_dup
>     add_changeset_node (inlined)
>     build_changeset_next_level
> 
> unreferenced object 0xffff888113721240 (size 16):
>   backtrace:
>     __kmalloc_node_track_caller
>     kstrdup
>     __of_node_dup
>     add_changeset_node (inlined)
>     build_changeset_next_level
> 
> unreferenced object 0xffff88810a38d400 (size 128):
>   backtrace:
>     kmalloc_trace
>     __of_prop_dup
>     add_changeset_property
>     build_changeset_next_level
> 
> Fixes: 7518b5890d8a ("of/overlay: Introduce DT overlay support")
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
> ---
>  drivers/of/overlay.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> index bd8ff4df723d..a5189a0ec0a3 100644
> --- a/drivers/of/overlay.c
> +++ b/drivers/of/overlay.c
> @@ -436,8 +436,10 @@ static int add_changeset_node(struct overlay_changeset *ovcs,
>  		of_node_set_flag(tchild, OF_OVERLAY);
>  
>  		ret = of_changeset_attach_node(&ovcs->cset, tchild);
> -		if (ret)
> +		if (ret) {
> +			of_node_put(tchild);
>  			return ret;
> +		}

By visual inspection of the code (Linux 6.1-rc1), this does not appear to be
correct.  For the only case where of_changeset_action(),
called by of_changeset_attach_node(), returns an error, of_node_get() has not
yet occurred on tchild.

>  
>  		target_child.np = tchild;
>  		target_child.in_livetree = false;

For which version of Linux were the memory leaks detected?  Were any additional
patches applied?

-Frank
