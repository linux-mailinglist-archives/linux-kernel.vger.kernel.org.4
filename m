Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B18763090B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 03:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbiKSCDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 21:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbiKSCDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 21:03:09 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95217C7211
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 17:55:31 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8CxLLdtN3hjPcgIAA--.13291S3;
        Sat, 19 Nov 2022 09:54:53 +0800 (CST)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx_eFsN3hjCcAWAA--.59330S3;
        Sat, 19 Nov 2022 09:54:52 +0800 (CST)
Subject: Re: [PATCH] lib/vdso: use "grep -E" instead of "egrep"
To:     Greg KH <gregkh@linuxfoundation.org>
References: <ad42d19d-959c-61b4-8581-02ce0990c23f@arm.com>
 <788b5155-fef5-0e44-721a-f9183e145ae5@loongson.cn>
 <Y3dMgfPXNMm/vaG2@kroah.com>
Cc:     vincenzo.frascino@arm.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, tglx@linutronix.de,
        Andrew Morton <akpm@linux-foundation.org>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <337a9a23-436e-7f58-bfc5-600452779472@loongson.cn>
Date:   Sat, 19 Nov 2022 09:54:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <Y3dMgfPXNMm/vaG2@kroah.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Dx_eFsN3hjCcAWAA--.59330S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvdXoWrtr1DXF1UAr1fKrW3ur1kGrg_yoWxKwc_uw
        4rWFWrC34kXF4jya17tr4Yvws5AFy8AF93XrWxK34xurZxA39Ivan3GFW5u3WDXw1kWFZ5
        AF1Yy3s7ZryIvjkaLaAFLSUrUUUU8b8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY
        J7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
        AFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
        6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7
        xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAaw2AF
        wI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
        14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
        AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E
        14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
        CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
        MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
        4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnI
        WIevJa73UjIFyTuYvjxUc0eHDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc Andrew Morton <akpm@linux-foundation.org>

On 11/18/2022 05:12 PM, Greg KH wrote:
> On Fri, Nov 18, 2022 at 04:44:50PM +0800, Tiezhu Yang wrote:
>> Hi,
>>
>> This patch can not be found in the torvalds/linux.git or
>> next/linux-next.git tree, please take a look, thank you.
>
> That is because no one has applied it to their trees :(
>

Maybe Andrew can pick the following two patches sent by Greg.

[PATCH] lib/vdso: use "grep -E" instead of "egrep"
https://lore.kernel.org/lkml/20220920170633.3133829-1-gregkh@linuxfoundation.org/

[PATCH] scripts: coccicheck: use "grep -E" instead of "egrep"
https://lore.kernel.org/lkml/20220921091341.217365-1-gregkh@linuxfoundation.org/

Thanks,
Tiezhu

