Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A212D5FB267
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 14:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiJKM1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 08:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJKM1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 08:27:03 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC66D237D9;
        Tue, 11 Oct 2022 05:27:01 -0700 (PDT)
Received: from [192.168.100.127] (unknown [223.106.24.89])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxFeIOYUVjle8qAA--.25299S3;
        Tue, 11 Oct 2022 20:26:55 +0800 (CST)
Message-ID: <ce2705c1-d7d9-e1bf-d6ff-925de9eceff3@loongson.cn>
Date:   Tue, 11 Oct 2022 20:26:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/4] docs/zh_CN: promote the title of
 zh_CN/process/index.rst
To:     Wu XiangCheng <wu.xiangcheng@linux.dev>,
        Alex Shi <alexs@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, chenhuacai@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1665467392.git.bobwxc@email.cn>
 <2741340f3b5f131a32d0f295224edd569aab0d98.1665467392.git.bobwxc@email.cn>
Content-Language: en-US
From:   Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <2741340f3b5f131a32d0f295224edd569aab0d98.1665467392.git.bobwxc@email.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxFeIOYUVjle8qAA--.25299S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZw4rGFW8uFyUWr18Kr1rWFg_yoWfJrX_Zw
        4kXF4vkFWjvr1xXF18Cr4kJr4xAF48u3WDKws0yrZ8J3y3Kr45WFyDX3sYqrWrWFZI9ry5
        Cr1kWryrJFnxJjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbxkYjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkI
        ecxEwVAFwVW5JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_
        Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8
        kb1UUUUUU==
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/11/22 14:00, Wu XiangCheng wrote:
> From: Wu XiangCheng <bobwxc@email.cn>
>
> update to commit 9d0f5cd16744 ("docs: promote the title of
> process/index.rst")
>
> Signed-off-by: Wu XiangCheng <bobwxc@email.cn>
Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>   Documentation/translations/zh_CN/process/index.rst | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/translations/zh_CN/process/index.rst b/Documentation/translations/zh_CN/process/index.rst
> index a683dbea0c83..a1a35f88f4ae 100644
> --- a/Documentation/translations/zh_CN/process/index.rst
> +++ b/Documentation/translations/zh_CN/process/index.rst
> @@ -10,6 +10,7 @@
>   
>   .. _cn_process_index:
>   
> +========================
>   与Linux 内核社区一起工作
>   ========================
>   

