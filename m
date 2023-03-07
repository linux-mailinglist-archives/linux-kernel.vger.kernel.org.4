Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCF96AD509
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 03:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjCGCwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 21:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjCGCwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 21:52:20 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 350C457D35;
        Mon,  6 Mar 2023 18:52:19 -0800 (PST)
Received: from loongson.cn (unknown [112.20.109.241])
        by gateway (Coremail) with SMTP id _____8AxlF3ipgZkNS0JAA--.11610S3;
        Tue, 07 Mar 2023 10:52:18 +0800 (CST)
Received: from [192.168.100.131] (unknown [112.20.109.241])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxTL7fpgZkoXlNAA--.4078S3;
        Tue, 07 Mar 2023 10:52:16 +0800 (CST)
Message-ID: <06ec3f93-87c6-9b54-734c-b0d9d1419e2b@loongson.cn>
Date:   Tue, 7 Mar 2023 10:52:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] specification sched-capacity.rst
Content-Language: en-US
To:     shao_xuehua <1154690388@qq.com>, corbet@lwn.net,
        leyfoon.tan@starfivetech.com, robh@kernel.org,
        conor.dooley@microchip.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_8D5CE32548E3EDDA267776815C3B982C3E08@qq.com>
From:   Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <tencent_8D5CE32548E3EDDA267776815C3B982C3E08@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxTL7fpgZkoXlNAA--.4078S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvdXoWrZFy7GF17CFy5Xr1xury8Zrb_yoWDCFcEgw
        n5GFnYyayDJF1kZ3W3JF1DJrsYvanFk3Wkuw1vq34kJayUuFZ7CryDKa4YkFW3XrZF9F98
        X3sYqFyrJrnFkjkaLaAFLSUrUUUU0b8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUO
        e7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
        AFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
        6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIx
        AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jz5lbUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 3/6/23 16:43, shao_xuehua 写道:
> Signed-off-by: shao_xuehua <1154690388@qq.com>
> ---

Hi xuehua,


Missing commit message. See 
<Documentation/translations/zh_CN/process/submitting-patches.rst>


Thanks,

Yanteng

>   Documentation/scheduler/sched-capacity.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/scheduler/sched-capacity.rst b/Documentation/scheduler/sched-capacity.rst
> index 8e2b8538bc2b..6bbdcb10ffa9 100644
> --- a/Documentation/scheduler/sched-capacity.rst
> +++ b/Documentation/scheduler/sched-capacity.rst
> @@ -420,7 +420,7 @@ to a CPU with more capacity than its current one.
>   
>   RT task wakeup CPU selection searches for a CPU that satisfies::
>   
> -  task_uclamp_min(p) <= capacity(task_cpu(cpu))
> +  task_uclamp_min(p) <= capacity(task_cpu(p))
>   
>   while still following the usual priority constraints. If none of the candidate
>   CPUs can satisfy this capacity criterion, then strict priority based scheduling

