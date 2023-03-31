Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237A06D1B12
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbjCaJAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCaJAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:00:49 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA09DBEE
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:00:35 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t4so16419319wra.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680253234;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4nQxeJeXLAS1yXrHfRZgden2oQvmJ5Y9pjAachYDoZ8=;
        b=Rfekt0B+9GcLek7jW9pdK9C1nrTpK/XO63FVs0kWMDI5v92l510njwVLFzcTfuNy+e
         aPvLB9GcI83JEBBGZe/Jyw+qV6BywO88PArPxQJB6+QFugl+XaEatn4d3umC0stKVGyt
         Ttp65Pj8/BRs+eT1Aejcl6TLwpDDS/JloMzMIrZLZJNugidEBrFDVP8LWnzS9bDb+Txp
         9qRh97w8EUdr1zZZNCzE872PvRwyXLl81Neqi6pSMFhbKSjh4z7CTS0Gvn2DzYaHadPZ
         zeL3fbjd7nuFEV5lqH+D3qz4uuDn6CgUXNGcEh5oqhHCvHOgCFL0RmrF1kgE3DN0GwCG
         i7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680253234;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4nQxeJeXLAS1yXrHfRZgden2oQvmJ5Y9pjAachYDoZ8=;
        b=15RQG6x2STwt4LCF8LWYLR6S7HXVm7o+vfM6TYv9PVJ7wxKOLP0y9RxuSxu7pCAY1H
         WrWAgpaa2PyDtuytkEXpIp7VsMnjrzNET5P5zaFa4pBuQu5LIXfnOVCN2g1nG4aWXDgM
         iIifzGwT6HG90Upe2r/BhBVU8MqLuKti008AcEpIEJAJwHy1k9/1c17f3ywzjKhEz9De
         Q2ZUIv0ktcI5icrk6wAV9L+MpX2s4W1DTHN9vHBQIjTwwP5MVi0/TD0C3BsD0vpUJKZ1
         KsaDRX9zt8JoFj6Ywk0sHxTCtkFkRFjzjBCQLqMg9nJ9B59hKAscGIbKd5ZvQWn6GbZ+
         X+yg==
X-Gm-Message-State: AAQBX9csPnKJqufBtTmbMAMRtB7OYKydiEL3sjpV+aUzczXw/6RaGcor
        KyY7MiCGo9UfOH0YboZCEh95qw==
X-Google-Smtp-Source: AKy350Z55GTUKlJlEyylgRJXO0eyo6+oSEbH6wjS3e2bsKEghN79AAf836I98UmhXi41vJrW7Wd7SA==
X-Received: by 2002:adf:f703:0:b0:2cf:ea38:ef29 with SMTP id r3-20020adff703000000b002cfea38ef29mr20498270wrp.44.1680253234309;
        Fri, 31 Mar 2023 02:00:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:74cb:1a96:c994:e7e0? ([2a01:e0a:982:cbb0:74cb:1a96:c994:e7e0])
        by smtp.gmail.com with ESMTPSA id n5-20020adffe05000000b002d97529b3bbsm1619283wrr.96.2023.03.31.02.00.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 02:00:34 -0700 (PDT)
Message-ID: <4a22e085-b339-aa43-518e-d528c5f76de4@linaro.org>
Date:   Fri, 31 Mar 2023 11:00:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 2/3] drm/bridge: tfp410: Fix logic to configured polled
 HPD
Content-Language: en-US
To:     Jonathan Cormier <jcormier@criticallink.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Williamson <michael.williamson@criticallink.com>,
        Bob Duke <bduke@criticallink.com>
References: <20230125-tfp410_i2c-v3-0-a85d5f0f50f1@criticallink.com>
 <20230125-tfp410_i2c-v3-2-a85d5f0f50f1@criticallink.com>
Organization: Linaro Developer Services
In-Reply-To: <20230125-tfp410_i2c-v3-2-a85d5f0f50f1@criticallink.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20/02/2023 23:10, Jonathan Cormier wrote:
> From: Michael Williamson <michael.williamson@criticallink.com>
> 
> The logic to configure polling (vs async/irq notification) of hot-plug
> events was not correct.  If the connected bridge requires polling,
> then inform the upstream bridge we also require polling.
> 
> Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
> Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
> ---
>   drivers/gpu/drm/bridge/ti-tfp410.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti-tfp410.c
> index bb3f8d0ff207..41007d05d584 100644
> --- a/drivers/gpu/drm/bridge/ti-tfp410.c
> +++ b/drivers/gpu/drm/bridge/ti-tfp410.c
> @@ -155,7 +155,7 @@ static int tfp410_attach(struct drm_bridge *bridge,
>   		return -ENODEV;
>   	}
>   
> -	if (dvi->next_bridge->ops & DRM_BRIDGE_OP_DETECT)
> +	if (dvi->next_bridge->ops & DRM_BRIDGE_OP_HPD)
>   		dvi->connector.polled = DRM_CONNECTOR_POLL_HPD;
>   	else
>   		dvi->connector.polled = DRM_CONNECTOR_POLL_CONNECT | DRM_CONNECTOR_POLL_DISCONNECT;
> 

A Fixes tag is probably needed here ?

With that:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
