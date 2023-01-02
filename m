Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D4565AEC0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 10:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjABJhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 04:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjABJhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 04:37:45 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A9838B4;
        Mon,  2 Jan 2023 01:37:44 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id u18so37851665eda.9;
        Mon, 02 Jan 2023 01:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XzIKgubKsbYp6CHbNgEC7oTL3o/23K1nX1884mvfwHU=;
        b=G19KnHZkfpxRRK8GEtPuLli3UOIw8JaGumkCm3OfvuuGgyvVoIItwF9UL+YKeEoziV
         tVaLLp6LncTO3aVNx9fajlVFGGY7KPLBg9VJc5aEjDTIbcKpgiC20I7uipBOUNWxxKrm
         7sp0QkboCr+8Ff/nn9QaP4Aj+bjlHzvfmjUG+/BPqrAI85dL9RC7fFT8iT78Y37gCR8G
         4Trio+r7k/Xog96G03l5kDStW939gVOFO6X8zHcaM+ChvSCsr1iwZDqg6bBklfD5R3KL
         TNn7fidXDuMzE2IAC671VcdQmkt2pAoq1Qw5K9XVeS9rMR/iCoCi45F1zjojjcYdLJ0I
         jweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XzIKgubKsbYp6CHbNgEC7oTL3o/23K1nX1884mvfwHU=;
        b=cf3O3hKxmNtt1XVIiwnhY7EDyaK3ZUgi0ihwgHOOEXsrwcuaZc14ZK8AIimftCacVx
         RiPW4jCKJN/mzay1ndUJkC+/udS0xyy+nO32BK0QTy22cEpYXj7JwT/PrvRx/VmSxKXo
         gLml51v/fvd9XkxtsfD3FwaG+d41YQvI6/I5X+X0GzwozqlSCIBoAqGeTTJNrCOy4HCF
         Qko8QjxliqOx5S80iRSWCEtMqn1NiWzgu9BM07UreBjfk8xREV1z5/mlqq0CNDbWPb2N
         X+csXZGmk/bcGfmkOQU1e+cjogOKaECgQAHvZLFayHu7/0ACUiHw6zRMCx7DltqQU5fQ
         7/LQ==
X-Gm-Message-State: AFqh2koanBu6ko70polwwFJTfZjZGdt/bVA95np0bp/KEsO4uRm6Q4KJ
        kX8sX4puA46XcxP9IJ+F600=
X-Google-Smtp-Source: AMrXdXuS1dQR4WrrMJ2ZYnuZUsvK51zUK97T9LdHUD8iN13xlT2i9x/voG32HeRtdP8fLD4ew6NlcQ==
X-Received: by 2002:a05:6402:b3c:b0:47f:ab65:b3ff with SMTP id bo28-20020a0564020b3c00b0047fab65b3ffmr30127650edb.35.1672652262900;
        Mon, 02 Jan 2023 01:37:42 -0800 (PST)
Received: from [192.168.0.104] ([82.77.81.242])
        by smtp.gmail.com with ESMTPSA id bo6-20020a0564020b2600b0048ca2b6c370sm2385835edb.29.2023.01.02.01.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 01:37:42 -0800 (PST)
Message-ID: <28da9e33-57e8-7ac1-7e6c-13c297a945d6@gmail.com>
Date:   Mon, 2 Jan 2023 11:37:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/8] spi: dt-bindings: Introduce spi-cs-setup-ns property
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>, Michael Walle <michael@walle.cc>
Cc:     tudor.ambarus@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        nicolas.ferre@microchip.com, robh+dt@kernel.org
References: <20221117105249.115649-2-tudor.ambarus@microchip.com>
 <20221118141458.954646-1-michael@walle.cc> <Y3elIdM3Xz1H4kKk@sirena.org.uk>
From:   Tudor Ambarus <tudor.ambarus@gmail.com>
In-Reply-To: <Y3elIdM3Xz1H4kKk@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18.11.2022 17:30, Mark Brown wrote:
> On Fri, Nov 18, 2022 at 03:14:58PM +0100, Michael Walle wrote:
>> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
>>> +  spi-cs-setup-ns:
>>> +    description:
>>> +      Delay in nanosecods to be introduced by the controller after CS is
>>> +      asserted.
> 
>> Does this need a type as the spi-cs-setup-ns is apparently just 16bit? At
>> least the driver uses it that way.
> 
>> But IMHO this should just be a normal uint32 value to be consistent with
>> all the other properties. Also the max value with 16bit will be 'just'
>> 65us.
> 
> Making it 32 bit does seem safer.  I've applied the series

Thanks. There are few implications to consider before making this prop a
u32, and I'd like to check them with you.

struct spi_delay will have to be updated to have a u32 value, now it's a
u16. This means that we'll have to update spi_delay_to_ns() to either
return a s64 or to add a u64 *delay parameter to the function so that we
can still handle the conversions from usecs and the error codes in the
SPI_DELAY_UNIT_SCK case. Then all its callers have to be updated to
consider the u64 delay.

I don't know what to say, I'm in between. 65us delays are improbable,
but I'm fine to update this as well. Let me know your preference.

Thanks,
ta
