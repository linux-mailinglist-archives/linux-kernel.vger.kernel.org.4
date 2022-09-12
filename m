Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CDC5B5BD4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiILODB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiILOCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:02:53 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 154F632AB6;
        Mon, 12 Sep 2022 07:02:45 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oXk1M-0007Yg-01; Mon, 12 Sep 2022 16:02:44 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id B9100C1291; Mon, 12 Sep 2022 15:40:03 +0200 (CEST)
Date:   Mon, 12 Sep 2022 15:40:03 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Aditya Srivastava <yashsri421@gmail.com>,
        linux-mips@vger.kernel.org,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>
Subject: Re: [PATCH] MIPS: ath25: clean up non-kernel-doc comment warning
Message-ID: <20220912134003.GB9232@alpha.franken.de>
References: <20220823025441.30708-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823025441.30708-1-rdunlap@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 07:54:41PM -0700, Randy Dunlap wrote:
> Don't use "/**" kernel-doc notation for comments that are not in
> kernel-doc format.
> 
> Eliminates one warning:
> 
> arch/mips/pci/pci-ar2315.c:6: warning: This comment starts with
>   '/**', but isn't a kernel-doc comment. Refer
>   Documentation/doc-guide/kernel-doc.rst
>     * Both AR2315 and AR2316 chips have PCI interface unit, which supports DMA
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Aditya Srivastava <yashsri421@gmail.com>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: linux-mips@vger.kernel.org
> Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> ---
> Fixes: 3ed7a2a702dc ("MIPS: ath25: add AR2315 PCI host controller driver")
>   but backport is not needed.
> 
>  arch/mips/pci/pci-ar2315.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/arch/mips/pci/pci-ar2315.c
> +++ b/arch/mips/pci/pci-ar2315.c
> @@ -2,7 +2,7 @@
>  /*
>   */
>  
> -/**
> +/*
>   * Both AR2315 and AR2316 chips have PCI interface unit, which supports DMA
>   * and interrupt. PCI interface supports MMIO access method, but does not
>   * seem to support I/O ports.

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
