Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97BB6D9171
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 10:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbjDFIZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 04:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbjDFIZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 04:25:14 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843011BD
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 01:25:13 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id fi11so23898439edb.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 01:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680769512;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E4F+7d3J1d8Tojpr35OzJKNgJHvYHx+anZ0eoB7h8gw=;
        b=UHf+wRDzmZllhHH6nZ3fb1iqeWhdx6IvpJSSY0dlcz6jjviXma8CLDNRME4kFl+kz/
         uzIkZ4m07E2asHciVv2XZz6XCUga53m4L9STnttVv2MPHXf2TI2o8/kj2LOUbtoAyslU
         KH3um78Z9Ns8tf1Zj6TsEE5skLe5OPvVt52RCSC67BNI2mGyiSu3MoDxaLqPESE1bO36
         AYat1rmQF8ZlEVMjOpC+OWxnJRbr6zEIHjv7oNNyHZDhSKWggERub3nSuxTGJy0T8deG
         v/pqOUxe/3Wpkvp3G+9dHhDhY6WpoM0JjtgPtDKe8RQRhGSNfJvb2sAHG4dpF5pBTE6V
         CjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680769512;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E4F+7d3J1d8Tojpr35OzJKNgJHvYHx+anZ0eoB7h8gw=;
        b=s93GQiRojZng7qVMjdpCxrFT96IMAGPBqkL+3jXXoxoOoUJgRPwRMCQNFIf7O8HVLf
         27o8j8T2AAUovXf55cStU86tDNKULby3NkO9GUbBeyhfx5hE6DF/yVxJc5I3BF2hBo3s
         NfJmzFwRNfaWtP1HHvnwpVt+xUB5QHCsheY4kqS8nzJNhYsrjsAIpo4FY9/vZRSHQ3Rc
         C2B1Gloz3lJo1Au1JVnxYxOzhfPolPhHYofFBDgkVgXwcxGOpwiP9K3UYcZ3uUB2LO5J
         xusB3+PnO2Fg0fIPyW+ZhQuZwXQWtJufiXcCs8sJAbqqhqr4En2nUA4iwRDWUTYHga6i
         Rf/w==
X-Gm-Message-State: AAQBX9enp0rjmmwGVKQhMbE/XCXQAqktMoWkMwE27tk7wMbGTV0goWx6
        okuJ6ZPuUXFc0LrU5q6g9CTx8uTi6j1eBOqQ/tM=
X-Google-Smtp-Source: AKy350Zh5RCJaVNCZk4j+Q0sSNrwnXyD1MaiZ+wEhn3fiWt8bz5ky4TlulnxqZXbiWyVfs/0ZvbrDw==
X-Received: by 2002:a17:906:4893:b0:947:3bfc:4c84 with SMTP id v19-20020a170906489300b009473bfc4c84mr5324289ejq.23.1680769512017;
        Thu, 06 Apr 2023 01:25:12 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id c19-20020a1709060fd300b00931baabe36csm495422ejk.63.2023.04.06.01.25.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 01:25:11 -0700 (PDT)
Message-ID: <4115e47e-b64b-391a-493c-701c8de0565b@linaro.org>
Date:   Thu, 6 Apr 2023 10:25:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 8/8] regulator: fan53555: Add support for RK860X
Content-Language: en-US
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Joseph Chen <chenjh@rock-chips.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@collabora.com
References: <20230405194721.821536-1-cristian.ciocaltea@collabora.com>
 <20230405194721.821536-9-cristian.ciocaltea@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230405194721.821536-9-cristian.ciocaltea@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2023 21:47, Cristian Ciocaltea wrote:
> Extend the existing fan53555 driver to support the Rockchip RK860X
> regulators.
> 
> RK8600/RK8601 are fully compatible with FAN53555 regulators.
> 

> @@ -531,6 +634,18 @@ static const struct of_device_id __maybe_unused fan53555_dt_ids[] = {
>  	}, {
>  		.compatible = "fcs,fan53555",
>  		.data = (void *)FAN53555_VENDOR_FAIRCHILD
> +	}, {
> +		.compatible = "rockchip,rk8600",
> +		.data = (void *)FAN53555_VENDOR_ROCKCHIP
> +	}, {
> +		.compatible = "rockchip,rk8601",
> +		.data = (void *)FAN53555_VENDOR_ROCKCHIP
> +	}, {
> +		.compatible = "rockchip,rk8602",
> +		.data = (void *)RK8602_VENDOR_ROCKCHIP
> +	}, {
> +		.compatible = "rockchip,rk8603",
> +		.data = (void *)RK8602_VENDOR_ROCKCHIP
>  	}, {
>  		.compatible = "silergy,syr827",
>  		.data = (void *)FAN53555_VENDOR_SILERGY,
> @@ -637,6 +752,18 @@ static const struct i2c_device_id fan53555_id[] = {
>  	}, {
>  		.name = "fan53555",
>  		.driver_data = FAN53555_VENDOR_FAIRCHILD
> +	}, {
> +		.name = "rk8600",
> +		.driver_data = FAN53555_VENDOR_ROCKCHIP
> +	}, {
> +		.name = "rk8601",
> +		.driver_data = FAN53555_VENDOR_ROCKCHIP

Why do you need this entry match data if it is the same as rk8600?

> +	}, {
> +		.name = "rk8602",
> +		.driver_data = RK8602_VENDOR_ROCKCHIP
> +	}, {
> +		.name = "rk8603",
> +		.driver_data = RK8602_VENDOR_ROCKCHIP

Why do you need this entry match data if it is the same as rk8602?

Best regards,
Krzysztof

