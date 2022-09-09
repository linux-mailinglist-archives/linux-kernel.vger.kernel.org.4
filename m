Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05F95B2FB7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbiIIHXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiIIHXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:23:49 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB81103075
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 00:23:45 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id p5so765945ljc.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 00:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=xw2tGj4i/BGzgrmFBPep6DT8sXHDJUaiisGkdVfexQY=;
        b=FDb9QYtHpeMnKLbXsu6sSQ2VNTLSHs98Gp3ucj9BbfZGPm3CejGQZ2b3XBBUXZNwuS
         cfhv6+sLtmK4BroTfM6zwXbrHWa88kONsBXff3kTnt4ye396MQETU1hEGZ7k9eF7PSy7
         rKYmavVegYi+dX2Bq/NrCpV7sCjttCuQKwVTFI0bAZ6Qv1zugjRb59I03a2hwpzJXQNO
         py1kzoKyDOkuwmzWkYVoamxJ5Gnl39JHQv17U/iDbNZ0o2XJOqA172ZI/UYe9WuWifGH
         KRegy8IzuMmnlgJPwh9dNvUc2WyH3UCGAun6xA8+vtydKb5owZyEUNf/JQuVsyiQ9SsS
         wUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=xw2tGj4i/BGzgrmFBPep6DT8sXHDJUaiisGkdVfexQY=;
        b=bLSzivh44cSr8njoPJmrmYwmxhZQS1OKjSmznRy062mJiaQvk2Gjy/NHJXo7T2VIXh
         6Bmp5QXpfRMUnuW7SoYzG4zmRVwZhxX9HZRnrwtRYMfHIHL9dZvqGA40Mubunk++P7yj
         H0ZWwK3M3Lx/qUpWul28zJQmx+U6j+DTFucuptWj2hkoZJITcgqJemcpfOu7Jf47Jj7N
         i4fE8nizrs3xVJSXvVQDTsWY8AAT0fC4Ba2CJYziXJWCm18W0hcHhbuOzDGv9SzSAl44
         I5H4V425Nz3m95zPSDuJaf7PtQ9L2ezaqGoY+262dTNIyCviKRzB1KauZF7T2V43adOn
         h/aw==
X-Gm-Message-State: ACgBeo3n5srkfhpFg0DZDGlO+cvWAcCK12CK4N34b2H7XWcWZbLrJPUx
        2S1EG48WfpnGOU44ott2BOvwUg==
X-Google-Smtp-Source: AA6agR5pKzdG0AkkDvuWtiRQUCUOrpOGaZ995aHdvP6egqMViKL6g6CWuElhBa3jVgm6OsOXiZemMQ==
X-Received: by 2002:a2e:b0f1:0:b0:26b:dac2:d53a with SMTP id h17-20020a2eb0f1000000b0026bdac2d53amr1820196ljl.253.1662708223297;
        Fri, 09 Sep 2022 00:23:43 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id p26-20020a19f01a000000b004979ec19380sm149450lfc.285.2022.09.09.00.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 00:23:42 -0700 (PDT)
Message-ID: <ac2bcca1-6997-2d17-b1d6-a5e81ced2613@linaro.org>
Date:   Fri, 9 Sep 2022 09:23:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] dt-bindings: sound: ts3a227e: add control of debounce
 times
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Astrid Rost <astrid.rost@axis.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        kernel@axis.com,
        alsa-devel-mejlinglistan <alsa-devel@alsa-project.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220907135827.16209-1-astrid.rost@axis.com>
 <2b81d814-f47a-e548-83dc-b1e38857e8ce@linaro.org>
 <Yxn9o1MVMPnFO3PM@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Yxn9o1MVMPnFO3PM@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2022 16:35, Mark Brown wrote:
> On Thu, Sep 08, 2022 at 02:20:42PM +0200, Krzysztof Kozlowski wrote:
> 
>> Anyway new properties cannot be accepted. This has to be converted to DT
>> schema (YAML).
> 
> Doing a whole binding conversion feels like a bit of a steep requirement
> when people are just adding a simple property, it's a lot of stop energy
> to figure out the tooling, do the conversion and deal with all the
> bikeshedding that the tools don't catch.  It's definitely nice if people
> want to look at that, for more complex binding changes it gets more
> reasonable but for trivial properties it's disproportionate.

It's more than one property here and many patch submitters are using
this reason as well. In an effect few bindings TXT grew from 5 to 10
properties in one year and still no conversion to YAML.

I understand your concerns however I have stronger motivation to do the
conversion is stronger for me, than for accepting new features.

Best regards,
Krzysztof
