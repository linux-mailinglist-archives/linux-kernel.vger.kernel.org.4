Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3DF646A1D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 09:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiLHIIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 03:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLHIH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 03:07:57 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4022C129
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 00:07:56 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id y25so851878lfa.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 00:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zfp+IGt+QZqvH7TGZjbe8ZWw4VLFQco9xoAxwS9Oob4=;
        b=CMrqWh8b9NxucZNp6wNtnclXL+OfABb3i8sqnOGL0Tbz4cqO3w4GLEXOEskULk1iSn
         Bh7QiLHGAv7Hzi5w7/LDouMXPtsKfzey4U/iMRdjJ/KucKbV301jR+XAtz5YnlaYEwv+
         YjjcW5VrCbb6CZdzvDjeROIKQjYY9Q+nzGitfLHBbbYHVUo1NxMGES++X67PBU+Ikk7j
         nMGl/Lsz0kWWtWP5ox1amQg9MA+VGsFFh98Cn6FT7gKngCg3DTACX5zsiEVxbgCglEMN
         m1+2PDme2OfZ8s2W/a0EZcr1pKjbbySOLvmnEaZx7lOQNHZRUcz2bP+yuhB1MCJDSJyt
         wOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zfp+IGt+QZqvH7TGZjbe8ZWw4VLFQco9xoAxwS9Oob4=;
        b=EJa+uS1pX70GEG1UL20l+78RL8X7Wz54SLb8oN4emS23YUsdl2p8uJU0afki1PZKw+
         iOicnB/9Db+HwqLFFxG7jvZ1bjqo5fGqHIKso26G7dz0RK9GmYFwSvUASI6r8Y+uIkwv
         VdrhFtM8EvdzJ+1iM7ufU+xK20NOzHc+NdSHtLKaxdI0JHmjujybYDmoF5+5FNFuBoyX
         ByeCGRNPTkmjCtnARVug2Gawp/4vB7bj6pDWHY1hZ7pQmDgWMForBZeLO5k5JUHWxp4k
         Z8nG2/Dclp6KUP2TC3Vud2PsPvl0CCsvV8kmm2Xbvxw6zM8Lk0gec4ShL5zG/jiFZsZx
         Nu5A==
X-Gm-Message-State: ANoB5pmT5krcj3oVQHBjTRV+825sGaBdf7AC+e2HJddzfknLE99/mC8a
        lLHHDopC5JtCotigH2zLxYWPNQ==
X-Google-Smtp-Source: AA0mqf43a2tefTrmb+xeFqZMFM0jLMf0lDsD4IRgFS2CXIWumOMGXWXYh7rHDArZhPQb9eFAN1BFEg==
X-Received: by 2002:ac2:58ec:0:b0:4b5:6a14:6e4f with SMTP id v12-20020ac258ec000000b004b56a146e4fmr6172620lfo.578.1670486874905;
        Thu, 08 Dec 2022 00:07:54 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id r11-20020ac25a4b000000b004a93b8508edsm3232291lfn.181.2022.12.08.00.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 00:07:54 -0800 (PST)
Message-ID: <edd39013-af5f-5868-6c78-173d8f163754@linaro.org>
Date:   Thu, 8 Dec 2022 09:07:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 03/16] dt-bindings: pinctrl: Fix node descriptions in
 uniphier-pinctrl example
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221207055405.30940-1-hayashi.kunihiko@socionext.com>
 <20221207055405.30940-4-hayashi.kunihiko@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221207055405.30940-4-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2022 06:53, Kunihiko Hayashi wrote:
> Rename the parent node to the generic node name "syscon".
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.yaml
> index 14a8c0215cc6..186fc550af4c 100644
> --- a/Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.yaml
> @@ -69,7 +69,7 @@ examples:
>    - |
>      // The UniPhier pinctrl should be a subnode of a "syscon" compatible node.
>  
> -    soc-glue@5f800000 {
> +    syscon@5f800000 {
>          compatible = "socionext,uniphier-pro4-soc-glue", "simple-mfd", "syscon";
>          reg = <0x5f800000 0x2000>;
>  

Not visible in the diff but this is a poor example. It has only
compatible! Drop the parent node instead and extend the pinctrl node to
show complete picture of pinctrl.

Best regards,
Krzysztof

