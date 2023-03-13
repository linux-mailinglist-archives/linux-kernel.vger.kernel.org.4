Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14416B72C4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjCMJia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjCMJiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:38:02 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B062B3B86A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 02:36:35 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id j19-20020a05600c191300b003eb3e1eb0caso10428063wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 02:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678700193;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/voBu6XJv3Cuj4S1ZjmI/oeTZAcic/pgfze+nCN+AT0=;
        b=ZqJSmKTV8NfA58WB+WzePvSMWdfCwDddQE/PtoPdRV8N4+TIhZES7HK8mHwH5Zk4Rj
         Z0UByrMNGXFIkeUhPflzyVJ0sPJuMhQw6rDkZbFPAqhXp6VnU51OZwe8+O4Xko4B+dJV
         3hinDiIYhXEZFPz3riHzj+V5XPLbzktxlE/+pDGFP6rtxrZ+LJIwnRp7a9MkonLkqJi/
         jrh7zFobZUaJ3nmDLQeUWrGIigNZ3RYq1E0rLiJStf/M3a6ZVwc+N7gAYuxm6yls4bSC
         kzA4bS3a9tRfH05HYHE3aVNYpYu5PqkP5raXMwUayuwtyPDT1S7Jxi+3ysmRWEVdoJVx
         DZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678700193;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/voBu6XJv3Cuj4S1ZjmI/oeTZAcic/pgfze+nCN+AT0=;
        b=MnA67JUz116Fp4TA/GTNFpBxGXaeNmHxWQvHtxNDxzO2s6Z3N4AQvZFQsS+q06OWeQ
         8et57Synej0Q+Tqv2HWRo5HcnLQubl3ByCUVY80EZ9X6vYBMv8kFH82Qq5HqsceU8JcM
         yqfLNwJA3RDZWcgnJNoNNLrso5pTwzgWH5WRPo7SsjNodWTZdyp5KLjXRfyVXSjPlp7K
         Iaxfy2LqIhv9K1WvACSOv3oGOQ6zcNOa5nIKADL4Kwr/ea6f/LFC2yr0Tg3fCjx75T2g
         jM4efjIHVTjtcHf9qF1kZ5rWbxe6phquF7xcuYa/7X12j5HesLWyo67nnQdr0N7DsPkq
         waHw==
X-Gm-Message-State: AO0yUKVJLYwG+ZFfSWMD17J0ZX5SzMTPR1EpXnm7srABJeo7QjyApumx
        aBYz9+QiPNDcppIV2ob+y7Pz4w==
X-Google-Smtp-Source: AK7set+f9cpJyxCSLO6I2npjkfIwt56hnr9ULKBRmRjuy9MEkUdHAMeS9NJlzhQt8QuW3LddJn4H0w==
X-Received: by 2002:a05:600c:c8e:b0:3db:2e06:4091 with SMTP id fj14-20020a05600c0c8e00b003db2e064091mr11333479wmb.37.1678700192785;
        Mon, 13 Mar 2023 02:36:32 -0700 (PDT)
Received: from [192.168.7.111] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c470700b003e8dc7a03basm8792434wmo.41.2023.03.13.02.36.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 02:36:32 -0700 (PDT)
Message-ID: <292f25d7-2b2b-ba2a-36c3-c207960141f9@linaro.org>
Date:   Mon, 13 Mar 2023 10:36:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] MAINTAINERS: Add include/drm/drm_bridge.h to DRM DRIVERS
 FOR BRIDGE CHIPS
Content-Language: en-US
To:     Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, andrzej.hajda@intel.com, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@gmail.com, daniel@ffwll.ch
References: <20230313055951.2997299-1-victor.liu@nxp.com>
Organization: Linaro Developer Services
In-Reply-To: <20230313055951.2997299-1-victor.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2023 06:59, Liu Ying wrote:
> Appropriate maintainers should be suggested for changes to the
> include/drm/drm_bridge.h header file, so add the header file to the
> 'DRM DRIVERS FOR BRIDGE CHIPS' section.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3d409875740d..b6e7ac70b8a8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6824,6 +6824,7 @@ S:	Maintained
>   T:	git git://anongit.freedesktop.org/drm/drm-misc
>   F:	Documentation/devicetree/bindings/display/bridge/
>   F:	drivers/gpu/drm/bridge/
> +F:	include/drm/drm_bridge.h
>   
>   DRM DRIVERS FOR EXYNOS
>   M:	Inki Dae <inki.dae@samsung.com>


Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
