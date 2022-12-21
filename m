Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD942652D0B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 07:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbiLUGuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 01:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbiLUGuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 01:50:04 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862161F2C4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 22:50:03 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id z10so3398227wrh.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 22:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l3DtQUdn5yG8C3edbDeOK2NMVM1cqCLWe0A5+U54eM4=;
        b=pgqp3sYgI0M2y0TLRjzoFFM/5rxF4gkCBlezPnjShaxGBb39t7uWWapYEzhh3ZuOdB
         DqlaarruN8SdkiwbO3z9OmoCsj07wvdHXWjH9OZmIvUu2VgeZbTw2BZYhgKT1t/T6147
         cjzOjcdrBNMo1G2UIqkGp3o/l92YwMMX+GBT42W07QEn25bV9MNZun2QsSQlObsFYTSc
         kCFKO80yY+LhokCaqch1jmWEP+Ff4PJCThkr0cuvMd5NmdOdlfjOTnXvw/1DPcsBTWJJ
         A7IwVaAnT6RDRfUY1ntnMBplgoIF5Klb6KUCVImaffNSNB2ViJyqVCYJlgshKwtr0QYI
         x1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l3DtQUdn5yG8C3edbDeOK2NMVM1cqCLWe0A5+U54eM4=;
        b=4Kci7kTIzM2DqA4tHw5AhVaMZiAGFqb6Ho4FDQsuJxO6rKLj5L+ZH/1Wn3o4nHRl7r
         z10com7gDqmtC5rfw2kF+mqG2L0OWM8Xm5ldMvwRNt7uzTjYTni1d6TvZHhr99AN7Z0r
         L+JpNLJdNZzrZTrrDITlgY96tgvMp57K5jIihsKAj3olT7FUtyAu6bmXWg2PP47VZBK1
         sXtt5LMQEYJOmxQOBLKPRx9C2cSVMzRupAPOMSqjxowSI07GE1S8Td1km8c8qEbL72lA
         BnJaKXgCdRXXfHPdCDtLqKRlTITaEweZVBnfCXkBhZcRysJnobBgVkcGyDsjQD4GEJWk
         KjBQ==
X-Gm-Message-State: AFqh2kooForQHfbaYmCs9hHtEDHTwwZkaa0g5O27tGLmRUeb4EUcoHP/
        CrbZEglZwsvDBW/OATQabKBA06noa+WZ18jD
X-Google-Smtp-Source: AMrXdXth8YVxu/eVaNR55QfF/dyr7TzuzV6+kGR9hoc4Qpo+Qp8xSopCCpRvF2Wi2pqThcWKuwXA4w==
X-Received: by 2002:adf:e54f:0:b0:242:7fd6:1c82 with SMTP id z15-20020adfe54f000000b002427fd61c82mr278418wrm.16.1671605402105;
        Tue, 20 Dec 2022 22:50:02 -0800 (PST)
Received: from [192.168.0.173] ([82.77.81.131])
        by smtp.gmail.com with ESMTPSA id d11-20020adff84b000000b002425787c5easm14324294wrq.96.2022.12.20.22.50.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 22:50:01 -0800 (PST)
Message-ID: <026225c6-f17f-e9da-b7c0-5d3473a97e89@linaro.org>
Date:   Wed, 21 Dec 2022 08:49:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] [v2] mtd: cfi: allow building spi-intel standalone
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Walle <michael@walle.cc>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221220141352.1486360-1-arnd@kernel.org>
 <cae6328b-5204-a1ab-810d-8fb64e466453@linaro.org>
 <20221220165701.5696df1a@xps-13>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20221220165701.5696df1a@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.12.2022 17:57, Miquel Raynal wrote:
> Hi Tudor,
> 

Hi,

> tudor.ambarus@linaro.org wrote on Tue, 20 Dec 2022 17:44:49 +0200:
> 
>> Hi, Arnd,
>>
>> On 20.12.2022 16:13, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> When MTD or MTD_CFI_GEOMETRY is disabled, the spi-intel driver
>>> fails to build, as it includes the shared CFI header:
>>>
>>> include/linux/mtd/cfi.h:62:2: error: #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work. [-Werror=cpp]
>>>      62 | #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work.
>>>
>>> linux/mtd/spi-nor.h does not actually need to include cfi.h, so
>>> remove the inclusion here to fix the warning. This uncovers a
>>> missing #include in spi-nor/core.c so add that there to
>>> prevent a different build issue.
>>>
>>> Fixes: e23e5a05d1fd ("mtd: spi-nor: intel-spi: Convert to SPI MEM")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>
>> Looks good to me. I'll let the linux-0day bot run over it and apply it
>> once -rc1 is out.
> 
> The issue sometimes produces build errors, shall I send it through a
> fixes PR instead?
> 

Yes, that I was thinking about.

Thanks,
ta
