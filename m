Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AE669E883
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 20:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBUTqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 14:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjBUTqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 14:46:16 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE800303CC;
        Tue, 21 Feb 2023 11:46:14 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FB291FB;
        Tue, 21 Feb 2023 11:46:57 -0800 (PST)
Received: from [10.57.13.181] (unknown [10.57.13.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0276D3F587;
        Tue, 21 Feb 2023 11:46:12 -0800 (PST)
Message-ID: <ed2d7750-786d-82a1-5e79-1f216a682b20@arm.com>
Date:   Tue, 21 Feb 2023 19:46:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 0/7] MIPS DMA coherence fixes
Content-Language: en-GB
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        Rob Herring <robh+dt@kernel.org>, m.szyprowski@samsung.com
References: <20230221124613.2859-1-jiaxun.yang@flygoat.com>
 <20230221175423.GA15247@lst.de>
 <A8AC22A0-E883-4D9B-A629-5A3721B976C5@flygoat.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <A8AC22A0-E883-4D9B-A629-5A3721B976C5@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-21 18:15, Jiaxun Yang wrote:
> 
> 
>> 2023年2月21日 17:54，Christoph Hellwig <hch@lst.de> 写道：
>>
>> Can you explain the motivation here?  Also why riscv patches are at
>> the end of a mips fіxes series?
> 
> Ah sorry for any confusion.
> 
> So the main purpose of this patch is to fix MIPS’s broken per-device coherency.
> To be more precise, we want to be able to control the default coherency for all devices probed from
> devicetree in early boot code.

Including the patch which actually does that would be helpful. As it is, 
patches 4-7 here just appear to be moving an option around for no 
practical effect.

Robin.

> To achieve that I decided to reuse dma_default_coherent to set default coherency for devicetree.
> And all later patches are severing for this purpose.
> 
> Thanks
> - Jiaxun
