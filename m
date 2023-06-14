Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A5573078B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbjFNSn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbjFNSnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:43:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFD3212B
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686768192; x=1718304192;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8BZWivFgrNDBQ4NBD9/UgphMadDCQU4QXbeHYdRwhkc=;
  b=OB1EbLJZ+81YzHmAJ/1tvd+P2YIQJpzZSKfFfmk/M4ayfo6UNdHQ/yia
   IqzuolqjFuhL+w4k+9xCyXuuCCPRhQe9/BziGZPI2tUid3+WQjMVdmb68
   YGo7Ho0tubzJwUh+PpC2lqtg0O/zbsJJy1EMnMySyuGZVf9Eki1YmZch6
   vj5Z0PukaFbZpu1ZT99LjZNEoO9AdNrp/1IQtY3nkOgxgwfh2eywupTQd
   Ndou7/MDfqeMrpn5o6V5/xyjqJApc7oxJN7GNThY3xSePmdC38gUBNKrT
   OlqXO0yUGLckMDIod1kpDcaCVEflfEOct8hVIVaV0gS3xWJW2D+IwCC75
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="338337625"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="338337625"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 11:42:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="712164261"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="712164261"
Received: from pompl-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.62.32])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 11:42:18 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 44FE9109F66; Wed, 14 Jun 2023 21:42:15 +0300 (+03)
Date:   Wed, 14 Jun 2023 21:42:15 +0300
From:   "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/mm: Remove unused current_untag_mask()
Message-ID: <20230614184215.otffkpay2pjhr6n6@box.shutemov.name>
References: <20230614174148.5439-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614174148.5439-1-bp@alien8.de>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 07:41:48PM +0200, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> e0bddc19ba95 ("x86/mm: Reduce untagged_addr() overhead for systems without LAM")
> 
> removed its only usage site so drop it.
> 
> Move the tlbstate_untag_mask up in the header and drop the ugly
> ifdeffery as the unused declaration should be properly discarded.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
