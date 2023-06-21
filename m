Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0455738545
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjFUNd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjFUNdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:33:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE34191;
        Wed, 21 Jun 2023 06:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687354433; x=1718890433;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UGeph0SnmhqYhiHgSmqDullZqGhaZth9Yn0Kr+BwwTs=;
  b=CJwTo2VdYTY/LYqO4uUZnMcIYItGJW2cy0CiSA+YJvXxMZ1fnEsPBWLT
   l+ZEeaZnWOTaUCtg3/XQEaVGCyHQxOXRMEvGzhRJgnZEUW//AbzApxWUq
   KNrC6mxZ+VA612fff7IFzlOSYxjZbrWv1gjTE4d44TS608ivD8m7jeTZC
   fD/U2zR35LphoV4JQ86QCdfO8UVxEK7DwjzASAZTI9vBwstKjt2lsADI0
   tvtl4T5JZXvbnNVnPyuLaKLIIBKcdrYp7CulEAq0lqTXaNHJIGrGPDqzq
   C+3zeUuqGVrRBmZkOXqeoQ07S+1fjpKaCww9y6jSmr811DBqtO0bUmHx7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="359041977"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="359041977"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 06:33:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="784502088"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="784502088"
Received: from araj-dh-work.jf.intel.com (HELO araj-dh-work) ([10.165.157.158])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 06:33:52 -0700
Date:   Wed, 21 Jun 2023 06:32:13 -0700
From:   Ashok Raj <ashok_raj@linux.intel.com>
To:     linan666@huaweicloud.com
Cc:     axboe@kernel.dk, linan122@huawei.com, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v3 0/4] block/badblocks: fix badblocks setting error
Message-ID: <ZJL73Zhyq4d/oaXd@araj-dh-work>
References: <20230621172052.1499919-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621172052.1499919-1-linan666@huaweicloud.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 01:20:48AM +0800, linan666@huaweicloud.com wrote:
> From: Li Nan <linan122@huawei.com>
> 
> This patch series fixes some simple bugs of setting badblocks and
> optimizing struct badblocks. Coly Li has been trying to refactor badblocks
> in patch series "badblocks improvement for multiple bad block ranges", but
> the workload is significant. Before that, I will fix some easily triggered
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You mean the refactor is going to take longer to complete? 
If so, maybe state it that way...
