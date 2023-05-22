Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C881F70BF31
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 15:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbjEVNIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 09:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbjEVNIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 09:08:10 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5162F1AD;
        Mon, 22 May 2023 06:07:49 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8AxNPAkaWtklPIKAA--.18687S3;
        Mon, 22 May 2023 21:07:48 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxDbMjaWtk+BtvAA--.55849S3;
        Mon, 22 May 2023 21:07:47 +0800 (CST)
Subject: Re: [PATCH v11 0/2] spi: loongson: add bus driver for the loongson
 spi
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230522071030.5193-1-zhuyinbo@loongson.cn>
 <3c15d22f-4f94-4cc5-96a8-f565e58c66b9@sirena.org.uk>
 <4dfa5245-d330-f432-e81e-163053687d42@loongson.cn>
 <a4afd330-6ffd-432e-a868-f8a19fddb47d@sirena.org.uk>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <1e8c3e92-4043-11f2-e7a7-0bf4273c65d8@loongson.cn>
Date:   Mon, 22 May 2023 21:07:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <a4afd330-6ffd-432e-a868-f8a19fddb47d@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxDbMjaWtk+BtvAA--.55849S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvdXoW7Jr1kKFWfuw1kXFy5Jr4DCFg_yoWDtrbEkF
        W0kFyxC34Uta18Aa1xGF4FvrW3tF40qw18CrWvqw47Gw15XF4DG3yDJ3s7u3Z5AayfKF1D
        u393J39FgwnxJjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY
        07CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2
        IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84AC
        jcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84
        ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF
        6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14
        v26r1Y6r17McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48I
        cVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l42xK82IY6x8Erc
        xFaVAv8VWrMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
        xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWlk3UUUUU=
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/22 下午7:56, Mark Brown 写道:
> On Mon, May 22, 2023 at 07:44:49PM +0800, zhuyinbo wrote:
> 
>> The recently patch was as follows, It seems no issue for patch apply
>> them, Maybe it is the 0/2 patch issue ? this 0/2 patch wasn't a valid
>> patch and it need was skipped.
> 
> What's causing problem is that you patched MAINTAINERS in both patches
> but also used the wrong subject line for the first patch so I was having
> to fix it up by hand every time.

Hi Mark,

I learn about what you said that bindings patch and spi driver change a
same MAINTAINERS file, but It seems not cause apply fail if the patch
series apply in order.  I'm sorry, I don't understand the reason why my
spi series patch apply failed,  then I have a look about your spi ci
tree and that what I need to do is just change the title of [1/2] patch
like this in next version ?  Correcting the title can solve the problem
of patch series apply failure in your tree ? actually, I don't reproduce
that apply faile issue in your current spi tree and for-next branch.


spi: add loongson spi bindings

Thanks
Yinbo

