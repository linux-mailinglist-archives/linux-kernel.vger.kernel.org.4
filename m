Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDFB616EF5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 21:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiKBUnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 16:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbiKBUnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:43:39 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498B864CD
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 13:43:38 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id x18so1527060qki.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 13:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ltt9NnEIjGYG5lwZ6IHnSObeQ3raAW3TtWZ21QCUHmE=;
        b=f7vI5crW47B36jradRBCcmIhyekL1RaywghaonA1HttPuiWTI4cKCEt+qm5zkoB7P2
         Lh/mNN9AyR2t9poLz7zE1UXsvqlgxiX+w/gT/VEdADVZAs4qkkCcCwv0ZRiWyK3zf5ox
         uI7rcJ8nG6pJbDp979SHFIclSffX/jjRzy01tv87kgL0nvtl+3sjWq0lSDfw4Ah+XWkE
         DInQqk+6kr7eJfM+Sqmkh95rxOTrNuCP8SGXVTe2ZhePYnGudj40j7PSQu+rf3S6V+kr
         4FHYjughcsRnQgzAixrQ90I2g/ByQQmjOLRjFoU8Ex3FX9iVqc3c2wkcPVNsuFUlyEAh
         BHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ltt9NnEIjGYG5lwZ6IHnSObeQ3raAW3TtWZ21QCUHmE=;
        b=FTGz93vyg+1xH8YdigrN36ZB+3POLhk83eyDpDKKOWmNgrMm0oV8h9RH4S0fL8+27n
         Cre8G6qSaTp2P/LXCOCdCEvwi1OyvtEPvQj43boQlniQhXVmWUvgwnKUvlIl191JdglI
         vZgGk5wB/Ho3LSlnu6E3uYbpBFSM+t14QVZO/ci72TbuOa/Y2gNoKNnAfl3l7RBrILFa
         HxIpbhYCvw3aB0w6CSuWQJ80jrdcJRib+rxYI8NLiO1heDiWWE44sWdO1VTEDPiEevxD
         4GhAUiJVjNRrTS4dwzIdCfdtSzPWRzW3gR5FhB+ZggpNi7CNP+HfRAA2McVk0ISkN+fG
         enuQ==
X-Gm-Message-State: ACrzQf1duu7XA40dUg5NkicXPMYMkF94lWy6qYtHPAGs46w8cjS8JM5N
        18OO1PJxxvanQ1y1J2B7IfULqw==
X-Google-Smtp-Source: AMsMyM4oCbZg4lNyLR2GtlIfKfLa2p6djOGtmfr7BuAfYZIUxocU92p7n5dbJahyx9Shf5PRqLrfGg==
X-Received: by 2002:a05:620a:152e:b0:6fa:3cb8:dd9c with SMTP id n14-20020a05620a152e00b006fa3cb8dd9cmr10779651qkk.82.1667421817473;
        Wed, 02 Nov 2022 13:43:37 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:28d9:4790:bc16:cc93? ([2601:586:5000:570:28d9:4790:bc16:cc93])
        by smtp.gmail.com with ESMTPSA id x30-20020a05620a0b5e00b006eeae49537bsm1815398qkg.98.2022.11.02.13.43.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 13:43:37 -0700 (PDT)
Message-ID: <cdc79d9b-7afe-1aaf-3692-171370abaa3c@linaro.org>
Date:   Wed, 2 Nov 2022 16:43:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 2/2] dt-bindings: thermal: mediatek: add compatible string
 for MT7986 SoC
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.or, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <136157bd1f94c64504f87ee2db6b3ed0a8dcc3de.1667254476.git.daniel@makrotopia.org>
 <1216e96b279d08230cb2aa61d536f44c1e9b800a.1667254476.git.daniel@makrotopia.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1216e96b279d08230cb2aa61d536f44c1e9b800a.1667254476.git.daniel@makrotopia.org>
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

On 31/10/2022 18:16, Daniel Golle wrote:
> Add compatible string 'mediatek,mt7986-thermal' for V3 thermal unit
> found in MT7981 and MT7986 SoCs.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  Documentation/devicetree/bindings/thermal/mediatek-thermal.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> index 5c7e7bdd029abf..efc16ab5b22b5d 100644
> --- a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> @@ -13,6 +13,7 @@ Required properties:
>    - "mediatek,mt2701-thermal" : For MT2701 family of SoCs
>    - "mediatek,mt2712-thermal" : For MT2712 family of SoCs
>    - "mediatek,mt7622-thermal" : For MT7622 SoC
> +  - "mediatek,mt7986-thermal" : For MT7981 and MT7986 SoC

Then recommended is to have specific compatible followed by fallback (so
7986 followed by 7981)

Best regards,
Krzysztof

