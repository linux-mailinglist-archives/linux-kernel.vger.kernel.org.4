Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2FC69E864
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 20:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjBUTfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 14:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjBUTfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 14:35:16 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E887B1632D;
        Tue, 21 Feb 2023 11:35:11 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D5931650;
        Tue, 21 Feb 2023 11:35:54 -0800 (PST)
Received: from [10.57.13.181] (unknown [10.57.13.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA0C13F703;
        Tue, 21 Feb 2023 11:35:09 -0800 (PST)
Message-ID: <54f204eb-79b5-5c1c-fffb-696939644d8c@arm.com>
Date:   Tue, 21 Feb 2023 19:35:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 4/7] dma-mapping: Always provide dma_default_coherent
Content-Language: en-GB
To:     Christoph Hellwig <hch@lst.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, tsbogend@alpha.franken.de,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        robh+dt@kernel.org, m.szyprowski@samsung.com
References: <20230221124613.2859-1-jiaxun.yang@flygoat.com>
 <20230221124613.2859-5-jiaxun.yang@flygoat.com>
 <20230221175813.GC15247@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230221175813.GC15247@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-21 17:58, Christoph Hellwig wrote:
> On Tue, Feb 21, 2023 at 12:46:10PM +0000, Jiaxun Yang wrote:
>> dma_default_coherent can be useful for determine default coherency
>> even on arches without noncoherent support.
> 
> How?

Indeed, "default" is conceptually meaningless when there is no possible 
alternative :/

Robin.
