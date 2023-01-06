Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA0665FE0C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 10:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbjAFJga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 04:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbjAFJgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 04:36:08 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC95C8D38C
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 01:28:04 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id g10so667836wmo.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 01:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o62n9NBbSVSiAKonaXoYdKNKA7O0bg5G8XsGNr/A9Rc=;
        b=tPYq5WRY85k9btPiVrnv2nF1F4k9la5HZRecSieuIdTpbp6MkznWVU0sa19MfcwdmA
         qiWzMK2gE9soQ168GTB9AImH6iuqp5EM8+buKfArAOnp5X+K3cSfwYKjjFldwmiNjCtU
         FY0HwG1ViN5QIbyYnemJAiMcxKQp016Ox3Ds2Wu5/6SJ2SrhAxG7dAcdcaIAAAFy1VQl
         nEiDvP8QjQXeAx6DqwQhX76q9Vky0IfxdrSQOaCYz/41GtDRqAuK80qw/1Yz30427Lvl
         JScaFZHXdbHlSHq6q5wHPkYBYwdRA62l+hhHPRvFvTCEw74zhDPPoq/+JQhW0pELUV6X
         S+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o62n9NBbSVSiAKonaXoYdKNKA7O0bg5G8XsGNr/A9Rc=;
        b=ZECznSgcwa8BN8LShRz9kyFpSKu23cy6GsFn/me4g6t4cZ5U8FPsSPPQyAOL2htWGk
         khSp1K9XM2qUUe0/jyjWEqCCm6biC4xDgbiioZqe8cddQPsSR8kD2x+DYsZpCh6sHJ1q
         bP8tFayw+LI3hJeWAG3bcSENe86tMWM33CbCCNj6muUwpIRIXGLUCknBVbhMU4NcCMx5
         eEx6K1fCKISa4KmVa8RlcLk2l4WIgui0AIk78bBwjb/m9jhDBLRsyQdsWOFypriFp258
         axCk2ZGbJ1zFvSAvyChNpbZoc7PV+1Wv8T23iFS//7mL4beqeqiGIVQik1Ysr4Ru/J61
         XBRQ==
X-Gm-Message-State: AFqh2kpZtpcq4LeZz/celwQvIeN9Cg+O1eiqTjC0Oc2EaMOyZ1eOcxy6
        zYPlqYLbIKSVpvmS00QgD7fzhQ==
X-Google-Smtp-Source: AMrXdXs0JBJ4niKpF4pQfza4ErydKUpKj3bcSZLk7ks5fAlEoOogGLVXZLw1+9PUmKUf3HGg0CMNZA==
X-Received: by 2002:a05:600c:34cf:b0:3d0:7415:c5a9 with SMTP id d15-20020a05600c34cf00b003d07415c5a9mr40190823wmq.21.1672997282446;
        Fri, 06 Jan 2023 01:28:02 -0800 (PST)
Received: from [192.168.1.102] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u8-20020a05600c19c800b003d9780466b0sm1125082wmq.31.2023.01.06.01.28.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 01:28:02 -0800 (PST)
Message-ID: <9bbd5343-30bc-1146-3296-2c3a43b9a91b@linaro.org>
Date:   Fri, 6 Jan 2023 10:28:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/7] dt-bindings: usb: Correct and extend FOTG210 schema
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Fabian Vogt <fabian@ritter-vogt.de>
References: <20230103-gemini-fotg210-usb-v1-0-f2670cb4a492@linaro.org>
 <20230103-gemini-fotg210-usb-v1-1-f2670cb4a492@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230103-gemini-fotg210-usb-v1-1-f2670cb4a492@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01/2023 00:35, Linus Walleij wrote:
> It turns out that this IP block exists in at least two
> incarnations: FOTG200 and FOTG210. The one in the Gemini
> is FOTG200, so add the variants and rectify the binding
> for Gemini.
> 
> This affects things such as the placement of certain
> registers.
> 
> It remains to be seen how similar this block is to the
> third USB block from Faraday, FUSB220.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/devicetree/bindings/usb/faraday,fotg210.yaml | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/faraday,fotg210.yaml b/Documentation/devicetree/bindings/usb/faraday,fotg210.yaml
> index 84b3b69256b1..12d4fc742f20 100644
> --- a/Documentation/devicetree/bindings/usb/faraday,fotg210.yaml
> +++ b/Documentation/devicetree/bindings/usb/faraday,fotg210.yaml
> @@ -5,7 +5,7 @@
>  $id: http://devicetree.org/schemas/usb/faraday,fotg210.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Faraday Technology FOTG210 HS OTG USB 2.0 controller
> +title: Faraday Technology FOTG200 series HS OTG USB 2.0 controller Bindings

That's not correct change, probably due to rebasing. Change the name
only, do not add "Bindings".


Best regards,
Krzysztof

