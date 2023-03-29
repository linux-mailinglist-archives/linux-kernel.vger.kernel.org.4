Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693FA6CD7C1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 12:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjC2Kdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 06:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjC2Kde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 06:33:34 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 923FC46B4;
        Wed, 29 Mar 2023 03:32:58 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8Axrtq1EyRkD7gTAA--.18616S3;
        Wed, 29 Mar 2023 18:32:21 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxD7+zEyRkU1MQAA--.47195S3;
        Wed, 29 Mar 2023 18:32:20 +0800 (CST)
Subject: Re: [PATCH v4 1/2] dt-bindings: spi: add loongson spi
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        Mark Brown <broonie@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, zhuyinbo@loongson.cn
References: <20230328112210.23089-1-zhuyinbo@loongson.cn>
 <20230328112210.23089-2-zhuyinbo@loongson.cn>
 <168000761529.3001360.2224316097077012976.robh@kernel.org>
 <4ed4e0b6-63a8-a5b1-fed9-64a6d036459b@loongson.cn>
 <3850df80-d3e9-00a8-df4a-fddd86706373@linaro.org>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <265b1bce-f6b4-7eba-e486-ebf4f3c7d421@loongson.cn>
Date:   Wed, 29 Mar 2023 18:32:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <3850df80-d3e9-00a8-df4a-fddd86706373@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxD7+zEyRkU1MQAA--.47195S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
        BjDU0xBIdaVrnRJUUUPK1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4
        v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY
        67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2js
        IE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE
        52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I
        80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCj
        c4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64
        vIr41l42xK82IY6x8ErcxFaVAv8VWrMxAqzxv262kKe7AKxVWUXVWUAwCF54CYxVCY1x02
        62kKe7AKxVWUAVWUtwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
        jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
        ZFpf9x07j04E_UUUUU=
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/3/29 下午4:05, Krzysztof Kozlowski 写道:
> On 29/03/2023 03:12, zhuyinbo wrote:
>> This patch need depend on
>> https://lore.kernel.org/all/20230323025229.2971-1-zhuyinbo@loongson.cn/
>> then the spi yaml file will build successful. That changelog had record it.
> 
> Thus it cannot be merged now. Do not resend it till dependency hits
> mainline (since you decided not to go with Rob's advice).
> 
> Best regards,
> Krzysztof
> 
okay, I got it.

Thanks.

