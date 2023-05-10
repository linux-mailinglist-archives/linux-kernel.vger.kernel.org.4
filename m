Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259396FDFF4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbjEJOWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237185AbjEJOWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:22:35 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1DB35A5
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 07:22:33 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-96a2b6de3cbso124959466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 07:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683728552; x=1686320552;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Cq2dAXKen28TFRJxFUmJolJOIPagqM9lmyQejrbnP0=;
        b=CRLLTkxpDNRBjKbcf/EKDbxrp5trWySYKgR+gWJ1yji7JfDBGtjR+yR5I/IDeFbs5S
         FUXYSY4MSBforC2h+SBu1Yn44w8jBH3eKyEHwbYGSRb+Y+/VO2MrtAlh1d+/moKXWOii
         j7ji9jTqlYIckeN/20CTedNK0jHeZUmVqHg4FUV3uXre+tUbWeMmBua+5CthWo/SLPde
         TU4UU1G/2mwqbEpTgRz4Fd8fxz6fnDdPhfpHQrxFCsvJvO/a0cPuVY7f0DyeID5V1W8i
         8w/nZP4LBKB8JnGYmZxYeciaE4aXmgGkmiz9YBGPjU6cEKOtnp+HiIisb6R1dqn3lcgi
         7SIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683728552; x=1686320552;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Cq2dAXKen28TFRJxFUmJolJOIPagqM9lmyQejrbnP0=;
        b=XiVfTz54vXMQCXE4S9cvcCBYpiLdz4Orcn3bYHjKRUIbqau8stLns9bqpyoMzyL8f0
         XPIB49xT/LEnsIqhfPWK9nyM0yGDXf2LbTQCpNz9F4KL53lrAMBVPGiVslDazd/z1dRa
         I/LLkmNYBwc3u9MLmqqhMYh/paDFy8EZQfqVV4lls/evbfu+JMUgqY9LmTAvKK9fp1kf
         BzPYZ+lwLSzRGKGNeNEpTGPk4aG3klUyrILkbrD6EdoYDKkqAR7mATdsF7CwIIosfIF9
         UaA38TyVE/mYsH9Qz533S9HXNsX+y0DniXOcCzPE2HVoocDuopy9R57yg8tGz+zCOUbb
         wvrg==
X-Gm-Message-State: AC+VfDzLj1cq19qcHwTpjO3xB/40UjpSDr+7euoTPNFO3c69sj1GTKxH
        +K0nlSTpRCA/5Run6W1qSfvdaQ==
X-Google-Smtp-Source: ACHHUZ5hF1/+EtCFaC53Xeuo+W2qUa0bKiM/oLJWXkNMc4r1wFlIqW/8j5HbrXL7lnjtCS+dVxD4NQ==
X-Received: by 2002:a17:907:940e:b0:94d:69e0:6098 with SMTP id dk14-20020a170907940e00b0094d69e06098mr16660292ejc.45.1683728552300;
        Wed, 10 May 2023 07:22:32 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c175:a0f9:6928:8c9d? ([2a02:810d:15c0:828:c175:a0f9:6928:8c9d])
        by smtp.gmail.com with ESMTPSA id u18-20020a170906069200b00967004187b8sm2720364ejb.36.2023.05.10.07.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 07:22:31 -0700 (PDT)
Message-ID: <06412b70-7c36-1a7e-3ef1-eb255285895a@linaro.org>
Date:   Wed, 10 May 2023 16:22:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 7/7] dt-bindings: power: supply: axp20x: Add AXP192
 compatible
Content-Language: en-US
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, sre@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, wens@csie.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230510115046.963432-1-aidanmacdonald.0x0@gmail.com>
 <20230510115046.963432-8-aidanmacdonald.0x0@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230510115046.963432-8-aidanmacdonald.0x0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2023 13:50, Aidan MacDonald wrote:
> The AXP192 is most similar to the AXP202, but the current
> limits are different and the USB OTG status register has
> a different address (0x04 instead of 0x02).
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  .../bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml  | 1 +


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

