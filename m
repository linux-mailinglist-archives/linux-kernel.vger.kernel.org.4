Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5FA685F30
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 06:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjBAFsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 00:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjBAFsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 00:48:13 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482B42D4A;
        Tue, 31 Jan 2023 21:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675230484; x=1706766484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=criam7cYjtnG6oXtIHe30zPRK01bt1DpgV+tG1/ktUI=;
  b=ZShG3UjAi+S/WP67u4X7Wh46sRFXpGzho/JB4JC6CvYfuLP3mpOQ7oHo
   AbZGfb6Q2FMJNlq0l9dczMut+TLpAzzfgRoPo7bzU30fe1CwVVqdKDZ1C
   JaD3GHdWvRdsiA6DGkHdIugmP9V8mTVxqpE3WvKs+hVUexfdQEPLpowVT
   +hgb+NqPXPj36A53G+6WAW1p338gbShmy/tM16lmibgG2YJuMLAuPMvJE
   5oi++bxMcyjafZh9Go40yAIIjCK17dDv83vnbcig+WNcn7KHZHZml0Nhu
   Df57GIsm6GBUr+yIzSSHSni+APDQKfoVJP3POpqxC9I4P1US2jyjUKK29
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="326710064"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="326710064"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 21:48:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="664761127"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="664761127"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 31 Jan 2023 21:48:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 95468E1; Wed,  1 Feb 2023 07:48:39 +0200 (EET)
Date:   Wed, 1 Feb 2023 07:48:39 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mauro Lima <mauro.lima@eclypsium.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: intel: Fix device private data and PR_NUM for
 BXT
Message-ID: <Y9n9NyV4x7G2cS/J@black.fi.intel.com>
References: <20230201050455.505135-1-mauro.lima@eclypsium.com>
 <20230201050455.505135-2-mauro.lima@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230201050455.505135-2-mauro.lima@eclypsium.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

Please call it "Broxton".

On Wed, Feb 01, 2023 at 02:04:54AM -0300, Mauro Lima wrote:
> Some private data fields have to change from bxt_info to cnl_info.
> Here is the list of Device IDs with the respective documentation taken for
> validation:
>     0xa0a4 - Intel® 500 Series Chipset Family On-Package Platform Controller Hub
>     0x02a4 - Intel® 400 Series Chipset Family On-Package PCH
>     0x06a4 - Intel® 400 Series Chipset Family Platform Controller Hub
>     0x34a4 - Intel® 495 Chipset Family On-Package
>     0xa3a4 - Intel® B460 and H410 Chipset
> 
> According to documentation BXT has five PR registers.

Here too, "Broxton".

> Signed-off-by: Mauro Lima <mauro.lima@eclypsium.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
