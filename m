Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156F3743C16
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 14:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjF3MnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 08:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbjF3MnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 08:43:05 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D4035AF;
        Fri, 30 Jun 2023 05:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688128982; x=1719664982;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jh5EMMBq/kwv4zwh4mtqrj/lvWk5Oe0+aZ++KdUCnTA=;
  b=dl7ecg/3yRruKuQ1zWLLsQC6LO2k926cp6MnEi+Z2fXwO4ktnZDwgcAX
   3eXr7e3MsxrNq2z1FUz4iqkPG11GHJR1xzzCxXN67uovXtV0ZcGQu2Ob7
   oAFEE6MrBeC3k3GWEZ5eQoicd+EMrIzOL0oM21TY7b62mC5il73sUyMh7
   frL+BtK/JSZjACNhAF7y+GyIxejMuqKRAPtgs32Yg0WY2S4Om0hKslCp4
   ttzn15XUwRtUeJG1E3zfvUnjXrG7OjPnzh1juVpnMiqzBpbdGNo1+Za0/
   j1GsZJXItih+gQvFRHxWD4lbzIyeSEVedMlQ/8V211RoNx+djTmt7ZZcG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="347165615"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="347165615"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 05:43:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="862280550"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="862280550"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 30 Jun 2023 05:42:58 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 30 Jun 2023 15:42:57 +0300
Date:   Fri, 30 Jun 2023 15:42:57 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Kyle Tso <kyletso@google.com>
Cc:     gregkh@linuxfoundation.org, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 3/3] usb: typec: Use sysfs_emit_at when concatenating
 the string
Message-ID: <ZJ7N0S2BUtKbesRQ@kuha.fi.intel.com>
References: <20230623151036.3955013-1-kyletso@google.com>
 <20230623151036.3955013-4-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623151036.3955013-4-kyletso@google.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 11:10:36PM +0800, Kyle Tso wrote:
> The buffer address used in sysfs_emit should be aligned to PAGE_SIZE.
> Use sysfs_emit_at instead to offset the buffer.
> 
> Fixes: a7cff92f0635 ("usb: typec: USB Power Delivery helpers for ports and partners")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kyle Tso <kyletso@google.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

-- 
heikki
