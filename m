Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC30864D1AF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 22:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiLNVWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 16:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiLNVWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 16:22:05 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E154F36D4F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 13:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671052922; x=1702588922;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SMK0U8yjK3Zsbnx3d/e9+h2/Iho4ZzxAqy4FitCdUrs=;
  b=AADgxRk/6TsFNA8TJK6pnudnGtguVsRXu+yOWq/R71NlPpyW8927RkoS
   5wP9XhoY/MbIW2C02+9r9Ux88R9lM63tn+NYWs7V5AXt+QhLvjNeb/Yiu
   EPEbBZzirJoJmlH2L4ihQ49DuFMlDtLF/oOjXggmGWhfY+jxndyXlKiMD
   Pr+OWuVVSQHG5Z2CJu6XfccqoBqau2T8r+TWyx2X72W8TCZVoKHwKKlUd
   DNvAd0h5KiswkttNms+3xBl12RWfu0LV58h2WZNe19RfcygDKoFggPUwp
   Dnw4LYGHPJHp8hB3XpGm4brO7SPxXZAH0r28EGQOG9dOFPYnXknOjBH75
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="316152844"
X-IronPort-AV: E=Sophos;i="5.96,245,1665471600"; 
   d="scan'208";a="316152844"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 13:22:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="737831635"
X-IronPort-AV: E=Sophos;i="5.96,245,1665471600"; 
   d="scan'208";a="737831635"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Dec 2022 13:22:02 -0800
Date:   Wed, 14 Dec 2022 13:30:15 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86: lib: Separate instruction decoder MMIO type from
 MMIO trace
Message-ID: <20221214213015.GA16072@ranerica-svr.sc.intel.com>
References: <Y5oy0vwZQAwzkDkr@zx2c4.com>
 <20221214203454.337299-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214203454.337299-1-Jason@zx2c4.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 01:34:54PM -0700, Jason A. Donenfeld wrote:
> Both mmiotrace.h and insn-eval.h define various MMIO_ enum constants.
> Rename the insn ones to have a INSN_ prefix, so that the headers can be
> used from the same source file.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

FWIW: Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
