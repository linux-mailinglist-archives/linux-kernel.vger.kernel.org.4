Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC9F5F7489
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 09:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiJGHGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 03:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiJGHGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 03:06:42 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371F2A6C08
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 00:06:40 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id d24so466197ljl.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 00:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=FSmGNYPsHl9Ro1MJ7SK0qxA2b0opEEGQTUXyGcDbh9o=;
        b=foHGxaipVhE4g1J2J3AKimMGWlMyYJ94BYSHus4iZXvHzycxZHOaxVIcx75vQhOkhM
         RUVn3+LF8DvwQqMfdRMsxSMAJQngOWfZ6Svfr2JJ+G/4EvJx4bwVbjnmBY4t8CWfPni/
         aOR68VVLHTz7M7lPiPwoxWld9aXAT2/zkWVus3Zvn8q61bqVvRZ33+lRHBUNJTqjTFbs
         7XOGhE0fGA7qyBmXMZYY+mSQ5mFW34rU2W0UDjJGmxSIG+Y43UQsQLQ/lMx7EWFebWB4
         /P3j0y4pT6ICbE7mbZW5+cWBwZvsuC95D1CrY8tVaGHo0rW8nIQJiv1qvS6CfpB+hnHJ
         9lwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=FSmGNYPsHl9Ro1MJ7SK0qxA2b0opEEGQTUXyGcDbh9o=;
        b=b5H+I2EZ/6+RPFLqZtPECAbiUBpke4xW0iHX+vzZdlXv9Qfhpdym0C+p4pj0xsgfgs
         FS2Nij2Dxjiqx86wHmeVdF9KT72dOUOXome/REjfT9sCJuE48arlq9Y/+U8tN+2kR5d3
         0RMeLmKA+gezEP0jKdNlqXMqpv2yIwabV78WtbNMUXOoCKzE8Hj8kEYFt+aD+pCSxysI
         H+WCNHvtK2vqKknUInPNWemlIzv919DObMMZ0V1SbDVMLcopdY4IcRV5S3vzkItnCv/R
         wa8ujM8yB+UhtUYFzyrwcaqKgMO67zAURfWRdcjJlelGI3sShwtKvl6ORdOoNEsxOGhi
         iC0Q==
X-Gm-Message-State: ACrzQf3NZfAFhJFgdLmw5rTN26ipowJB7dS40qJDSKYuDPWHxjK4Lluk
        kVzbdu0TMQfLyHyST0VttDvmUQ==
X-Google-Smtp-Source: AMsMyM7eIvv5GKIgDiCZIjDDnCooaDnHvZD7wBLGQTTRpllEwxZlb9pUXT4af4QcZRMvuZKVS512JA==
X-Received: by 2002:a2e:92c8:0:b0:25d:6ddf:e71d with SMTP id k8-20020a2e92c8000000b0025d6ddfe71dmr1129408ljh.170.1665126398407;
        Fri, 07 Oct 2022 00:06:38 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a17-20020a056512201100b004a27bb1ad62sm173557lfb.205.2022.10.07.00.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 00:06:38 -0700 (PDT)
Message-ID: <4b861177-df32-ab9c-c746-f32f0ee6438d@linaro.org>
Date:   Fri, 7 Oct 2022 09:06:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v3] greatlakes: dts: Add Facebook greatlakes (AST2600) BMC
Content-Language: en-US
To:     Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>,
        krzysztof.kozlowski@linaro.or
Cc:     patrick@stwcx.xyz, garnermic@fb.com,
        Bonnie Lo <Bonnie_Lo@Wiwynn.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org
References: <20221007055346.3484180-1-Delphine_CC_Chiu@Wiwynn.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221007055346.3484180-1-Delphine_CC_Chiu@Wiwynn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2022 07:53, Delphine CC Chiu wrote:
> Add linux device tree entry related to
> greatlakes specific devices connected to BMC SoC.
> 
> ---
> --- v3 - Add documentation of board compatible (bindings)
> ---    - Add board compatible
> ---    - Remove the bootargs
> ---    - Revise the DTS node name
> ---
> --- v2 - Add binding document
> ---
> --- v1 - Initial draft

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

> ---
> 
> Signed-off-by: Bonnie Lo <Bonnie_Lo@Wiwynn.com>
> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../dts/aspeed-bmc-facebook-greatlakes.dts    | 241 ++++++++++++++++++

You need to document the binding. I think you already did, but then
submitted without it. Read the process:

https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst

Best regards,
Krzysztof

