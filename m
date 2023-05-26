Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E5B712B83
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236487AbjEZRNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237418AbjEZRN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:13:28 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C6310D4;
        Fri, 26 May 2023 10:13:07 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2af30d10d8fso9803421fa.0;
        Fri, 26 May 2023 10:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685121185; x=1687713185;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jIXIP2zWjaYbZBFcIHQqMIYmOFHICRYr7cn3dtDGJTU=;
        b=n4sM3hzT6GGKnEITLtm1o9V82TXZcmN1hewCOWUQF6BAofOLFelMmNYdKGYYrBHpJ9
         OEWH0JmuHqPT9JK/ak327pp/koYwK1autAmEKpHZ1IIuzMaWYS7q4x80K8IaqdEvdg8E
         2pQ1t78P1rhdU9nJulHW//XRHv1PDGDN4GjsiaWnBJLxa6l+vrWXE1G9edNJAsfIUtTo
         UWq21QNwCLgodTlO2I6gt0WsYcPiMUptw3B/At1sjrjjBbyXa5MJ6fv2W1WLwmSeyzIv
         3frbuDNSjVwHlKYW5BpVYKG7Zt5t1XXEk93ObK7GMwUJswqftl8B6nfPr8Xj+EE4FXAf
         wgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685121185; x=1687713185;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jIXIP2zWjaYbZBFcIHQqMIYmOFHICRYr7cn3dtDGJTU=;
        b=OPzPy26Y7zrVn96XcOVlDdJE/dUqBN4KdpLB6kF8oRbVbVAtcmFHdoI/erFTXJZJFP
         TaI8Rq8G3zCbXbiKSnGlvVeab+p6BKb1SAZP2Cqp0P9cWd7JdlBnrW0FdXTuQzZhBDfQ
         kZH39h6/Y5d4+ItJlHKFJKxzCyJKXyVSz4Wlk3JJaitFfHMxhtevP5AbmI+3KLeM6Ih+
         LPzYLsFhwDkxEpZxn42FDvDTuf+fpaeNPoyFC/P8a1aEwU14Xt7Ca3qs6KukDHwKF3/E
         Ks9ZYHlc7213+MuYsa2lpbDl/SvL8e2+jlg3rV7GYMyfEyemIgQ7TSvhjZFwWrTTFTJt
         3PNA==
X-Gm-Message-State: AC+VfDyM6wHFlWtQUUoEFXJ2GYLA4Wtv4LkplKwIb4KPEQzODMDnFUzv
        7zchYMQ2dH3jLphHkxLiZ2s=
X-Google-Smtp-Source: ACHHUZ56M27lYSfafVDVv+8NEF4IosaIspdd/GcRS3lW/hVsbLDfoiz0n+98aspbTHOG8skXRJY5hw==
X-Received: by 2002:a2e:8614:0:b0:2a7:a5f7:9651 with SMTP id a20-20020a2e8614000000b002a7a5f79651mr988300lji.23.1685121185135;
        Fri, 26 May 2023 10:13:05 -0700 (PDT)
Received: from [192.168.1.126] (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id c22-20020a2e9496000000b002a7853b9339sm814026ljh.119.2023.05.26.10.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 10:13:04 -0700 (PDT)
Message-ID: <aa1b7590-1105-b1f0-c0bd-784e8369913f@gmail.com>
Date:   Fri, 26 May 2023 20:13:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 7/7] iio: accel: Add support for Kionix/ROHM KX132-1211
 accelerometer
Content-Language: en-US, en-GB
To:     Mehdi Djait <mehdi.djait.k@gmail.com>, jic23@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1685111274.git.mehdi.djait.k@gmail.com>
 <d776c1dd5beef6ef812a4f7e4958eb6cb0f5e58e.1685111274.git.mehdi.djait.k@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <d776c1dd5beef6ef812a4f7e4958eb6cb0f5e58e.1685111274.git.mehdi.djait.k@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/23 17:30, Mehdi Djait wrote:
> Kionix KX132-1211 is a tri-axis 16-bit accelerometer that can support
> ranges from ±2G to ±16G, digital output through I²C/SPI.
> Add support for basic accelerometer features such as reading acceleration
> via IIO using raw reads, triggered buffer (data-ready), or the WMI IRQ.
> 
> Datasheet: https://kionixfs.azureedge.net/en/document/KX132-1211-Technical-Reference-Manual-Rev-5.0.pdf
> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>

Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

