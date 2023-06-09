Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED60729F82
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242028AbjFIQBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242013AbjFIQBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:01:03 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F8335B1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 09:01:01 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9788faaca2dso318505066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 09:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686326459; x=1688918459;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JJHKGlV47afxhESmn4M8emdIU67tKEEb2KjyNS3Cyy8=;
        b=YwxbeP9Z1jnP1x3v5Xf+YEUjQFZwEf032mOgVxMfemo1HoEhK5v/oJAT0gfnF0RU5F
         2o08W8Ddz2BVJdDAVuKu2lGMYh6OkaHbWQnxGKwfIJkirJRbqH4ARKbys3ME1R1XKQ2i
         tiHbXpHhvD7G1I2ed9MqQIOLDHU3YqkJ1LrqA2MleUw798uqxQ6PxuObwTcElplSF3SW
         G9Xv7GocLoi+ylI6iQo1ljUz2J8OC/txFLLZXSetIxuqijFx5PlHX8vucxVHDvoghlvW
         SEyzDgtoWpFG46I6zbZLfmvbPGuqF43g/uwkUBcNz2DRT60oz+4ShsbZAC1klp/jfdBF
         NhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686326459; x=1688918459;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JJHKGlV47afxhESmn4M8emdIU67tKEEb2KjyNS3Cyy8=;
        b=TZKVaz9Z3K138B3hIsEJUwsqx1y2qKYs5f5vKLvhV6qKe108m3st60mqiYb4b+XkDt
         dY2xrbkRNp21dyJIO65QAyo2jGDMaPBJFdqjhRXq/8aDKySy2Xgm59rnp1e2WYDz2rp/
         HBnHQ16UaC9G1FQhgWDvSzKf0Cj/NWrLWgrKm1eleiESN4BVPKhXtLhSWJoZ++uTlZMq
         LaKjQ20D6IxFdGGYQz8RrI2sOqSYj1aa6ByWKhpryDkCaqCChmoQD9T0QoLjCH5a4AQL
         GbFJxvrf0JF4lSBTEqUDa17CXuRLdXAjbfAKn+8xydxL9YEuHYpfuUOtOF1OhRa/Axu2
         SG0Q==
X-Gm-Message-State: AC+VfDxvp1pK/5lsVCqppgpMgzMoe3SLaqiHcGVvFrXrnldtuKFoipC1
        rjmse4U1BOD0A+Q0rNlPSX2qTg==
X-Google-Smtp-Source: ACHHUZ4MNMzOVPyOZds2RmjGMSDMu8ErQik4SCpzMcmtDR930mLUJy8Vxh/s1fzyIeO2OeXqSiaynQ==
X-Received: by 2002:a17:907:7da9:b0:973:8cb7:4d81 with SMTP id oz41-20020a1709077da900b009738cb74d81mr2136036ejc.49.1686326459617;
        Fri, 09 Jun 2023 09:00:59 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id h26-20020a170906829a00b00965c529f103sm1437369ejx.86.2023.06.09.09.00.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 09:00:59 -0700 (PDT)
Message-ID: <949a2d21-eb14-3ef8-a7be-9c12152cd15a@linaro.org>
Date:   Fri, 9 Jun 2023 18:00:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v5 1/2] dt-bindings: HID: i2c-hid: ilitek: Introduce
 bindings for Ilitek ili9882t
Content-Language: en-US
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dmitry.torokhov@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, dianders@chromium.org,
        hsinyi@google.com
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230609063615.758676-1-yangcong5@huaqin.corp-partner.google.com>
 <20230609063615.758676-2-yangcong5@huaqin.corp-partner.google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230609063615.758676-2-yangcong5@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2023 08:36, Cong Yang wrote:
> The ili9882t touch screen chip same as Elan eKTH6915 controller
> has a reset gpio. The difference is that ili9882t needs to use
> vccio-supply instead of vcc33-supply. Doug's series[1] allows panels
> and touchscreens to power on/off together, let's add a phandle for this.
> 
> [1]: https://lore.kernel.org/r/20230607215224.2067679-1-dianders@chromium.org
> 
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

If there is going to be new version, then:
A nit, subject: drop second/last, redundant "bindings for". The
"dt-bindings" prefix is already stating that these are bindings.


---

This is an automated instruction, just in case, because many review tags
are being ignored. If you do not know the process, here is a short
explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions, under or above your Signed-off-by tag. Tools like b4 can help
here. However, there's no need to repost patches *only* to add the tags.
The upstream maintainer will do that for acks received on the version
they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

Best regards,
Krzysztof

