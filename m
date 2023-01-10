Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46716663E81
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 11:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238194AbjAJKqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 05:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238086AbjAJKqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 05:46:17 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF621759B;
        Tue, 10 Jan 2023 02:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673347573; x=1704883573;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9YZ2PeAZKlHibjJN9Eo/0ObT6UUPozn9XZoXqU5DOpI=;
  b=HxtG2mh/7cKp64Au7dU5reO+QIIZycNMGpE5gti429ZcuXDSrelEZVzc
   JUF72CiY4ZHhdYXTjYeciOYCJ+1423/a1jEfTvoMY20ssYZUWQ3O34RjK
   UIi/D2+s4ZzwPmuKkRD6OJEJj97uxJbkr7l3Z9ZvbUXRor3iq7Qylnwgs
   MB3aYKS7C8B0OWUebTA2HV8PtGkgdxTdW7WOI3YsAUtAW0gkymBkN5M/R
   hXsSlEsW2jrMSY4P/DQ+t644QUxDhQ7GHnW6/EzFk0W6ysvL44rLOYTbu
   DeIEw++huQQdyi521zu/LGf4tpd5oQH3janrYkRH+PWKBE/eLCieu9QgE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="350336527"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="350336527"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 02:46:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="799386901"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="799386901"
Received: from joe-255.igk.intel.com (HELO localhost) ([172.22.229.67])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 02:46:11 -0800
Date:   Tue, 10 Jan 2023 11:46:09 +0100
From:   Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Oded Gabbay <ogabbay@kernel.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH][next] habanalabs: Replace zero-length arrays with
 flexible-array members
Message-ID: <20230110104609.GA1602079@linux.intel.com>
References: <Y7zB4z5cxpFkPXKV@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7zB4z5cxpFkPXKV@work>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 07:39:47PM -0600, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated[1] and we are moving towards
> adopting C99 flexible-array members instead. So, replace zero-length
> arrays in a couple of structures with flex-array members.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [2].
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays [1]
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [2]
> Link: https://github.com/KSPP/linux/issues/78
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
