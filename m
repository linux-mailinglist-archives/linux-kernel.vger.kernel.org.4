Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D6E73D1D8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 17:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjFYPqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 11:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjFYPqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 11:46:36 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DDA115
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 08:46:35 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-98e39784a85so107466466b.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 08:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687707994; x=1690299994;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CBfhQMoEipi5XAE7AqBqA8xkyhGnNfaeMZodBBrJBjA=;
        b=QZhohzCXpsI7+DT4AL8Q4mQsrl8RruBJw/R4ZcD8XBnDoaozCNWlPj42b4qoQfco7q
         jdLTMrwU3uocsZRWyANlo0UPrdThq8Q9AxYdA5QOC9X6I+PWRMa2FYGHVvR6BIGf0jrT
         Ur/K/p94clSBtu7q6XsARj1PgJHxTe6QvJMKrb+As2A8sTXuaA7xiz8zbwi2ukxiplAa
         vhlCi8b9lIoV1F0ErLZ/+45lIPV6jHZ1/xokihp1lvVMyeMkAGPloLNlEUWmQ2sXqbOu
         2vtMBlvfMOnu1zcqgrv5UF34mX2SLYErtsvDX+LrkL+jKWwxsxaZRyWAJD27K7Qj7LOr
         Pvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687707994; x=1690299994;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CBfhQMoEipi5XAE7AqBqA8xkyhGnNfaeMZodBBrJBjA=;
        b=e55dca4Y8C3oTdai496so/aEtlMbFNNYUdYzSWPnMxGu2bXCnNr85CORPuVR6g7ypU
         aUfByKTIZK2eTrkNV1+ZoJIU6m79BpFV136JGlKPLFebZPRP3cirBwKqie7JBF13XioS
         hEdXC6djHHmIRFu4bQslau75sAC1mhFUOG8UbmWf/wIb29uNGVX8ESH+fG8WbVtXZH5r
         860rgVa90skm9LRCSbmL0zcdnJMUbybUHTfwvrYvJSRAU/hz/QRhdV7Ftghxu04JYbNR
         f9JiEbcS7/CP2AC8YNiD6srdWSQ1/x+/IzCNwnNODEEGKMjc+FvTQFBgI84KW0/z9h2y
         zdFA==
X-Gm-Message-State: AC+VfDz1z4LjcVrWhrTCM6o9RtUCeAf0UW2hHkBefKEilizYgYGEMuxr
        zktZMlYLMUk6zmPvGQLTkqIaCg==
X-Google-Smtp-Source: ACHHUZ4MamQOEwU6km9t2W1ycNEyUducjTZqX8Eaj1G0PpnDaxxXvhRQMhbv7UGxy6/5gUrP0D1k5g==
X-Received: by 2002:a17:907:72d2:b0:98e:3935:60f4 with SMTP id du18-20020a17090772d200b0098e393560f4mr1752596ejc.1.1687707993534;
        Sun, 25 Jun 2023 08:46:33 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id b21-20020a170906491500b009828dac8425sm2206521ejq.105.2023.06.25.08.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 08:46:33 -0700 (PDT)
Message-ID: <4244c92d-2079-e3d9-44c8-8e5593d093a5@linaro.org>
Date:   Sun, 25 Jun 2023 17:46:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/5] dt-bindings: pps: pps-gpio: introduce capture-clear
 property
Content-Language: en-US
To:     Eliav Farber <farbere@amazon.com>, giometti@enneenne.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ronenk@amazon.com, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, itamark@amazon.com, shellykz@amazon.com,
        amitlavi@amazon.com, almogbs@amazon.com
References: <20230625142134.33690-1-farbere@amazon.com>
 <20230625142134.33690-3-farbere@amazon.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230625142134.33690-3-farbere@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/2023 16:21, Eliav Farber wrote:
> Add a new optional "capture-clear" boolean property.
> When present, PPS clear events shall also be reported.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
>  Documentation/devicetree/bindings/pps/pps-gpio.txt | 4 ++++

Please convert the bindings to DT schema first.

>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pps/pps-gpio.txt b/Documentation/devicetree/bindings/pps/pps-gpio.txt
> index 9012a2a02e14..8d588e38c44e 100644
> --- a/Documentation/devicetree/bindings/pps/pps-gpio.txt
> +++ b/Documentation/devicetree/bindings/pps/pps-gpio.txt
> @@ -14,6 +14,10 @@ Additional required properties for the PPS ECHO functionality:
>  Optional properties:
>  - assert-falling-edge: when present, assert is indicated by a falling edge
>                         (instead of by a rising edge)
> +- capture-clear: when present, report also PPS clear events, which is the
> +                 opposite of the assert edge (if assert is rising-edge then
> +                 clear is falling-edge and if assert is falling-edge then
> +                 clear is rising-edge).

Why this is board-dependant? Falling edge is happening anyway, so it is
in the hardware all the time. DT describes the hardware, not Linux
driver behavior.

What's more, your property name sounds a lot like a driver property, so
even if this is suitable for DT, you would need to name it properly to
match hardware feature/characteristic.

Best regards,
Krzysztof

