Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D22B638A97
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 13:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiKYMy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 07:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiKYMyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 07:54:22 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E8B2188C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:54:21 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id t25-20020a1c7719000000b003cfa34ea516so6084769wmi.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5fMUQM11ScQmJFsh5+zp1neRXE0jcnRGWVW/sbvW0aY=;
        b=GIdtHOoQHHiUn1y9l/Y9Y7lvVJH5safuLE/ABl8bNAvBBRta8ryKAcNTERLKJzAf3m
         /h03SXHSMKmQd7PoGYDKXhQZwfTv8l+6vbO6sbdfVNgIlAvXi8ubIR0ZbsecY6j+PzRd
         in2I8dCK1E/kOFv87JMn9uR6rtiDr/uaE5So9b/1CbeutTGaLphg50PhJba2Xn2soH+V
         kShBskf/0Aj/Od4H3KnFYn/Yni+5401mZsnlcrGZa5IPuzYbSewTGiXHicmshnUEtXTX
         Y3kQjSJcL6QONme2XAZVn5/HYOWirqv979NYXzuC4oNqQv2XOsyqv0ok92jWClinMjCe
         LtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5fMUQM11ScQmJFsh5+zp1neRXE0jcnRGWVW/sbvW0aY=;
        b=nsW/UThhvUOJwxuDcHpJbaLPC1Zc5TP7Vh94GadU9AO7qN3+2uteJUbY2sYaTFxbYK
         2ODMbtdXu54tuNtEMZ+9XLYwCPbQ9+mHoCC5/LohxK6jBIIVzgulRnst+zOjhkAYbm4n
         SGn3YaytbpWAJlJqPnMW+c5+gAR4igy1p5SKvL676itTg8nlJQs5y32pNbu0ahyCOwr2
         zaSlIf/Wij7F2x3KhWbEc1GJxy37NeXtAb+qhhMn0HhEojhyJWNdkjQZTTlameupAIVu
         bWhTarFUFS0dWNRS3u4A0DvY3UhtXo5ymmShSf1q7qaf/r8Fg2um+94NQKbdMM98yJL/
         0eag==
X-Gm-Message-State: ANoB5pnGUkcto+gW26briFKp34RIcBOvMYciUxd4UhEdq2W6k9Wmesvu
        XdCVeqGLnQzQ7cgbkA1xPfvfFA==
X-Google-Smtp-Source: AA0mqf6di6CQrRNIc+mrM8NPW7llqrHiL3OqZguZhdBaU+sCaOV5whaWpASwKSH7fyutYkh0E5A5Mw==
X-Received: by 2002:a05:600c:1e8d:b0:3d0:2c5c:e483 with SMTP id be13-20020a05600c1e8d00b003d02c5ce483mr12808700wmb.141.1669380859643;
        Fri, 25 Nov 2022 04:54:19 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:84a5:7e09:b15:f1fe? ([2a01:e0a:982:cbb0:84a5:7e09:b15:f1fe])
        by smtp.gmail.com with ESMTPSA id u26-20020a7bcb1a000000b003cfd42821dasm5092970wmj.3.2022.11.25.04.54.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 04:54:19 -0800 (PST)
Message-ID: <22300a29-c2c4-6514-ec4b-a62e04ade70a@linaro.org>
Date:   Fri, 25 Nov 2022 13:54:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/6] dt-bindings: power: Add NNA power domain
Content-Language: en-US
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Amlogic Meson SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson SoC support" 
        <linux-amlogic@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221125111921.37261-1-tomeu.vizoso@collabora.com>
 <20221125111921.37261-3-tomeu.vizoso@collabora.com>
Organization: Linaro Developer Services
In-Reply-To: <20221125111921.37261-3-tomeu.vizoso@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 25/11/2022 12:19, Tomeu Vizoso wrote:
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
>   include/dt-bindings/power/meson-g12a-power.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/dt-bindings/power/meson-g12a-power.h b/include/dt-bindings/power/meson-g12a-power.h
> index bb5e67a842de..93b03bdd60b7 100644
> --- a/include/dt-bindings/power/meson-g12a-power.h
> +++ b/include/dt-bindings/power/meson-g12a-power.h
> @@ -9,5 +9,6 @@
>   
>   #define PWRC_G12A_VPU_ID		0
>   #define PWRC_G12A_ETH_ID		1
> +#define PWRC_G12A_NNA_ID		2
>   
>   #endif


Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
