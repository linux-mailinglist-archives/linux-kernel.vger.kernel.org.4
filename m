Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCA96B710F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjCMIWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCMIWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:22:44 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4E8252A7;
        Mon, 13 Mar 2023 01:22:43 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id f18so14614969lfa.3;
        Mon, 13 Mar 2023 01:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678695762;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AO5HxHzGBIMe9WIdTTZKOExWILcN/PtatPuzHHVjsds=;
        b=VPJr8vzznKoEfbr8e8rPdysVk5mPp9Zjk2Sb94Ka2A5GosAoXm1q055nXOOzG3RUA0
         tHJQIZ1XUy/InkczEJS4+SLfuku8YumVTKwBZhSg0StErJMy6unXmV8zPER5yi+5gXN+
         kWJvy9+ukfCIFoOuj6S8cRw+HINTsE07S1vTFoq9gpYoTj3PzM8qVcBiaxeKaMrRGAlv
         widrTvVBslCFPXr/y57peIf+FEPVqpHG8GNIWMEsJPga6+dmis9Wv76cMcOYuZdC0iQK
         Hs1h7WVvk0J0/cQEb67SQJONxWipsn5lvxoQk5BTX0h+/9uWt5aH/XDV0eYiBHaOf5UI
         J+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678695762;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AO5HxHzGBIMe9WIdTTZKOExWILcN/PtatPuzHHVjsds=;
        b=hemM9RigQo0DgZd9Qa1hJeN2kP0RmSOYFzPcH6jQ5h2BN62HnAWcY2gj+1h8GaVrIy
         I5TjX97RNRCrDFlh/7NzcVU6D+34LrID68nLCygXjcrI02D8FGhVneBj0s+9cGPDUQOB
         DTNU+ZTviZPSlgUJmWL1n7WI+C6mQ7KtN/81go3USURFpClBhskKehqa3ujlePr3jYZO
         qRp4xkX5xor2QPpm8WkFuAl5EEo697lwFJ/uLLAz995EcTGG8W2Aew9eicU0Yz7Vk/tl
         6MPKVgYvSXWNa8M0UAJByD7iyc9HpQ1mp+MIAEC9HZ3gCPNLocKLh19bQyFXqV3AqhbA
         WqiQ==
X-Gm-Message-State: AO0yUKU39s49yIM3XW8/iqr2WUuLQ//uaf6KOZuszCqKZiKrAqOO5Pnp
        2qD3u/360iS2me8VHMqHok8=
X-Google-Smtp-Source: AK7set+GqcnpiFfgAmE2etd54OAM+nGkOI56TgHT0ouiR1+UXqeePBeWxMuggFooVXLuK/aCgiDgMw==
X-Received: by 2002:ac2:51c2:0:b0:4e2:40ba:af44 with SMTP id u2-20020ac251c2000000b004e240baaf44mr10509644lfm.7.1678695762012;
        Mon, 13 Mar 2023 01:22:42 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::6? (dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::6])
        by smtp.gmail.com with ESMTPSA id v5-20020a2e2f05000000b002934b69344bsm916564ljv.16.2023.03.13.01.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 01:22:41 -0700 (PDT)
Message-ID: <f590c5c0-2458-b4b4-42d2-e3ff4f0c7b52@gmail.com>
Date:   Mon, 13 Mar 2023 10:22:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCHv1 10/11] power: supply: generic-adc-battery: add DT
 support
Content-Language: en-US, en-GB
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230309225041.477440-1-sre@kernel.org>
 <20230309225041.477440-11-sre@kernel.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230309225041.477440-11-sre@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/23 00:50, Sebastian Reichel wrote:
> This adds full DT support to the driver. Because of the previous
> changes just adding a compatible value is enough.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Best Regards,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

