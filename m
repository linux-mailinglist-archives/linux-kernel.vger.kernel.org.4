Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842536B0B2D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjCHOaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjCHOaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:30:04 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F671B53C5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 06:29:25 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso1458165wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 06:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678285763;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VJ89bgjwAq+pShFJM6RxMYNop2d8WVlgJ36rQMMJ4eM=;
        b=YdonUz4xOW0eFNZKwHudpDzlHIbOr45eQE0qUxNDxYp3f2t08zob05lymsOaXglaQ5
         7Mi8D/FA6hX7eu4klOL1vAErXGkEUhpEipjyOfRSFZcof2DJpaxRey5Fkz+scgd3RI1y
         hBepafmLgER0CegeNdhGr+F1MEQ18NYfhVBTCpIzviy6IEmTtzswrNGjdsgdUBp2FJXQ
         NtJFuoAp1BOu0CQz5/LSarMyI6YWKvhPJn8q3UvQEX1wxNIYtJi4ikTAO0l2Pqfly2Gh
         YmAFwtbXR5ox5w/YW3Gwc6BmkTLHIu5YYDbStjAzW2D7o8PhaTT1oIykQDCcGs/VH4o1
         pVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678285763;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VJ89bgjwAq+pShFJM6RxMYNop2d8WVlgJ36rQMMJ4eM=;
        b=ZcarycSIWWjcjyTd9O9/ZVTq+WvLyIk9bIdI3JWEDSstEnQlbdDOzDVBgc9104LWnf
         KS688MEAgrtdZRrIxMDy5sf50DOGTOfi26M1+CIwagBtpFhXSnODGJmAUmOn5+OjiJxs
         2Il4VtkX7cx0A49FW6pyN/tYrX3wdqHSt4i+1vanytemfENWuT8ZASBxyx2x6/JIaOas
         c/08u363YZSCEqA3mVM0rHx/8F+rWxWfvbK/+MLy571cZkt77+2le/ne/tdyNVJEINuH
         +BxGxR7x97udHXoSsNkebytIjRbiInCb/2VQvR4vWR+PD6NF2/AIWyB3WbTGfKpNZFj0
         9lxg==
X-Gm-Message-State: AO0yUKWOIED27trh22yWSogjB02RTCXGRCIPhPX63zSD7HgPn9M+sK+U
        rYIcrJWr1QSLHc5hP2C2qFN9jw==
X-Google-Smtp-Source: AK7set+HAv5fmjg10kPMR7nSiF8/ZvozyEcaeqRI+z3ppiDYu2deL0rbHyTQZTm/HTLfpWTrq1mZ2A==
X-Received: by 2002:a05:600c:3b11:b0:3e5:4fb9:ea60 with SMTP id m17-20020a05600c3b1100b003e54fb9ea60mr13743367wms.9.1678285763151;
        Wed, 08 Mar 2023 06:29:23 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id e15-20020a5d594f000000b002c56046a3b5sm15411660wri.53.2023.03.08.06.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 06:29:22 -0800 (PST)
Message-ID: <6d5fa55a-c9cc-c1a3-3f60-33a99c8b91bc@linaro.org>
Date:   Wed, 8 Mar 2023 14:29:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/4] serial: qcom-geni: fix console shutdown hang
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230307164405.14218-1-johan+linaro@kernel.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230307164405.14218-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/03/2023 16:44, Johan Hovold wrote:
> This series fixes some of the fallout after a recent series adding
> support for DMA transfers to the Qualcomm geni serial driver.
> 
> Most importantly it fixes a hang during reboot when using a serial
> console and the getty is stopped during reboot.
> 
> Doug just posted an equivalent fix here:
> 
> 	https://lore.kernel.org/lkml/20230307073155.1.Iaab0159b8d268060a0e131ebb27125af4750ef99@changeid
> 
> but the commit message only mentions the regression with respect to
> kgdb, which is not as widely used serial consoles generally, so I
> figured I'd post my version for completeness.
> 
> Either version of that fix should address the immediate regression, but
> fixing the underlying problems which have been there since the driver
> was first merged is going to be a bit more involved.
> 
> The rest of the series fixes a few bugs in the new DMA support that I
> found while investigating the console regression.
> 
> Johan
> 
> 
> Johan Hovold (4):
>    serial: qcom-geni: fix console shutdown hang
>    serial: qcom-geni: fix DMA mapping leak on shutdown
>    serial: qcom-geni: fix mapping of empty DMA buffer
>    serial: qcom-geni: drop bogus uart_write_wakeup()
> 


Tested this series on RB5

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>



--srini
>   drivers/tty/serial/qcom_geni_serial.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
