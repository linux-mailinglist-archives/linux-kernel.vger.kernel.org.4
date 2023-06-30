Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0B2743C0D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 14:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjF3MlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 08:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjF3MlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 08:41:13 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE46ED;
        Fri, 30 Jun 2023 05:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688128872; x=1719664872;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2FYd99bnFlQzYvPT8VK/+D26pZGzuJX6LEsG6BobVfE=;
  b=REOLyBAhhyceInBpXDnwGQdyG6H9KNPtDZlKH7/t8ik/s66v08+M6s+3
   VsWWo0/MNmigcw3m3gACFeh3KPyIqFjriFNW4rmCuY7oinInYaMX1Gfsc
   e7kwARoRLm+w9YdqjWx6yWLJKjXHOT4YaUeMhD9KbynG8WCNAMWx2GXU5
   07i4LnMJ4DPF/QzLpOVITarlOB0ZW5WiOwaobZVYpygaTknWyJqrQ2rlc
   rvKKswgWTlhlRhl1jSLxFrFKoIluWVpZWgqQK0HpUoEt9mmrvPr9SxecR
   dgCtOhU1YJ8ojzcsYWQS0P/iL+UKpR4OnJttkzmfAkc0wDx5Yy0gRw1rp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="347165217"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="347165217"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 05:41:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="862280390"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="862280390"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 30 Jun 2023 05:41:08 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 30 Jun 2023 15:41:07 +0300
Date:   Fri, 30 Jun 2023 15:41:07 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Kyle Tso <kyletso@google.com>
Cc:     gregkh@linuxfoundation.org, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 2/3] usb: typec: Iterate pds array when showing the pd
 list
Message-ID: <ZJ7NY2iEGgmmVjzE@kuha.fi.intel.com>
References: <20230623151036.3955013-1-kyletso@google.com>
 <20230623151036.3955013-3-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623151036.3955013-3-kyletso@google.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 11:10:35PM +0800, Kyle Tso wrote:
> The pointers of each usb_power_delivery handles are stored in "pds"
> array returned from the pd_get ops but not in the adjacent memory
> calculated from "pd". Get the handles from "pds" array directly instead
> of deriving them from "pd".
> 
> Fixes: a7cff92f0635 ("usb: typec: USB Power Delivery helpers for ports and partners")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kyle Tso <kyletso@google.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

thanks,

-- 
heikki
