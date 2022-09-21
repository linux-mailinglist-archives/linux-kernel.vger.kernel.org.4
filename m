Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3C05BF92B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiIUI1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiIUI0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:26:52 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AAB85F8B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:26:51 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id a8so7892846lff.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=9KJJwj1s7Dp0oQBIoEw2O9tVMdNPTzRC2Bn8QNz1lZA=;
        b=bak9WbdaxzzxlosLYD5AgDCdwbWrSGFRBj9JCiZwg6CyAPVMBppsimakW+92rSRUjW
         xLnUTkDAnXwAS7d8G9NMEXZmgmvmODtiMw17u7dWdYZA/AqkiKVdSgjW9Lu9acj+mYDy
         kP+yGU89j0kZbhUlJIxfe7OeO4MQl5V6+DuBTTW34FhPKfBjZ21yz3hqZs19pxV7iQ1C
         EDhl5MZ2puMZtw/1MWfc3i1CRilaArwvUF7Q3ksLNAYYjtNP1BdqYy8lOTcxxL8HrwG9
         3vgDXl2tcJ4YVsFI/H8tSx6SzOpmtxswb6Ba8orsxC33J9tylEJ8uf4/Nx0KP3xMaxEd
         DXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=9KJJwj1s7Dp0oQBIoEw2O9tVMdNPTzRC2Bn8QNz1lZA=;
        b=mnyOTOHnbMb305DcZCDBFibCt6H3TYEL9ulFe1DDZ056b9RGY1mwPu1VJtilXHtvRz
         thvyC6MFOp7F1oT9lwpEk7F5lP/I2J57b+F74rNNc0Msq92ktOys+yWxIyDoheM/kWNU
         GzprEi3OQZ3Mv5va5aoONKN7JRF1NK3dJdEAR7SN6OdHuxAbB5E/lOcIR6JkxZK7avYp
         r5Vnh8CL+mWF3aV9Upn5V6QCe5zFdICfn343dklGcw6PaR7qOf1wQ7ldITb90NX5P/4D
         d7jG2hbywY6xPJcljVTOu37ejHyO7Pm5Flp5ao3Hfpeunl8NyZtQwFoTlgg3VDhoc4jh
         PncQ==
X-Gm-Message-State: ACrzQf0OfP6ONWXNG47NWUpW71KL6AkEd2GC+LuPmsjOCx45CYLEXflE
        T57IKOQs5h1NHfXzGaUfn7czsQ==
X-Google-Smtp-Source: AMsMyM4QdzvfZZITqgLFRTgUk8vut+XtsP2NVx3OC2Rid6gZDVPdRIhc9BS39F0DfpmfaX8g4VaW4w==
X-Received: by 2002:a19:dc14:0:b0:494:82c3:e485 with SMTP id t20-20020a19dc14000000b0049482c3e485mr9523033lfg.542.1663748809789;
        Wed, 21 Sep 2022 01:26:49 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id c14-20020ac25f6e000000b0047f7722b73csm334323lfc.142.2022.09.21.01.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 01:26:49 -0700 (PDT)
Message-ID: <f7d57145-0850-a2f4-ba18-9ce74dd53005@linaro.org>
Date:   Wed, 21 Sep 2022 10:26:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v4 1/3] dt-bindings: sound: ti,ts3a227e: convert to yaml
Content-Language: en-US
To:     Astrid Rost <astrid.rost@axis.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dylan Reid <dgreid@chromium.org>
Cc:     kernel@axis.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Astrid Rost <astridr@axis.com>,
        devicetree@vger.kernel.org
References: <20220921081834.22009-1-astrid.rost@axis.com>
 <20220921081834.22009-2-astrid.rost@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220921081834.22009-2-astrid.rost@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2022 10:18, Astrid Rost wrote:
> Convert from ts3a227e.txt to yaml.
> 
> Signed-off-by: Astrid Rost <astrid.rost@axis.com>

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.


Best regards,
Krzysztof
