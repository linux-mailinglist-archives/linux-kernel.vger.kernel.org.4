Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B1A626A77
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 17:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbiKLQKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 11:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiKLQKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 11:10:32 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86148101DA;
        Sat, 12 Nov 2022 08:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668269431; x=1699805431;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VwA4hY1StmPVwmTURop/V0d2syA09os0bsDOlKpgEgQ=;
  b=VsqukZ0JAE8yhKqls0m2n4egc2VkIw5PhCsuWJqIFM3PCdVdxUGfReQg
   R4nZzga1wWfAvt5Cv4QSgRIASTvVdxQNfnCfJbWq3oUlM/sfQC3YwAQwX
   dY74hOMCVuhS90AyfWyhRU6S3pKE9dmCiPn6cddO6MJdCCr04MFbcHQtl
   8kFPsL6cx9feDfTwgUIyYQv2NVhlQd8Njfmoy9PPuxBUGjZbWEqqEkxFm
   am7EIYvpMzpzACpw+cJD53NLAZOMGFzBD0YCXbFwSsV3HDr4AZ7vQGG0K
   junj2YWjwpuGHHHJM4e5UMf9ImJqPc+gjXtt+9omJmGymMG6kEvRbHNIL
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="311746143"
X-IronPort-AV: E=Sophos;i="5.96,160,1665471600"; 
   d="scan'208";a="311746143"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2022 08:10:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="637890744"
X-IronPort-AV: E=Sophos;i="5.96,160,1665471600"; 
   d="scan'208";a="637890744"
Received: from shambhav-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.251.12.9])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2022 08:10:30 -0800
Message-ID: <a37a579768310cbf57069c0ea0015ecd6ba7c569.camel@linux.intel.com>
Subject: Re: [PATCH][V2] hid: intel-ish-hid: ishtp: remove variable rb_count
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Colin Ian King <colin.i.king@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Even Xu <even.xu@intel.com>, linux-input@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 12 Nov 2022 08:10:30 -0800
In-Reply-To: <20221020210219.45131-1-colin.i.king@gmail.com>
References: <20221020210219.45131-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-10-20 at 22:02 +0100, Colin Ian King wrote:
> The variable rb_count is being incremented but it
> is never referenced, it is redundant and can be removed.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> V2: Fix commit message.
> ---
>  drivers/hid/intel-ish-hid/ishtp/client.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/hid/intel-ish-hid/ishtp/client.c
> b/drivers/hid/intel-ish-hid/ishtp/client.c
> index df0a825694f5..2d92fc129ce4 100644
> --- a/drivers/hid/intel-ish-hid/ishtp/client.c
> +++ b/drivers/hid/intel-ish-hid/ishtp/client.c
> @@ -841,7 +841,6 @@ void recv_ishtp_cl_msg(struct ishtp_device *dev,
>         unsigned char *buffer = NULL;
>         struct ishtp_cl_rb *complete_rb = NULL;
>         unsigned long   flags;
> -       int     rb_count;
>  
>         if (ishtp_hdr->reserved) {
>                 dev_err(dev->devc, "corrupted message header.\n");
> @@ -855,9 +854,7 @@ void recv_ishtp_cl_msg(struct ishtp_device *dev,
>         }
>  
>         spin_lock_irqsave(&dev->read_list_spinlock, flags);
> -       rb_count = -1;
>         list_for_each_entry(rb, &dev->read_list.list, list) {
> -               ++rb_count;
>                 cl = rb->cl;
>                 if (!cl || !(cl->host_client_id == ishtp_hdr-
> >host_addr &&
>                                 cl->fw_client_id == ishtp_hdr-
> >fw_addr) ||

