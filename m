Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABA86BFFCF
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 08:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjCSHn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 03:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjCSHnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 03:43:25 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200E3D310;
        Sun, 19 Mar 2023 00:43:23 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id br6so11335213lfb.11;
        Sun, 19 Mar 2023 00:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679211801;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cKQ9+zcD3Rd7aVdMbVeCBBy2eV3CcuTrbfVLskPdsiE=;
        b=LnwViOWZZCmOFXVAdg5YGVNaqBFXolm5RTZjWFoKnLyHP2idFJckmyVe5dWdSbd/iM
         GMRwaKcx7ecPglXRRhJmbwouNWm+TVBZxtKb/Ycnc5iqAmT2gWXw5tM4ix6CSeVCIxM4
         yup+gc86VcPNBlN2AuJcVwIsv5G4OPKVUppU6kVregD8bLLmnnrA2ZlY1gNuq7z4ANvd
         ZlD5h/wm2vWBd7B7SEEpc3rGfdPZEEL+SEVZXCHZhKczoMGVhRk8PJspzjt6Hb4kLCNV
         hwJc0jMjC5SWPSCNQy0csg0L5ig4e2H4drSlsjODIBFT43roY/FpSzC0GdNfNbYiTGnL
         /Sxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679211801;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cKQ9+zcD3Rd7aVdMbVeCBBy2eV3CcuTrbfVLskPdsiE=;
        b=DmpZVXSLt60sUBXAuYozKTIdxCIxBPcl2otasYZUbpFK2zODNTXzKFUrC+0nvMN+Lz
         HIcnT6zp14AGwLdkWAN3SDJwSrnVwzVrClO3VMbitj8aBkGI6h083JtX383g9a16K6d6
         IZesD7ahv+WCQ1t52XIcAQQn2zQht7t9ou1LTdwFKpHdQ5+iGuj1q1vwd0v5WZbjZ9zK
         CZBCD91KVAXjqvEX2SZnDz8juEqafi0Csd/fPs/tGWeDm3tOFvR2Jr57+y/21u34QhDb
         DJVrC8Vb402UNSalqOKqhHWhKZgh+nfZ6P3DomXAXynYnu65gPk78t31Nd+TxMh2kAeI
         9N/w==
X-Gm-Message-State: AO0yUKVEN5Xk56huIcAibflVW5cE9nUT03fd/VIoDLTu/Ouh6/hF4KEz
        9SoR3VLm2bQkbxuOxdfSDVY=
X-Google-Smtp-Source: AK7set+WSobBy+NrqDWma4ZIFQ6X+UnNKimVP+lN+1EpV2lSV8AM18xuijBloop2Ijhue3oxTC4sWA==
X-Received: by 2002:a05:6512:910:b0:4dd:af76:d3c with SMTP id e16-20020a056512091000b004ddaf760d3cmr5351856lft.48.1679211801120;
        Sun, 19 Mar 2023 00:43:21 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id y26-20020ac255ba000000b004e9b307d2c8sm271097lfg.238.2023.03.19.00.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 00:43:20 -0700 (PDT)
Message-ID: <00babd12-0ab7-de2a-857b-a58a0948b85c@gmail.com>
Date:   Sun, 19 Mar 2023 09:43:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     Mehdi Djait <mehdi.djait.k@gmail.com>, jic23@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1679009443.git.mehdi.djait.k@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH 0/3] iio: accel: Add support for Kionix/ROHM KX132
 accelerometer
In-Reply-To: <cover.1679009443.git.mehdi.djait.k@gmail.com>
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

Hi Mehdi,

Things have been piling up for me during last two weeks... I will do 
proper review during next week.

On 3/17/23 01:48, Mehdi Djait wrote:
> KX132 accelerometer is a sensor which:
> 	- supports G-ranges of (+/-) 2, 4, 8, and 16G
> 	- can be connected to I2C or SPI
> 	- has internal HW FIFO buffer
> 	- supports various ODRs (output data rates)
> 
> The KX132 accelerometer is very similair to the KX022A.
> One key difference is number of bits to report the number of data bytes that
> have been stored in the sample buffer: 8 bits for KX022A vs 10 bits for KX132.

The KX022A has 16bits of data in HiRes mode. This is the default for 
kx022a driver.

> A complete list of differences is listed in [1]
> 
> 
> [1] https://kionixfs.azureedge.net/en/document/AN112-Transitioning-to-KX132-1211-Accelerometer.pdf1

This document is somewhat misleading. It does not contain KX022A but the 
older KX022. Kionix has the somewhat confusing habit of having very 
similar names for models with - occasionally significant - differences. 
(My own opinion).

I the "Technical referene manual" is more interesting document than the 
data-sheet:

https://kionixfs.azureedge.net/en/document/KX132-1211-Technical-Reference-Manual-Rev-5.0.pdf

I have heard that there have been a few very different versions of KX132 
as well. Not sure if they have "leaked" out to public though. In any 
case, for the kx132 it might be safest to use the full model name - 
especially in the DT compatibles.

Finally, AFAIK the key "thing" in KX132 is the "ADP" (Advanced Data 
Path) feature which allows filtering the data "in sensor". 
Unfortunately, I am not really familiar with this feature. Do you think 
this is something that might get configured only once at start-up 
depending on the purpose of the board? If yes, this might be something 
that will end-up having properties in device-tree. If yes, then it might 
be a good idea to have own binding doc for KX132. Currently it seems Ok 
to have them in the same binding doc though.

Anyways, I'll have proper look at this series during the next week - 
Thanks for the contribution! Much appreciated!

Yours,
	-- Matti

> Mehdi Djait (3):
>    dt-bindings: iio: Add KX132 accelerometer
>    iio: accel: kionix-kx022a: Add chip_info structure
>    iio: accel: Add support for Kionix/ROHM KX132 accelerometer
> 
>   .../bindings/iio/accel/kionix,kx022a.yaml     |  13 +-
>   drivers/iio/accel/kionix-kx022a-i2c.c         |  21 +-
>   drivers/iio/accel/kionix-kx022a-spi.c         |  24 +-
>   drivers/iio/accel/kionix-kx022a.c             | 413 +++++++++++-------
>   drivers/iio/accel/kionix-kx022a.h             | 181 +++++++-
>   5 files changed, 464 insertions(+), 188 deletions(-)
> 

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

