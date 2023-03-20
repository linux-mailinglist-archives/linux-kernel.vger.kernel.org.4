Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264A06C2419
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCTVuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCTVuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:50:35 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D70C28852;
        Mon, 20 Mar 2023 14:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679349034; x=1710885034;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LeAa6DuhRYRCQma2nsqwLazbP8SFz0u7Pm23olEi4bk=;
  b=VTGv69ck+rYQlrNEo92h3S78EfYhYK3yljtdWO9D90PYf7TnBnjs8jip
   90cD0OhuCRPZ5YFygM7ADc54NCyqQEitryyRsmHHygk+Jy8rx31j7f327
   E5z6NpBMHNCzNGypo/zu6Qz0hO2hrORIpjQOWRM9BbSstp9gjWEghNlg4
   3YORwDIiCerbhU2coN00zTUwgz4eRIHJD478Wp0jb7KTq+XqyGVSsB77b
   zMwCZgxLQVn9e51YV+hnEM61MS+fmij0N3P4NTR0VP2V0Q1xwn8WGSKNc
   6escV54l1U0MZYZuvfBsk34diQUgU0x6Bvj0QqpQRv3cB+CHZnQTvFmm6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="403660032"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="403660032"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 14:50:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="745566166"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="745566166"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 14:50:32 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 68BE212160F;
        Mon, 20 Mar 2023 23:50:29 +0200 (EET)
Date:   Mon, 20 Mar 2023 23:50:29 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the v4l-dvb-next tree
Message-ID: <ZBjVJeynfimHknol@kekkonen.localdomain>
References: <20230321082344.6250cfc6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321082344.6250cfc6@canb.auug.org.au>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, Mar 21, 2023 at 08:23:44AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   71937240a472 ("media: ov2685: Select VIDEO_V4L2_SUBDEV_API")
> 
> Fixes tag
> 
>   Fixes: ("media: i2c: ov2685: Add .get_selection() support")
> 
> has these problem(s):
> 
>   - No SHA1 recognised
> 
> Maybe you meant
> 
> Fixes: 859128ab6f0f ("media: i2c: ov2685: Add .get_selection() support")

Yes. So far at least. I'm not sure if the commit id might still change when
it gets to media tree master.

-- 
Kind regards,

Sakari Ailus
