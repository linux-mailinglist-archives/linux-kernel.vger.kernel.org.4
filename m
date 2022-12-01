Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDDD63EAE9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 09:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiLAISK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 03:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLAISI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 03:18:08 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31441BEA4;
        Thu,  1 Dec 2022 00:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669882684; x=1701418684;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qvgj4UYKFORZ6SYDr8FMpL/JjXjKi/cME0VH74Zx2ss=;
  b=KJEeddr/wf6lTdxpVVyg4gCQ/K2H0awwqUyJD1HJV3xmUiInOqmSYag/
   jKsu7cQldpO9X1596l3H7QFFY/DCZp+8rVRow0QjQ3GPOSdHNy5k9oooJ
   ELJMBMH1701ehkjKByvqBPsnOzJFpKblE65oemQRbGfTaSE0u9Z2rgtjx
   ijiwqIwppesPYehzk1ptnsOn9tkvrTAgsQ8OOkTO+/vb0nWk4iHUh8EHh
   7L6egWVBK/9/jDdn7MW3c0ZPMfQUUjYMgTtJduZ5AaeqyRGOiGEN4OWs5
   40vVWGu2mMhTvpvE6zKnuq2UmrCMbujgsB88e7ZvyBbDaJFgfAvAS4p3+
   g==;
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="189504600"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Dec 2022 01:18:02 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 1 Dec 2022 01:17:58 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 1 Dec 2022 01:17:56 -0700
Date:   Thu, 1 Dec 2022 08:17:37 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
CC:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        <linux-riscv@lists.infradead.org>, <ajones@ventanamicro.com>,
        <aou@eecs.berkeley.edu>, <corbet@lwn.net>, <guoren@kernel.org>,
        <heiko@sntech.de>, <paul.walmsley@sifive.com>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v1 3/3] Documentation: riscv: add a section about ISA
 string ordering in /proc/cpuinfo
Message-ID: <Y4hjIWHTuYcf90ja@wendy>
References: <20221130234125.2722364-1-conor@kernel.org>
 <20221130234125.2722364-4-conor@kernel.org>
 <Y4gZ/KZz9rdYj/0r@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y4gZ/KZz9rdYj/0r@debian.me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 10:05:32AM +0700, Bagas Sanjaya wrote:
> On Wed, Nov 30, 2022 at 11:41:26PM +0000, Conor Dooley wrote:
> > +#. Single-letter extensions come first, in "canonical order", so
> > +   "IMAFDQLCBKJTPVH".
> 
> "..., that is ... ."

Hmm, that reads strangely to me. s/that/which/.

> 
> > +#. The first letter following the 'Z' conventionally indicates the most
> > +   closely related alphabetical extension category, IMAFDQLCBKJTPVH.
> > +   If multiple 'Z' extensions are named, they should be ordered first by
> > +   category, then alphabetically within a category.
> > +
> 
> Did you mean "most closely related alphabetical extension category in
> canonical order"?

I am not 100% sure what you are suggesting a replacement of here. I
think I may reword this as:
  For additional standard extensions, the first letter following the 'Z'
  conventionally indicates the most closely related alphabetical
  extension category. If multiple 'Z' extensions are named, they will
  be ordered first by category, in canonical order as listed above, then
  alphabetically within a category.

> > +An example string following the order is:
> > +   rv64imadc_zifoo_zigoo_zafoo_sbar_scar_zxmbaz_xqux_xrux
> > +
>  
> IMO literal code block should be better fit for the example above,
> rather than definition list:

Uh, sure? I'm not sure what impact that has on the output, but I can
switch to a pre-formatted block.

Thanks,
Conor.

