Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C081D6A3EAB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjB0JxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjB0JxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:53:21 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9710D9764;
        Mon, 27 Feb 2023 01:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677491596; x=1709027596;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dwUo3BFORgMJVeDfksL8jP7HkkuWEuVDbhgyCpyAFqs=;
  b=XiETXY2S2vPWGu9yDgaMGervupGgpNAWSnf2uSqMAHhwMJJL+zL/QsN2
   E7PMdb4TlNTzlZY5bCYQLkg3plUcz/9Wm8Z6h0W3T6Gkz/KBlUNhMg5mG
   iGxsJFULGkbNS3ee+lVGpI8OvkAIug+PHTZVCUh8n+Zs0a5iqZFItgFk6
   RhBSWw1Z5cUvjIQDd/EjeTZdl3SI2ZkHpxVUI4cLF25wC6C/ciJpIJRH3
   WVVvjqJuEo7Ne1DGMHjThUSQ644fO09YGnHNm9i0KMg7GycktKHBzTxwc
   dBkJVjchVfVnpXkdIxK8Jpdnp68mCta/TBVx9zhsJRapClhcz6j8iunkU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="336101810"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="336101810"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 01:53:15 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="847756370"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="847756370"
Received: from jrissane-mobl2.ger.corp.intel.com (HELO intel.com) ([10.249.41.42])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 01:53:07 -0800
Date:   Mon, 27 Feb 2023 10:53:03 +0100
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [Intel-gfx] [PATCH v5 1/7] arch: rename all internal names
 __xchg to __arch_xchg
Message-ID: <Y/x9fxS1cFsa1ylP@ashyti-mobl2.lan>
References: <20230118153529.57695-1-andrzej.hajda@intel.com>
 <20230118154450.73842-1-andrzej.hajda@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118154450.73842-1-andrzej.hajda@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrzej,

On Wed, Jan 18, 2023 at 04:44:44PM +0100, Andrzej Hajda wrote:
> __xchg will be used for non-atomic xchg macro.
> 
> Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> [m68k]
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com> [riscv]

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi
