Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787B46C7271
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 22:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjCWVkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 17:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjCWVj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 17:39:57 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE631DBBC;
        Thu, 23 Mar 2023 14:39:34 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A822B68B05; Thu, 23 Mar 2023 22:39:30 +0100 (CET)
Date:   Thu, 23 Mar 2023 22:39:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        Rob Herring <robh+dt@kernel.org>, m.szyprowski@samsung.com,
        Robin Murphy <robin.murphy@arm.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 0/4] Use dma_default_coherent for devicetree default
 coherency
Message-ID: <20230323213930.GA7730@lst.de>
References: <20230321110813.26808-1-jiaxun.yang@flygoat.com> <20230323072944.GA18524@lst.de> <60D7FE31-D708-4495-949F-3F64DDC11377@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60D7FE31-D708-4495-949F-3F64DDC11377@flygoat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 09:07:31PM +0000, Jiaxun Yang wrote:
> 
> 
> > 2023年3月23日 07:29，Christoph Hellwig <hch@lst.de> 写道：
> > 
> > The series looks fine to me.  How should we merge it?
> 
> Perhaps go through dma-mapping tree?

Is patch a 6.3 candidate or should all of it go into 6.4?
