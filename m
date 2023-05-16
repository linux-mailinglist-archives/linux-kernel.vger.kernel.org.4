Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B807A70464A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjEPH0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjEPH0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:26:42 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8455C18E
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:26:41 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f41dceb93bso72679155e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684222000; x=1686814000;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hz+au+qUB6SxKi+qykB673rTVgNMoB1frUgWHg+rsLg=;
        b=MNrp1H63iaoBI8hbDN1m3mIPv0cIdy640o+Nh2IunYwS5OkIQ1Abz9cB91TmepJ8gU
         nyC0lBHy3hhnQZu7CeIsLx1CL00K+Vzhe9nSx+I25bctVFh4nOCJdT0d9zGVMRnL+8cT
         c5mebiOmX0zt11C13KJZGR97qj7AnwojHgLQpV2jprqX5VzZo3XJYwvc5UVMO3sdoZOz
         f22qHBW0AEMIfeEN3p1Gq6ABxoKAREGIhj5+cYgKW8I3BkZcU/kwowkWAsDa9N9rzwGS
         RGJPn/zgVrq20hCdUetBEQ4sj/PdXTl98WNuR/JcxWYXGClicsRdq2PLgsITsTDbA0JK
         VrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684222000; x=1686814000;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hz+au+qUB6SxKi+qykB673rTVgNMoB1frUgWHg+rsLg=;
        b=jua2SRQwUnWI6z+h4uKgW/AexInyUcgcIzgvcDdUMRKFyFyuayLg+EZCYIuXmmL5Rz
         J7P8FeBV/1f5mZK2eMCB5hp1d6En3z/p4OMfjbuzSobGlmGF6bcKMeTfKlu725dCyO8/
         kXRPlo3I93VFk90UxqgcqAprxxULcTIph7hCDU09Z+Tx/lGwWnHgg3DZizHuxTkJYQJB
         /7dd0bDK806p/BZA6ffpcz9WJw5UKKd4uKckkHIsUUyQEmBxWruL2wQe3L8+WGAU/rho
         mWf1wC6HNuVKVPECsESRd5X4dxKB2nIYBy3UL3aph0kFpAmOWhAav1W4ClHB+RRha81Z
         6CWQ==
X-Gm-Message-State: AC+VfDynBIylOLCmiw0GQX3X8LsfTsRfCt4b3N6hBrf7XzNJoRjOOGCP
        Hqd4vyNYzPm++/ivs+w0NZKwjA==
X-Google-Smtp-Source: ACHHUZ7D+Y/jBCKwmWM3hC8D664oReRitr6GThGsoDF5GvDJXGJ0eNddIgbv6jqwlNC3vde62mMtmg==
X-Received: by 2002:adf:f990:0:b0:307:c0c4:109a with SMTP id f16-20020adff990000000b00307c0c4109amr13177326wrr.6.1684221999997;
        Tue, 16 May 2023 00:26:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:86be:97a:a043:77a8? ([2a01:e0a:982:cbb0:86be:97a:a043:77a8])
        by smtp.gmail.com with ESMTPSA id p3-20020adfe603000000b002e5f6f8fc4fsm1499806wrm.100.2023.05.16.00.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 00:26:39 -0700 (PDT)
Message-ID: <6bb1586e-b141-5bbc-8206-d72a9e8d3596@linaro.org>
Date:   Tue, 16 May 2023 09:26:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1] drm/bridge: tc358768: remove unneeded semicolon
Content-Language: en-US
To:     Francesco Dolcini <francesco@dolcini.it>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20230515184408.9421-1-francesco@dolcini.it>
Organization: Linaro Developer Services
In-Reply-To: <20230515184408.9421-1-francesco@dolcini.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2023 20:44, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Remove unneeded stray semicolon.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202305152341.oiSjRpv6-lkp@intel.com/
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>   drivers/gpu/drm/bridge/tc358768.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
> index 03c7e82e4109..97ae3a9c90da 100644
> --- a/drivers/gpu/drm/bridge/tc358768.c
> +++ b/drivers/gpu/drm/bridge/tc358768.c
> @@ -952,7 +952,7 @@ tc358768_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
>   	case 24:
>   		input_fmts[0] = MEDIA_BUS_FMT_RGB888_1X24;
>   		break;
> -	};
> +	}
>   
>   	*num_input_fmts = MAX_INPUT_SEL_FORMATS;
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
