Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875D560211D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiJRCZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiJRCZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:25:16 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776C55E325
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666059913; x=1697595913;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=275Um1ze1pSzyhmea9p1sEcLfYTF1wmpUx1T88m5Zo4=;
  b=OAhzhddsdekJLNZzUqRpMiC42PjXVL354rrLhmC19NdeUUPILghLjXcC
   nAtsaeoa1a8j1jPAoL2pUXcVNQjkOWwmT420RNCHqUcv8WqlNC6ck2Gad
   cX1j6Mmlc5ovHcXTn9WGI2uDukFX+nudL1fGMWFWLk0v0Ki9Hn8YomvER
   /YPW+ysVWOw0WTi+MkZ3E0elEdjfFQmFMwzj4aAp61/tf66VkpTpHlRCn
   vQacLs2fcfhCceFAbMI/00Lxfp0tBfWzF+tfsMTHGU1pcH+C5UyYsu+wO
   iaq6j3M2jD6hOj1Jgd+RnVU81uvWBws4ZD4diqi5Qyqi/3yF2rW3KwT35
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="305960060"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="305960060"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 19:25:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="753854275"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="753854275"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga004.jf.intel.com with ESMTP; 17 Oct 2022 19:25:12 -0700
Date:   Mon, 17 Oct 2022 19:31:58 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, len.brown@intel.com,
        linux-kernel@vger.kernel.org, mgorman@suse.de,
        peterz@infradead.org, rafael.j.wysocki@intel.com,
        ravi.v.shankar@intel.com, ricardo.neri@intel.com,
        rostedt@goodmis.org, srinivas.pandruvada@linux.intel.com,
        tim.c.chen@linux.intel.com, vincent.guittot@linaro.org,
        vschneid@redhat.com, x86@kernel.org
Subject: Re: Trying to apply patch set
Message-ID: <20221018023158.GA23064@ranerica-svr.sc.intel.com>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20221011191221.3254760-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011191221.3254760-1-carlos.bilbao@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 02:12:21PM -0500, Carlos Bilbao wrote:
> Could you please tell me on top of what tree does this apply? It would be
> great if you could provide a link to a patched repository, given the
> depedencies on other patch sets.

Hi Carlos,

These patches apply on top of v6.0. Also, you need to apply these patches
first:

https://lore.kernel.org/lkml/20220825225529.26465-1-ricardo.neri-calderon@linux.intel.com/

I will push these patches to a repo to make it convenient.

Thanks and BR,
Ricardo
