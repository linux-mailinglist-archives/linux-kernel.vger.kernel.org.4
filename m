Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28176609185
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 08:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiJWGwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 02:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJWGwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 02:52:09 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A37F76964;
        Sat, 22 Oct 2022 23:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666507929; x=1698043929;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ABkS0NhAjDi8ntSJ5iUziEw9CbuP9xXeeAUlShM0158=;
  b=d7l7K8XglqPq/42axHqWjQTjxt7CswOp0iEM4uKMDSTJztDvpoIG8HQ8
   fphV8P1gSJtaJRcFTB0nl4/J8/sx9vU7Q55Ow1+AGRf6H5jkGaQnupKlA
   eS6HNSUFMoXcd1thIRHbPStRr1TE79YcpnLtdp7HAi9RxBDXhXrVr+l0W
   pHUCqFWLFzSwo5c2LXGwKkvCW1o0IxBGK5m9idBOjISJtBWTno0CwVazN
   YxO4QIV+BCmirOf7PLJm5Y0m952Ttsu8LdXBS2Ru05A1PgeZl9UFaqKB+
   o21brek933AGAuEwzAkCd7InisodSkWm2MkiinRY+pSF9JLFGeCYqvnUU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="308332040"
X-IronPort-AV: E=Sophos;i="5.95,206,1661842800"; 
   d="scan'208";a="308332040"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 23:52:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="699804517"
X-IronPort-AV: E=Sophos;i="5.95,206,1661842800"; 
   d="scan'208";a="699804517"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 22 Oct 2022 23:52:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id C01F4107; Sun, 23 Oct 2022 09:52:28 +0300 (EEST)
Date:   Sun, 23 Oct 2022 09:52:28 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: remove redundant assignment to variable len
Message-ID: <Y1TkrCZJVkQgXcAY@black.fi.intel.com>
References: <20221019225709.1506515-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019225709.1506515-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 11:57:09PM +0100, Colin Ian King wrote:
> The variable len is assigned a value that is never read. It is re-assigned
> a new value in the following do-while loop and never referenced after
> the loop. The assignment is redundant and can be removed.
> 
> Cleans up clang scan build warning:
> drivers/thunderbolt/xdomain.c:344:2: warning: Value stored to 'len' is
> never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied to thunderbolt.git/next, thanks!
