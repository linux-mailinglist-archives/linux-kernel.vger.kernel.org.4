Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981EC60C6EF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 10:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbiJYIwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 04:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiJYIvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 04:51:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AC610B7B2;
        Tue, 25 Oct 2022 01:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666687911; x=1698223911;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hbhV4A15ndt/saOeMCmNJor1iFigW50w+1NuvMqFvSY=;
  b=P2oMnF13xGVIMlzkZ/vPMXo34Au/KXwvSR1uxsNAHu9kmSS+IH1nQ0Lz
   axFOu2QYnOncYnahdkqmntd/xSLHM6Cn6VapGgxB2IqLOEFQewLEHXzKG
   yLvF+Ns96N4uCpH4eJnehLBhh2TSeqfov4qBYOJC3n33wq80u7QOIfZxl
   OA3sFFBimjj6lvOtFnyOG2bk5ETgYkaLAYR3Py0g7z7CvYroXhPCVTX0V
   FReWfSWcwv9b/9VDFUijQrKhK+Y53WmPhdS8viZo+U7IgyW5jtm8cT6Ff
   cwuhUb7OQk9gHE4Zv+QeXtolM+oqGQFJyXLkAKjpte2cPKYXxnH363WRS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="287344511"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="287344511"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 01:51:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="876732788"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="876732788"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 25 Oct 2022 01:51:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id A7C94107; Tue, 25 Oct 2022 11:52:11 +0300 (EEST)
Date:   Tue, 25 Oct 2022 11:52:11 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] thunderbolt: ACPI: Use the helper
 fwnode_find_reference()
Message-ID: <Y1eju9YGutD9LsgB@black.fi.intel.com>
References: <20221024074846.84805-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024074846.84805-1-heikki.krogerus@linux.intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 10:48:46AM +0300, Heikki Krogerus wrote:
> Replacing the direct fwnode_property_get_reference_args()
> call will this wrapper function.
> 
> No functional changes intended.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Applied to thunderbolt.git/next, thanks!
