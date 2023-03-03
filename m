Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97C16A94DC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 11:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjCCKJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 05:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjCCKJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 05:09:19 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B588513513
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 02:09:18 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id s11so8098142edy.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 02:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677838157;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fI5/Jh41zzz66+bX6TPVbQtVq4+vv/aKacxWrTWABSE=;
        b=GDRKF4xLTB19IREv6jG4HYZQ0ofjbXmSt9cp0hUeSzkffeEljgn0DuezlRwNSxvv0h
         vsvkgIH9DkVJBTEEM9XbulZhffMKFFota432hx6lQMB1DMjsESXujWd3ehi1K0lF5Q2+
         g4Lf+pwaNmhyxY3xlBdAUVKyx4D4An/79s9GTR2Lwc0IIJBiUkNLNPfKIWMugcnJHNPB
         O5yFGNO5VqxxftWzj0gAW+weu3TAsXvO4WE6URMTidh8+pKZVIDq0z1pvQdJuvn4EkGc
         BejAS25JdUJ+/3jLx/i/ElM9mqbXsLh9kp/XoWcrBPX5bmgDy/NWTt6WpB8ilyOeLJol
         dPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677838157;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fI5/Jh41zzz66+bX6TPVbQtVq4+vv/aKacxWrTWABSE=;
        b=x5dyXf3Vu80v70RxG06trVx6qo8qBje5dMsXzjT2usZpXzhH2iuztYK/7JePLxwiIk
         zMwj7oo9LAGOt9kodymF1OCkJYPY+jw0QxvktLXaWMySdHDUnoimWHiANLmrI89yZ7Ed
         OHeL5PpnfvU6JH0YjPodf7EaO6XyB9Mbk0uRnEJqj1IyusYu5KglLT3Gi1Yr5UcKqJUa
         DRRGKhYozA0kCGwEMbZk5El1IVsB4iKzW9snu2oKKL1YqHpQqgFqW2nMcSFLKPemyqkW
         xNwNkFY5FpvlsrFqLc32NWXarXGrqnu6sPrIgi505PsW1X/irsRdVhB5D6Z+Pu9ATxhR
         PVxg==
X-Gm-Message-State: AO0yUKVEJlVaBLa/HLJpxyOuIt6J0GH1WoxOoRD1RotoVMt5nSPw/3wh
        C0kv9vLyITONuqHBoqCNAcqy/A==
X-Google-Smtp-Source: AK7set+lYy9fbQ5CtagXjbaTvZl/r3WY5kdiT+NQAjR24/Xnjs6G0dloTGXariMq8eLU9YUg4roYEQ==
X-Received: by 2002:aa7:c147:0:b0:4bd:e63c:d3be with SMTP id r7-20020aa7c147000000b004bde63cd3bemr1328940edp.20.1677838157226;
        Fri, 03 Mar 2023 02:09:17 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id c5-20020a056402120500b004c17977da1esm959561edw.8.2023.03.03.02.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 02:09:16 -0800 (PST)
Message-ID: <45d306d3-8efb-12ac-0a83-f01ca2982b0a@linaro.org>
Date:   Fri, 3 Mar 2023 11:09:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 2/3] ASoC: dt-bindings: maxim,max9867: add clocks
 property
Content-Language: en-US
To:     richard.leitner@linux.dev, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ladislav Michl <ladis@linux-mips.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benjamin Bara <benjamin.bara@skidata.com>
Cc:     Benjamin Bara <bbara93@gmail.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Leitner <richard.leitner@skidata.com>
References: <20230302-max9867-v2-0-fd2036d5e825@skidata.com>
 <20230302-max9867-v2-2-fd2036d5e825@skidata.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230302-max9867-v2-2-fd2036d5e825@skidata.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2023 11:04, richard.leitner@linux.dev wrote:
> From: Richard Leitner <richard.leitner@skidata.com>
> 
> Add clocks property to require a "mclk" definition for the
> maxim,max9867 codec.

But why? You just wrote what the patch does, which is easy to see.
Commit msgs should explain why you are doing something.

> 
> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> ---
>  Documentation/devicetree/bindings/sound/maxim,max9867.yaml | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/maxim,max9867.yaml b/Documentation/devicetree/bindings/sound/maxim,max9867.yaml
> index 74cd163546ec..6f27029b137d 100644
> --- a/Documentation/devicetree/bindings/sound/maxim,max9867.yaml
> +++ b/Documentation/devicetree/bindings/sound/maxim,max9867.yaml
> @@ -35,9 +35,13 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  clocks:
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
> +  - clocks
>  
>  additionalProperties: false
>  
> @@ -50,6 +54,13 @@ examples:
>              compatible = "maxim,max9867";
>              #sound-dai-cells = <0>;
>              reg = <0x18>;
> +            clocks = <&codec_clk>;
>          };
>      };
> +
> +    codec_clk: clock {
> +        compatible = "fixed-clock";
> +        #clock-cells = <0>;
> +        clock-frequency = <12288000>;

Drop the node, it's entirely common/regular stuff.

Best regards,
Krzysztof

