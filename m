Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF576A0D5E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 16:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbjBWP4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 10:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjBWP4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 10:56:23 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0D456795
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 07:56:22 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id ck15so45034832edb.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 07:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S9MksQe2BAdK07YeQzg1YaUSY9SPjEfox3Q0Fk5Pvig=;
        b=UNy54ENZ5YaJ640QDfUC0Y2TGuVWRdfwf8gTHRnsWKa3j4GW74I6DrGJmhDe81spyw
         DRkIGsTPNzlC3KtKw2RqCtTphDmp0dS61/RcrY9YyCRW02beCeXQs8FhoEEep2i/Rb0S
         YPtHsEDTveQVnJQdOxQvbYje8YpoTu61rFol8jczeENhWovxNuiAx4xqrG6gmHIhLbxz
         7t8TNdEZU8xfvNvKOEoDFRwVHCzZd/yOsGJmX8oWFt0k6kQ2XJMwvUjBwIoUiLvqCia8
         CwTdLJ6z42Fupzrffsf568CNX9dw+wYDOAaNmW6PpgmbigOQrH4yNL2uIDDlCH1pJnmu
         VobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S9MksQe2BAdK07YeQzg1YaUSY9SPjEfox3Q0Fk5Pvig=;
        b=NKqWpU93UUdvRMWHeOLgKV17zxjHjR4gzVdU4bRYd05PNniuvkKiCJGqgY0HCsva8p
         PylWQMr8BxTj8Ta3YygnloFjUiIjRRimQdIwv4kexAh6Ei/h2iLGGOUmFqMt0RUdflzC
         H+pLWeb1+KVT/jqPKoxxcgAeqAxZVBRV0y3YVNjIMzwkPEi2Ww6PBEGzKPsOBRZ4gdpW
         YeKd8USTMJJfU4O9aGktzDfNSI+MQERj2tJPIgJormrQ84vT6vXhG016yjWAPOxtUvsa
         o5lddOjtQv6VljZg0k31+x3TSipl9jL+pf/NdcZ9KqkvRGGElbleeriecncwfWyF68rp
         Gcag==
X-Gm-Message-State: AO0yUKXsEW5Hjd0fEkwVJC8WMqYD/4LTr7tj9nDNUzfwm7qund91uaGE
        JrAoYcV+cnLfKNw9imBQkEyVkno77p/bIzbi
X-Google-Smtp-Source: AK7set+A4SdT4h0K2X6Z+k0pdQEnMjswA7kn3apuBvEbNI+fDaMOmYhARfdEssZmoVhshaRzLOjsQQ==
X-Received: by 2002:a17:906:58c6:b0:8ea:825:a5db with SMTP id e6-20020a17090658c600b008ea0825a5dbmr6993494ejs.76.1677167781178;
        Thu, 23 Feb 2023 07:56:21 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id og5-20020a1709071dc500b008b1816dcf04sm8717024ejc.136.2023.02.23.07.56.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 07:56:20 -0800 (PST)
Message-ID: <bbec5e72-ccd8-c24c-0f62-bcd18981f39e@linaro.org>
Date:   Thu, 23 Feb 2023 16:56:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] dt-bindings: vendor-prefixes: add Internet Initiative
 Japan Inc.
Content-Language: en-US
To:     INAGAKI Hiroshi <musashino.open@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
References: <20230223132502.2045-1-musashino.open@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230223132502.2045-1-musashino.open@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/2023 14:25, INAGAKI Hiroshi wrote:
> Internet Initiative Japan Inc. (IIJ) is a developer of network equipment
> and a provider of network-related services.
> https://www.iij.ad.jp/en/
> 
> Add a vendor prefix for it.
> 
> Signed-off-by: INAGAKI Hiroshi <musashino.open@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

