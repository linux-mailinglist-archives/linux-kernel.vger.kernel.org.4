Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006666C591D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 22:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjCVVzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 17:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCVVzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 17:55:03 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E636A24BF7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 14:54:43 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b20so45859453edd.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 14:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679522082;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8uvaRG6SEubgVDA8byacGya26N57UadVLJD7KEjV3v8=;
        b=e3uHRIoBfiqATEEQUeoKbGF4jKPKe/GadoIicmI2t0auPCUZSg0mWBf2LIk1arnKmZ
         54hOhTTuBT3JmwEEZob6Lw4YvkMmj/kplRUumQm3fHT7Kd4AxBPfk8L3b3XpmeoWGLPg
         T+2whG2hq/Sb8mClxgwgOT+kPi0v3gbBeGTzI2wp7+YS7q3jtsp+RoYUX8bTYdNySWli
         vQK1fv45TOVgSllyKbw/6jDxPXyacVEZGCQsZk+1yl+khoX7XIbFqL7Z2InRpfvPxXhf
         DiyCR8yjhJ0oOjhFBdCquaJhzSEkQwCNf/9P9xtscbbtt5SRkzF7Ttvc/WwuPlTcXR4Z
         KW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679522082;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8uvaRG6SEubgVDA8byacGya26N57UadVLJD7KEjV3v8=;
        b=itgEgBq9N0RqOSrC4Ohgw71r7UkuZhgjui2ZTCu69C1lkdmvQPOK3fd2PknCbdN8O/
         Tquj4gj+nYc97IiEoM3fjIKqC29KXWx+V/mzRBWT519qVknl8v3aSq0FzH90bjkOkcLB
         HP5yckY0FGICL9VwqtzYVoGqH1BgON1sV8Sp87ESP71AZfVXeJrnQ9QMfzB37/Z1kDuw
         95rhNSGFHpaXWtfL31LwWIEilAVFCCQmmjVK5xJ7yy1j6oH0M93ej3gpiaFv4FolstV/
         o+W8ZidYUr6DLVXZJD7xLKvM4UtN3M0tz0kNR6wiKDAho7Z9G/AJkf5bSWUayTLAFUkT
         FU9A==
X-Gm-Message-State: AO0yUKVryEQhnj30v++bjEEV22Ex8OZJ7X9Wr+83M90LLmAmIa1d6ETu
        6aJSHPeUNrTydIb6WmRw/IUyQg==
X-Google-Smtp-Source: AK7set/PZpsMUz4Si6epVj5Xk29Fp9cUg4PfUfBNqtl8qYNcExJeg+LuYMrEp71qE9lZhQLzeacgUA==
X-Received: by 2002:a05:6402:1391:b0:501:c839:cf90 with SMTP id b17-20020a056402139100b00501c839cf90mr7103329edv.3.1679522082373;
        Wed, 22 Mar 2023 14:54:42 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:626d:5729:6e71:4c22? ([2a02:810d:15c0:828:626d:5729:6e71:4c22])
        by smtp.gmail.com with ESMTPSA id x21-20020a50d615000000b004bb810e0b87sm8377005edi.39.2023.03.22.14.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 14:54:41 -0700 (PDT)
Message-ID: <50a6f96b-0822-66e4-be5c-46466766702b@linaro.org>
Date:   Wed, 22 Mar 2023 22:54:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 2/4] dt-bindings: trivial-devices: Add Atmel
 AT30TSE004A serial eeprom
Content-Language: en-US
To:     Eddie James <eajames@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        andrew@aj.id.au, joel@jms.id.au, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org
References: <20230322140348.569397-1-eajames@linux.ibm.com>
 <20230322140348.569397-3-eajames@linux.ibm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230322140348.569397-3-eajames@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2023 15:03, Eddie James wrote:
> The AT30TSE004A EEPROM is compatible with the JEDEC EE1004 standard.
> Document it as a trivial I2C device.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

