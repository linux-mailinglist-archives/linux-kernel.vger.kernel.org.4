Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64550605585
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 04:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiJTC0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 22:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbiJTC0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 22:26:38 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1459A18B491;
        Wed, 19 Oct 2022 19:26:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0VScpkGP_1666232788;
Received: from 30.221.97.125(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VScpkGP_1666232788)
          by smtp.aliyun-inc.com;
          Thu, 20 Oct 2022 10:26:29 +0800
Message-ID: <cc713fb3-371f-ffb9-d0d3-6bb4da776398@linux.alibaba.com>
Date:   Thu, 20 Oct 2022 10:26:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH V4 2/2] Documentation: kdump: describe VMCOREINFO export
 for RISCV64
To:     Bagas Sanjaya <bagasdotme@gmail.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        heiko@sntech.de, guoren@kernel.org, mick@ics.forth.gr,
        alexandre.ghiti@canonical.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, corbet@lwn.net, Conor.Dooley@microchip.com,
        k-hagio-ab@nec.com, lijiang@redhat.com
Cc:     kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        crash-utility@redhat.com, heinrich.schuchardt@canonical.com,
        hschauhan@nulltrace.org, yixun.lan@gmail.com
References: <20221019103623.7008-1-xianting.tian@linux.alibaba.com>
 <20221019103623.7008-3-xianting.tian@linux.alibaba.com>
 <26810115-1325-faf2-0f6e-0d7ff164982d@gmail.com>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
In-Reply-To: <26810115-1325-faf2-0f6e-0d7ff164982d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/10/20 上午9:56, Bagas Sanjaya 写道:
> On 10/19/22 17:36, Xianting Tian wrote:
>> The following interrelated definitions and ranges are needed by the kdump
>> crash tool, which are exported by "arch/riscv/kernel/crash_core.c":
>>      VA_BITS,
>>      PAGE_OFFSET,
>>      phys_ram_base,
>>      KERNEL_LINK_ADDR,
>>      MODULES_VADDR ~ MODULES_END,
>>      VMALLOC_START ~ VMALLOC_END,
>>      VMEMMAP_START ~ VMEMMAP_END,
>>
>> Document these RISCV64 exports above.
>>
>> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> Hi Xianting,
>
> Seems like you forgot to keep carrying my Reviewed-by from v3 [1].
> Anyway, here it goes...
>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Sorry, I forgot... :(
>
> Thanks.
>
> [1]: https://lore.kernel.org/linux-doc/20221018081755.6214-3-xianting.tian@linux.alibaba.com/
>
