Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EE0629996
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238035AbiKONFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbiKONFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:05:42 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABDFAE48
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:05:41 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id j4so24376049lfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mdvIIl4cgeDqGAAZabaWbNUrV+o8u8RyyIYZ5puj5yk=;
        b=qOtJaIwH5zDp2x+c7JZp5p6url0leqnsVkLXKiytCF+mj9qC/OPnLPj+LipgqD5BoI
         hfd1LAOrqW8F0caLVPawRfohG+XUQdZMRPGQDRmQndRQpOke7jigxlvXImtU0edjAQsx
         xFJGxCvvnvcm158dkvd4JFuB0TEz4P7c9P7L/CTPyZrQNGFHJlqpI8U48Ztgi5c+rysz
         mDLJ+ZjLe6xNgIuWvquFNs1ureCvY4ydvXC/UtTMJ4pAXLkC7lQuZ7fzfuguWyYRh6+5
         HhOUZ/+sGDPkLAa6p5dj7ekCJIxNILV+zs3IPIUQnORa0pK9Yb3LJq1ULLXemoB2apHk
         Nd5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mdvIIl4cgeDqGAAZabaWbNUrV+o8u8RyyIYZ5puj5yk=;
        b=cAtir4a2EOfW0gmWBxbvmSUYTKoeA6Up/b3qw0s0UpGMMi3l79A3yC0FkBUcvxpSQa
         PswwTynF+qrx3NtCXNzQiU4uWj45YAMr41AdX0DbslA//gn/6X6bj0GRBU8XNw5GX5Dq
         IqbU1JEHCAolNCRiO27zFjC9lM8hvxNZfPIyyErxMJk3xLCCPOte+D5TqmG9XutyUa9E
         HgU9aI7TAqzvkgSuM6qT7uKXvSp2Wp/ni4PAoTGEID34JntJUzlrwHefSo5992AM+y2G
         BjuHxS0uDtO/ArsZudGa/DBcg0bq+rZdjd1F0bRsI0+4rnlUlRjQjCidIqNBt9QwI0XX
         Pa1A==
X-Gm-Message-State: ANoB5pkPXK/MZRLvABG3y33b8H7MyEcQWf2QbPpG6X18SE5cEcCGCbLn
        G0AUjprMQ7qLhK5P7RafCId46w==
X-Google-Smtp-Source: AA0mqf6kInCc+A0yhclN+A1KPhxr4No2Ve/TJmp4KVoenUiZl6E/W2ygFzWNtp+0/7LIUoFw4og0aw==
X-Received: by 2002:a19:e30e:0:b0:4a2:5163:f61b with SMTP id a14-20020a19e30e000000b004a25163f61bmr5403368lfh.177.1668517539513;
        Tue, 15 Nov 2022 05:05:39 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id e10-20020a19674a000000b0049311968ca4sm2194132lfj.261.2022.11.15.05.05.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 05:05:38 -0800 (PST)
Message-ID: <a1a7fdf4-2608-d6c9-7c7a-f8e8fae3a742@linaro.org>
Date:   Tue, 15 Nov 2022 14:05:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/7] dt-bindings: clock: renesas,r9a06g032-sysctrl: Add
 h2mode property
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20221114111513.1436165-1-herve.codina@bootlin.com>
 <20221114111513.1436165-3-herve.codina@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221114111513.1436165-3-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8
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

On 14/11/2022 12:15, Herve Codina wrote:
> Add the h2mode property to force the USBs mode ie:
>  - 2 hosts
> or
>  - 1 host and 1 device
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../bindings/clock/renesas,r9a06g032-sysctrl.yaml      | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml
> index 95bf485c6cec..f9e0a58aa4fb 100644
> --- a/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml
> +++ b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml
> @@ -39,6 +39,16 @@ properties:
>    '#power-domain-cells':
>      const: 0
>  
> +  renesas,h2mode:
> +    description: |
> +      Configure the USBs mode.
> +        - <0> : the USBs are in 1 host and 1 device mode.
> +        - <1> : the USBs are in 2 host mode.
> +      If the property is not present, the value used is the one already present
> +      in the CFG_USB register (from reset or set by the bootloader).
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]

0/1 are quite cryptic. Why not making it a string which is easy to read
and understand? Can be something like "two-hosts" and "one-host". Or
anything you find more readable...

Best regards,
Krzysztof

