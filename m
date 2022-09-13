Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56CC5B6A72
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbiIMJOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiIMJNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:13:55 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489875C37E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:13:54 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n35-20020a05600c502300b003b4924c6868so505123wmr.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=wOXq4EBtuFiFHBb3GzVfUsN7E33ZUXKGmJFqun2J61A=;
        b=V6I/nxUOszHJyPi5bIFgW0oqsqnpS8KyGBZG/a1xhhRUvqDZd131R2gJ301L4Ajydl
         v4S/TQkUc+Yh8jbzv89IO/NurpCLdjwxpHs0X3d51XESJfs0DJTevSiXxeAmYXra89Ue
         i/xynn4IuPiMi7PZjE0hszi4fAk1YiLc8+gusYUCg2Sj6b1T6S1ZLCdhQKdLZM9pwRX2
         feHXc5OJkHT7tne1xTkGDC3FSar9+NrF6tSWJXPPBuHV1vG9ziSDUZwfMUiAX7j/w7E+
         XHTds1HJndxPoUQlYOwVj0vjfWtd+4fdHSmHUECt2OSq5Bb0ZPXl2SoUcp4tt/m+xdKe
         kNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=wOXq4EBtuFiFHBb3GzVfUsN7E33ZUXKGmJFqun2J61A=;
        b=X1OLRCq5jSBR1xgWDiCU0W3PjK8UusanDzMkLurm03EDTytjdXfkZCZUxF9L+5rNzf
         I9w0r3XYJ8OaiTCF4VaSGnpulbfMY1VBIErD+LbN7OwRXCLQwY2gz1M7mf//TyZ/NNJj
         iPaQngSQj++ZiB7AkaesxYSy87cnXIRUAqvXruO2Fydvqa+ppzemY1XusFj5Wn3pTLLa
         UXQC3sR+mziI3k/0QK5sQCt35+6mwyoCTJ7pIaNDiAtWf0W+Kj7Vtc1vf8BdK/U+Uu94
         /09/z3DqoAD8N5OoTN/ehaY9t4Elssuf1ixr6KUoUbla6L2+unl8lQzQFgSQ6wiGeGUA
         7GfA==
X-Gm-Message-State: ACgBeo30NVu5mnVtppuFdGI3CH+/v9HvmqLx2/JElF8fTE59vzYrSmNE
        PbRVF9H2nst4482Ogyhs9xRhdw==
X-Google-Smtp-Source: AA6agR404Z9zyxR/Dsu85/hoOYfczNYlMnh8Xl9pLVAYhwqsaYuQdkGuTi0iBEyaqLP4aXhbUp3Z/A==
X-Received: by 2002:a7b:c8d5:0:b0:3b4:76bc:5dae with SMTP id f21-20020a7bc8d5000000b003b476bc5daemr1620741wml.122.1663060432548;
        Tue, 13 Sep 2022 02:13:52 -0700 (PDT)
Received: from [10.119.22.201] ([89.101.193.70])
        by smtp.gmail.com with ESMTPSA id a12-20020a5d570c000000b00228dd80d78asm9673036wrv.86.2022.09.13.02.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 02:13:51 -0700 (PDT)
Message-ID: <404caabe-f855-012e-4cae-35abdb58f23a@linaro.org>
Date:   Tue, 13 Sep 2022 11:13:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] dt-bindings: sound: ts3a227e: add control of debounce
 times
Content-Language: en-US
To:     Astrid Rost <astridr@axis.com>, Astrid Rost <Astrid.Rost@axis.com>,
        Mark Brown <broonie@kernel.org>,
        Dylan Reid <dgreid@chromium.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        kernel <kernel@axis.com>,
        alsa-devel-mejlinglistan <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220907135827.16209-1-astrid.rost@axis.com>
 <2b81d814-f47a-e548-83dc-b1e38857e8ce@linaro.org>
 <Yxn9o1MVMPnFO3PM@sirena.org.uk>
 <ac2bcca1-6997-2d17-b1d6-a5e81ced2613@linaro.org>
 <9a72bd22-9298-65ce-a894-540f98745a7e@linaro.org>
 <d521d40e-c79d-b044-44b7-6f10845f4268@axis.com>
 <bdfa3f29-f63d-1fb7-f37b-0b4a1f6374b3@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <bdfa3f29-f63d-1fb7-f37b-0b4a1f6374b3@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2022 09:16, Astrid Rost wrote:
> 
> Hello,
> 
> I did the conversion from txt to YAML.
> It requests me to add as a maintainer?
> 
> Dylan was the original Author.

The maintainer of the bindings should be a person caring about them and
about the hardware. Usually it is a person with some access to the
device or to its datasheet (but it's not a requirement). Feel free to
add yourself and/or Daniel and/or any current maintainer of the driver
(but not subsystem maintainer).


Best regards,
Krzysztof
