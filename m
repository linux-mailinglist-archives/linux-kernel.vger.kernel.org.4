Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BCF627A5A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiKNKWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236536AbiKNKWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:22:04 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A891D0D0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:22:02 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id u2so12515511ljl.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=49ivR/hLqgiIv6OqrmbBxE2JsrRkoVPBA0UvfU8gm7A=;
        b=l/uTJzzSuAgXfDj8m5PhL7yvhXNKhzoGsmDj0JX7Suu+H3cmDxCrPfKGiOzsGJt49T
         gAh6TVWrK0jJXzpG6hb4UW1KM/WvKtjIFB6tLKxfVmz80aYmhatH9oFzeQp7ZnbZZGhI
         4jIFn2NCHw6AWiQVqOG7ak+nw9MVWr0sOJcJ4WsUwe/GNqcxtEgjloXs11hhrf2fx0mp
         pG64xF/TP0pIpMFkY1TSjRA3LwJff/FJwBGbMN0MbEY+IAsAhSXtEB6eatOxcNJLGS+3
         d5jHZ2fAH71M7Z5YKLmbmROdY415BkgPWa4ZsKTG48H0uA9fLPuxBKP4e4ANj85l77lz
         EhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=49ivR/hLqgiIv6OqrmbBxE2JsrRkoVPBA0UvfU8gm7A=;
        b=cdUu8YBozRFDfcI2pRbZHSuJUtfOyMIqfYI8mz2arsX4jC9/7cnGF7J2SIp400fBIn
         rbbo+BhpqeiJ3iOe3hRPOCzWhKUYBXvQmbg7CPnqRkjjelRihe80CfO08K30uTu6F3X8
         8iqhCaNcoLZK+W8Kz/8N3mKrrltdtnO7YngNrOmOCwOhVM5GZdS+zmoFTrtKNxdBYiFo
         LF4b4oyicjaVIwUBXzotE74S/7XGw0mUYVhSkPkCjZLktp73i8sC31cdDQBHN3qvCRk+
         hm6nacYIlhZXzvQ5SbgUP1tU3iF6w/zMDU+KE5m00V0lzwjH7ixM3DACzQEvZ+P4P5m5
         ghXw==
X-Gm-Message-State: ANoB5plAWlKx7pHFFKBcm6Xv4RI7agkne78qMAnKGPHN846b0frlscVL
        CDCIktF13wLttC6uzcyM3eohQQ==
X-Google-Smtp-Source: AA0mqf7l8bh0quUrWupe/mrB5RNgcjOTA4Xt7T1LJfExKiUMll8vKYtDKCJcM8pf87jCy1PMmbEozg==
X-Received: by 2002:a2e:b705:0:b0:277:1c8f:7e8c with SMTP id j5-20020a2eb705000000b002771c8f7e8cmr4243094ljo.296.1668421321248;
        Mon, 14 Nov 2022 02:22:01 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id t13-20020a19ad0d000000b004946e72711bsm1759717lfc.76.2022.11.14.02.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 02:22:00 -0800 (PST)
Message-ID: <1ac3e532-566c-77d0-a9cd-516d0914d311@linaro.org>
Date:   Mon, 14 Nov 2022 11:21:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 08/18] mfd: max77843: Drop useless mask_invert flag on
 irqchip
Content-Language: en-US
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, lee@kernel.org
Cc:     mani@kernel.org, cristian.ciocaltea@gmail.com, wens@csie.org,
        tharvey@gateworks.com, cw00.choi@samsung.com, brgl@bgdev.pl,
        mazziesaccount@gmail.com, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <20221112151835.39059-1-aidanmacdonald.0x0@gmail.com>
 <20221112151835.39059-9-aidanmacdonald.0x0@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221112151835.39059-9-aidanmacdonald.0x0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2022 16:18, Aidan MacDonald wrote:
> Setting mask_invert to false is pointless because that's the
> default. The flag is also deprecated, so drop it.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

