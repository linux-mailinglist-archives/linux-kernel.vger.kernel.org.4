Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78AF5F43EF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 15:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiJDNKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 09:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiJDNKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 09:10:35 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABDF2A41E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 06:10:33 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z4so21069127lft.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 06:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=1Zs5AYtIbgN30Vpk1RFYyv899QtIhQ6er/wUtO6Qq6E=;
        b=BecqeHF+CHlOOFHthq4vfzkmI7poaVVdECpaRivrcOemqlWxzb24h+kIOJX2iOX0Hp
         WW4+ssamQk98jtcWnNmizmosI12yw1xQE5HvLbXpnZa74zZRkf6adOfRaVCnrv1hWL3d
         AEfQPwN67DM7h1yQVICeLRdYb17MaQcqlzEwmEZ6s2FRhrh+VQtvL9XL2UDxIC+mF5di
         etCZsBWCgV90NT980vVfEvHXI923IPqffBfXq8QYED0B+ABU12EsbNno+r/eYDbskRP5
         8GxTcRh+r6BMcClCDB6CUG12ZtTsjL/JpXfVKwdRASM19NHJCgpZcnZnqGucQ3TcMcnO
         dhkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=1Zs5AYtIbgN30Vpk1RFYyv899QtIhQ6er/wUtO6Qq6E=;
        b=VJGy+Iw2fEaSMdK7u5hTUJV0jsROULvbz6W+eVRyZcAIVGLskgjKqGTadA5zIfNwOS
         IG+3Rs/f3XieCDGQbCjdPFSycEsFtiq1vVWf1yMyjExAwCXbdp1umSWEfRs9dW8/sIoo
         2hSjka7o7FEIZb+bTYL3SrSaWj0w+Yqrk0R1nKAY53KT7MXtucBnC223xPYfDh+D1ua2
         6jw+AMkYEhysLxGQCBDBIWAfQikl39MRqDoOLOD+gpUDYVJ8HVKHwwaLHBZjLqYPMzgs
         7nIX/98bonV44jI2TIVAuK8fzjt0oXvi639oypdtabC3CMl9M4kCoywvXCfdLDWY+ykG
         7qkQ==
X-Gm-Message-State: ACrzQf2fbXJrHDLWbZVWU6r0BuC5kgbOLwZV8z9/4jz7heNSYMDSHnuI
        vxwJmYjrp9t7kQI23ZsK0DbAPQ==
X-Google-Smtp-Source: AMsMyM4g1VTiHI/xh6oQYaaI0i8Df44upYXlbUFk6fAawopFjhjHB4pKoEXsPqf2xp+ZlX8j7NPn/Q==
X-Received: by 2002:ac2:4c48:0:b0:4a2:5937:6f5e with SMTP id o8-20020ac24c48000000b004a259376f5emr680892lfk.677.1664889031960;
        Tue, 04 Oct 2022 06:10:31 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id h13-20020a2ea48d000000b0026bdb7ad643sm1231743lji.50.2022.10.04.06.10.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 06:10:31 -0700 (PDT)
Message-ID: <64a355f2-e9a1-dcca-cb86-48805acae8d5@linaro.org>
Date:   Tue, 4 Oct 2022 15:10:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] dt-bindings: display: panel: use
 spi-peripheral-props.yaml
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Markuss Broks <markuss.broks@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Dillon Min <dillon.minfei@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221004120907.72767-1-krzysztof.kozlowski@linaro.org>
 <YzwvDEKAzbqjSYjT@pendragon.ideasonboard.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YzwvDEKAzbqjSYjT@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2022 15:03, Laurent Pinchart wrote:
> Hi Krzysztof,
> 
> Thank you for the patch.
> 
> On Tue, Oct 04, 2022 at 02:09:07PM +0200, Krzysztof Kozlowski wrote:
>> For devices connectable by SPI bus (e.g. already using
>> "spi-max-frequency" property), reference the "spi-peripheral-props.yaml"
>> schema to allow using all SPI device properties, even these which device
>> bindings author did not tried yet.
> 
> Isn't this done implicitly by spi-controller.yaml ? SPI devices that are
> children of an SPI controller should match the patternProperties
> "^.*@[0-9a-f]+$" in that file, which has a $ref: spi-peripheral-props.yaml.
> Is there something I'm missing ?
> 

You are correct about one side of this - SPI controller bindings.
However these schemas here have clear: additional/unevaluatedProperties:
false, thus when they find DTS like:
panel@xxx {
  compatible = "one of these spi panels";
  ...
  spi-cs-high;
  spi-rx-delay-us = <50>;
  ... and some more from specific controllers
}

you will get errors, because the panel schema does not allow them.

The bindings were done (some time ago) in such way, that they require
that both SPI controller and SPI device reference spi-props.

Best regards,
Krzysztof

