Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615576A8389
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 14:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjCBNbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 08:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjCBNbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 08:31:19 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5C03B3C0
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 05:31:17 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id u9so18130981edd.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 05:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677763876;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JdSCIoGvZ8uawhCoN7CRlx74tUl0hbvAdJs1DSiOHBg=;
        b=utx+Op5vksoVqBv69RebrEF+WTiUWv5PUeEa5Wiythe3tNiIee0EtMhHFsACSyoRpe
         R+gjYyABRTXCMN7JZ9mJn1fF8or5JAQBJIuCqUWc+ELSy2mn+YStPrzKi6C97ljMUlYd
         NI+Wc/pcv8gisPQwQmah+tBbPz4u/95/q6o17agSHWKuHrWli8QscsTg209m5ANEd84S
         Ja+2EylmZ0AzbyC4J51mWpwsfAKTXB4vdtM7Rkhv9dn2sdfHvJgoo5yxKA5lMDJ1eYMe
         iqexrSHRE6NJyEZmLEtTTYlzf7FkURRopOb1/PHUNej5ScwY2ID3VoJV35yWZkTg2uK7
         C/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677763876;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JdSCIoGvZ8uawhCoN7CRlx74tUl0hbvAdJs1DSiOHBg=;
        b=XPy1UEw0UR8iloiHUu7uU71M56/RFbYdlSMpFkC1kp0SMudyL8SqAGmFZXw1ya+u2r
         Mnrk0tIbUInO8BnEztuoo3QppMlqBoE91NxdtQnIjh6PRZ6TY/fK+DKEeje+3oNt3h1w
         2h14cYug9X5D3MrygJfaHOAzzsjRmu/QrmSRiDV/kdB1ZSBy8h44+w7vrQDFeGSyAIsM
         YT3Wj2MoRSU5haDfIs3MhR+PdDhnQZAGOICd5ksL/sQjmoWxCyyLWc/be+8dwxp5f2OV
         ifC0Sxv7dakHnbdHUAO6LfqQWTBjmDJMOAmEypZixccO3YgV1Vfi3URTWIr9S/fFAqt2
         xDNg==
X-Gm-Message-State: AO0yUKVIWk1mS7pU93a2FW8Png0RwpsGRVKxFNXAmMoqzGBHQOlqpKAG
        QL5ecsEhPa+DtlW8ruWzxd9qnQ==
X-Google-Smtp-Source: AK7set+2aK3lx5BxQFRboIYFX6J8/gU0ACeShJ21COKRBvUNuJaCQTn8BQJ7PSol6yRlSmxQTp4b1A==
X-Received: by 2002:aa7:cb83:0:b0:4af:64b8:262e with SMTP id r3-20020aa7cb83000000b004af64b8262emr11220297edt.6.1677763876250;
        Thu, 02 Mar 2023 05:31:16 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id jl9-20020a17090775c900b008b17de96f00sm7065387ejc.151.2023.03.02.05.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 05:31:15 -0800 (PST)
Message-ID: <27aa0b4a-14fc-5fce-ab49-a8744b131882@linaro.org>
Date:   Thu, 2 Mar 2023 14:31:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: maxim,max9867: convert txt
 bindings to yaml
Content-Language: en-US
To:     richard.leitner@linux.dev, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ladislav Michl <ladis@linux-mips.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benjamin Bara <benjamin.bara@skidata.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Richard Leitner <richard.leitner@skidata.com>
References: <20230302-max9867-v1-0-aa9f7f25db5e@skidata.com>
 <20230302-max9867-v1-1-aa9f7f25db5e@skidata.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230302-max9867-v1-1-aa9f7f25db5e@skidata.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2023 12:55, richard.leitner@linux.dev wrote:
> From: Richard Leitner <richard.leitner@skidata.com>
> 
> Convert from max9867.txt to maxim,max9867.yaml and add missing
> '#sound-dai-cells' property.

Thank you for your patch. There is something to discuss/improve.

Except wrong ID (and missing test):

> +
> +examples:
> +  - |
> +    &i2c {
> +            max9867: max9867@18 {

Generic node names, so "codec" and drop the unused label.

Use 4 spaces for example indentation.

> +                    compatible = "maxim,max9867";
> +                    #sound-dai-cells = <0>;
> +                    reg = <0x18>;

Best regards,
Krzysztof

