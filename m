Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DFB74A5F4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 23:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjGFVgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 17:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGFVgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 17:36:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6571CDD;
        Thu,  6 Jul 2023 14:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=6VTQEgefufGygnJ8bChGWaxuJEA6DRUc4kN6fIJ6UPg=; b=CiSHve47NNhLbViFFM/79e7BtG
        Eip/wWw1jIlg+gyBZvYqMtgqK5LcLhwqMOzCVlVXoI7VZnKCGfYNb2u+fh5I/y6LndZE3tUwfg2tF
        dQ10slzhPduQuMe2gm6QPSIX2ld2oE757JVwAkyBtNbkF3tY+Ar5RjuqanNO49R6lgd1DZYvdWZOE
        IEtUOD5uJFNSCsqahjOpq0WUkebkO60oB+fsEhMdXh1xQCZxeZ0zjIHJ3LDXk7gyLln+sgyuPuFJU
        FG6kudMD5aU3lykn+3znYK0WWg2579oxqcFMY295ZFHYQCO8AyHpg0KDgglVtQ+fj+QwTL6kZa63u
        U0b14oVQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qHWdy-002kAr-11;
        Thu, 06 Jul 2023 21:36:06 +0000
Message-ID: <62e993a5-0bb4-40dc-6399-f60525300a6c@infradead.org>
Date:   Thu, 6 Jul 2023 14:36:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: linux-next: Tree for Jul 6 (arch/riscv/)
Content-Language: en-US
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Conor Dooley <conor@kernel.org>
References: <mhng-a4ed8be3-1e00-4604-ac93-29d893829988@palmer-ri-x1c9a>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <mhng-a4ed8be3-1e00-4604-ac93-29d893829988@palmer-ri-x1c9a>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/6/23 14:32, Palmer Dabbelt wrote:
> On Thu, 06 Jul 2023 14:27:53 PDT (-0700), rdunlap@infradead.org wrote:
>>
>>
>> On 7/5/23 18:57, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Please do *not* add any v6.6 related stuff to your linux-next included
>>> branches until after v6.5-rc1 has been released.
>>>
>>> Changes since 20230705:
>>>
>>
>> on riscv64:
>>
>> WARNING: modpost: vmlinux: section mismatch in reference: $xrv64i2p1_m2p0_a2p1_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0+0x14 (section: .text.unlikely.set_bit.constprop.0) -> numa_nodes_parsed (section: .init.data)
>>
>>
>> Full randconfig file is attached.
> 
> Thanks, I'm giving it a look.  Do you happen to also have your toolchain version easily availiable?  The mapping symbols are new and we've seen some odd stuff happen, something is likely broken somewhere...

I'm using gcc-13.1.0 from  https://mirrors.edge.kernel.org/pub/tools/crosstool/

-- 
~Randy
