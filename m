Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E087383AC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjFUMYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 08:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbjFUMYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:24:05 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA9519A5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 05:24:01 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f9b4a715d9so24327625e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 05:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687350239; x=1689942239;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HyrN9ABo7D1rMAlVWp90E4oDQOUS70PYpdgdCcfeHQs=;
        b=GJMQOelCjgjeElOgF/yRWW/zmO45PI4Z4cqDmYnmNbJkmD+s9SIl7CvuFMxKx1tp65
         XsSiqjvxOgs1pBN3DLPy7Voxvpwa+tfV70z9MQm3GBmUiZGmjBr38brOWf1KNvokVkr2
         co1v+fyyCXhUYsd5I0Z+aHXPCJFvScUZ3c2K4Nrma9KR9yNFbECsnahIXRs5iEnuWyyd
         nIAzoSHdP7oNSxm3cNol4d7nYfah0PqjY/qL9jqmWLfSheZ/Q6hx7mkPFuwnWZOiQY6y
         2Ze9c0hZ4IN+GNLPgQZSDl5ZiL2eRmZTILgO9qIM7219PTbnEfLfN2Qktntl2C3esxWd
         mGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687350239; x=1689942239;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HyrN9ABo7D1rMAlVWp90E4oDQOUS70PYpdgdCcfeHQs=;
        b=k+tWmgJRYyxd29L5Rjj3MN9KC4MsIIbGFsX/HZmN2fKeSCMh3dRan2AT+awAuwcMrf
         5BXnovPJm9hK8Nea7gXxSKzVwaNrQWswGiZYhAEdorAaLBooul64+EhQMG1BNXoFBtIO
         vtKtl/O1REU2ZaduDmwnVXHMPmw7L1U6/pXn0sKD5iezlywR5ccdDw/WFeyAXWu9f7p8
         lsHFX1e7IpyVTR4LCGLoW8+i7OcewIOUNP7s5PWGVpR7sqDb7qi/Yp+C1+dbjv+QCeCr
         tP3Nf8IWtyKmN9ibylVj/lHEP9ivrxC+woXwQWpHH93kkzoRJ4GZmryvf3ZdQv8l+Rdd
         B6CA==
X-Gm-Message-State: AC+VfDxZN8uW+6iem3bWiU12l886L1UuHvI9mH6XAdVeWH8IL07D4cri
        lKqYGY6GxjRTP2+T8slVidNzJgMSHQB92ejz0UI=
X-Google-Smtp-Source: ACHHUZ7255jwlQugIpETOZOq8b8AyBKGM97MqOJ58i/4Ig868aZxMEtz1PGHvaVgiHV435PiSRz48w==
X-Received: by 2002:a05:600c:b59:b0:3f9:b3e3:bc9b with SMTP id k25-20020a05600c0b5900b003f9b3e3bc9bmr6461662wmr.4.1687350239519;
        Wed, 21 Jun 2023 05:23:59 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id h25-20020a1ccc19000000b003f42158288dsm15939950wmb.20.2023.06.21.05.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 05:23:58 -0700 (PDT)
Message-ID: <819ae31d-7837-105d-6781-c5c48765c919@linaro.org>
Date:   Wed, 21 Jun 2023 14:23:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] spi: dt-bindings: stm32: do not disable spi-slave
 property for stm32f4-f7
Content-Language: en-US
To:     Valentin Caron <valentin.caron@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230621115523.923176-1-valentin.caron@foss.st.com>
 <20230621115523.923176-3-valentin.caron@foss.st.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230621115523.923176-3-valentin.caron@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2023 13:55, Valentin Caron wrote:
> STM32F4-F7 are, from hardware point of view, capable to handle device mode.
> So this property should not be forced at false in dt-bindings.
> 
> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

