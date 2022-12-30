Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDAFA6596F8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 10:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234705AbiL3Jxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 04:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiL3Jxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 04:53:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2BF13CC9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 01:53:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8211BB81BA1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 09:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7190C433D2;
        Fri, 30 Dec 2022 09:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1672394008;
        bh=6BbcwURsfoWE5CeUSO8rRzJWcG0Hs1462MOsJYy+oRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ob8wWcDI7hrQJumfWyQegOXOi6RLaicuUCduy/Rfr5KtBke0ayC6nlDRKQq/8wKK0
         xGMwLl7K02mAfc9gtlblN2N2iymbO5YJ2qL0ggvj4t9kImnfcqCTWWxeFuxeDcIpDa
         NwnAD6ejkVLiSGS1tEn5Te+9UsDDKL1/2zTPsprs=
Date:   Fri, 30 Dec 2022 10:53:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     nickel@altlinux.org
Cc:     linux-kernel@vger.kernel.org, Oleg Obidin <obidinog@basealt.ru>
Subject: Re: [PATCH] Revert "ASoC: soc-pcm: Don't zero TDM masks in
 __soc_pcm_open()"
Message-ID: <Y661FSRlfUFeXB26@kroah.com>
References: <20221230093454.468857-1-nickel@altlinux.org>
 <20221230093454.468857-2-nickel@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221230093454.468857-2-nickel@altlinux.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 12:30:53PM +0300, nickel@altlinux.org wrote:
> From: Nikolai Kostrigin <nickel@altlinux.org>
> 
> This reverts commit c34db0d6b88b1da95e7ab3353e674f4f574cccee.
> 
> Sudden sound disappearance was reported for some laptops, e.g.
> Acer Swift 3 SF314-59-78UR 11th Gen Intel(R) Core(TM) i7-1165G7 @ 2.80GHz
> 
> lspci
> 0000:00:1f.3 Multimedia audio controller: Intel Corporation Tiger Lake-LP Smart Sound Technology Audio Controller (rev 20)
>         Subsystem: Acer Incorporated [ALI] Device 148c
>         Flags: bus master, fast devsel, latency 32, IRQ 197, IOMMU group 12
>         Memory at 601f270000 (64-bit, non-prefetchable) [size=16K]
>         Memory at 601f000000 (64-bit, non-prefetchable) [size=1M]
>         Capabilities: [50] Power Management version 3
>         Capabilities: [80] Vendor Specific Information: Len=14 <?>
>         Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Kernel driver in use: sof-audio-pci
> 
> Bisection revealed the commit being reverted.
> 
> Reported-by: Oleg Obidin <obidinog@basealt.ru>
> Link: https://bugzilla.altlinux.org/44690
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216861
> Signed-off-by: Nikolai Kostrigin <nickel@altlinux.org>
> ---
>  sound/soc/soc-pcm.c | 5 +++++
>  1 file changed, 5 insertions(+)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
