Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2DD719377
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 08:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjFAGnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 02:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbjFAGnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 02:43:07 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AD698
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 23:43:04 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-973e7c35eddso55788066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 23:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685601783; x=1688193783;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UmSfsETfgsyBnEWYanCV/ROlC60ZGrEUeoYRLWqXRks=;
        b=DgKtwOZ8y07HecygPtYrT+IQdA1ysHg1/QELL+zVR+za+1arve2tFeGNXh/jjko/CZ
         XIryuoQ9jKAHP2k+Vn2LsNSTu/2BLSppy4hRw/2Dfz54fmg302q/IRqwG3HzzJFlly0M
         Jro8DadZMP06KL9eZ+dv2FojO7nZFjEe6LPLipRtOZFSkd++DEVeX8hgDIoPfMt9i0xy
         eLHl6O9aOZmJ9bNYOcRMRwqydeZWPkTuC7sraCy/AZ+MlPLLyAQQLILNJEJhfEkJceW7
         a2t7sDrTicSJC/yJ0d+gIj3IGmXpQgmct4ibu4yNpNDhdBH9jsNz28jrQvZcV8+/EkuS
         VIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685601783; x=1688193783;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UmSfsETfgsyBnEWYanCV/ROlC60ZGrEUeoYRLWqXRks=;
        b=VNOXy7mOFStvhLjkqbZvThsCqzmYrn6lJgd+dDL7Hgr7pEMQsnfSL4NM46PlMTuLiv
         WlCRnZF9nKlSqgFFJ/tNMX/YtTEyQ5b6t73VdQHbjVZq+4qc6VX+bPIAIu21GEhcmZyf
         xsbRYZuVUesvEdwm6H95ggcvAZQlUbYRD83fePkLhYRvk9IuK9BICxU9S4J2HjIsocAj
         N9wDjdNWalwf8nY4Ma1zyCP39XsFljlBRtM1xqc9Av7sFNhGfzaGuKUt0nC7/eX5sJik
         VUgA1X77WgDdfCMW9v9lOzMapWSTvpAwQLuLpEtT5fsIBjHfn5fkWwwvQk5vTLSJnsD3
         VVKg==
X-Gm-Message-State: AC+VfDz9e8mHFQjieDKy6MEcK4i5ceHOS6ntWeL/UqHv+Ab0AofI2KZ0
        cJRylnvYPm/CGTi8/4k6QdP0Ig==
X-Google-Smtp-Source: ACHHUZ5RHyfEK1QryJ6fVuNpnZ9juCMBcnlrYfmha5Dwl3DpZm52+m4R1AwSvkzRU0EPvxsrHA4LSg==
X-Received: by 2002:a17:907:26c7:b0:973:92d4:9f4e with SMTP id bp7-20020a17090726c700b0097392d49f4emr6962082ejc.53.1685601783025;
        Wed, 31 May 2023 23:43:03 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id f13-20020a170906560d00b009603d34cfecsm10041260ejq.164.2023.05.31.23.43.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 23:43:02 -0700 (PDT)
Message-ID: <5b07a200-5bf4-db0b-e3c1-ca52c5a204c6@linaro.org>
Date:   Thu, 1 Jun 2023 08:43:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 08/43] dt-bindings: timers: Add Cirrus EP93xx
Content-Language: en-US
To:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601053546.9574-9-nikita.shubin@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230601053546.9574-9-nikita.shubin@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2023 07:33, Nikita Shubin wrote:
> This adds device tree bindings for the Cirrus Logic EP93xx
> timer block used in these SoCs.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
> 

Fix versioning.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

