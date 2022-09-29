Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768B75EEE3C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbiI2HBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235062AbiI2HBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:01:24 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1300DB07ED
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:01:12 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id i26so845243lfp.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=/IXLbjH5KQJTVAywyqeKJX3mELhE8CvWdqMVSTRdvVc=;
        b=ulNv9ztLuwltm4KnY0u7qOVoQ4PAMVml3FifhKVcV+4Yyhny+3sq6cAuV3U01ktIvt
         NN76w9jfTNbWEhlSUCMKp1f6APBkjyA0Bb98WtHkOs7mV16Rc9IP58+mWxIujwz5G7wU
         wVYdHGXuPVEBfT9OtbNtAGKVuuN8UqtAaKYaikH/AupJm70k5TPBLdIpocGefGdzoQ5y
         EnJH9mIO3GEMJ2i14W3HYcVcMvO1Up1U+gD3ZLdODl5HEF7Tu+UjYTMjdGmcuzq6Qiba
         fcxnTZeed5Ynl/Gbp/RTfL/PFqxRSHylbMC12sAQBAx1LHsMi7BRtfMcXVqjIArVieHy
         2bMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/IXLbjH5KQJTVAywyqeKJX3mELhE8CvWdqMVSTRdvVc=;
        b=AlJWbX4MOBzAhyXDV3KRybzLnip+eRcZOg6JCfreAZbYpf0KXfEEuETyN0mGNLBy4+
         9srWMzAaBpazzMXQ9NxW2MWqa8pU5hXYB71A8JsNmmsPZLb/eztY9+o8Efq2JOgKTRpk
         6z0Nv8HmoEs7gG59ODSSbhAl7LgA00HV/V9hlr+LWrZ4vYHgKHOaCqzqiL3RaHkhx8Lz
         0tvezaiw3vOwXRd7Yi13x6XwHJKtNCmkQJ29u6Fw9PNusHQ3gAIxJxQ3Xw8gyETli+wH
         uRHJlX5ZnVxuTOSOOrmrUHxYavQposAI5QWva8RdCiqigFjTMvkU9qNfX0jAvZSg+48h
         k45g==
X-Gm-Message-State: ACrzQf3flTvwF3TVbXd0XDM2Uvm1pIZmLgKBq7rahxpMX01n+2fqI8P3
        ScI4oochWWfkNEg6fFCjfQ2eNg==
X-Google-Smtp-Source: AMsMyM7iC2rj0wIw/XHeSNZGx3uJYvB4fvO0oao86ygIhhfvcid/LGD+visWqDZnceunDjjMcb0iKA==
X-Received: by 2002:a05:6512:1283:b0:499:d0a3:3ca8 with SMTP id u3-20020a056512128300b00499d0a33ca8mr707348lfs.665.1664434870569;
        Thu, 29 Sep 2022 00:01:10 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q12-20020a2e84cc000000b0026c41574790sm631066ljh.30.2022.09.29.00.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 00:01:10 -0700 (PDT)
Message-ID: <efd42f94-1868-9189-d88e-f03b8c19f866@linaro.org>
Date:   Thu, 29 Sep 2022 09:01:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/1] dt-bindings: usb: tegra-xudc: Add Tegra234 XUSB
 controller support
Content-Language: en-US
To:     Wayne Chang <waynec@nvidia.com>, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
        krzysztof.kozlowski+dt@linaro.org, nkristam@nvidia.com,
        jckuo@nvidia.com
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220929034221.3817058-1-waynec@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220929034221.3817058-1-waynec@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2022 05:42, Wayne Chang wrote:
> Extend the Tegra XUSB controller device tree binding with Tegra234
> support.
> 
> Signed-off-by: Wayne Chang <waynec@nvidia.com>
> ---
>  Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml b/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
> index fd6e7c81426e..7e4eb379bcf4 100644
> --- a/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
> +++ b/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
> @@ -22,6 +22,7 @@ properties:
>            - nvidia,tegra210-xudc # For Tegra210
>            - nvidia,tegra186-xudc # For Tegra186
>            - nvidia,tegra194-xudc # For Tegra194
> +          - nvidia,tegra234-xudc # For Tegra194

Where is the driver change? Where is DTS?

Best regards,
Krzysztof

