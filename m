Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC19E72F264
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 04:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241839AbjFNCDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 22:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbjFNCDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 22:03:51 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CB68172A;
        Tue, 13 Jun 2023 19:03:49 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8BxKuoEIIlkb+gEAA--.10445S3;
        Wed, 14 Jun 2023 10:03:48 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxduQDIIlkhwMaAA--.8372S3;
        Wed, 14 Jun 2023 10:03:47 +0800 (CST)
Subject: Re: [PATCH v13 2/2] spi: loongson: add bus driver for the loongson
 spi controller
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230613075834.5219-1-zhuyinbo@loongson.cn>
 <20230613075834.5219-3-zhuyinbo@loongson.cn>
 <CAHp75VdtFjkyBF4K1+MOHAmp0S6RU5Cg3NYD8yGH+8FBBG0Zuw@mail.gmail.com>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <55f236d0-129e-4042-ef03-adc678a0ab3c@loongson.cn>
Date:   Wed, 14 Jun 2023 10:03:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdtFjkyBF4K1+MOHAmp0S6RU5Cg3NYD8yGH+8FBBG0Zuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduQDIIlkhwMaAA--.8372S3
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



在 2023/6/13 下午9:03, Andy Shevchenko 写道:
> On Tue, Jun 13, 2023 at 10:58 AM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:
> 
> ...
> 
>> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> Just a remark for the next contribution. When you have a tag, no need
> to have a Cc for the same person, Git tools automatically add all
> tagged people to the Cc list of email.


okay, I got it.

Thanks,
Yinbo
> 

