Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3C2652D21
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 08:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbiLUHDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 02:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiLUHDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 02:03:12 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB2718B1F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 23:03:10 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h16so13940983wrz.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 23:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eg0WhSchjTvqXeKP426L54VYEv3WuT9Mujc7Ng9EqQk=;
        b=B6/+mfC87WaDmrKji/kmap+UCJ13c7ySQtXVy061Q8CaXeYfrtmsV12CRBzMes/Xoj
         8jXqhRpeOSuNvQkSawR9K+F7E6Xl6YHuHXqFc+YaBaSVJJFJYL2h4SuSaxdVOfm7IRmb
         Ws644Udaa1jAlQBbJrVSqOfeBgBk4kItqV8rHKsOD8OSo/Ew/4b2hJgMftYjEAEaVrVV
         wJdNa8BBlGxLxvd/t4M9hZ5ZnqyztTY/6MqPqQMQIZDX6ebaI8dzpXbDujV+5gxOn3oQ
         K3MG2XmHV1Dv7NhQ2HsZ2FWxdc+KYPAftr4D6T0n3cxlmJkw8fRr/OJmErpOl/90UMa0
         qo8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eg0WhSchjTvqXeKP426L54VYEv3WuT9Mujc7Ng9EqQk=;
        b=hC0+m2KN3dIgvgoasUzzeSfCUN4WgLLZjEQCZX0kAjvlWanRMQ5tIQBMx3VXEPmKq0
         k9DdxTb4/VUw+gT3o8gIU57mFcN33vJrxRffdAcuXqHnwwuhv9KIkDessMXp6UZd+EGU
         a7waoN6nbJqAATPv7c5rNmZdE9mYXlkMW0VKXJebI2nzPUOPQH/EUhLduBASbpUchC04
         xhxlS5BFClKtx8YlZsHo+og7wLXpjHAqGbfr4bG22VydiJeqrlhzxVaueE4TjEkl+NKF
         DV7uX2sth9lDUD1R5lEAlwEoO374w8Qzns9FFMascKn9KDUVyhL1GrlIpRNSBdRFJ411
         aBkg==
X-Gm-Message-State: AFqh2kodKwlgQ5FWutt9a6VWnkvLcY9n7acFO9Q4uUk8z2Tv6YJXuDlu
        QY764D+SRdJIvH4phpZbkQ4ssg==
X-Google-Smtp-Source: AMrXdXseUP2FWdrUvMZQlBwGZpeRZYjgxls4v7sX9+wuHvypLn0jbH1WS3VJaOvEpeMDbg4HMV3eRw==
X-Received: by 2002:adf:e103:0:b0:26a:6e7d:5782 with SMTP id t3-20020adfe103000000b0026a6e7d5782mr312026wrz.35.1671606188859;
        Tue, 20 Dec 2022 23:03:08 -0800 (PST)
Received: from [192.168.0.173] ([82.77.81.131])
        by smtp.gmail.com with ESMTPSA id q9-20020a05600000c900b0024228b0b932sm17074639wrx.27.2022.12.20.23.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 23:03:08 -0800 (PST)
Message-ID: <96b4574d-8fe1-7662-5029-fc375f7b9ac9@linaro.org>
Date:   Wed, 21 Dec 2022 09:03:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 1/2] mtd: spi-nor: issi: is25wp256: Init flash based on
 SFDP
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, greentime.hu@sifive.com,
        jude.onyenegecha@sifive.com, william.salmon@sifive.com,
        adnan.chowdhury@sifive.com, ben.dooks@sifive.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220920184808.44876-1-sudip.mukherjee@sifive.com>
 <20221221003009.GA280250@roeck-us.net>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20221221003009.GA280250@roeck-us.net>
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



On 21.12.2022 02:30, Guenter Roeck wrote:
> Hi,

Hi, Guenter,

Thanks for the report.

> 
> On Tue, Sep 20, 2022 at 07:48:07PM +0100, Sudip Mukherjee wrote:
>> The datasheet of is25wp256 says it supports SFDP. Get rid of the static
>> initialization of the flash parameters and init them when parsing SFDP.
>>
>> Testing showed the flash using SPINOR_OP_READ_1_1_4_4B 0x6c,
>> SPINOR_OP_PP_4B 0x12 and SPINOR_OP_BE_4K_4B 0x21 before enabling SFDP.
>> After this patch, it parses the SFDP information and still uses the
>> same opcodes.
>>
>> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
> 
> With this patch in place, qemu emulations with is25wp256 fail to
> instantiate the flash. Specifically, this affects the qemu sifive_u
> emulation. The resulting error message is:
> 
> spi-nor spi0.0: BFPT parsing failed. Please consider using SPI_NOR_SKIP_SFDP when declaring the flash
> spi-nor: probe of spi0.0 failed with error -22
> 
> qemu command line:
> 
> qemu-system-riscv64 -M sifive_u -m 512M \
>       -no-reboot -kernel arch/riscv/boot/Image -snapshot \
>       -drive file=flash.8Vtb7,format=raw,if=mtd -bios default \
>       -append "root=/dev/mtdblock0 mtdparts=spi0.0:- console=ttySIF0,115200 earlycon" \
>       -nographic -monitor none
> 
> Reverting this patch fixes the problem.

I need some more debug info in order to have both flavors of the flash
work correctly. Would you please revert the patch locally and do the
tests from below? Thanks!

ta

---
# dd if=/dev/urandom of=./qspi_test bs=1M count=6
6+0 records in
6+0 records out

# mtd_debug write /dev/mtd4 0 6291456 qspi_test
Copied 6291456 bytes from qspi_test to address 0x00000000 in flash

# mtd_debug erase /dev/mtd4 0 6291456
Erased 6291456 bytes from address 0x00000000 in flash

# mtd_debug read /dev/mtd4 0 6291456 qspi_read
Copied 6291456 bytes from address 0x00000000 in flash to qspi_read

# hexdump qspi_read
0000000 ffff ffff ffff ffff ffff ffff ffff ffff
*

0600000

# mtd_debug write /dev/mtd4 0 6291456 qspi_test
Copied 6291456 bytes from qspi_test to address 0x00000000 in flash

# mtd_debug read /dev/mtd4 0 6291456 qspi_read
Copied 6291456 bytes from address 0x00000000 in flash to qspi_read

# sha1sum qspi_test qspi_read
57f8d4fee65622104e24276e865f662844f12242  qspi_test
57f8d4fee65622104e24276e865f662844f12242  qspi_read

# cat /sys/bus/spi/devices/spi0.0/spi-nor/partname
is25wp256

# cat /sys/bus/spi/devices/spi0.0/spi-nor/jedec_id
9d7019

# cat /sys/bus/spi/devices/spi0.0/spi-nor/manufacturer
issi

# xxd -p /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
53464450060101ff00060110300000ff9d05010380000002ffffffffffff
ffffffffffffffffffffffffffffffffffffe520f9ffffffff0f44eb086b
083b80bbfeffffffffff00ffffff44eb0c200f5210d800ff234ac90082d8
11cecccd68467a757a75f7aed55c4a422cfff030faa9ffffffffffffffff
ffffffffffffffff501950169ff9c0648fefffff

# md5sum /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
ba14818b9ec42713f24d94d66bb90ba0  /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
