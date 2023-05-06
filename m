Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A50F6F90A1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 10:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjEFIhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 04:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjEFIhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 04:37:19 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C24010B
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 01:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683362238; x=1714898238;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ie2JF7K4hZ3yMGP89aL77tk1Nyd+9sHbkXIRoPRFYqs=;
  b=ZjzMq9yKG6gxxGRoSSrOKyKYQ5L3iMwaCaY6FOaxjJ4zgI0r4QEVGodD
   cIQ0sdLVxNdePM/vFGlOqHF/uos3v9PUaVHDMa4SMXXg3yJJM62Wc1qs6
   43EIhkWSZHDZG9Dl7gVpEhjYK65uEfuNXSwuV0n9AYsvTgUD/19AF87AZ
   INWHqhE/37EH7sCNwKSdC/OhfeGwC3G8ltVaU5NpbaVu6zqJTAvsRDm43
   nAx1R9cpxu95Brow+Fuxhl4Xniik7vrUXbiM64SrUWWQk7pZerhYWtZU+
   8fGO9NOpq9FmyhfhdMX7a/KOxc4u+1CaotS+ZXE+9MYUY+XWnlfZg2cmY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="349396296"
X-IronPort-AV: E=Sophos;i="5.99,254,1677571200"; 
   d="scan'208";a="349396296"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2023 01:37:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="822035661"
X-IronPort-AV: E=Sophos;i="5.99,254,1677571200"; 
   d="scan'208";a="822035661"
Received: from jhaapako-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.37.135])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2023 01:37:17 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 704DD10C8DE; Sat,  6 May 2023 11:37:14 +0300 (+03)
Date:   Sat, 6 May 2023 11:37:14 +0300
From:   kirill.shutemov@linux.intel.com
To:     Nikolay Borisov <nik.borisov@suse.com>
Cc:     dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/tdx: Wrap r11 argument of decompression hypercall
 with hcall_func
Message-ID: <20230506083714.nniw676timel46wt@box>
References: <20230505120332.1429957-1-nik.borisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505120332.1429957-1-nik.borisov@suse.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 03:03:32PM +0300, Nikolay Borisov wrote:
> This just unifies the decompression  tdx-related code with the rest
> of the code which invokes tdx hypercalls. No functional changes.

Maybe s/tdx/TDX/g ?

> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
