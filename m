Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913C861EBEE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 08:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbiKGH1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 02:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbiKGH0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 02:26:43 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A415FFE7;
        Sun,  6 Nov 2022 23:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1667806002; x=1699342002;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5pWR/2lH42uSW94u2o+L9YjVlm+F/RrGVfPj8XIu9R4=;
  b=dzUpnMpH9g3DFqcCXNs9r57PZzMrVBoo3EA/pvjK5D5LQCyt4Jhm0wgG
   uSfHA9nvg2fTUta0aMSELB6Bz9Bq82buyqEy5/VvURzMd1dYHe4Cs4kG/
   XsCkhsd41iAtP0Yy5ybXQ7/duFf051uwoqVYBD22YB804u0z/Pzdys2Sc
   cfQ6FLcLganPqpZzrqdiU/Y0M3kaAsGQaOw9sZkgNBKWaPNksUCAwqrz2
   DAeJKEr+gR37CJpyfK3bmAyVow+yUzYJ+dUd3x+z3sgY8y5CG+MAonn+F
   U/N1Q5RA9+T4GC+j+Q9lfmbIa60iz98nAztvNq603tki2+D7vuXeoT9Hy
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="185649310"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Nov 2022 00:26:41 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 7 Nov 2022 00:26:40 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Mon, 7 Nov 2022 00:26:39 -0700
Date:   Mon, 7 Nov 2022 07:26:23 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
CC:     Conor Dooley <conor@kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>
Subject: Re: [PATCH] Documentation: riscv: tableize memory layout
Message-ID: <Y2izHzwaYLDCOECc@wendy>
References: <20221106100239.53704-1-bagasdotme@gmail.com>
 <Y2eY+LulWaKm7MHl@spud>
 <aebae1eb-ed56-00a9-101f-c4e5ab0af91a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aebae1eb-ed56-00a9-101f-c4e5ab0af91a@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 09:55:31AM +0700, Bagas Sanjaya wrote:
> On 11/6/22 18:22, Conor Dooley wrote:
> >> +   +------------------+---------+------------------+---------+----------------------------------------------------------+
> >> +   |    Start addr    | Offset  |     End addr     |  Size   | VM area description                                      |
> >> +   +==================+=========+==================+=========+==========================================================+
> >> +   | 0000000000000000 |    0    | 0000003fffffffff | 256 GB  | user-space virtual memory, different per mm              |
> >> +   +------------------+---------+------------------+---------+----------------------------------------------------------+
> >> +   | 0000004000000000 | +256 GB | ffffffbfffffffff | ~16M TB | ... huge, almost 64 bits wide hole of non-canonical      |
> >> +   |                  |         |                  |         | virtual memory addresses up to the -256 GB               |
> >> +   |                  |         |                  |         | starting offset of kernel mappings.                      |
> >> +   +------------------+---------+------------------+---------+----------------------------------------------------------+
> >> +   |                             Kernel-space virtual memory, shared between all processes:                             |
> >> +   +------------------+---------+------------------+---------+----------------------------------------------------------+
> >> +   | ffffffc6fee00000 | -228 GB | ffffffc6feffffff | 2 MB    | fixmap                                                   |
> >> +   +------------------+---------+------------------+---------+----------------------------------------------------------+
> >> +   | ffffffc6ff000000 | -228 GB | ffffffc6ffffffff | 16 MB   | PCI io                                                   |
> >> +   +------------------+---------+------------------+---------+----------------------------------------------------------+
> >                                                         ^
> > Will these numbers remain right-aligned in the formatted doc? They were
> > aligned before in the text form & no longer appear to be.
> > 
> 
> These numbers also become wrapped in their cells.
> 
> However, in order to fix alignment of these, custom CSS is needed, similar
> to one in StackOverflow [1].

Hmm. In that case I'd be inclined to agree with Akira that this should
be left as is.

Thanks,
Conor.

