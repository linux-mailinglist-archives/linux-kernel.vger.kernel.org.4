Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FED86BA8DF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjCOHRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjCOHQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:16:54 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA752D160
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 00:16:52 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z21so6347300edb.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 00:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678864611;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l12j+5DZPIr3CM2plc1IPPLtAzb+IPIK3UVC9/MBJgA=;
        b=Salfcnwr7cE3680LEI6UokKNQ23hdAFfxBkXrk9OgvhcU7KAr2nZaOfrWy4aD19rc3
         WVFdvRJ4PhHH88B9nj8sBQc3sfeI+DyQWYi4o+HFGp43wAT7n1XsMPd3uKioTlz1FY0/
         Y69J1H6q+OGPmVT8f9gYmtVgsbdOFoJPIsoini5Rd0rQDjOJGWC+hcKKq3qdcRYv+z3g
         Q2dOlIuRxfejp40fuDIXjGE/NTvS3RRVpccmql11Rr0I41Cm0+rMqn/FzVlH0geas9kf
         83Wot/qXX9/5BN0nFnq1Z3S0Nfcf4+iXTMDImerQaoJEuNxbb38CT7KuJY1OF5EK6BXh
         +ZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678864611;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l12j+5DZPIr3CM2plc1IPPLtAzb+IPIK3UVC9/MBJgA=;
        b=dyhsamI9nFrsjqPzYKBCcFDh4j8TG4eIEq9R8jzc7Bm9TVJ+NvYC+sIq3pgHZI8eoz
         gZeV7GbCDrTD+H0M2KB1yk+yQIThuWGMHj8ibRdP9BYnWO2/pSiS4maXhWwRXR2XV1Z8
         ZvApadLT5lYeVYPB1saNpFNJ0MiwbNvy7VqrvJar1K3NSuWahR0QrjJNzz/o+GhbICAg
         dm1HibTkkNEpfsUPPTu0rfoiRok7AihNOZt0bLFV8SQ954yAQW/sSCxiWaA4+gW+TVoU
         U/U+gchsCBjLH5BlfPsEnqZcXlASxHxvEANHbRd9JpCU6djG1Q9vNXKVh7PGdxTOX++f
         7aIw==
X-Gm-Message-State: AO0yUKU9HRkddwuCCLJtYeMKP5ow4zj+e0J35Wan5RQ/v3kMn+1h2uMC
        ZgyutiTlW6S6bzFcDwIGAe5DCw==
X-Google-Smtp-Source: AK7set+Cw/lpF35VCg0jANWxJglVMzoNi7c/Kjdm3hf/RwhjGB4/m0AFAUdJGGQ4tg4dqD1K2Oyidg==
X-Received: by 2002:a17:907:c78a:b0:91f:5f9c:5db6 with SMTP id tz10-20020a170907c78a00b0091f5f9c5db6mr442065ejc.52.1678864610933;
        Wed, 15 Mar 2023 00:16:50 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:940e:8615:37dc:c2bd? ([2a02:810d:15c0:828:940e:8615:37dc:c2bd])
        by smtp.gmail.com with ESMTPSA id qq11-20020a17090720cb00b008c6c47f59c1sm2105301ejb.48.2023.03.15.00.16.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 00:16:50 -0700 (PDT)
Message-ID: <b1e0cc91-4a67-6417-eb4e-e044ce6dd03b@linaro.org>
Date:   Wed, 15 Mar 2023 08:16:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: rockchip: Add Khadas Edge2 board
Content-Language: en-US
To:     Yixun Lan <dlan@gentoo.org>, Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Nick Xie <nick@khadas.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230315033441.32719-1-dlan@gentoo.org>
 <20230315033441.32719-2-dlan@gentoo.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230315033441.32719-2-dlan@gentoo.org>
Content-Type: text/plain; charset=UTF-8
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

On 15/03/2023 04:34, Yixun Lan wrote:
> Edge2 is an ultraslim, credit-card sized ARM PC designed by Khadas.
> It has quite a few rich peripherals.
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

