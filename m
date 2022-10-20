Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCC9605F71
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJTLy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJTLy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:54:26 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949C912A356;
        Thu, 20 Oct 2022 04:54:18 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id b18so25977786ljr.13;
        Thu, 20 Oct 2022 04:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5JGPiF/4jkoD0aBNRCvwydXVeVeGYneVf/IKbljyENQ=;
        b=ZjbQByTE2QtMBGesKwYrvQvu1WW0ijiW+cjdm4n7kNdoF6VW1nF78m74dVBe8KSFt8
         /5tTjakEQ9fBWBNyvn2s6xMonLcHkYnRF8ATZDb+SXrqWHYBY60wMf8XGTpQ/rm9UDRY
         lgmR531GjfPPkjMQvlUS3aaIM5Yt3sdk0fd5rVwKj8tlekuM71eON4t/oF1Xzh6pYNJ6
         0lEV14Y/+OOAV8w24BIll7j9VW0jqKXQA6tj2XErZJ88ncLewrsvmeKHqPOdW4WTxBFg
         /R7K4lOWdNVXJRF4NDFFKQhbiqLZGdaw7EbEsqU+fprMkqFsnR6QYGoA5jdVJi4zn3zN
         CWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5JGPiF/4jkoD0aBNRCvwydXVeVeGYneVf/IKbljyENQ=;
        b=n6FZGuuZgebXLJ5UL8Wfan7uyYXQ68r1OOF3WE1PQTLv6Eq814TpL6TVzuzTaM+/Qy
         zrkHHF27VkhR43tvCN5DbpYg7kQzaXCvTBUvAy8qmSLHI2Bp8moeVfWxw9y98ogyOsvP
         LV0fwbCya2T2E/vziRfspyknRJBmi5pGVV5h4XelDU+ZqbIPFv5aYm8GgW3wep0w9Erb
         8TpE+Gjs8mBuF4pjdLQojzeFArIS2Ir6YkIvp/hvdEpLe0O3YMkhelV5bk/2rdmDDC7d
         NWWpHH3kS+tIwzuWUNxd/jrQMQIHTjdED6MRFJsDdRCc7S5expA+M3WVObrVJDtuQkBQ
         iAxg==
X-Gm-Message-State: ACrzQf111sbOz9ff+0VJSuac1UtDANdb6U8Q6Fk9BhCA7Rm7e0DQUq6j
        auqHr3tE7fGUUKE1dHN3RCk=
X-Google-Smtp-Source: AMsMyM46UPSKHOo0se4flSNdEG/fBMvboDvcvuT+IK9c0Sh4oIh3mWrr92RC8p63+wNLiC6JYFEUUw==
X-Received: by 2002:a2e:2418:0:b0:26d:d930:e3cf with SMTP id k24-20020a2e2418000000b0026dd930e3cfmr5172130ljk.232.1666266856924;
        Thu, 20 Oct 2022 04:54:16 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::4? (dc75zzyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::4])
        by smtp.gmail.com with ESMTPSA id f5-20020a2e9e85000000b0026dfdcbccdasm2878012ljk.14.2022.10.20.04.54.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 04:54:16 -0700 (PDT)
Message-ID: <7d8660c4-2f4c-b91e-4e1e-b2dee5cc058f@gmail.com>
Date:   Thu, 20 Oct 2022 14:54:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 0/3] iio: Support ROHM/Kionix kx022a
Content-Language: en-US
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1666263249.git.mazziesaccount@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <cover.1666263249.git.mazziesaccount@gmail.com>
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

On 10/20/22 14:35, Matti Vaittinen wrote:
> Add initial support for ROHM/Kionix kx022a accelerometer
> 
> About the HW:
> KX022A accelerometer is a sensor which:
> 	- supports G-ranges of (+/-) 2, 4, 8, and 16G
> 	- can be connected to I2C or SPI
> 	- has internal HW FIFO buffer
> 	- supports various ODRs (output data rates)
> 	- support detecting special events like double tap or motion
> 	- can be configured to wake-up system when events are detected.
> 
> About the series:
> 
> This series adds support for only getting the accelerometer data and
> configuring the G-range / ODR via IIO. Motion detection or double-tap
> detection are not supported by the series. The other quite important but
> still missing piece is the runtime PM. Nevertheless, the driver should be
> usable and brings the basic support for getting accelerometer data.
> 
// snip

> base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
> prerequisite-patch-id: f692b7ef9ce0a0b016fb5ac1c5733e562baa4ae2
> prerequisite-patch-id: cc2e849e2b3fe553fe955f21a4b995681e04383f
> prerequisite-patch-id: f136637f7a8fe92dc4f60b908e2e7aa24aac3f43

// Snip.

Sorry folks! I don't know what happened with my format-patch :( I 
Should've noted this before sending. My apologies.

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

