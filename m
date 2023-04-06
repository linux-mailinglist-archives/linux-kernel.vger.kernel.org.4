Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD386D9183
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 10:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236102AbjDFI2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 04:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236117AbjDFI2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 04:28:10 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE217686
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 01:28:07 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b20so147427839edd.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 01:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680769685;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I7lRsFf1L4fQnEzaLtv1MoTYQNVZVAYHc8tBsB/TvO4=;
        b=anCP01luFaDe/Jo9JpPc1+q4v3LHR2ILhcK572jKQfQXsNvmBrCEj6DwlfSnw6PmL1
         ssFajYuwhXB9prFYXGt6GtMnh+K+To39qgruZl5UfU8V/1BeHynpoAKF7oDgwe5g68P5
         k3KNCOw8pdZTvzuLL4bG7kGuCU0LSoqZe5hg0v3/PzPlaOHKBEfoKI1XYWSDmUx0127l
         wDljBKLysSLOMNNqfcwYP/ML+ZHVCteLo6eJNsnO9g/1HF12UCiCcFHssVRwm0o4vwm3
         wutGqGDdRgxBvsyIP3IIUpvWAoYYDO9CRj5py/f7gVcX7DD+PywkZWpOV9g6DyGqPqEF
         1HFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680769685;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I7lRsFf1L4fQnEzaLtv1MoTYQNVZVAYHc8tBsB/TvO4=;
        b=JpgfjLoVHEfPD32J1lPao5K17w2N05+psIZEYezojSDYK6uD95e08RXwaJ5WrbwDjB
         fxp2gJuXz4gnDEqMECbZN3FRRdeNaAQ0rllPuqnRc6WoLYL0lnYEu/2R4E09zyAQYag1
         hZ6Ti9u6ZBB1d7aX0im62NpkawJ8y+rJlNuOVellR3rLJYBPi24M1U8YpJ3bMqBUQKlJ
         8lVZMeX8pIMHCSbpqiWffnfhgCdCq7wY5q2H2ErIFyfE4WId9iJDRq04tmV2l0ai/UPP
         Z9990j3JJIhgWau/YUb57QJdy+taqJd1KpUT4f6jIR1ZH8JNfuU0N1wUmAmxFYCLaahF
         iTiw==
X-Gm-Message-State: AAQBX9ewBqJj6ZPtKBUTdZQvxgPedT4Dr6lJJm2BnYAY/5vz9dGOhtnD
        kRsi9GG9e1lht2Izi5g0Pq2byA==
X-Google-Smtp-Source: AKy350YLVffCoF2DKktsXZ/ZRG76zI6+Z/r/Kp9Idluq6+XCLkBjUWzD/AXwoB/SDw9rBljyBzOcHA==
X-Received: by 2002:a17:906:524e:b0:93b:943f:6261 with SMTP id y14-20020a170906524e00b0093b943f6261mr5057621ejm.74.1680769685528;
        Thu, 06 Apr 2023 01:28:05 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id jw12-20020a17090776ac00b00946c1068b14sm479754ejc.120.2023.04.06.01.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 01:28:05 -0700 (PDT)
Message-ID: <d7e795b8-6c36-70c5-73e4-ae115cac32a9@linaro.org>
Date:   Thu, 6 Apr 2023 10:28:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 3/3] dt-bindings: mfd: dlg,da9063: document voltage
 monitoring
Content-Language: en-US
To:     Benjamin Bara <bbara93@gmail.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     DLG-Adam.Thomson.Opensource@dm.renesas.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Benjamin Bara <benjamin.bara@skidata.com>
References: <20230403-da9063-disable-unused-v3-0-cc4dc698864c@skidata.com>
 <20230403-da9063-disable-unused-v3-3-cc4dc698864c@skidata.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230403-da9063-disable-unused-v3-3-cc4dc698864c@skidata.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2023 19:14, Benjamin Bara wrote:
> From: Benjamin Bara <benjamin.bara@skidata.com>
> 
> Document that the da9063 only provides under- *and* over-voltage
> monitoring in one, and therefore requires both to be configured with the
> same severity and value. Add an example for clarification.
> 
> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>

This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions. However, there's no need to repost patches *only* to add the
tags. The upstream maintainer will do that for acks received on the
version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.

Best regards,
Krzysztof

