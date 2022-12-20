Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E3F652406
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 16:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbiLTP6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 10:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiLTP61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 10:58:27 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED5B6313
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 07:58:26 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id b3so19301464lfv.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 07:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iok0tfWHvjI2YIYrpMqgnqWPH9Pjk6yIC34HQbrXVj4=;
        b=RHiDD0Q1KfR73AVqO7L8iHjH8Yux5ME2eL7xpgBKCc30RV1Iyh1q1NGTmb1eO/Ic8l
         dPt6OcHhrtmUgFnF+oZkf0TbrTnbHZfo44UdT4s2JKnHg/5q+jm/PU7XcouNLkZQpBoo
         JoH0Td0EJCTrKYu7IOX745vxYJOF82lwVeX/XB1eCo4AGj+vYFpCy2XHcYuyN+rAzLPs
         xB9ZnGEboaqimD8My81UVte474Mxxz3omYXP3GcqfFUanJYXWuZkrhHCg8bf4SxmkV8V
         TcTW97t1DY7v+lXdU4gh0prnpaGteo6IsB2+le6s/tQ6eqnbnp1bCIwHaJD/h9MFKdH4
         YL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iok0tfWHvjI2YIYrpMqgnqWPH9Pjk6yIC34HQbrXVj4=;
        b=j8V+toNHtlkNznIIhh5zsiupMr/ypMR3DEnvubG7WEH7riAheGNaEeZhtHOkOVoQrZ
         kD4qPSQO07HuDGBy0pfV3FAYMhwfMoio3/dAB8DvDTrO1Pk5Oric/qE13/x3xm+U7/J8
         0Z59ToPVe7HX2iN4buxTkOg8d7n0etIi5tfi6On6zeMNWmGWs2/FbFOg+ng6wJt7t8CZ
         8IqAMsGDpmrMw1y+PoovDkEDQ+uk3qQkMGcmKmKF3MWBp6/R+jlXkpgXTkRAILdJcwin
         TWUGzRRP3vt7/p1kcRoKKQ4v9J7nJrI5jgWXqN2IHFtweKuKmgG7uR/cvIiSnxTqPitp
         4G6w==
X-Gm-Message-State: ANoB5pm+UZS4LEwXzAY1rwQb+eCmzbjA0Kpqe9T+LyEUdrV0VQ2FWSYY
        IR034uhi2dtB8eusxIKXZwsNhg==
X-Google-Smtp-Source: AA0mqf7Bcg6J6e7YwYfJL8HhIHW8PORg+AXoOGUHvmnFbL4Yp1Ia/8QU4IGfubKk/IuBXEfxBiANjw==
X-Received: by 2002:a19:c502:0:b0:4b6:edee:586e with SMTP id w2-20020a19c502000000b004b6edee586emr9387032lfe.10.1671551904993;
        Tue, 20 Dec 2022 07:58:24 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v13-20020ac258ed000000b004996fbfd75esm1495078lfo.71.2022.12.20.07.58.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 07:58:24 -0800 (PST)
Message-ID: <93fbb172-2b0a-cfb1-effd-1b6f1245f91f@linaro.org>
Date:   Tue, 20 Dec 2022 16:58:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v6 2/2] misc: nxp-sr1xx: UWB driver support for sr1xx
 series chip
Content-Language: en-US
To:     Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        will@kernel.org, axboe@kernel.dk, robh+dt@kernel.org
Cc:     mb@lightnvm.io, ckeepax@opensource.cirrus.com, arnd@arndb.d,
        mst@redhat.com, javier@javigon.com, mikelley@microsoft.com,
        jasowang@redhat.com, sunilmut@microsoft.com,
        bjorn.andersson@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, ashish.deshpande@nxp.com,
        rvmanjumce@gmail.com, Kwame Adwere <kwame.adwere@nxp.com>
References: <20221220154747.2372597-1-manjunatha.venkatesh@nxp.com>
 <20221220154747.2372597-3-manjunatha.venkatesh@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221220154747.2372597-3-manjunatha.venkatesh@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2022 16:47, Manjunatha Venkatesh wrote:
> Ultra-wideband (UWB) is a short-range wireless communication protocol.
> 
> NXP has SR1XX family of UWB Subsystems (UWBS) devices. SR1XX SOCs
> are FiRa Compliant. SR1XX SOCs are flash less devices and they need
> Firmware Download on every device boot. More details on the SR1XX Family
> can be found at https://www.nxp.com/products/:UWB-TRIMENSION
> 

(...)

> +
> +/**
> + * sr1xx_dev_suspend
> + *
> + * Executed before putting the system into a sleep state
> + *
> + */
> +int sr1xx_dev_suspend(struct device *dev)
> +{
> +	struct sr1xx_dev *sr1xx_dev = dev_get_drvdata(dev);
> +
> +	if (device_may_wakeup(dev))
> +		disable_irq_wake(sr1xx_dev->spi->irq);
> +	return 0;
> +}
> +
> +/**
> + * sr1xx_dev_resume
> + *
> + * Executed after waking the system up from a sleep state
> + *
> + */

Lines of comments or code should not be part of anyone's Key Performance
Indicators (KPI). Don't bring your KPI to Linux. Drop all such useless
comments and adjust your style to Linux coding style.

Best regards,
Krzysztof

