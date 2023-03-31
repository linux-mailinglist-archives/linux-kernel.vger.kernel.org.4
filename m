Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538416D1CFC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjCaJvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbjCaJvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:51:25 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC0722E87
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:49:42 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id y20so28179742lfj.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680256181;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZnWBUW3nUtZAoa8t2Uk9JsdIPMN187oJzfJjlXLN/3k=;
        b=SO47t4BrSz+0Ya2L17CY5aaGJmyu12XYH/60nMWB4NqBn/p8/0zEv2hk8YZTzilXHk
         K2leQyVkG4hZtep7CXRjOzCrcG0TVMTBy43uXEl2OyECJLd/oDYGMj6pdVf01oCBVVhM
         7k56sT52l9DEqL/iALbWu/GA2aCPZIj7dXv5qP5jV/UIBG2pdSphgv5t3Q8n2gXtJRpT
         3J4XmTcKq/flTsNoqwZHRLqMqXuRa+FLBI/ww3y7vhim775/t3V55vuY5AQS3vmGsct7
         pwqlA4dbd6ly7aLwYPlNpr2fY3kwTj3aY8REs3sY4aR4A3zgCbC5dUW8NeA8jpMt16yM
         tY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680256181;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnWBUW3nUtZAoa8t2Uk9JsdIPMN187oJzfJjlXLN/3k=;
        b=dgsjzs3j+fGy38Ubls7gJNHrEfqAXhY1cLCrrImNqxTtRJ6NhM1CdFZ2qH2Ig1ab12
         iDCvTWkCP0ro1mHFB5fdAfRXjFVGYOJp11/nodI1eE9rxn3w8aCNSnVxq4IkYimxSBpH
         UZ7LhOTf4BRZYSyWLPRUHRFegcTCmEg4Dz3InfjN1o6pknJdDvUHqV9uhLMBw0nHfJ/p
         ZGL2rW6B+28eyUOjT0oOiKPZBm53PLTW3MRN95KUi/Nmd3SPzbgYDrs1MfHsuhC70/OT
         5WdzODweAuep5z+CsUQntnpFGR4lYwTimzBq3Jm6Hbssn5Dvj1R9aYkVfHFM9tbyMCea
         FmUg==
X-Gm-Message-State: AAQBX9ePPciWv1i8NI4gsFjLIk3I68EQZyefUaL82Td8+sGFeeUiCB6Q
        YlNoauBLB7FtTkBVwhWdmJXGPA==
X-Google-Smtp-Source: AKy350bRaWmaWYv9VciLbpP08Z1N4J3jY/hl0ylFbIG8kB+HmxvcndpVh+yrb2bBTuHo0y3AhQEBVg==
X-Received: by 2002:ac2:4c95:0:b0:4d7:58c8:5f44 with SMTP id d21-20020ac24c95000000b004d758c85f44mr8869699lfl.12.1680256181030;
        Fri, 31 Mar 2023 02:49:41 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g12-20020ac2538c000000b004d85895d7e0sm313021lfh.147.2023.03.31.02.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 02:49:40 -0700 (PDT)
Message-ID: <d9043fa1-dff0-cb9a-afb8-8db9c3eeea2c@linaro.org>
Date:   Fri, 31 Mar 2023 11:49:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 1/2] dt-bindings: power: supply: bq256xx: Add
 ti,no-thermistor property
Content-Language: en-US
To:     Hermes Zhang <chenhuiz@axis.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Davis <afd@ti.com>
Cc:     linux-kernel@vger.kernel.org, kernel@axis.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
References: <20230330065202.1349948-1-chenhuiz@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230330065202.1349948-1-chenhuiz@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2023 08:52, Hermes Zhang wrote:
> Add a new property ti,no-thermistor to indicate that no thermistor is
> connected to the TS pin of the chip.
> 
> Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
> ---

So you keep ignoring my comments? I wrote extensive comment at v3. You
did not respond that anything is not clear about my request.

If you keep ignoring it then it's a NAK from me.

Best regards,
Krzysztof

