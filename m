Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E7F7290A3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237793AbjFIHNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjFIHNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:13:22 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E98DF271D;
        Fri,  9 Jun 2023 00:13:19 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8DxSuoO0YJkZPIAAA--.2912S3;
        Fri, 09 Jun 2023 15:13:18 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxKeUO0YJkIRYKAA--.30952S3;
        Fri, 09 Jun 2023 15:13:18 +0800 (CST)
Subject: Re: [PATCH v12 2/2] spi: loongson: add bus driver for the loongson
 spi controller
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230608072819.25930-1-zhuyinbo@loongson.cn>
 <20230608072819.25930-3-zhuyinbo@loongson.cn>
 <CAHp75VfrPX=VsXMry0Dg_Y4zgt59S=uY=rxCZzv8fBvr_w+i-g@mail.gmail.com>
 <CAHp75VfUg6wq1xSpGsQFQpYbK+tkA3NJBCjBMte6sB7fQBBvrw@mail.gmail.com>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <dc360396-de35-0eb7-3073-75deeb2d762c@loongson.cn>
Date:   Fri, 9 Jun 2023 15:13:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfUg6wq1xSpGsQFQpYbK+tkA3NJBCjBMte6sB7fQBBvrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxKeUO0YJkIRYKAA--.30952S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/8 下午6:18, Andy Shevchenko 写道:
> On Thu, Jun 8, 2023 at 1:15 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Thu, Jun 8, 2023 at 10:28 AM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:
>>> +       ret = readb_poll_timeout(loongson_spi->base + LOONGSON_SPI_SPSR_REG, loongson_spi->spsr,
>>> +                       (loongson_spi->spsr & 0x1) != LOONGSON_SPI_SPSR_RFEMPTY, 1, MSEC_PER_SEC);
>>
>>                         (loongson_spi->spsr &
>> LOONGSON_SPI_SPSR_RFEMPTY) != LOONGSON_SPI_SPSR_RFEMPTY,
>>                         1, MSEC_PER_SEC);
> 
> Actually the last should be USEC_PER_MSEC, as the parameter is in microseconds.


okay, I got it.

Thanks
> 

