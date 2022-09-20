Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961345BDD2C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiITG3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiITG3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:29:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C20B84E;
        Mon, 19 Sep 2022 23:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663655378; x=1695191378;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8n3877gQYlPKXInE5qx6m7J9WFLruUZo33OceC1bcYU=;
  b=JfB3JWQtRgTcyR9qnwdTE4kHmJ3B2jwfm9h1cP4m0v+E1dSre5n8lQ6R
   SyRRljQjAUPv9nUeeuBHF/OBxfVJgeZHTVg5xHoRQLSBibWYoiKuqdjQv
   GF//C+8buMQpIHtjmW8r0txgwl06pBTXmjisgmyjYFhpy6BlIqFu2Y8GZ
   DeeD4HmpEVd/zEfc2xnP9SuIZlknNCKMFdx0rjutCf5Udjiiz33I3tenl
   p/hIRrHz3iUA6s91nRXXuJGjFmmbWYeojKK2FBqmA3CHZpLWVy0Dy7ZBP
   Y1IeYl2AgLwCDl+CZeTdLQCkFyEmrnIAGTqsnObrlv6kxaOmkXcgjaaNp
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="181086171"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Sep 2022 23:29:35 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 19 Sep 2022 23:29:34 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Mon, 19 Sep 2022 23:29:34 -0700
Date:   Tue, 20 Sep 2022 07:29:13 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the risc-v-mc tree with Linus' tree
Message-ID: <YylduXa12mtakuHT@wendy>
References: <20220920051905.500a52ce@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220920051905.500a52ce@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 05:19:05AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the risc-v-mc tree got a conflict in:
> 
>   arch/riscv/boot/dts/microchip/mpfs.dtsi
> 
> between commits:
> 
>   3f67e6997603 ("riscv: dts: microchip: mpfs: fix incorrect pcie child node name")
>   e4009c5fa77b ("riscv: dts: microchip: mpfs: remove pci axi address translation property")
> 
> from Linus' tree and commit:
> 
>   2ad0883d86c8 ("riscv: dts: microchip: move the mpfs' pci node to -fabric.dtsi")
> 
> from the risc-v-mc tree.
> 
> I fixed it up (the latter change seems to include the other 2) and can

Yup, I test merged it after applying and that was my resolution too.
Thanks Stephen.

> carry the fix as necessary. This is now fixed as far as linux-next is
> concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell


