Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2B36BE589
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjCQJ0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjCQJ02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:26:28 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE69BB78BD
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:26:24 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id cy23so17760237edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679045183;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dS1ViTo7YXyoHaesprxlUZ73a5LNDAZaMI4/y98OGuE=;
        b=tyy1h+/Rm73cWzgEe1RM3BtxotuK6dKfzT1mKLI4UP2oyUQUP4x+WLCi7NAplS54Tb
         n74zCjRqOOEZENLO0BRqMkVmy29sD0/pztmylHrQSYGlKkU+p8rHnyRqtKz4f2l9UgbI
         Ixd5CEwtb6SyMdJ7YAKTLAggVpn3O62mCgRkseNRODAXHqaizsPvBiGYeKySM3Inmogk
         DTO8qjUvvCi8ZVmSmAzO1ApPPleLxA1auE+zNNaq1fVHzI+5UrX3gqDXk6yfMC9rom98
         jj7sG0ryeYKPNHPM5Za+GXpXi2DrIEo9Bm9wVxGKfvbkCjYeScDUau3WQrB9xxVr7LuI
         GQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679045183;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dS1ViTo7YXyoHaesprxlUZ73a5LNDAZaMI4/y98OGuE=;
        b=awpoZWoPu7RUa3M7UiwiFwc8kPXrBxPerY2ffFlLmLyWkeqUGGqCZYkvVZz9qtC//L
         JKfnnGayxxmqic1D7t5aJuUBPcImuDx8Xb+St5orVwCLKkNDE1k/pkOYjAGzUQUEVoTJ
         fkg03b0hmn7HwVufSJblWpMB4SkOesptq5h1Yiy9eHoSl3sFShanN8a3dqHjM304zjQ8
         OkWoit9rlDI9aw9eLFgBPwylaB6IwDGYXsYIIKThmN9iNJnEeDxUNJx3SSSUcGsX4sZf
         c6QedorTyI1+4/4ElMggNzb1ZQ3zTlTpmZ99tvND/9gnexV7dsLAEVA2hU1vO0zCbOAD
         M1dg==
X-Gm-Message-State: AO0yUKW7jD7Jea6ql9b6gsrCIGrUI36hXAcxAgm8+gcFPbU3GVqaCkxz
        aGQb7JKKyfWucCzbRsX6G0Q1eSKw76t4Hkg8Xc8=
X-Google-Smtp-Source: AK7set9xWJGf4X02U+zMuBYCf/KV6yHt7pRADOs3M3LCzDMMcohMQJRFroGQ2jAbyqSumn9pK8pf9A==
X-Received: by 2002:a05:6402:1057:b0:4fa:96fd:797b with SMTP id e23-20020a056402105700b004fa96fd797bmr2268033edu.6.1679045183373;
        Fri, 17 Mar 2023 02:26:23 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:848a:1971:93e0:b465? ([2a02:810d:15c0:828:848a:1971:93e0:b465])
        by smtp.gmail.com with ESMTPSA id i4-20020a170906850400b0093018c7c07dsm746241ejx.82.2023.03.17.02.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 02:26:22 -0700 (PDT)
Message-ID: <5a8fa13b-d9f7-aca8-3898-51d6e53fa78a@linaro.org>
Date:   Fri, 17 Mar 2023 10:26:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 3/3] i2c: mpc: Use i2c-scl-clk-low-timeout-us i2c
 property
Content-Language: en-US
To:     Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wolfram Sang <wsa@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Ryan Chen <ryan_chen@aspeedtech.com>
References: <20230314215612.23741-4-andi.shyti@kernel.org>
 <20230314221614.24205-1-andi.shyti@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230314221614.24205-1-andi.shyti@kernel.org>
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

On 14/03/2023 23:16, Andi Shyti wrote:
> "fsl,timeout" is marked as deprecated and replaced by the
> "i2c-scl-clk-low-timeout-us" i2c property.
> 
> Use this latter and, in case it is missing, for back
> compatibility, check whether we still have "fsl,timeout" defined.
> 
> Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
> Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Tested-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> Hi,
> 
> this should be the only patch where I forgot an 'ms'.
> It should be fixed now.
> 
> Thanks, Chris.
> 
> V4 -> v5
>  - replace /ms/us/ in the commit subject and in the comment.
> 

Please send entire new v5, because this messes with our
threading/reviewing and our tools.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

