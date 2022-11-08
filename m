Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC176211E7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 14:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbiKHNDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 08:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbiKHNDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 08:03:18 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50BB758033;
        Tue,  8 Nov 2022 05:03:04 -0800 (PST)
Received: from loongson.cn (unknown [223.106.24.7])
        by gateway (Coremail) with SMTP id _____8AxStiHU2pjflEFAA--.15477S3;
        Tue, 08 Nov 2022 21:03:03 +0800 (CST)
Received: from [192.168.100.127] (unknown [223.106.24.7])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxj+CFU2pjxvkOAA--.41338S3;
        Tue, 08 Nov 2022 21:03:02 +0800 (CST)
Message-ID: <ec33b88e-7149-e15a-53cb-e7fd669dfc50@loongson.cn>
Date:   Tue, 8 Nov 2022 21:03:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] docs/zh_CN: Add userspace-api/futex2 Chinese translation
Content-Language: en-US
To:     Wu XiangCheng <wu.xiangcheng@linux.dev>, Rui Li <me@lirui.org>
Cc:     Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221105041741.288094-1-me@lirui.org>
 <Y2ZmJ6bFeLi+xF+a@bobwxc.mipc>
From:   Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <Y2ZmJ6bFeLi+xF+a@bobwxc.mipc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxj+CFU2pjxvkOAA--.41338S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvdXoWrAF48AF17KF4rXFW3Cw1fCrg_yoWxGFg_G3
        y0yFy09w4UJFyxGay3Aa1fGF93uF45CFn8WF1UJr9xX392ywsrJrnrXan3tF15AFsrZry5
        Kw1DZr1ftF12qjkaLaAFLSUrUUUU8b8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY
        W7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
        AFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
        6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7
        xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2kK
        e7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280
        aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
        xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xF
        xVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
        C2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_
        Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
        WUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
        CTnIWIevJa73UjIFyTuYvjxU4AhLUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/5/22 21:33, Wu XiangCheng wrote:
> 2022-11-05 (六) 12:17:41 +0800 Rui Li 曰：
>> Translate the following documents into Chinese:
>>
>> - userspace-api/futex2.rst
>>
>> Signed-off-by: Rui Li <me@lirui.org>
> Reviewed-by: Wu XiangCheng <bobwxc@email.cn>

Reviewed-by: Yanteng Si <siyanteng@loongson.cn>


Thanks,

Yanteng

>
> Thanks,
>
>> ---
>>   .../zh_CN/userspace-api/futex2.rst            | 80 +++++++++++++++++++
>>   .../zh_CN/userspace-api/index.rst             |  2 +-
>>   2 files changed, 81 insertions(+), 1 deletion(-)
>>   create mode 100644 Documentation/translations/zh_CN/userspace-api/futex2.rst
>>

