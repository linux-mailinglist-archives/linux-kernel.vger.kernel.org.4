Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211315F82EB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 06:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiJHELa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 00:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiJHEL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 00:11:28 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE71D89AFA;
        Fri,  7 Oct 2022 21:11:26 -0700 (PDT)
Received: from [192.168.100.127] (unknown [223.106.24.89])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxYOJa+EBjTCsoAA--.17025S3;
        Sat, 08 Oct 2022 12:11:21 +0800 (CST)
Message-ID: <6afa9f74-8c92-4246-17e7-c40bdd622639@loongson.cn>
Date:   Sat, 8 Oct 2022 12:11:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/4] docs/zh_CN: Rewrite the zh_CN/index.rst
Content-Language: en-US
To:     Wu XiangCheng <wu.xiangcheng@linux.dev>,
        Alex Shi <alexs@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, chenhuacai@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1664945550.git.bobwxc@email.cn>
From:   Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <cover.1664945550.git.bobwxc@email.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxYOJa+EBjTCsoAA--.17025S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kry8Xr1fKFykKw4rWw15Arb_yoW8JF4fpF
        9akr97K3ZYyw15uw4xW3yUGF18WF4xWa98t340qw1FqF1kZr4rArZrtryIgayjqFWSva43
        XF4fKFyDWr1UCrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvFb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l
        c2xSY4AK67AK6r45MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
        AVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvj
        xUxf-PUUUUU
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/5/22 13:13, Wu XiangCheng wrote:
> Follow Jonathan's steps[1], rewrite the entry point of kernel's Chinese
> translation documentation.
>
> Thanks,
>
> [1]: https://lore.kernel.org/linux-doc/20220927160559.97154-1-corbet@lwn.net/T
>
> Wu XiangCheng (4):
>    docs/zh_CN: promote the title of zh_CN/process/index.rst
>    docs/zh_CN: add zh_CN/arch.rst
>    docs/zh_CN: Rewrite the Chinsese translation front page
>    docs/zh_CN: add a man-pages link to zh_CN/index.rst

When I apply your patch set, Git says:


Applying: docs/zh_CN: promote the title of zh_CN/process/index.rst
Applying: docs/zh_CN: add zh_CN/arch.rst
.git/rebase-apply/patch:41: new blank line at EOF.
+
warning: 1 line adds whitespace errors.
Applying: docs/zh_CN: Rewrite the Chinsese translation front page
Applying: docs/zh_CN: add a man-pages link to zh_CN/index.rst


Thanks,

Yanteng

>
>   Documentation/translations/zh_CN/arch.rst     |  30 ++++
>   Documentation/translations/zh_CN/index.rst    | 169 ++++++------------
>   .../translations/zh_CN/process/index.rst      |   1 +
>   3 files changed, 83 insertions(+), 117 deletions(-)
>   create mode 100644 Documentation/translations/zh_CN/arch.rst
>
>
> base-commit: 05fff6ba04eef8b88bb94734b66731bef3d8d34b

