Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC7B6F84EC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 16:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbjEEOin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 10:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjEEOil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 10:38:41 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0CF1991;
        Fri,  5 May 2023 07:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683297520; x=1714833520;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PUgpExWS/DnhiAjBBBKEofIsIASJDAnwJ4/ps5m0Kg0=;
  b=hVHIo+Hrg3Gl6QpD2unDfzAMjQIoMFYUm/Ed2d3zPBxboywY2aIh2FRx
   8/IGfgwTjRi/pfVU3lLOpgalZTijocaSjSbhzUOO2ljZU81b0FHzg05Bj
   j+5XGSz3MaB4MlWOMCe636OcShwfhZNl2TxNSDTyZT4PQj1ZMRMX04lNx
   j7iKcGe4T8xHMgiBrs5NLPT0to0nN87l2F/RkwL/gS6CrqmtwomB+7WIx
   b4gGFf3Hw6bYqzptnb34jYb1j837pqT+lcijSXiIcu2HV/2lGZ5rPR5UK
   nwL6nbWYDPPYEIp2W5xJB3af5nYyxaGTd0aJUzEXw0Nmk5+7G5z2AZceD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="349256428"
X-IronPort-AV: E=Sophos;i="5.99,252,1677571200"; 
   d="scan'208";a="349256428"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 07:38:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="1027518594"
X-IronPort-AV: E=Sophos;i="5.99,252,1677571200"; 
   d="scan'208";a="1027518594"
Received: from annguyen-mobl2.amr.corp.intel.com (HELO [10.209.140.100]) ([10.209.140.100])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 07:38:39 -0700
Message-ID: <a7e4998b-23b0-0018-57e7-7f6faa12e6db@intel.com>
Date:   Fri, 5 May 2023 07:38:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [tip:master 4/4] htmldocs: Warning: arch/x86/Kconfig references a
 file that doesn't exist: Documentation/x86/shstk.rst
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Ingo Molnar <mingo@kernel.org>
References: <202305050705.5V1x1V3i-lkp@intel.com>
 <aa2efa2f-70ea-09b4-f21b-8e69f18fad1e@infradead.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <aa2efa2f-70ea-09b4-f21b-8e69f18fad1e@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/23 17:17, Randy Dunlap wrote:
> which has been moved to Documentation/arch/x86/shstk.rst.

There's currently a pull request for this x86/shstk branch in Linus's
inbox.  If he pulls it, we'll send along a fix on top.  If not, we'll
fix it up before the next merge window.  No biggie.
