Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6A36E79EA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbjDSMqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjDSMqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:46:49 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4904688
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 05:46:48 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id vc20so26396780ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 05:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681908406; x=1684500406;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7aC9QJVuBevcboA/BflNZ1RlmayRbwZ7HK/k/lxZnPM=;
        b=fte+W3khVB7Nunis5EJJJxCuWIDON4bWzUASAqX1LDHPQtIdTrYFFNDFQcNC5zLa5U
         6AII/xLy4pSmLVowVDwCUaEyblFIfh69FPW4zMlmDquXOnkfEUjs6n5UHNBJs0AC84PJ
         FQ3Hy7xnL6DA5Non9JnW5N9fYi0c0jRuW7kV41D8w+upHOaxcp/D8n9lJsjK9k6Wotrc
         +pS4bu1gZ/jKYuxG1mNY+88q0fLguwNZECvbC4Gnr+3Kfxo7nLPhF4DnrXxRS0JmMG+B
         n/auVOQZ0o7aBTWSt1Hy0c323kDirlxUo1i7fSf7W60EU8OJTxaRXiF2cB6EudK0TCd+
         e84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681908406; x=1684500406;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7aC9QJVuBevcboA/BflNZ1RlmayRbwZ7HK/k/lxZnPM=;
        b=D0aaNDWwIyZS3rdna7ochy0QeRaiwNKcBJtp4Cpndr+7IHj8p1eoq7WuUfWPgyAG9L
         S36zPVDW4u7BsfEiUg4Bkin46BN5hYDHVlYg+hbPiv5TqwqSSLI2Qym3kBLN2RY2qd1q
         5IWxv+6038cbgC0j8b6VYLjYVvBmIOnEtrgW39oArK4inLu2akeQqG9QE23rtD8eUuK+
         RaljcHPjGWO/4dJDasJ6v+F20BYFu1X+iwdPshX8fKdKocMmFwTHmZlIohdo76oUbC4c
         9BLMnGHj0hQVDvBzVx1cD3ZtmEeqjIZitu8TWzzWRiETCiWEPqXm2jfLyMRynLCD1KCE
         v3gw==
X-Gm-Message-State: AAQBX9eRcY0BrsFmjUybri/l7pxIpZtsmITD70MFUHv4+IIK12jVY6le
        6Jz4LhHLRGiGMKCFPTPrhZNhsg==
X-Google-Smtp-Source: AKy350ZMwOuWqQxCAIS+0nah/aDzoumU1LrPPa2y+0kQgJJnXaUJi2vAA/WtVdpbsllwiaweARGZ6A==
X-Received: by 2002:a17:907:3e1c:b0:94f:3728:7047 with SMTP id hp28-20020a1709073e1c00b0094f37287047mr13216088ejc.6.1681908406654;
        Wed, 19 Apr 2023 05:46:46 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:b7d8:d88b:1fac:c802? ([2a02:810d:15c0:828:b7d8:d88b:1fac:c802])
        by smtp.gmail.com with ESMTPSA id me15-20020a170906aecf00b0094f4e914f67sm5128812ejb.66.2023.04.19.05.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 05:46:46 -0700 (PDT)
Message-ID: <9a2ed4b6-13b7-9e65-263c-d2b08e11da00@linaro.org>
Date:   Wed, 19 Apr 2023 14:46:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] arm64: defconfig: enable TI K3 R5 and DSP remote proc
 drivers
To:     Hari Nagalla <hnagalla@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org,
        quic_bjorande@quicinc.com, arnd@arndb.de, treding@nvidia.com,
        dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        broonie@kernel.org, rafal@milecki.pl
References: <20230419113958.17141-1-hnagalla@ti.com>
 <20230419113958.17141-3-hnagalla@ti.com>
 <70b6f997-d420-0e59-0be5-6ae9db7aed66@linaro.org>
 <ae49267f-4534-e489-4bb7-946944a9a04c@ti.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ae49267f-4534-e489-4bb7-946944a9a04c@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2023 13:52, Hari Nagalla wrote:
> On 4/19/23 06:43, Krzysztof Kozlowski wrote:
>> Why two separate patches for simple defconfig change?
> The intention is to separate commits for enabling mailbox driver from 
> remote proc drivers. The mailbox driver is used by the TI K3 system 
> controller interface (SCI) driver as well, which is independent of 
> remote proc drivers.

Yeah, but why? This is simple defconfig change, just enabling drivers
for same platform. With such arguments are we going to enable all
drivers everywhere one-by-one?

Best regards,
Krzysztof

