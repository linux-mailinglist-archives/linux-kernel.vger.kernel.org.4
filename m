Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB235BA98F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 11:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiIPJix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 05:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiIPJih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 05:38:37 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA45EAA3D0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 02:38:33 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id u15-20020a05600c19cf00b003b4acef34b1so2890662wmq.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 02:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=jaViFlX4lh2uaP1D7syHJI1ti93zcQPyxKWLvbMQLAE=;
        b=di7m+Qy+mVsh0nfi9wBs7xlDXuCkW2nW8ioSmZozZxAgPKVWxVEJ+Nvilbfb+nVFKi
         n/53OTs64Y9EQBSLYPB6XlQcaQwCMqkZ57D7GrFcQrMt3jwhP1S56BHNXHFzh14Xm86m
         te2LQZJn0wmygQUKSgTkPGn2HzZ03p462MV4XL4WIbpEq0sRsA/KXGb49VTX3APD1cw6
         /W2fs6Ui4PAx5W2fKcUK1n8MTI0Unxo32Fs438ahnOzD7HtE9uqSoPPvxW9c2u51zr4a
         FIxVTMf8XmzdM62zY8xSLuh+/bght3rD5Wu1c/I0XfDx5GRHWONNbxCCY4drUEHAHXkE
         33ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=jaViFlX4lh2uaP1D7syHJI1ti93zcQPyxKWLvbMQLAE=;
        b=ywd9RdO1QaKT0pEoXfPCWR9zN/MMdEgBc10zcEMubY4itO7RgT8OPTqUKhI1m1v11N
         NMSJrswQfkH+Q37Lk3umze7DRReXQsAJHRtGfd/tMWTSvk+fZbeEwL8DspMj1YPQ9pTx
         tyhTdF8ho3llySVWVrrUxVfN/moanCKb7Y9AoNTvAnO98UkN0EJdkDisjF3xBAYE7eXD
         v/jjsB7zrEb1m3/YiKw3iq7xqBrj3hiZBdXysoeJO+C7z6usJOBeBVgFYMkGy1yNSlFu
         sqFnI56dn0PUQeDL0Kousk3hi6FbZtRIPtwo4o6taU9+BxvYqSUF+EzcdKZWWtNeeyOr
         z5EA==
X-Gm-Message-State: ACgBeo3IVp5+cotEJCjP3S0ZfKBe7nA9IyIOeK8vsbCqNilg2vpvmYi7
        bO8gDF4ce+KPaXldCgI0LwiqAA==
X-Google-Smtp-Source: AA6agR5K6aEBX4onUgN7iO+sqyyS+wfQKkh5xLNQnWsZy4tBsXMLtosyEoNbV9S0WTZqjFI9cFCkWw==
X-Received: by 2002:a05:600c:34d6:b0:3b4:91fd:cfc with SMTP id d22-20020a05600c34d600b003b491fd0cfcmr9667661wmq.1.1663321112215;
        Fri, 16 Sep 2022 02:38:32 -0700 (PDT)
Received: from [10.119.22.201] ([89.101.193.73])
        by smtp.gmail.com with ESMTPSA id x4-20020adfec04000000b002253604bbefsm4586633wrn.75.2022.09.16.02.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 02:38:31 -0700 (PDT)
Message-ID: <42e78db0-74f9-3098-0cf2-908092a0b594@linaro.org>
Date:   Fri, 16 Sep 2022 10:38:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/2] dt-bindings: firmware: imx: sync with SCFW kit
 v1.13.0
Content-Language: en-US
To:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viorel Suman <viorel.suman@nxp.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220915181805.424670-1-viorel.suman@oss.nxp.com>
 <20220915181805.424670-2-viorel.suman@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220915181805.424670-2-viorel.suman@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2022 19:18, Viorel Suman (OSS) wrote:
> From: Viorel Suman <viorel.suman@nxp.com>
> 
> Sync defines with the latest available SCFW kit version 1.13.0,
> may be found at the address below:
> 
> https://www.nxp.com/webapp/Download?colCode=L5.15.32_2.0.0_SCFWKIT-1.13.0&appType=license
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> ---
>  include/dt-bindings/firmware/imx/rsrc.h | 299 ++++++++++++++++--------
>  1 file changed, 203 insertions(+), 96 deletions(-)
> 
> diff --git a/include/dt-bindings/firmware/imx/rsrc.h b/include/dt-bindings/firmware/imx/rsrc.h
> index 43885056557c..a4c68f394986 100644
> --- a/include/dt-bindings/firmware/imx/rsrc.h
> +++ b/include/dt-bindings/firmware/imx/rsrc.h
> @@ -13,34 +13,38 @@
>   * never be changed or removed (only added to at the end of the list).
>   */
>  
> -#define IMX_SC_R_A53			0
> -#define IMX_SC_R_A53_0			1

You cannot change binding constants... Aren't you breaking all possible
boards and users?


Best regards,
Krzysztof
