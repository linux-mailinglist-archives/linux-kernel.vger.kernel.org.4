Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE45270159A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 11:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbjEMJYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 05:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjEMJYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 05:24:01 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA8240FA
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 02:23:59 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-96ab81aa68dso248321066b.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 02:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683969838; x=1686561838;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+nUJ6bVVbajhYwzqyGBHtXorNDh8RrDk7cVB9nWp+XA=;
        b=GY6OGlUsN9I5wgSgN/Y6d6Oq7TYwbRgw9h10QC0u33QloU8zUQMELVg5A5EFBP2TMK
         5+DacRzMzbe+aUVG8N3JlMQcsu+nRIyL6RkcgvccBdxX7dlkvJZW+L1ADOwdrlXlFn8z
         nA+UL39YcebKcms/hSP3rpVc5rgY7uHBRyL0VK0sP/BPmeADdZsTUqV6zSx6EZR2P9ew
         iTWLvGS48yx4Rj+rvSbUGFyS+uAVh1qmjb8GydfyaEzvF3XmCg8KvLm2Y5f9NNrdz8k6
         ZxUH1Sf4k7zPSHciwm/OK3QT4L85cmEeWh5BHmajOsGJ4p0tL++tbFBvAoG+v23csiYC
         AvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683969838; x=1686561838;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+nUJ6bVVbajhYwzqyGBHtXorNDh8RrDk7cVB9nWp+XA=;
        b=gpYpEADEN1ihT0bVVaoDR710H/BQEvRFyk0yANNE0+uNbtiu00rfaU2oz5vltSaDiQ
         ueqQQnC2hSmcWy/i9YE0aXmLyxi+o7eqrwSQ75IXdlfSqa4MnNuAHkjnswOh/MHaCKOo
         RqQgrwY6Tqbtv7dS78IBLp2JnIrom1Xvc8/FkDf/u1mno/7Oc5+EzVWsPimcdctnFfPN
         SHoUAhdyav7EibZoBfDKAvLc4how7sqNAZ7QgO5pzacqypNWMi+RuCTpNFed6QLnNORH
         DWB4ea1lcYFL+SP7u6weSWOxlYs2BbQ3AgdQDfCWVZ0BPKXrBsM5bKxg/akS7w1JXZmN
         KlfA==
X-Gm-Message-State: AC+VfDz/u5crfA6Oatat9xzK8A3waeHBaXtDB45xxtXbffW/3kWU/82e
        bFhPZV6G8B65Im0Cx7+ov15/wA==
X-Google-Smtp-Source: ACHHUZ6k34w7iV1aLVJwog/4Ot7rebbRo2qcqGCxyaHSI/PQtwd4jd6J8SiA3ejtI7MpSvBRMN2D2A==
X-Received: by 2002:a17:906:db08:b0:965:fa80:bf1 with SMTP id xj8-20020a170906db0800b00965fa800bf1mr25142579ejb.32.1683969838396;
        Sat, 13 May 2023 02:23:58 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:1d0:810a:586c:c5ba? ([2a02:810d:15c0:828:1d0:810a:586c:c5ba])
        by smtp.gmail.com with ESMTPSA id og40-20020a1709071de800b0095807ab4b57sm6668852ejc.178.2023.05.13.02.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 02:23:57 -0700 (PDT)
Message-ID: <6e61929a-b2f2-1e17-0166-42fe1004c345@linaro.org>
Date:   Sat, 13 May 2023 11:23:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: dts: imx8mq-mnt-reform2: drop simple-panel
 compatible
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-kernel@vger.kernel.org
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230512204627.3304342-1-dario.binacchi@amarulasolutions.com>
 <6a1bdc48-a65f-43c3-0a41-bd45c0c3b0aa@linaro.org>
In-Reply-To: <6a1bdc48-a65f-43c3-0a41-bd45c0c3b0aa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2023 11:22, Krzysztof Kozlowski wrote:
> On 12/05/2023 22:46, Dario Binacchi wrote:
>> The "simple-panel" compatible is not documented and nothing in Linux
>> kernel binds to it.
>>
>> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>> ---
>>
>>  arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dts | 2 +-
> 
> I already sent it:
> 
> https://lore.kernel.org/all/20230326204502.80794-1-krzysztof.kozlowski@linaro.org/

And makes me wonder, why did you use exactly the same words as my patch...

Best regards,
Krzysztof

