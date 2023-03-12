Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D946B6A46
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 19:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjCLSkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 14:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbjCLSjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 14:39:52 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57161BAF1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 11:39:23 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id cy23so40168410edb.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 11:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678646322;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MukKlSaXn+csqECoJ3KBk99PAzcPglNNLVcc1uff/co=;
        b=qIZqT9XEQSwd1NXp19KkdEJq/QPh/tGB/PgDP9MgxnoG+lhw171u+q5EFE4lfAGcRq
         lcgHcupo8gBG/LCOJgwFq6tgLuXApZ5+vZQkvwqp5KVXTJVewV9WQUxsy+YwI6nhvmtv
         U3xDbMuKAoWB+IFGmj5IWtD7RUXsuJu30AbBhaE7fdp6wa6s6W2NmFpDz3S/98863jbp
         aEjegxZ2unqYrCwIFW4sCX/qQ4ntes9CuLAxgOu6JqZEUBA4n3zhUG9qLxV678SYhA0l
         eX7yFSdggBXPnprodOEpdeclkFrpV2yqO6tQmEadJId+fbBLX+LjNmCMHasbEbFUhDGY
         7pnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678646322;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MukKlSaXn+csqECoJ3KBk99PAzcPglNNLVcc1uff/co=;
        b=WFHccrGxPESBGOBLaRkeveD25hiKgEa316LvdFDAlhbyQDHsu9q0Zp0YRjARl4v1zh
         ySU9VCPStRiFTYLroz2PU5Ol7kuwGHa8naS8zHI5eoalXE5VL30RqcVMK04XVyg1s9wz
         JuEnddSw67eq4MrvOuAAk5vkrAo2O1tvEVzF+FVwmz/7gwVJNdyocK24qijmTYbUEqRx
         eksg/e6Ry8pMtrXXQMunSBM/NqxKnuwRaR8wXH8t3QrdyOhHoY1c8IH8OLP98R2HQSmR
         8LTjZ8hjtwkIbgxGT9KmNl5owqVcw0xJ2G+etN9PuNXtS9Xt6kzCqr8tNimKNWdKKBqg
         XJEw==
X-Gm-Message-State: AO0yUKVwzuws7WJvbGBTvzaeXOqoG/0zUvVg9hMddYXyQiefLF/DMP9y
        QpMdCuXGiH49+DvEaF5zjCtyrA==
X-Google-Smtp-Source: AK7set/ds4FZR+9Sbx1wmYQb+SiE4TL0IAvOHMVGkztRD7on4JuKvVShrEDtEqcE/ztJ7kgMJVSM+Q==
X-Received: by 2002:a17:906:fe08:b0:881:23a:aba5 with SMTP id wy8-20020a170906fe0800b00881023aaba5mr42754123ejb.11.1678646322468;
        Sun, 12 Mar 2023 11:38:42 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id jw11-20020a17090776ab00b008d53ea69227sm2471340ejc.224.2023.03.12.11.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 11:38:42 -0700 (PDT)
Message-ID: <6c1f07c0-f656-19d5-055f-042125697e5e@linaro.org>
Date:   Sun, 12 Mar 2023 19:38:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/8] arm64: dts: qcom: sda660-inforce: correct key node
 name
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>,
        Gustave Monce <gustave.monce@outlook.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230312183622.460488-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230312183622.460488-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2023 19:36, Krzysztof Kozlowski wrote:
> gpio-key bindings expect children to be named with generic prefix:
> 
>   sda660-inforce-ifc6560.dtb: gpio-keys: 'volup' does not match any of the regexes: ...
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Apologies, this one patch was sent second time, without a need. Previous
submission few minutes ago:

https://lore.kernel.org/linux-arm-msm/20230312173458.411231-1-krzysztof.kozlowski@linaro.org/T/#u

Best regards,
Krzysztof

