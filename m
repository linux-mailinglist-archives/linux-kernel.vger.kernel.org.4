Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B97574AC43
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 09:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjGGHtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 03:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjGGHtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 03:49:47 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2D71FC4
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 00:49:46 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-314319c0d3eso1602236f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 00:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688716185; x=1691308185;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9EnDHhrFdq4WRPA6nencTKPgQFqADeWH5m8/o3xI9B8=;
        b=g1YuWBRKHLFT0FuLHKbxERzH7W5s4CbuSJ3luIHO7njz/BcL7v6U8EMEAou5wcL5XU
         jdC024WagmvLbTQU7S4FFroIzyhT0XYsAsqySsoRm/tP0HZeMKaNm5vagX8fNtCX5w7d
         +TTVnENjnND/pMl8I2rZFHIepEkmC3xVhpjM59FIZhsbzOdOrrRg9HkIsRObyIIEztC+
         xskJ89cqaVli1Vps42QIQRwflilzYnTGlyjv9OaN1RXkNkFu0GNCJI4COY6iUNz9InL4
         3HoL+j9VD+pVmS0Z17nCjCK904gxrTPnDYKAJgErrXymk8e8G8f6HrOAOpw6XB2zn+C6
         FlUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688716185; x=1691308185;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9EnDHhrFdq4WRPA6nencTKPgQFqADeWH5m8/o3xI9B8=;
        b=az9ZnMz6t6477/qbN4J7CBBFzNIUPxGLuSKj9JGfKIJOqa7ywUIPSvuwars9G10pCo
         kQhlHuoGGF0hqzmNDrj7b9BM2RYK6cif9KJ13Y6yKZvVrIhKzzpXpsI31alhk0pKZwzB
         ZxpMY+tgNWSndPN89qcDi4eJ+eQFdk69/GT3tiXAy4kH6ZXUXGrTNZ+Mi3R6R7eokBL2
         2O6GII/GlmbnRREIWpRh0jRJgZzeTpkMZyCCP0xjtmNSZPYNom0YY+ysb9Xq8HgIcOPF
         e5FwW7yXPeBg+uzQxMNkrr6aK0Z8FbjXnqxPOUchRdBkYV01QlWcN9h+6zmhZflQUKWn
         g7AQ==
X-Gm-Message-State: ABy/qLb1aSRmAoiJ4efjZb2tSBxI5HoOUETD2R6gDeCI0RE+6hy8uFH3
        1af6Up1yLQ8H/A5SbY5Wi1QPgw==
X-Google-Smtp-Source: APBJJlGYScvW1lAKhc3c3YrVDD6Uj/RBfcMAhiRqaaXOv3mivFVVkG2S890dmxWftnhVg5f1N40JFQ==
X-Received: by 2002:adf:e2c6:0:b0:313:fa44:a410 with SMTP id d6-20020adfe2c6000000b00313fa44a410mr3787177wrj.52.1688716185182;
        Fri, 07 Jul 2023 00:49:45 -0700 (PDT)
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
        by smtp.gmail.com with ESMTPSA id g3-20020a5d5543000000b0030e5bd253aasm3739416wrw.39.2023.07.07.00.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 00:49:44 -0700 (PDT)
Message-ID: <bbf39525-5afb-2185-e768-f78de0ed63e4@linaro.org>
Date:   Fri, 7 Jul 2023 09:49:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH V2 1/4] soc: amlogic: use name instead of index as
 criterion
Content-Language: en-US
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
References: <20230707003710.2667989-1-xianwei.zhao@amlogic.com>
 <20230707003710.2667989-2-xianwei.zhao@amlogic.com>
Organization: Linaro Developer Services
In-Reply-To: <20230707003710.2667989-2-xianwei.zhao@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/2023 02:37, Xianwei Zhao wrote:
> The  variate 'index' could be equal to zero in some SoCs. Such as C3 SoC,
> PWRC_C3_NNA_ID be defined zero. Use 'name' instead of 'index' as criterion.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
> V1 -> V2: add a new patch for change.
> ---
>   drivers/soc/amlogic/meson-secure-pwrc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/amlogic/meson-secure-pwrc.c b/drivers/soc/amlogic/meson-secure-pwrc.c
> index 25b4b71df9b8..c11d65a3e3d9 100644
> --- a/drivers/soc/amlogic/meson-secure-pwrc.c
> +++ b/drivers/soc/amlogic/meson-secure-pwrc.c
> @@ -179,7 +179,7 @@ static int meson_secure_pwrc_probe(struct platform_device *pdev)
>   	for (i = 0 ; i < match->count ; ++i) {
>   		struct meson_secure_pwrc_domain *dom = &pwrc->domains[i];
>   
> -		if (!match->domains[i].index)
> +		if (!match->domains[i].name)
>   			continue;
>   
>   		dom->pwrc = pwrc;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
