Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC0F6B5D8B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 16:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjCKPxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 10:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjCKPxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 10:53:15 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33711125A3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 07:51:01 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id y4so2952696edo.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 07:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678549860;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FOPcjhDYKPCO/Zmz2tGgC7qcp0wJ1W217UIkJ4Y9I8g=;
        b=exLH0pXHR2Hk2k1GxkMT8NMsFHRUn8Gh4Hi84g2CApUpajQKPndJt5y+CGjzcwO4DV
         NjVjIYSvcYVSJYBuEH5VwTgcBhO6CTHG9zqBf3Qh/eZpM7k2AmEcbmLed4hsDVHqXKzX
         zhpg09XUjiwP8IbNlQRuoUPUbo1DO685I0vPic9/1QSfnOzrpPtNPjYrnNsNW2nyAaSW
         YM1pbQYnxdtaSiUjt0jH+qrgS6V5+618+VCfDMm/QFx9ldVDG970XSC5e0Vm21WzjDkC
         zvX+tOA9MVp/TiOHI60XMFU5DX17sePwJf2kjUvi0xAy9pKzY9ERSkn6ycS/h0djU9ZC
         zTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678549860;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FOPcjhDYKPCO/Zmz2tGgC7qcp0wJ1W217UIkJ4Y9I8g=;
        b=J0gbx6coYjHIRNLs9SrHvvcGzxLltFjkmB5ZHGw/j4YARoDZzKCobWfJ3V1u+Om1dj
         Q+FAggGQV+uVr9PKdhg/OJtWp0pTDf8SphY/xjnN7HmBUw1CY9IX/JjDXDc9QLP2ykqg
         0PbzsG1O33nHUimV9nJXwUWAfPEKRkB4uuusyXJD1WPGlme4tPVA+tOWVl7PrKRCJE2X
         +Fma/I5SgvMahF/M4+4RxQAXDwHGXyPwiURIJqlA9+8wYKIcT+5SMg3DfCdVl//o8Sb3
         nv21Oe+EP9vbRt0AOlFjbOZUbCVTxpJAxQ7YK/NOg4tOF6zf5pyU0kqPDey1FtJPSUTa
         jUQw==
X-Gm-Message-State: AO0yUKWY0+LC6wxSQkwbq1Z/8KmDhmqNfUgL8w1wynw4NkN2ECK1r69U
        dh8a2xdyvez9WhnLqCjr+g2JZQ==
X-Google-Smtp-Source: AK7set/jKFNKU2NfkbcpoS9MGUQVvnrWP9c19CwbXw4TjLsty5YWBFzICJsaDHdJ1KheJ00mIggWjg==
X-Received: by 2002:a17:906:2843:b0:8b1:15ab:f4cd with SMTP id s3-20020a170906284300b008b115abf4cdmr26060805ejc.53.1678549860208;
        Sat, 11 Mar 2023 07:51:00 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:6927:e94d:fc63:9d6e? ([2a02:810d:15c0:828:6927:e94d:fc63:9d6e])
        by smtp.gmail.com with ESMTPSA id n7-20020a17090695c700b008e493b7bb61sm1214587ejy.153.2023.03.11.07.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 07:50:59 -0800 (PST)
Message-ID: <c13993bc-9d12-f20e-de27-fa0b8a58ed33@linaro.org>
Date:   Sat, 11 Mar 2023 16:50:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] devicetree: synopsys-dw-mshc-common: add
 "fifo-access-32bit" property
Content-Language: en-US
To:     Sergey Lisov <sleirsgoevy@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1678548256.0817535-1-sleirsgoevy@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1678548256.0817535-1-sleirsgoevy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2023 16:22, Sergey Lisov wrote:

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).

Missing commit msg, which should answer why you are doing this and give
more background.

> ---
>  .../devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml    | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
> index 8dfad89c7..2bc5ac528 100644
> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
> @@ -57,6 +57,12 @@ properties:
>        force fifo watermark setting accordingly.
>      $ref: /schemas/types.yaml#/definitions/flag
>  
> +  fifo-access-32bit:

Missing type boolean.

> +    description:
> +      Specifies that this device requires accesses to its 64-bit registers
> +      to be done as pairs of 32-bit accesses, even on architectures where
> +      readq is available.

And why the device would require this? If it has 64-bit registers in the
first place, they can be accessed in 64-bit. Otherwise these are not
64-bit registers, but just lower/upper 32-bit, right?

Also, why this cannot be implied from compatible? Why different boards
with same SoC should have different FIFO access?



Best regards,
Krzysztof

