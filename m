Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1126F9FE4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 08:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbjEHG2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 02:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjEHG2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 02:28:47 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581541942D;
        Sun,  7 May 2023 23:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683527324; x=1715063324;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nXdELMbRrnDTUXjbb0lwHIaR5rWE11IP1arr7TjU6fE=;
  b=RnRrY8QKwmaBfVegtbOc6ORZRkSDhmHZoHDY2Ocsca8kbhcl48zCRdOE
   zpg4fzqJrN1T+Xc62Jfl/QvuJmaK51W9boIo2LXRmVwrL+Mg7zrgoW8my
   DIDN2EetF6xzT565TxmdRU4Q+sSnPpXaSdLvy/wx3jAoDt2mAy1uCREA7
   hKZEFNnfrEcgYI6nS5yGiI9NNhoHsdv5+37+ZYKOUrpUJPsLNCtF8EuyS
   pNlEZNHcZbcSnOVvmOE2pq9vdcojqKT52IGqQ9vTW8eKg5iKavpKvY27k
   +AcGp0yBjp0Ue4hEps2Am5G97C5E86io6VDOc3MJtjZA/DmGP38UQJwnN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="329928579"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="329928579"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2023 23:28:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="822562685"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="822562685"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2023 23:28:42 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id ADA691203DA;
        Mon,  8 May 2023 09:28:38 +0300 (EEST)
Date:   Mon, 8 May 2023 09:28:38 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of Linus' tree
Message-ID: <ZFiWlvImCBcMe2F/@kekkonen.localdomain>
References: <20230508144426.608fb8e2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508144426.608fb8e2@canb.auug.org.au>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Mon, May 08, 2023 at 02:44:26PM +1000, Stephen Rothwell wrote:
>   f57fa2959244 ("media: v4l2-subdev: Add new ioctl for client capabilities")

There's a fix for this but it hasn't been merged yet, will be soon.

<URL:https://lore.kernel.org/linux-media/20230418105924.126608-1-tomi.valkeinen@ideasonboard.com/>

-- 
Sakari Ailus
