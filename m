Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC5D680BF4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 12:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbjA3L2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 06:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236337AbjA3L16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 06:27:58 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4EE6A74;
        Mon, 30 Jan 2023 03:27:55 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id l8so7745204wms.3;
        Mon, 30 Jan 2023 03:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OLtIKfrQlP60j4+DiH/uXns1J7cBM/abFHLneyBahMs=;
        b=Irt249mnGvQvO23P85fhdsJ7dvOLw4yemt9EXkUwsHhP610YrgXtEsxLJBHhJb+zIv
         vH3kXhG0fNhEuqOzY0vjpH3qn3+KYxn/uhJeYUsOHEk8ekF/668EGj3xjF6hQLPjABOr
         iAMHcFoM17QRWeqQmSY2ySPZs9NQjQjpXrchvTmVpgNYHFafmgmWUwz53BbUZa0r59+q
         fQJm+MUm55/BO/Y0RiFE0IwR8S8jgOhP3qHCoyjwgA3Fk2Z60tWXo4CP8tWIT60IlLC9
         Gh8MK2Awpq+5ZUwR/wzPhZEHQFFeVOiUfGBlBxYp0scx9MbJjodnA8g5+B0JZYSH1tpC
         NGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OLtIKfrQlP60j4+DiH/uXns1J7cBM/abFHLneyBahMs=;
        b=B+JWU8rLlFIdHVefU9YohbKJTKWSqWsffgESSzVWsuvvpjxm0Lo5wIQMlfs4YqPZHY
         VFE40I/demFyhc0ddv23CSQWo9V68q42fZ9NMipCe9P6M2EMpJS2gBWGW2HgxSWJCWsx
         EsfSXHEHYlljM0HzTexWcFV8Wu/0TGZ2cPEDGVrJplVb3tW/Tpa5WWRl6XWwVjHoVlJv
         p4qEark+5hTL2WJcuOE3auV5B09UmBC3+yGu4JEtg//9aYhXez73bZLqzA7EzahunF3r
         tTINMDESFInuQZs22JGSgkdVRJ/jI4XNAxrMlvsXRbZ0EPgscgADdGi03pyG0VbeOFkQ
         8ncA==
X-Gm-Message-State: AO0yUKVNnFwYmXs6PX1bg4TMH/fu83IeHSPaJ1BkR0Qr24AD3fFg/rdJ
        E07yIq0ZVX3G3tq2AhOg0oQ=
X-Google-Smtp-Source: AK7set/5iNsvsM5ybxrTH5ZpW/0KUhjubVlqPz+QI8m2RB1wvXMRG7KKhUq0WeLIHNH7pCYanD2Oqw==
X-Received: by 2002:a7b:c7ce:0:b0:3dc:42d2:aeee with SMTP id z14-20020a7bc7ce000000b003dc42d2aeeemr10296508wmk.25.1675078074261;
        Mon, 30 Jan 2023 03:27:54 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id bd16-20020a05600c1f1000b003d1f3e9df3csm16557501wmb.7.2023.01.30.03.27.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 03:27:53 -0800 (PST)
Message-ID: <c8023960-3361-91a3-6fdb-7c66bcabd2e9@gmail.com>
Date:   Mon, 30 Jan 2023 12:27:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v6 2/4] dt-bindings: arm: mediatek: mmsys: Add support for
 MT8195 VPPSYS
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230118031509.29834-1-moudy.ho@mediatek.com>
 <20230118031509.29834-3-moudy.ho@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230118031509.29834-3-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/01/2023 04:15, Moudy Ho wrote:
> For MT8195, VPPSYS0 and VPPSYS1 are 2 display pipes with
> hardware differences in power domains, clocks and subsystem counts,
> which should be determined by compatible names.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>

Applied, thanks!

> ---
>   .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml        | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> index 84de12709323..b08ae7405b1a 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> @@ -33,6 +33,8 @@ properties:
>                 - mediatek,mt8186-mmsys
>                 - mediatek,mt8188-vdosys0
>                 - mediatek,mt8192-mmsys
> +              - mediatek,mt8195-vppsys0
> +              - mediatek,mt8195-vppsys1
>                 - mediatek,mt8365-mmsys
>             - const: syscon
>   
