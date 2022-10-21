Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7846072F0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiJUIxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiJUIxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:53:06 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A42E254373
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:53:05 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j7so3814303wrr.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2yFNgPrxCkN3vH9PPBXlL1gkousmScL4S6lxJCZitd8=;
        b=fi+QdgkB18efcGJTtaZHb5gI52m1faT4pA8LxpNrl7VTN15E3uxHeJ8qRUJWyMZp+0
         g/Aosk6/h7usT/vmlc5Es/n1B6GLpyIMetfq+N47KY7Pqgt72QbPcbDCpFXBnAcez1NP
         bUTyiPbWp14F5Nk8JsxVNY6B4GVxN2yxfnZcFWTgm/Mn+Na6cHriC3iTVtofo9nAFIBh
         qRQeUPCc4Y2FKcIiS44/AQY8363saN+FK5KLpgxxKqTqicyz4eu7YgGWidg5THe3etmH
         g1BGbbmjZMptxRbxp7lUE6tiVUqgh9DGOdaXQnEi7EWiFOJaqyPcqQCmQbAX/h3tTiyF
         qe5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2yFNgPrxCkN3vH9PPBXlL1gkousmScL4S6lxJCZitd8=;
        b=n4od2Ek6GULeuEQ0CYLLyTrsH5awff/UJPaXcRPp7k3sVJkPsh9mQKyOJaUAv2wX6G
         12S7lSPpy4upLEkwjty6fzlBSeItdfpvyONbLEk6C6BVvfiA6ERYC5j9VSTOby7jIWUD
         RUlVQlSVVYQucvF40Ou88c+SFozDaHEdsmijxfs5snl7GyID7Gv3H9DsB8JPHai8GEHb
         NK67PWyDwdYRFtAsbo8B01esSAlOausL59m/w25FuJq8kWVdgTXLyFgORsX2scXnsc3v
         nQ3au6fP0vyrZ2pXTULW161LxgCNsErPtklm1iiV7rbACcQ/uSUUTCJxuDBnUl3gj985
         A8mQ==
X-Gm-Message-State: ACrzQf1r6seNWAXQYRfGtQ5yeTrmZnYS32S0zovtOhZUWkknPBybVfGn
        sfziykF+HK0CH+9fioD+aByFZUHwh9aKmw==
X-Google-Smtp-Source: AMsMyM79Now5PJ4RnHDx5QLn+ilAlnHz6e+oaSFCdz7Kx8L/oMejVNNnJaf94ux0eVd1+P9DpLrswA==
X-Received: by 2002:a5d:6906:0:b0:22c:d6d5:6322 with SMTP id t6-20020a5d6906000000b0022cd6d56322mr11730228wru.355.1666342383646;
        Fri, 21 Oct 2022 01:53:03 -0700 (PDT)
Received: from [10.50.0.10] (ec2-54-194-108-71.eu-west-1.compute.amazonaws.com. [54.194.108.71])
        by smtp.gmail.com with ESMTPSA id m2-20020adfe0c2000000b0022e6178bd84sm19282661wri.8.2022.10.21.01.53.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 01:53:03 -0700 (PDT)
Message-ID: <bc131c94-fc41-a7f5-c378-12742de677a3@linaro.org>
Date:   Fri, 21 Oct 2022 10:53:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: [PATCH 2/2] virtio_ring: use helper function is_power_of_2()
Content-Language: en-US
To:     shaoqin.huang@intel.com, mst@redhat.com, jasowang@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20221021062734.228881-1-shaoqin.huang@intel.com>
 <20221021062734.228881-3-shaoqin.huang@intel.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20221021062734.228881-3-shaoqin.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/22 08:27, shaoqin.huang@intel.com wrote:
> From: Shaoqin Huang <shaoqin.huang@intel.com>
> 
> Use helper function is_power_of_2() to check if num is power of two.
> Minor readability improvement.
> 
> Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
> ---
>   drivers/virtio/virtio_ring.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 2e7689bb933b..723c4e29e1d3 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1052,7 +1052,7 @@ static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
>   	dma_addr_t dma_addr;
>   
>   	/* We assume num is a power of 2. */
> -	if (num & (num - 1)) {
> +	if (!is_power_of_2(num)) {
>   		dev_warn(&vdev->dev, "Bad virtqueue length %u\n", num);
>   		return -EINVAL;
>   	}

This makes the following code unreachable:

	if (!num)
		return -ENOMEM;

Do we want to move it earlier or remove it?

Regards,

Phil.
