Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497F66CB87A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 09:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjC1HqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 03:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbjC1HqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:46:19 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B1304492;
        Tue, 28 Mar 2023 00:46:18 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1ph41q-0003r6-00; Tue, 28 Mar 2023 09:46:02 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 2C9BFC1C6A; Tue, 28 Mar 2023 09:45:11 +0200 (CEST)
Date:   Tue, 28 Mar 2023 09:45:11 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        Rob Herring <robh+dt@kernel.org>, m.szyprowski@samsung.com,
        Robin Murphy <robin.murphy@arm.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 0/4] Use dma_default_coherent for devicetree default
 coherency
Message-ID: <20230328074511.GA6188@alpha.franken.de>
References: <20230321110813.26808-1-jiaxun.yang@flygoat.com>
 <20230323072944.GA18524@lst.de>
 <60D7FE31-D708-4495-949F-3F64DDC11377@flygoat.com>
 <20230323213930.GA7730@lst.de>
 <CB41D3AF-20F6-42F3-9168-C0D6E716431A@flygoat.com>
 <20230328011812.GA21977@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328011812.GA21977@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.7 required=5.0 tests=RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 03:18:12AM +0200, Christoph Hellwig wrote:
> On Fri, Mar 24, 2023 at 09:17:38AM +0000, Jiaxun Yang wrote:
> > > 
> > > Is patch a 6.3 candidate or should all of it go into 6.4?
> > 
> > Please leave it for 6.4, as corresponding MIPS arch part will be a part of 6.4.
> 
> Ok.  I'll really need review from the MIPS and drivers/of/ maintainers,
> through.

I don't see any MIPS changes in the series besides the ifdef CONFIG_MIPS
part in patch 1, which gets removed again in patch 4 (chance to drop
that completely ?).

I've merged the corresponding MIPS patches into mips-next last week.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
