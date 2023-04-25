Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9306EDB1E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 07:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbjDYFRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 01:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjDYFRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 01:17:30 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFB35247;
        Mon, 24 Apr 2023 22:17:28 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4eff055d4d3so2367333e87.3;
        Mon, 24 Apr 2023 22:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682399847; x=1684991847;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JnxMYL7t9r8k0/dlYqYKpi162XSbo0kvlvfpcduFJf8=;
        b=ZRcPtqc6A7+Y+R9nvZWVWNH5ENJ8XmMUXJU8z1XmgMbKtVtI3YA95jl8dINwG+UXPc
         8zYfv6wX+ZG5/YfeUiTDmauroG6QXvvY+k/L5aepun0qOTg6k2hSvTdmHrF8Pd9YPs0P
         /jZql0swRJYkq0AFTAY3GDwOXouJjjlsuO8LTYpHCVulD51pqWC2oygnsmFl5somCONs
         aam2jC66iA4CdB+sVQkmNfB251+4XJRKmeF3l0x2vMb7J+NX6izHoqnzskk5FUrjFFRT
         FrWJDanxIvDG0ASt4lXRRKQXyw5czkuupjl6+hK1Qt4cQcXF7uzORKI2pVU13mntxY2v
         ggJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682399847; x=1684991847;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JnxMYL7t9r8k0/dlYqYKpi162XSbo0kvlvfpcduFJf8=;
        b=PjirbNw5mxvkscoiHv17kPCZfaHkiF6l05XJ4OCxyomoQB4dX+pcUn1F06qtg0mVrP
         8UA/72vbyHYCZ7DpDJ6wJAF5v6xJL8luVcug0mGNd/a0W0LDtDu9z5rt33ZE5dvQ9n1q
         QpqpiucDymZx6Po+obPYQKbZA2Siyz5ckFZnT8YyCvdAgtVZQP9CZSs/1OZIj5nyesiT
         Naic3YKFgaTeuzJKf3tpsGLqhaFG8cPGloUavQZbQ9EtpTukPsWiPUb/qtRosHrQwmsQ
         YwTpV3g0TJDF8+Xy8I0wv3OmY1craIk4B/nxMv7CgeI9FxIrZwEsbAWkokrLDBdf0RCC
         KaZg==
X-Gm-Message-State: AC+VfDwkkJMrps3OZoHOabrDz+AuaXVYKqyRs5y63jq329u7TqMxff+E
        q8vJqRiW6dgiXZIagOVfRAsaGO0HJu4=
X-Google-Smtp-Source: ACHHUZ51wPdu4BKlXfKiIk398KdCzpCgkBeCfXi/Ho7jUkSE1zK3B1sJMeMLc4KUpyl4YbL0P6eUcQ==
X-Received: by 2002:ac2:43db:0:b0:4ef:fed9:8ef1 with SMTP id u27-20020ac243db000000b004effed98ef1mr114658lfl.48.1682399846653;
        Mon, 24 Apr 2023 22:17:26 -0700 (PDT)
Received: from [192.168.1.111] (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id b7-20020a056512218700b004eb12329053sm1909605lft.256.2023.04.24.22.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 22:17:26 -0700 (PDT)
Message-ID: <614c626e-208d-2be8-6a83-f99f2720e091@gmail.com>
Date:   Tue, 25 Apr 2023 08:17:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/5] iio:trigger: Add simple trigger_validation helper
Content-Language: en-US, en-GB
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1682340947.git.mazziesaccount@gmail.com>
 <91fffd0001e8efef90f43fa03026dc0e5e30b4e4.1682340947.git.mazziesaccount@gmail.com>
 <ZEabb3lJzGNb/BMO@smile.fi.intel.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <ZEabb3lJzGNb/BMO@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/23 18:08, Andy Shevchenko wrote:
> On Mon, Apr 24, 2023 at 04:08:19PM +0300, Matti Vaittinen wrote:
>> Some triggers can only be attached to the IIO device that corresponds to
>> the same physical device. Implement generic helper which can be used as
>> a validate_trigger callback for such devices.
> 
> Missing space in the Subject?
> 

After iio:? Yep, thanks!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

