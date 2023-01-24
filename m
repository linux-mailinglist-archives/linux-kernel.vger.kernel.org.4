Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6681E67936F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 09:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbjAXIsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 03:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbjAXIsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 03:48:04 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA299F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 00:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674550084; x=1706086084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Dl7rXKEdq8PvoijCs/oOyLxW6MYTFYAWUkJ0i39JYpA=;
  b=bhEzXO3PpJJ5kvHEs7fYzzXgCS9jaI3yVsP4Zvgc8KhRP+APkSQwdhwB
   bckAGS1nvUH/UsHrfQ5v/anJc7NSAaIika+w3FccS/vEBei0E/tblYDxX
   5YKk2ibp+gp086Fgcd1cJAOnee29LSWvZ55QaXItL5DWl6Qge9Ugw9wWU
   zqgQAd+ogJANJA57pkRd8k6TH+GqQ2+gW7SHdVRK0YfHiXYl4myYahLHk
   3FE/jPD6VsEMZGt2w1aT5b661GDeNgEdeS+rD6uXBzwBV+s+aGp7gfz9T
   NGajy+W2SYZ2hTkQqXVElhXwXHa9yfPCI9naBDytPprBXQ/9EcPMwnNl9
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="390756801"
X-IronPort-AV: E=Sophos;i="5.97,241,1669104000"; 
   d="scan'208";a="390756801"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 00:48:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="804508982"
X-IronPort-AV: E=Sophos;i="5.97,241,1669104000"; 
   d="scan'208";a="804508982"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.55])
  by fmsmga001.fm.intel.com with SMTP; 24 Jan 2023 00:48:00 -0800
Received: by stinkbox (sSMTP sendmail emulation); Tue, 24 Jan 2023 10:47:59 +0200
Date:   Tue, 24 Jan 2023 10:47:59 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH] nvme-pci: Switch back to sync probe to fix rootfs mount
 regression
Message-ID: <Y8+bP2Oqy3B2XyuJ@intel.com>
References: <20230124004542.29659-1-ville.syrjala@linux.intel.com>
 <20230124062140.GA29175@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230124062140.GA29175@lst.de>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 07:21:40AM +0100, Christoph Hellwig wrote:
> Err, no.  We're not going to randomly revert things.  If you want
> to be productive check the one liner Keith reported in reply to the
> last report.

No idea what that previous report is. Care to share a link?

-- 
Ville Syrjälä
Intel
