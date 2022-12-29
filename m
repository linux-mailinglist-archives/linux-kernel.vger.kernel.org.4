Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459CA658E2C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 15:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbiL2O7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 09:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbiL2O7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 09:59:39 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D411209F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 06:59:37 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id bq39so20034143lfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 06:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BQgqD5yKyexPyUiP+XHbQzzKxGqubb9GzAa5DLAHirE=;
        b=V0Q7BmFFT6ec0yZSyXvvigAl02ccTK/qahRH20BazR/w7cvF0awkiwzS842J8G5acU
         96oQrEEAWezsdbJ/GSL76EGu1usEdhBMHchN6b//EazZNR2JTqwywfJgLsVkGdnJoQOk
         ZUCdSV6ffMi5ZnAR7U1foIaS3AWX0esV4jzaRwcmsUDzX2Ry6dA5hYQKcWFr8KsaRjiM
         JugI2iGCSzWO6GUA+RJ/6COyPJXnZjB+EB37nCABmjoCITTRQzGjlfH/a2eXMIfCikOd
         McNVxm5mZ6dDRlehbwsJZ1DomTHxp0cNXkzOxl5Ta4RUZ7e0kt3BHw0IJkfG8a/Hn1yB
         R3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BQgqD5yKyexPyUiP+XHbQzzKxGqubb9GzAa5DLAHirE=;
        b=xZSdJ0r5ep8RyM+LwJSG3OYnLc5fUCv1BFRAP9FqaWUPn/ckCbDY4LM00wNBI3U1nd
         5uxxeVboN0UYrocSeKO8Lz7za9tC1KbpslTymTvxriy7QUKC80TvXNg6tIhGU68p064q
         5knGQQup1+NJOIYkvNLF8/ToyVZNNfQzYZPnilPAG9cuhCUPNQ4l7fHhYxohponcFZgV
         WW8LlgAFbBFTNf3+vxm2mglHsgPqJXt6TjB9K9ksHBydzLTADdGcBx/Kitylet6QL8lC
         GanxCGfrvM03qBWdytw5HLwrJXqLCEP+EZm7zRKMYrqF1rW6rxSQcJ6XH58Fxw6M/J5Q
         F8xg==
X-Gm-Message-State: AFqh2kr4ExxJ46W6+oVagvjynqClvxReCt+WVnmbzAir0HU55rAzkPv5
        V5Ugbxvk2Qqr+wBoNWOgLVhOZA==
X-Google-Smtp-Source: AMrXdXtREVHs/knF6eP6Yx2euwcJo0QaCUFCD9N1Guy+1sbb/KTI1Ywv8mix9o60iLu5eU/gvf5Dyw==
X-Received: by 2002:ac2:5e9d:0:b0:4cb:b47:7c9e with SMTP id b29-20020ac25e9d000000b004cb0b477c9emr3138137lfq.38.1672325975446;
        Thu, 29 Dec 2022 06:59:35 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c26-20020ac2531a000000b004a6f66eed7fsm3087260lfh.165.2022.12.29.06.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 06:59:34 -0800 (PST)
Message-ID: <1bcccdc5-7d6a-c792-3829-8b3286c451ff@linaro.org>
Date:   Thu, 29 Dec 2022 15:59:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/2] ARM: dts: n900: rename accelerometer node
Content-Language: en-US
To:     "Sicelo A. Mhlongo" <absicsz@gmail.com>, linux-omap@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tony@atomide.com,
        devicetree@vger.kernel.org, maemo-leste@lists.dyne.org
References: <20221227223841.2990847-1-absicsz@gmail.com>
 <20221229145251.3535402-2-absicsz@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221229145251.3535402-2-absicsz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/12/2022 15:52, Sicelo A. Mhlongo wrote:
> Use generic node naming for lis302dl accelerometer, and drop its
> label that is not used anywhere else

Full stop.

Do not attach (thread) your patchsets to some other threads (unrelated
or older versions). This buries them deep in the mailbox and might
interfere with applying entire sets.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

> 
> Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>



Best regards,
Krzysztof

