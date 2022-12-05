Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608F86437E5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbiLEWSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbiLEWSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:18:40 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBA9AE7C;
        Mon,  5 Dec 2022 14:18:39 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id q18-20020a056830441200b006704633f258so1820712otv.0;
        Mon, 05 Dec 2022 14:18:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFtuaLPFDvWSIDNHEunnBqbOcPBvDu9AuTdJGDLR1Rg=;
        b=OM59D54KGXLqFzJAMp+OqvE5d4QDKNBYa3B3GTNdTTaSd8DQxlSxwS8LYnXEwYwMej
         kqEwT9OhEBIkpS8LcCBTN2cUbxQnj/uXKfUJl1ZubbKlHx3QjlcDUqj6y1UgZJ5qH+JN
         eyWU6LeSwYwJESzX9XfVZy7WXCe4YKwXvogcAbGVBYN6qEU8Dgw4cE7Ly3YDXi/jSAfS
         dIWLpLqTc8Hofydq4ixde0QSIZmho1UkIlV17lKG/X4JVGFRW4uXLhvmKQVO4K8YK8Hq
         0djj2fvCa5/VTt4hy7Z0WYOjP/CxvOozgJiQxg6cdrRl5WKC8zAgl8dJetptWB74R7/V
         T/pQ==
X-Gm-Message-State: ANoB5pkPNgrBAonFhoIwyxERNnpq7BxHUh1sil6kQcyWUOTP9KqjI44p
        c7ik94f6cchldeUM/L46ng==
X-Google-Smtp-Source: AA0mqf6ShutSKE2Yi5YoIQIMnGjUB7h2BjCoX+LWywRcAuN6EOEXjhZRfl25CkrY+MkKx6K5XZIOig==
X-Received: by 2002:a05:6830:22e9:b0:66c:3d27:369a with SMTP id t9-20020a05683022e900b0066c3d27369amr31990190otc.255.1670278718705;
        Mon, 05 Dec 2022 14:18:38 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e9-20020a4ae0c9000000b004a05e943f9esm2312599oot.21.2022.12.05.14.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 14:18:38 -0800 (PST)
Received: (nullmailer pid 2788910 invoked by uid 1000);
        Mon, 05 Dec 2022 22:18:37 -0000
Date:   Mon, 5 Dec 2022 16:18:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Young <sean@mess.org>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: leds: irled: pwm-ir-tx: convert to DT
 schema
Message-ID: <167027871674.2788859.2123525611385378965.robh@kernel.org>
References: <20221204104323.117974-1-krzysztof.kozlowski@linaro.org>
 <20221204104323.117974-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221204104323.117974-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 04 Dec 2022 11:43:22 +0100, Krzysztof Kozlowski wrote:
> Convert the PWM IR LED bindings to DT schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/leds/irled/pwm-ir-tx.txt         | 13 -------
>  .../bindings/leds/irled/pwm-ir-tx.yaml        | 34 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  3 files changed, 35 insertions(+), 13 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/leds/irled/pwm-ir-tx.txt
>  create mode 100644 Documentation/devicetree/bindings/leds/irled/pwm-ir-tx.yaml
> 

Applied, thanks!
