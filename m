Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313F863FAFE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiLAWyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiLAWyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:54:37 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AE3BE4E6;
        Thu,  1 Dec 2022 14:54:35 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id l15so2957646qtv.4;
        Thu, 01 Dec 2022 14:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8R0I2HiyAHJp+a7H8FDZLVY4oWPvtVh9vuwq1aO411c=;
        b=ngpb0iGSKcm6bS2RRRmqb6t9UUdIYG8fHe/JBS7odLAPnuz5QFCcmeFf2dak43WffM
         sSIulMqzs2uPDOihIcXkn5TiwUPcnQ98eAW7/sJ9lq+F5pEyIUY7EqnwDMlJVLa6Jqi3
         jZ0pMcz3l6IDHTPo4lYARqeDezhvX1zQCYcDxGYCqX/nEHFPPk8LVNkMT1Bys2l6QeWC
         B0sgu0+6+Ae13QRjFzpYbKFlctZlnZm80Md2sS84my9OD8y88amErWz4UJ+8zgFggDGK
         /2X1zGDd2yofGnOhjji/DRF5THoQHpGJescL/5TRwoZXZDTz+gGxm4rWFMJOJqksYVit
         9cOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8R0I2HiyAHJp+a7H8FDZLVY4oWPvtVh9vuwq1aO411c=;
        b=sU9GqkH/zpMqcrosA5WiMRFdPT9gpZcUPfg1FL8HunXWWQMznEnO6u/m64mo/KgKNC
         IXcJZ7DQix5fQs6DiPVpL2dI/JyWUU4Vdo6Bu5BDWCT7HizTiK9YYhhLYN/G9tQe9+ee
         bMVkVvPevHLD5dPHqSc/VbaGp7LbSs7EBjbcMSENosaRI7ggoSIYEroibRYnwLsMi7Kr
         mOa2haPvvUkrp0/vYBg7hYizz99ODSr/cH5g00esc3MFwN4YLAqQrfLA6G58eZImVG2W
         U58n0icIhLJN3+1k5FWM3ECFMWvUmjabWGNm60Pj1iuqPOkoJLc9fD2wFWWh2PTvpDEv
         h5GQ==
X-Gm-Message-State: ANoB5pm4qcEf5RzsH1Vx2qJi2S4M+P6CZEShxA+TLvwCNhdmXXz1D72B
        yoLgbCuw6Lab3jyTA9tyXAs=
X-Google-Smtp-Source: AA0mqf7hM/x14S5/qCLPz918zYKBXjGm+5ik5312aCqDfGrg8Tsjutzbpkt/No1s9PqD4MYCIGjM4Q==
X-Received: by 2002:ac8:4908:0:b0:3a5:faa7:35e7 with SMTP id e8-20020ac84908000000b003a5faa735e7mr63854046qtq.66.1669935275135;
        Thu, 01 Dec 2022 14:54:35 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:19b7:90d3:e1bc:23de? ([2600:1700:2442:6db0:19b7:90d3:e1bc:23de])
        by smtp.gmail.com with ESMTPSA id v12-20020ac8748c000000b00398df095cf5sm3246366qtq.34.2022.12.01.14.54.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 14:54:34 -0800 (PST)
Message-ID: <fc106a76-c661-b133-9ce0-2470ef03fefa@gmail.com>
Date:   Thu, 1 Dec 2022 16:54:33 -0600
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
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
>  
>  		target_child.np = tchild;
>  		target_child.in_livetree = false;

Pending updated Fixes: tag (mentioned in a previous reply).

Reviewed-by: Frank Rowand <frowand.list@gmail.com>
Tested-by: Frank Rowand <frowand.list@gmail.com>

The testing was my normal testing, but did not replicate the triggered warning
to verify that this patch eliminated the warning.  I am depending upon Zeng having
verified the elimination of the warning.

-Frank

