Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A0A6A6CC8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 14:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjCANDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 08:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjCAND3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 08:03:29 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0EE3E08F;
        Wed,  1 Mar 2023 05:03:21 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4AF6C67373; Wed,  1 Mar 2023 14:03:16 +0100 (CET)
Date:   Wed, 1 Mar 2023 14:03:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, tsbogend@alpha.franken.de,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        robh+dt@kernel.org, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/5] dma-mapping: Provide a fallback
 dma_default_coherent
Message-ID: <20230301130315.GA467@lst.de>
References: <20230223113644.23356-1-jiaxun.yang@flygoat.com> <20230223113644.23356-3-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223113644.23356-3-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 11:36:41AM +0000, Jiaxun Yang wrote:
> dma_default_coherent was decleared unconditionally at kernel/dma/mapping.c
> but only decleared when any of non-coherent options is enabled in dma-map-ops.h.

Overly lone line here.

>  }
>  #else
> +#define dma_default_coherent true
>  static inline bool dev_is_dma_coherent(struct device *dev)

Please keep an empty line before the function declaration.
