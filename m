Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EED06101B3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236426AbiJ0Tcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbiJ0Tcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:32:50 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075465B9DA
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 12:32:50 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id ay12so1347214qtb.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 12:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RtgEL63Tlyb0o1Eh/Oo0zvf3LB4TM+4LKozQxGoY5mA=;
        b=lkA69nOiOYyLC61juz90h/aBdsIingLRTQmDpl6vFdYxtApI8EgIIfvlV0tSlG3dn9
         G1AX+JiyrYu/HVyC2nWlQF/ImwdnBkLOr4wN+vZc1r++oF81LCzlgBNep900xrNq0nIS
         yBBqUhh2XRy019vt911mXg4erErQJbW28Tc9KGjuv4fMAcP9VP6CTSSVrNNGaOl7FIv/
         UznSdvKzc5TUG8eo9kjn1ax9IwR6NoEr8CQiSsqdsLE47H2fTGVppq/1wFkoRgHbrE6A
         wmrNC844NAKEtfnPC+Uo/JPoio0LZdrILJfpkk1uDIkMvXnBvNKvGTZsNMxvBxmce/9Q
         H2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RtgEL63Tlyb0o1Eh/Oo0zvf3LB4TM+4LKozQxGoY5mA=;
        b=omj+tBoFgqg0utZ3wSIBKx3l1gv4OgdO0WYuvRaEgFcuyJOx90xk7x5WVQlMHeJaKW
         CXLyQs2SgAmPaxCW/qbzJNmV3pq969N7GATsAmmxnElBvpcLrNnF1TPMD+nq1jfd9ycr
         3/ja8FvHVyG//yEZ8YqQ112XINMkO7Bl2UwiCAjfvQZtXgmBdUKBEiIUWCNlj0PyT8BA
         GrX7O57XBh9FWpBumgzrwZHT23G1LYXrTu3xJut8DKyyBgLfYeAPwVYR8lcv8eXLUFta
         5wiiLQ6MLfVmRkwq8Np2LwVqVZVeTkVFxyF2b39B4458MpN1/oAeJxS2LVnjDorUTQ8S
         B/bQ==
X-Gm-Message-State: ACrzQf0EOZOkdYrkkd0Ke1+TyrJKpvFR3qesCKHBTAOZqsSxfXSTdaS6
        8sBArcLoC4E+RTRnim6ALTo0Kz1CwiYdqA==
X-Google-Smtp-Source: AMsMyM7+EgBJ3VeVRnVI3DYBnQifABterCUNmIWpax4C3CZhC/fU7vjpzGm3rocEansWxHCs70HJsA==
X-Received: by 2002:a05:620a:400e:b0:6db:18a3:4001 with SMTP id h14-20020a05620a400e00b006db18a34001mr34886353qko.427.1666899158724;
        Thu, 27 Oct 2022 12:32:38 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id r19-20020ac85213000000b0039cc944ebdasm1306535qtn.54.2022.10.27.12.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 12:32:38 -0700 (PDT)
Message-ID: <5fbe3d15-5847-193e-f8f7-dd3d4cbe0aa3@linaro.org>
Date:   Thu, 27 Oct 2022 15:32:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 1/9] dt-bindings: mfd: syscon: Add TI-Nspire misc
 registers compatible
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Tang <dt.tangr@gmail.com>,
        Fabian Vogt <fabian@ritter-vogt.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221027181337.8651-1-afd@ti.com>
 <20221027181337.8651-2-afd@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221027181337.8651-2-afd@ti.com>
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

On 27/10/2022 14:13, Andrew Davis wrote:
> The TI Nspire devices contain a set of registers with a seemingly
> miscellaneous set of functionality. This area is known simply as the
> "misc" region. As "syscon" nodes like this still need a specific
> compatible, document "ti,nspire-misc" here.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index 4e4baf53796d..37a00532ea79 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -69,6 +69,7 @@ properties:
>                - samsung,exynos5433-sysreg
>                - samsung,exynos850-sysreg
>                - samsung,exynosautov9-sysreg
> +              - ti,nspire-misc

This is not what your DTS is saying...

Best regards,
Krzysztof

