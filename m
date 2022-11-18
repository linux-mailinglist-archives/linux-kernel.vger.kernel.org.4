Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CA362FDC4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242696AbiKRTES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243008AbiKRTCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:02:48 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCB554B10;
        Fri, 18 Nov 2022 11:02:36 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id g12so10650823wrs.10;
        Fri, 18 Nov 2022 11:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=E5Ey+SWUGHe54inhYQO4Q9IAek2nNg4LJ02tyTCqBBc=;
        b=muB+SifbTgI90sosGYp1Rdn9323oxvY/zKHPXxKDBsUaWLb+RDwNiQr346MUdyu7lC
         Gucft/tc7JBy/sxc44JyFyG2pL7UhNO5tik1/CaLmaBOOQFGFjDrt0rB71jm5h/WW4VN
         QNg3RKWX0yEJPqu7dLKG9Oz+By3cLCmQAhF8eLI7rFfy2yycAgWBMaPK9DwHZxe3OMnd
         Ij6RcFnNjlBq625Wwun3KE3WP0OiqrZKmC86roZKUid0EjoAuLba4qAFT4oNMBoenwt7
         RAsO4KMWBw0qoEuZZ66LqXSWOJp+pEvUrWX9/krmnj7hktPOkvvrhpqfLLg8YTYrYNQX
         vy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E5Ey+SWUGHe54inhYQO4Q9IAek2nNg4LJ02tyTCqBBc=;
        b=sDSkueVDN3ph5p4ZSCGqrDF7+P/VU6s5HeQV/gjVCACLtOQjrhh8ZgkzNVynSOjzpR
         wv4+iRKrbSWuY2R4RprFk5sKxpI//rPCFfq7B1nSn1vsG894vACQQWqkbHVZBtwXARTZ
         mDMKuL1I9cuyhfwHHkjPXdgcdysc+eRl7LBZr26llyKf5vZEUSFou2ETQKOzgb+nKLTL
         pBSfG++KwtratfWv40a5qojaaghAbbp7okkgSCJFWoNKKc+j4l0aXzrkFlujFMEuN6Ho
         MXIEBvuFjczONl3FXVuznOmSgomYaXvIhlVBB8hOxcja2Wnr17MeIpqcSe+abz3Abw//
         093w==
X-Gm-Message-State: ANoB5plyHq9hUPPSW6mirs+cLb+tf2kKwx1+JHKYkqCkThIH0rRhlrdI
        FfPc28/fYblO2A+ULiYQrYhlBXp7fQtgsDKl
X-Google-Smtp-Source: AA0mqf6w/1xAUqgYy2FX3lJHlg67dGBf2UYoc+mhcExG80QMtV/cbLJw50V7xfWynisTt8PVUp27yg==
X-Received: by 2002:a05:6000:114f:b0:241:c80c:5f54 with SMTP id d15-20020a056000114f00b00241c80c5f54mr476592wrx.15.1668798154591;
        Fri, 18 Nov 2022 11:02:34 -0800 (PST)
Received: from ?IPV6:2a0e:41a:894f:0:6f8e:6bf6:725c:d7d5? ([2a0e:41a:894f:0:6f8e:6bf6:725c:d7d5])
        by smtp.gmail.com with ESMTPSA id u16-20020a05600c19d000b003cf37c5ddc0sm5775361wmq.22.2022.11.18.11.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 11:02:33 -0800 (PST)
Sender: Carlo Caione <carlo.caione@gmail.com>
From:   Carlo Caione <carlo@caione.org>
X-Google-Original-From: Carlo Caione <ccaione@baylibre.com>
Message-ID: <8a3bdd84-2789-1b42-976f-2843320750b6@baylibre.com>
Date:   Fri, 18 Nov 2022 20:02:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/3] drm/tiny: ili9486: Do not assume 8-bit only SPI
 controllers
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        David Airlie <airlied@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20221116-s905x_spi_ili9486-v1-0-630401cb62d5@baylibre.com>
 <20221116-s905x_spi_ili9486-v1-2-630401cb62d5@baylibre.com>
 <Y3YWdeTLfmDh7UyB@sirena.org.uk>
 <cd2d4d1e-f42a-da5b-e498-fbb32f792094@baylibre.com>
 <Y3ZMT4F3+3bjNXKo@sirena.org.uk>
 <e36142ec-6b7f-e667-7d6b-48234318c8cd@baylibre.com>
 <Y3eoYTZRyRJnze1z@sirena.org.uk>
In-Reply-To: <Y3eoYTZRyRJnze1z@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/2022 16:44, Mark Brown wrote:

>> The problem arrives when your controller does support 16-bits, so 
>> your data is not swapped, but you still put the data on the bus 
>> with 8-bit transfers.
> 
> Why would you need to use 8 bit transfers if the controller supports
>  16 bits?

No idea why this driver is forcing 8-bit transfers when the controller
supports 16-bits (this is what this patch is fixing).

My theory is that this driver was written with the Raspberry Pi HATs in
mind and (AFAICT) the RPi has an 8-bit only SPI controller so the driver
author didn't bother with anything different.

--
Carlo Caione

