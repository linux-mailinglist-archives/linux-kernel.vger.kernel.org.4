Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B3B6DA88D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 07:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjDGFjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 01:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjDGFjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 01:39:07 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA7983D1;
        Thu,  6 Apr 2023 22:39:06 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6EF7967373; Fri,  7 Apr 2023 07:39:02 +0200 (CEST)
Date:   Fri, 7 Apr 2023 07:39:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     iommu@lists.linux.dev, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        tsbogend@alpha.franken.de, mpe@ellerman.id.au,
        paul.walmsley@sifive.com, palmer@dabbelt.com, robh+dt@kernel.org,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Use dma_default_coherent for devicetree default
 coherency
Message-ID: <20230407053902.GA6636@lst.de>
References: <20230401091531.47412-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230401091531.47412-1-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to the dma-mapping tree for 6.4.
