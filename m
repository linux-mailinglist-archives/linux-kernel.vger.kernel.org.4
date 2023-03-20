Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932536C1998
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbjCTPfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbjCTPex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:34:53 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1873754A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:27:33 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b20so15326237edd.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679326051;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WEmn3ezyj6eA5BOfLU0yXf7IoBAmpDvuzLW+5wrOX+g=;
        b=VVvn4d8bEf/oUM2tTGl4fQO5uS2x0It0EfbJYchV5E/p2pdzybPW9q75kxKStMuwND
         nEyNGy7E68tGnlspW3ierXl/cz4IDEit52b3b8b1F9aV4mkCAHiPUPS2MmAUkQtRWlfx
         R9MJ4DrhQxbPHxkLteE9fDhZxePSilbC5UNvTmYK9YQbfo3B+ZEBE5ZF6dUOJRlKzVHZ
         gGKK3ULN3UjXtXzYzH3rXK/Lw3IpeoFds7pkiLpduRc0plIi5916oZyJeZ42Yh6PEJJG
         ZajQs40soEXCJ2UdYkGSCr1KHJK2bHdZNnq+rZWnSJEfHtSsk9vTEpG73LRJ3IRvDKrp
         RY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679326051;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WEmn3ezyj6eA5BOfLU0yXf7IoBAmpDvuzLW+5wrOX+g=;
        b=74zoTbqzFoD/mgM1YDxCV/yAtpuE+4Y69m36pLXcN0hnPEkCwE6YK+3Oovoa/Vo+TT
         vvfbv+aHxXODNrLwzUZ5AgwEAmu3jvHx24LjZ93rGZsNG4gexs/XrwFIzz4Mo3RBGTl8
         nd7VbBAze1k0PWC+apfNgtIkXxgW+5kk8UmKDyiCNHmPzzIwqddpeSjWI2TGGmFy6uYS
         EDkBDMjKhk1EtuDHM1WN7+qCn477l8lprQJbk7LZWW2K/Q/BRyTh9Hw1fuiZiK2rQTnF
         dOXPE9ySBqN6yKXtJl+bWbB/NS0/ZkSsUiJ1n4Dsil5Tdvp+BlWGy3bil8r/YjoeL4gi
         BVMw==
X-Gm-Message-State: AO0yUKUCcOGY9zynSixm5Q9LsfTgXwJzS+jl8fr5QExIK8uQbWhStLHo
        2RVu2ydhbfnL5yMYCndHtQmtZQ==
X-Google-Smtp-Source: AK7set8Mv/6NZQmY/cewfFovcPQx3S77XB1TuD1OioHu4HZdpCl+pYhmc38k1airbGaoEgTwpYzVsg==
X-Received: by 2002:a17:906:84d:b0:933:1134:be1e with SMTP id f13-20020a170906084d00b009331134be1emr8843315ejd.53.1679326051561;
        Mon, 20 Mar 2023 08:27:31 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:458e:64e7:8cf1:78b0? ([2a02:810d:15c0:828:458e:64e7:8cf1:78b0])
        by smtp.gmail.com with ESMTPSA id d2-20020a17090648c200b008ea8effe947sm4568161ejt.225.2023.03.20.08.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 08:27:31 -0700 (PDT)
Message-ID: <f4c9e4cd-200f-9ec4-16e1-38596f74770c@linaro.org>
Date:   Mon, 20 Mar 2023 16:27:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCHv1 2/7] dt-bindings: display: st7789v: add Inanbo
 T28CP45TN89
Content-Language: en-US
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Gerald Loacker <gerald.loacker@wolfvision.net>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20230317232355.1554980-1-sre@kernel.org>
 <20230317232355.1554980-3-sre@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230317232355.1554980-3-sre@kernel.org>
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

On 18/03/2023 00:23, Sebastian Reichel wrote:
> Add compatible value for Inanbo t28cp45tn89 and
> make reset GPIO non mandatory, since it might not
> be connected to the CPU.

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586

> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>  .../devicetree/bindings/display/panel/sitronix,st7789v.yaml  | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
> index d984b59daa4a..4fc86f96b00f 100644
> --- a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
> @@ -15,7 +15,9 @@ allOf:
>  
>  properties:
>    compatible:
> -    const: sitronix,st7789v
> +    enum:
> +      - sitronix,st7789v
> +      - inanbo,t28cp45tn89-v17

Keep them ordered by name.

Best regards,
Krzysztof

