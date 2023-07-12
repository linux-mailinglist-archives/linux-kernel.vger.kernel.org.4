Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7992F750787
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjGLMHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGLMHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:07:07 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A381738
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:07:03 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fbaef9871cso10751070e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689163621; x=1691755621;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3aUrZFM5gyMcA+QPyE8YHFPQc0BMKlzWQfDrf9yaDl8=;
        b=ZzHhtBSZ5mbz/QjCbfuRo6+NiiwnP0eenohylVfl9iNhEhiZr+SRQP6a01kNCzy3xM
         HzQ2NacbTAGYHcY9btfl5EINFsbsWxgMznGVmEvmVUbRwHj1NdC3ryD3TYByiMQ39Mgi
         3+doXyCQzclfr0SC+TrMTojEwu0HhzdHsb+8nJ0iPVJ44dmrNQSWY72xTs6TijTYsFSO
         FXqVTQHxpqEWcvOR6ODdK76nACPbjBWgMjpoOKxq4JPHCmWUQZecpbxF3gBLH4Gm9P68
         Z0hQkC6hQv3NK90ZMomLsqXOt38ZUqzFh3OWiCV5E/FXXrD1DaN2tV/azvAFGuVYpRUM
         25oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689163621; x=1691755621;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3aUrZFM5gyMcA+QPyE8YHFPQc0BMKlzWQfDrf9yaDl8=;
        b=FMptJnfxneFnACOxMCXBp7FV1UmNrOqLedkqVaPFLrEa+0Ky0tzA38c421DpwEllqh
         yvLHmPgID61uoD//3JG7OUQN75UGcgjawY3mYjcikNeAZ8UYl/8nCL6sK3AHPFqC6jhG
         DAScXsxTS9FJ1WEZwOHRanTD/q5buof7kbKpzS9zLGgA+uq+sFYGRrfBRS2lNx314o5P
         sFvgtmxYrZ0511y60sIEnMSDWazQoYILAXOvk6ynmiM6wvxz7jYLtSPoEQBsPuBgAdqJ
         sfnR6NqC78wybVvre8MkBaW9RKijDsXCoXXPbjYn9/cW6dBCNGf6yLzbXmrXv27laaah
         kjcQ==
X-Gm-Message-State: ABy/qLaUNa8JDswMReH/DczJdVq5e1ohKZseYig8S1bVxJb+bk1+KMOM
        1hYQRTsqPrA/T6fmp/iqnDOwyUPg2VXazUO+mXU=
X-Google-Smtp-Source: APBJJlEaQO7gyYYDeV4Yr+qR7c/XnqifTqJIkggMCvR665mQT6xvulYbzD9SVMFZVDsLOy/VWSCXnw==
X-Received: by 2002:a2e:88d8:0:b0:2b6:cca1:9760 with SMTP id a24-20020a2e88d8000000b002b6cca19760mr15421335ljk.27.1689162713841;
        Wed, 12 Jul 2023 04:51:53 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id kb9-20020a1709070f8900b009894b476310sm2458160ejc.163.2023.07.12.04.51.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 04:51:53 -0700 (PDT)
Message-ID: <ce408456-5b8f-8aae-335f-a6c0845d1166@linaro.org>
Date:   Wed, 12 Jul 2023 13:51:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/8] dt-bindings: trivial-devices: Add MPS MP2971 and
 MP2973
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Rob Herring <robh@kernel.org>
References: <20230712114754.500477-1-Naresh.Solanki@9elements.com>
 <20230712114754.500477-2-Naresh.Solanki@9elements.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230712114754.500477-2-Naresh.Solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2023 13:47, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Add Monolithic Power Systems MP2971 & MP2973 to trivial devices.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

