Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C58E6C0DB1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjCTJvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjCTJv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:51:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCC81B2C0;
        Mon, 20 Mar 2023 02:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679305888; x=1710841888;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F5B5AEnVmr1t6vsXHndScG3OO7bIHfDCKGwu/Lz5eR0=;
  b=VoG2/PdNs6T8RzR6qvn8G/hVFMUmNw3uS6I3TgpbL0ZHruvcDjdkoZ1G
   aU0p5UBDSyTYzJ86uqfzJ8AVgJWB4iWoyNe/Ez4BrgBlfFmF1yZij73Hd
   wo/OLPgGDjx5sjZBfyi2tBTB5VT85C9sPLs3qvZpYtejotjzEWoD+y3Kb
   HQGk7XHPe8tZ2szFfuo1wtZ1OuRlhKREnBzGNJydU38b7CrKODDarmoLF
   sb5YDgYfElz7m9dJGNCCSq9CgFTTFwKABiYWGbfRoBBiCu/Bqn3Xp0h/H
   tlf9oeDoFvuVcRfD0v+KPXn4HaKnadlCP0dmMvOfFI37nKPSutoG5hdeK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="319019963"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="319019963"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 02:51:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="855231116"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="855231116"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 02:51:25 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 77F64122400;
        Mon, 20 Mar 2023 11:51:22 +0200 (EET)
Date:   Mon, 20 Mar 2023 11:51:22 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH] media: i2c: imx290: fix conditional function defintions
Message-ID: <ZBgsmvZDJmhGGrmU@kekkonen.localdomain>
References: <20230207161316.293923-1-arnd@kernel.org>
 <Y+J+7lsf083k4x80@pendragon.ideasonboard.com>
 <c5383d0e-d33c-d59f-3ee6-4635c1c4d334@leemhuis.info>
 <ZBgoHvg3kxsVoSzg@kekkonen.localdomain>
 <84540c66-166e-067a-e1d9-961234640d2e@leemhuis.info>
 <810afc81-57e3-17ea-c624-34a157602d1f@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <810afc81-57e3-17ea-c624-34a157602d1f@leemhuis.info>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 10:46:45AM +0100, Thorsten Leemhuis wrote:
> Argh, ohh no, it's there. Sorry for the noise. Second time something
> like this happens today. Seems today is not my best day. :-/

No worries!

-- 
Sakari Ailus
