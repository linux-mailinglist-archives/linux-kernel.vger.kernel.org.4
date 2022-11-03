Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57148618A17
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 22:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiKCVAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 17:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbiKCVAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 17:00:47 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8533C20F60
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 14:00:46 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id i12so2003509qvs.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 14:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ZuFw8KGSzrDCdciTqfDg2ZS28cKW8QtQvhMFthHBSA=;
        b=AKMzaH/b0tANxHacHk1sOGlRyRU/WNuMrHCzvtBXcnZUCZUozJuYs12b7gYVJJv61I
         cWV+Kpt2R+mfl6scgP9dOu/C1GLZ35B0m98RFOLvbuLMQMYyJwAMcwvKnNJIAvN2q/wP
         MC0agoRPQr1FdAspMz2zVd6+enY7C1T8krzp4Du3srywqbnYusxrTlbb3DLetATskAiL
         U5Rb7wFj50JqF7NV67AEsfXHE9e+R49VRAc1tEsDkAthrD5A9LacemaIYSgT3ftn1nBk
         wn1hzGS0gBDAr08f2YCGh40gTfygn8IUxY73CPu4rKiZHiG0lpUoBJ4sn93BXAqUx034
         5lOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ZuFw8KGSzrDCdciTqfDg2ZS28cKW8QtQvhMFthHBSA=;
        b=VO9EVp99EwnFJXSbpKkAcDJYiYFg2/UQEl6wLPwbpt+4PJBEch0afnEX8gm0utgR/N
         vHTUvMtwGdVmB/arCnQBCB80OIGm3WmTUOez5o3WmUofN3VyK4Rbj4KTFwjaM3mn0xZ8
         qpaBOSm5yvtfZoDD6jU8qfS7KkOy9O6iZguKwk9pgY4DF+SuAK3JBqauRoUXs4WxaFfs
         iW/PxJGS/NMokqb0CLu1MxoFD4vmBnuz6rsndkiqMyoACFHH59h85Wwv2gJBokllhYXy
         A+sXiN1tPTncKxHp8ogyvAwDaojp2g8lTWOOnqNFkwtYC7nKdyZ7L2zQyS26udtkH+el
         diug==
X-Gm-Message-State: ACrzQf3F/HPnNbre+qs5qA7Y8D6rGIZdzj5zEdUdYaNXvygAFD22qYpX
        bT0Y2r24N7mfOvFaCyrXWjVIQg==
X-Google-Smtp-Source: AMsMyM6TfVPpU0kIJEcyjrLXEaoANR9zWIMc1mB6CuJaekyILdWN4/cHPECABzUn2hfPV/Z0CThHig==
X-Received: by 2002:ad4:5ca6:0:b0:4b7:58a9:e40e with SMTP id q6-20020ad45ca6000000b004b758a9e40emr28714038qvh.113.1667509245606;
        Thu, 03 Nov 2022 14:00:45 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:a35d:9f85:e3f7:d9fb? ([2601:586:5000:570:a35d:9f85:e3f7:d9fb])
        by smtp.gmail.com with ESMTPSA id s9-20020a05620a29c900b006f1187ca494sm1533273qkp.28.2022.11.03.14.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 14:00:44 -0700 (PDT)
Message-ID: <7cfe285d-eb82-1840-0149-b5b77f2beaae@linaro.org>
Date:   Thu, 3 Nov 2022 17:00:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 3/4] arm64: dts: renesas: white-hawk-cpu: sort RWDT entry
 correctly
Content-Language: en-US
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221103205546.24836-1-wsa+renesas@sang-engineering.com>
 <20221103205546.24836-4-wsa+renesas@sang-engineering.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221103205546.24836-4-wsa+renesas@sang-engineering.com>
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

On 03/11/2022 16:55, Wolfram Sang wrote:

You need to describe the bug and its impact to justify Fixes tag (thus
AUTOSEL backporting).

> Fixes: 495e36c3a313 ("arm64: dts: renesas: white-hawk-cpu: Enable watchdog timer")

But I doubt that there is a bug here. Style (like order of things) is
not a bug.


> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a779g0-white-hawk-cpu.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a779g0-white-hawk-cpu.dtsi b/arch/arm64/boot/dts/renesas/r8a779g0-white-hawk-cpu.dtsi
> index bb4dd08781ca..c10740aee9f6 100644
> --- a/arch/arm64/boot/dts/renesas/r8a779g0-white-hawk-cpu.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a779g0-white-hawk-cpu.dtsi
> @@ -271,11 +271,11 @@ user@1200000 {
>  	};
>  };
>  
> -&scif_clk {
> -	clock-frequency = <24000000>;
> -};
> -
>  &rwdt {
>  	timeout-sec = <60>;
>  	status = "okay";
>  };
> +
> +&scif_clk {
> +	clock-frequency = <24000000>;
> +};

Best regards,
Krzysztof

