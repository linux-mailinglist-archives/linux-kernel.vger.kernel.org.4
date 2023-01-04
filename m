Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F8565CDD8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 08:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbjADHr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 02:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjADHrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 02:47:52 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5A1167CF;
        Tue,  3 Jan 2023 23:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672818471; x=1704354471;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6R09QmeYh3AUpWd1Fk6QvWgloEhaBRweABxyf0WRt2k=;
  b=QH8wkcrfu42KG2Mcydut7Gwt1C7rQ1H+rKIf+QPpeIB8xLnWS+wRB3NC
   oTy7m/CaNb4vDtil8B0JpCjbpkd2GxJ/q0KOxTyjR6LgraBvdiwluwpjF
   f+Bey2oArHTw7H0QSVvzeFu4dKjjyW0yFEbzKqVMZ9ExPfvtcgsQonqe3
   Gv9x9z/CkwVER6v7hhxSTd6yusulQ1RqfV+YR2TcWE+vJbNeuTb+X4drm
   s+y/XIAhF749sw54GRmNtHYRuzWkJeKJd89ijUYDtDALCvx4cYcj4ycz0
   8BRuh55oYu+gn0/qyvUcFObgvPT60atnPRn9JrEnP0Mg8zcO8fSXvhpEW
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="384161649"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="384161649"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 23:45:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="685672401"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="685672401"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 03 Jan 2023 23:45:31 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 97526162; Wed,  4 Jan 2023 09:46:03 +0200 (EET)
Date:   Wed, 4 Jan 2023 09:46:03 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: Re: [PATCH v1 1/1] thunderbolt: Refactor tb_acpi_add_link()
Message-ID: <Y7UuuzerRxPMJLpr@black.fi.intel.com>
References: <20230102192404.88076-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230102192404.88076-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 09:24:04PM +0200, Andy Shevchenko wrote:
> Convert while loop into do-while with only a single call to
> acpi_get_first_physical_node(). No functional change intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied, thanks!
