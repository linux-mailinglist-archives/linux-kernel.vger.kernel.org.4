Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C9B7466EC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 03:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjGDBix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 21:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjGDBiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 21:38:51 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E33EDE4E;
        Mon,  3 Jul 2023 18:38:48 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8AxhMQneKNkpWMFAA--.9010S3;
        Tue, 04 Jul 2023 09:38:47 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxfSMeeKNkUJMaAA--.33054S3;
        Tue, 04 Jul 2023 09:38:45 +0800 (CST)
Subject: Re: [PATCH v4 2/2] soc: loongson2_pm: add power management support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liu Yun <liuyun@loongson.cn>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230620090811.721-1-zhuyinbo@loongson.cn>
 <20230620090811.721-3-zhuyinbo@loongson.cn>
 <bd9661f1-b77d-2ce9-0de2-f559576bf55a@loongson.cn>
 <5f501f0f-2362-4079-d833-6883b674e588@linaro.org>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <ea9e6648-668a-202b-6d4f-b9c06db32c3a@loongson.cn>
Date:   Tue, 4 Jul 2023 09:38:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <5f501f0f-2362-4079-d833-6883b674e588@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxfSMeeKNkUJMaAA--.33054S3
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



在 2023/7/3 下午9:47, Krzysztof Kozlowski 写道:
> On 03/07/2023 03:30, zhuyinbo wrote:
>>
>> Friendly ping ?
>>
> 
> Please avoid pings during merge window. Not much can happen with the
> patchset anyway. Resend or ping afterwards.
> 


okay, I got it.

Thanks

