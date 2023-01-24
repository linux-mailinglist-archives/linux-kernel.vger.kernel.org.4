Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC063679F32
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbjAXQw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbjAXQw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:52:56 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA471816C;
        Tue, 24 Jan 2023 08:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674579174; x=1706115174;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s/RHGMIcoxzzNsrcXZyjKZdnfum0rKE9/ZvCm/s8sZs=;
  b=Hy3kWrS8hm7sL6byl/RmHJ7uHpnr9syEncwEJjzQyptfF9aVqctd9TSu
   icY49HPCbMmpUt66YE6dbsd43O6QvaNvrrE1/UgGY+F3Y/SMNjfwkkNfy
   Vbk8xoHKhc2xsblMEohn+Ie/LoqqSuoSsXO016mS61zfOEdVq09NmXmpI
   jqM5b+zaje6J9/X/70vIdVnb35mZ+jAUmqRYVBgNHNnM6E10kdYMoPuVw
   c7j9DFQa76ytpymnlxOjVONQAtDUW37eFXqcBw9XqbOF+Oel7hJ4TS3Z9
   DFlRrEjQx3W67/hsKUQcgYlPZsFnj+eI3n/Pvp24Lda9N5/1i90XuLS6Y
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="309914407"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="309914407"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 08:52:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="662191334"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="662191334"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga002.jf.intel.com with ESMTP; 24 Jan 2023 08:52:51 -0800
Date:   Wed, 25 Jan 2023 00:42:19 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>, greg@kroah.com
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Greg KH <greg@kroah.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: manual merge of the fpga tree with the tty tree
Message-ID: <Y9AKa/MU2EJPgQXS@yilunxu-OptiPlex-7050>
References: <20230123124502.725e8700@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123124502.725e8700@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-23 at 12:45:02 +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the fpga tree got conflicts in:
> 
>   drivers/fpga/dfl.c
>   drivers/fpga/dfl.h
> 
> between commit:
> 
>   4747ab89b4a6 ("fpga: dfl: add basic support for DFHv1")
> 
> from the tty tree and commits:
> 
>   3afe90d5b7a4 ("fpga: dfl: kernel-doc corrections")
>   e5541aae450e ("fpga: dfl: more kernel-doc corrections")
> 
> from the fpga tree.


Hi Greg:

I could re-apply the 2 FPGA patches based on the following series on
tty-next tree:

46879f71061a ("Documentation: fpga: dfl: Add documentation for DFHv1")
0926d8d52d42 ("fpga: dfl: Add DFHv1 Register Definitions")
4747ab89b4a6 ("fpga: dfl: add basic support for DFHv1")
e34a79d0b320 ("tty: serial: 8250: add DFL bus driver for Altera 16550")

Then there will be no conflict for my pull request.

Thanks,
Yilun

> 
> I fixed it up (overlapping fixes, I used the former version) and can
> carry the fix as necessary. This is now fixed as far as linux-next is
> concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell


