Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AECF604C4E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbiJSPxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiJSPxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:53:23 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00378168E4D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:50:40 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id d13so10961232qko.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qOfJ+DtwLBfM1XbcRFI2vxlA6IMtNA7Mryro9IUFiqQ=;
        b=oc0gnv7Evlf82aR7oG1AboITLdai3h8yWa1/UJ7yR9+TKLMHmoMbTTmAbXZDhx/mH/
         f8JzUDB4THCqRc0UcOpZlhBf1KF8fZ37sXyanaOERaci7Hknvb+VnHq9YbG3S6M4Qo6t
         Kd2fXjzLpcglTwZTAsYkeamTktkNbPTVxwdidUbWVJxEwIsSvaDQSYBNPbr630dN5pHj
         M+Ps8vzh5cyYyGUhPUJy8KVfU+HvhMor6ykp8jdRP8SuM03kXJie5tGnWlTL235k8gUg
         G33IffSj3PK5urVg+8imYLgvKxues9F4oX65mcPNhgvVmOmdMZfVBCV6vqIWG1/dOL0q
         K3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qOfJ+DtwLBfM1XbcRFI2vxlA6IMtNA7Mryro9IUFiqQ=;
        b=JB8ZcRb27Z62PhwP1t0NfqGRu/ApaRc9jRgzGnZduIa8n5/5btqn+GHanTZ54EDvG+
         bUAU2aGfGOzB6k5JxpgeLWaXyV8j0gW+FeI3Jf8Jnzvj84v0kvXdVI5eDRiY+RoLeAAt
         E1MCrETJXzWajGckpuPE30TElH2qEK2MAwC23ca3uq9kZmY3eKS73f1N+K830iE1OFkR
         vrbVj8Vig52qSJ3l9qyjZ+YXvnN2PDRD5QyvXcNl6bFipSeo/SxG0oDuXp8yGumnN2O6
         41ADM9n4qMABSTAHHBDTzVMlBmv7/HDLx8UNQQplmlL4b2kPANuOGLelsaWUAS2dZTKH
         bG6g==
X-Gm-Message-State: ACrzQf0DEFhU/s03cpGELDMjwxYCmLmLpyy3OCoNvnq6if3LUndxA+Eu
        ACGrd6LPIgz8ux0Nq8rXx2YrvA==
X-Google-Smtp-Source: AMsMyM4XstFVm8wPAtWg45RsoEAOZKJXDEbdNRgDhHSCIrBKgB8W/I23RBjhjFccEni81/er3hUtsw==
X-Received: by 2002:ae9:ef53:0:b0:6ec:f6f:4422 with SMTP id d80-20020ae9ef53000000b006ec0f6f4422mr6017291qkg.41.1666194588599;
        Wed, 19 Oct 2022 08:49:48 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id i23-20020ac84897000000b0039853b7b771sm4207324qtq.80.2022.10.19.08.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 08:49:47 -0700 (PDT)
Message-ID: <a44cadfe-5e9d-8c6a-b111-abd550a909bf@linaro.org>
Date:   Wed, 19 Oct 2022 11:49:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 3/3] doc: iio: pressure: ms5611: added max SPI frequency
 setting to the example
Content-Language: en-US
To:     Mitja Spes <mitja@lxnav.com>, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221019125254.952588-1-mitja@lxnav.com>
 <20221019125254.952588-3-mitja@lxnav.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221019125254.952588-3-mitja@lxnav.com>
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

On 19/10/2022 08:52, Mitja Spes wrote:
> Added max SPI frequency setting to the example. It is now honored by the
> driver.

Use subject prefixes matching the subsystem (git log --oneline -- ...).

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

> 
> Signed-off-by: Mitja Spes <mitja@lxnav.com>
> ---
>  Documentation/devicetree/bindings/iio/pressure/meas,ms5611.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/meas,ms5611.yaml b/Documentation/devicetree/bindings/iio/pressure/meas,ms5611.yaml
> index 4f06707450bf..08bd06e6dabe 100644
> --- a/Documentation/devicetree/bindings/iio/pressure/meas,ms5611.yaml
> +++ b/Documentation/devicetree/bindings/iio/pressure/meas,ms5611.yaml
> @@ -52,6 +52,7 @@ examples:
>              compatible = "meas,ms5611";
>              reg = <0>;
>              vdd-supply = <&ldo_3v3_gnss>;
> +            spi-max-frequency = <20000000>;

Whether it is honored by driver it matters less. More important is how
hardware can handle it. This should be included in the bindings/properties.

Best regards,
Krzysztof

