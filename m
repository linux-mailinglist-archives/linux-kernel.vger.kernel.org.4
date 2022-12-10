Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694C4648C92
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 03:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiLJCol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 21:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiLJCoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 21:44:37 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C156511C1;
        Fri,  9 Dec 2022 18:44:35 -0800 (PST)
Received: from loongson.cn (unknown [112.20.108.31])
        by gateway (Coremail) with SMTP id _____8Dx_+uR8pNjGpcEAA--.10598S3;
        Sat, 10 Dec 2022 10:44:34 +0800 (CST)
Received: from [192.168.100.127] (unknown [112.20.108.31])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx_1eP8pNj9eopAA--.36994S3;
        Sat, 10 Dec 2022 10:44:31 +0800 (CST)
Message-ID: <ec8602fe-2781-dd86-1011-fb901219f7f8@loongson.cn>
Date:   Sat, 10 Dec 2022 10:44:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] docs/zh_CN: fix a typo in howto
To:     Wang Yong <yongw.kernel@gmail.com>, alexs@kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221208083353.160152-1-yongw.kernel@gmail.com>
Content-Language: en-US
From:   Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <20221208083353.160152-1-yongw.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx_1eP8pNj9eopAA--.36994S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7JF4UKFykJrWrtFWrJrW7XFb_yoW8Jr4Upa
        sxKrn7G3W8Jr15uayfGr4xWFW7GF97GrZ7Kr9rtw1rJrn2yws7tFnFyryvgr97XryrGFWU
        uF4F9rn0934IkrDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E
        87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km
        07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
        1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUv
        cSsGvfC2KfnxnUUI43ZEXa7IU88Ma5UUUUU==
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_40,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 12/8/22 16:33, Wang Yong 写道:
> Fix a typo in Chinese translation of howto.rst
>
> Fixes: 40d93e496180 ("docs/zh_CN: update howto.rst to latest version")
> Signed-off-by: Wang Yong <yongw.kernel@gmail.com>
Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>   Documentation/translations/zh_CN/process/howto.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/translations/zh_CN/process/howto.rst b/Documentation/translations/zh_CN/process/howto.rst
> index 888978a62db3..10254751df6a 100644
> --- a/Documentation/translations/zh_CN/process/howto.rst
> +++ b/Documentation/translations/zh_CN/process/howto.rst
> @@ -254,7 +254,7 @@ Linux-next 集成测试树
>           https://git.kernel.org/?p=linux/kernel/git/next/linux-next.git
>   
>   通过这种方式，Linux-next 对下一个合并阶段将进入主线内核的内容给出了一个概要
> -展望。非常欢冒险的测试者运行测试Linux-next。
> +展望。非常欢迎冒险的测试者运行测试Linux-next。
>   
>   多个主要版本的稳定版内核树
>   -----------------------------------

