Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7128727A43
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbjFHIo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjFHIo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:44:26 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234B21984;
        Thu,  8 Jun 2023 01:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686213866; x=1717749866;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9WoyChy9T1zjK5uvjDRzAnTP2t/iDW4tpEep/A5SZY8=;
  b=axuG5pFAR3AcVBcoM9MX8x5bKDlCMMAT64fCpA+HkxVNNxRe8FGwk9/o
   NfgI49WIzmNB/8sj0yGqXHewVulVTz6pfLeVA1TKuW8SxCsxy5Cg5ZHli
   +mgu6/qERGIb//s5M+RR8apIZL3qcT7551eCG7ls2iqvK2jqAetW74pKk
   6LRKPj27krWM2aQjFhyrOrL8zVVHUNfUBpFSPjMOnbmr18nNEmyAFbcEf
   KVNiyGsMmoU+oPlwPl11nOvHFO6eeXhfFPgAwrxWtDMvyfnIn6uRt9hHJ
   I5lpplrKnC2ypJ0rrpZOhSHLpvbCpY7zAx5fN1jiBkFyeeCcviHJPWWXF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="420815335"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="420815335"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 01:44:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="854261577"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="854261577"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 01:43:57 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 2478B120C1C;
        Thu,  8 Jun 2023 11:43:55 +0300 (EEST)
Date:   Thu, 8 Jun 2023 08:43:55 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Conor Dooley <conor@kernel.org>, linux-media@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: drop Shawn Tu due to mail bounces
Message-ID: <ZIGUyy2hE6FNfMWS@kekkonen.localdomain>
References: <20230607-unfounded-blandness-93cf1e44f127@spud>
 <20230607173204.GG5058@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607173204.GG5058@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor, Laurent,

On Wed, Jun 07, 2023 at 08:32:04PM +0300, Laurent Pinchart wrote:
> Hi Conor,
> 
> Thank you for the patch.
> 
> On Wed, Jun 07, 2023 at 06:26:07PM +0100, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> > 
> > Emails to Shawn Tu bounce & I could not easily see a non-intel email
> > for them on lore. Drop them and orphan their drivers.
> > 
> > CC: Shawn Tu <shawnx.tu@intel.com>
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Unless someonw from Intel wants to volunteer and take over maintenance
> of the drivers below,
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I can maintain them. I'll send a patch to change this soon.

-- 
Kind regards,

Sakari Ailus
