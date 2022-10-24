Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A64660BE05
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiJXW5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiJXW5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:57:08 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F302D2D49
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:18:50 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id o2so6870482qkk.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U7xgcAQUxqCetKkAStPZTWmoUelcv5+Ss4HzMxPQZgU=;
        b=jMMG2YQgF8A58BVrxKwYRDkMAFRvuhplQeT6srJ/0jOIreEZW8IiTd6g5InVC+RyEV
         nnjyxcGScTmhewQLbd0bDO99ON88K1lEmwW9Z4X4e4kzuY+2hJgHtDLtq9uQkjU1KXt6
         B1yEPSApCgO7ZuINanql8Oe/CBxLXc4WLsnkTxy9NildJYk09TCK8jLd8IYRs7UU1J/h
         fQYQOwVFc0QGC7Qbv1GTUjojQqj15bAeP0+Ksp2tfmUOimgtzaJ++a8R6YjbDQMLqQyA
         yg4TnqJqv/R+ldisXWuLuEO9h6MALp4sDHiDERK4auyoGN9HOcZ2UHRFc8cn6gS3akf3
         4WHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U7xgcAQUxqCetKkAStPZTWmoUelcv5+Ss4HzMxPQZgU=;
        b=AvTb5V7OP0ooM+quPIv8jIc4uL8T+WgDxleoF4KvcPU6Rn7phORhVEUmBwl8mfwtZE
         XA9vXOw8RHBom248266K/09aFOQvVRKcPXn+buv3kiMgP1/bk48yASfKSZhcFNZvq3G8
         XJHoPemvtAK9V6GvCfrdQtuXzpITw1oVPaUoeL30xYdENRY7fQmyoAwA8bssR+0x8A9J
         8q43kti+TitHujUOHExcNMjPDauZ942RrvMrwVabnWaqCDxmdSlJt4cj5oNHIj64611M
         SqLg4UTethNthpF1ZQPkRXZ95Ounwuc1ziLTKr4AhJlSBb82aab3lwcYb9/+vZ+A7mW1
         VZpA==
X-Gm-Message-State: ACrzQf3khBbcAfF+mUiM8lCskEppG6oAjz6viZtjapl6kH5QiRWv67/U
        w04ap/Kc62JFf+yRDEYf345v5w==
X-Google-Smtp-Source: AMsMyM6Yg322PC/++Fxnl9cx9/2/2/tHEv914tArFIApiYucQv+fqbt/9M1K10vXjHWWjC+OIrMDNw==
X-Received: by 2002:ae9:e907:0:b0:6e9:5397:15fb with SMTP id x7-20020ae9e907000000b006e9539715fbmr24806111qkf.466.1666645941654;
        Mon, 24 Oct 2022 14:12:21 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id u4-20020a05620a430400b006bb8b5b79efsm618126qko.129.2022.10.24.14.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 14:12:21 -0700 (PDT)
Message-ID: <07255e98-b5fe-3555-8cf8-b1e0005fd3d4@linaro.org>
Date:   Mon, 24 Oct 2022 17:12:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [RFCv3 PATCH 1/2] dt-bindings: bus: add Wiegand bus dt
 documentation
Content-Language: en-US
To:     =?UTF-8?Q?Martin_Za=c5=a5ovi=c4=8d?= <m.zatovic1@gmail.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andersson@kernel.org, jeffrey.l.hugo@gmail.com,
        Michael.Srba@seznam.cz, gregkh@linuxfoundation.org,
        elder@linaro.org, hemantk@codeaurora.org, mani@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org
References: <20221024162650.36587-1-m.zatovic1@gmail.com>
 <20221024162650.36587-2-m.zatovic1@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221024162650.36587-2-m.zatovic1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2022 12:26, Martin Zaťovič wrote:
> This patch documents the devicetree entry for a Wiegand bus.

Do not use "This commit/patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> A Wiegand bus follows the Wiegand protocol. The bus claims two GPIO
> lines over which the communication is realized. It also introduces
> parameters to control the pulse durations and the length of a gap
> after finishing sending a frame.
> 
> Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
> ---
>  .../devicetree/bindings/bus/wiegand.yaml      | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/wiegand.yaml
> 
> diff --git a/Documentation/devicetree/bindings/bus/wiegand.yaml b/Documentation/devicetree/bindings/bus/wiegand.yaml
> new file mode 100644
> index 000000000000..cc8d3c46bcde
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/wiegand.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/wiegand.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Wiegand Bus
> +
> +maintainers:
> +  - Martin Zaťovič <m.zatovic1@gmail.com>
> +
> +description: |
> +  Wiegand interface is a wiring standard popularized in the 1980s. To this day
> +  many card readers, fingerprint readers, sensors, etc. use Wiegand interface
> +  particularly for access control applications. It utilizes two wires to
> +  transmit the data - D0 and D1.
> +
> +  Both data lines are initially pulled up. To send a bit of value 1, the D1
> +  line is set low. Similarly to send a bit of value 0, the D0 line is set low.
> +
> +properties:
> +  $nodename:
> +    pattern: "^wiegand(@.*|-[0-9a-f])*$"
> +
> +  compatible:
> +    contains:
> +      const: wiegand

I think you are still making some shortcuts in design and this also
causes some misunderstanding.

If this is a bus, then there should be child device(s). But there is
none. If there is no device, how are you going to use this? Imagine now
a SPI controller without child device...

If this is a bus, then one controller implementing it might be using
GPIOs, but other one might have dedicated lines. Unless it's not
possible and all Wiegand implementations use GPIOs? It does not sound right.

> +
> +  data-hi-gpios:
> +    description: GPIO spec for data-hi line to use. This line is initially
> +      pulled up to high value. Wiegand write of a bit of value 1 results in
> +      this line being pulled down for pulse length duration.
> +    maxItems: 1
> +
> +  data-lo-gpios:
> +    description: GPIO spec for data-lo line to use. This line is initially
> +      pulled up to high value. Wiegand write of a bit of value 0 results in
> +      this line being pulled down for pulse length duration.
> +    maxItems: 1
> +
> +  pulse-len:
> +    description: length of the low pulse for both data-lo and data-hi lines.
> +    maxItems: 1
> +
> +  interval-len:
> +    description: length of a whole bit (both the pulse and the high phase) for
> +      both data-hi and data-lo lines in usecs; defaults to 2000us.
> +    maxItems: 1
> +
> +  frame-gap:
> +    description: length of the last bit of a frame (both the pulse and the high
> +      phase) in usec; defaults to 2000us.

For these properties you must use standard units.

https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml

Best regards,
Krzysztof

