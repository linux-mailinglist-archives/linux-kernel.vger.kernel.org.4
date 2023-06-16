Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CEB732D2C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjFPKPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244305AbjFPKPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:15:42 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB8D1B2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 03:15:40 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-978863fb00fso75044666b.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 03:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686910539; x=1689502539;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zwScczYRHDuS+uM/rfmKO4C5p7n2XSuTcTw270MNkk4=;
        b=zu3fjlKDUVErA66PTf6isUYRnsi7raaRLUcMH8ROUwv9ap/uu6U8BdfBi0HWSg1D0n
         jIWXf8WKfMLoFoD/HMSIyr7h6cSx6mUIQTUDx1ojxopOqHpnY/Cd5fsYjkXjbpflKhGs
         /Bxj7GTAXk/eFTPgRZWgEENN33IOxXjFPSsnTAyrHupI8Ch+8Fqh83+tMGqRQZZfMdd5
         7i+BEgnvwp9iQTSkb4JDIBqygGSSCdPzRO8NWfQxEDShRtk5NcREle6gpZ3WbytjaUMJ
         +xKCckYV9aXSmfRRr5fCGpJ7S1ucHVhegy4U97iGyCgKIna2QnwMnbnz1JRNNuD+1Tw2
         Nevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686910539; x=1689502539;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zwScczYRHDuS+uM/rfmKO4C5p7n2XSuTcTw270MNkk4=;
        b=jXSIohU1OFy0OHqfvCWHt6T73W+GmJcQGFh+IUr39aWG2CgmSvQPncsykzBX80mRaf
         UCflfWI8Bt+fUtJBoLo4qzGh44gsmMhUlQKb7z760En7bA1GwZdgXMCiTearroNXd7qH
         mO9IuN+pNwC+OX8bjF9BR+vemsIkB3Hnx/Aes+BKXHK/NhGmN49wJsqtt9ybnuTBEyUc
         89XzvNXkC3kRmaz5Op9ubMBSh1FazrYIwjDzOSqim5tEgQSZEdPxH8nlDkgYBBMoOhlt
         ZhTAmrLHbBdrVVqO73E5BkR25BQT6ri7wuaZFnWjGjIEpWRUM8+GRe2bi6MdYsH9dUux
         EQ9Q==
X-Gm-Message-State: AC+VfDwGxJMpj4NRaU9Llj4hCSpoMpKFVNLydGxrRyaDyCW4r/y002Eq
        IExWJlI8V1Ma72w+EcEC8XFNXQ==
X-Google-Smtp-Source: ACHHUZ6a9+a+UtZA5+MxGsJZ0KNpW4rSE+S0VhL127tZfNrsWcrP79KtqNmz573hlr6hcjvmtpqGYQ==
X-Received: by 2002:a17:907:9621:b0:982:8a28:ba24 with SMTP id gb33-20020a170907962100b009828a28ba24mr1789141ejc.63.1686910539290;
        Fri, 16 Jun 2023 03:15:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id x5-20020a1709060a4500b00982a60f2c0asm1926383ejf.74.2023.06.16.03.15.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 03:15:38 -0700 (PDT)
Message-ID: <165dd295-1b3a-5062-772a-613a7bf6fd45@linaro.org>
Date:   Fri, 16 Jun 2023 12:15:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] dt-bindings: arm: socionext: add bindings for the
 Synquacer platform
Content-Language: en-US
To:     jaswinder.singh@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, robh@kernel.org,
        ilias.apalodimas@linaro.org, masahisa.kojima@linaro.org
References: <20230616035813.255062-1-jaswinder.singh@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230616035813.255062-1-jaswinder.singh@linaro.org>
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

On 16/06/2023 05:58, jaswinder.singh@linaro.org wrote:
> From: Jassi Brar <jaswinder.singh@linaro.org>
> 
> Socionext's DeveloperBox is based on the SC2A11B SoC (Synquacer).
> Specify bindings for the platform and boards based on that.

A nit, subject: drop second/last, redundant "bindings". The
"dt-bindings" prefix is already stating that these are bindings.

> 

Binding without it's user is usually useless. Where is the user?

Best regards,
Krzysztof

