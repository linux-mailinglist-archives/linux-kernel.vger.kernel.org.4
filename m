Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DBC690DB7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjBIP5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjBIP5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:57:01 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F16AA5E2;
        Thu,  9 Feb 2023 07:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675958219; x=1707494219;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nPgSjSnHTmQsvwxH0O6W9fGsy0DfRfu4PfopvC3aaII=;
  b=I6iTYI2arRNm7OuqOzlqjdJ53+KI8Xc279MPjae7ZPbHenB4h0790zB3
   W0jkjHsOU4hprfU7TonbO4YXTL6hBps51lHycRMm0PBB6dN/DB7MY9yoW
   /Q9OG7AyJe0YPasRRG3iff9LR9hzRkrwLhAGALk23SWagdy1TLK3iTn41
   OVP+ClnwkS4Ej8xIhT1gdjFqRNB0Onoc5u+aVRCF7DqF/wKd/N5DkSpHB
   d+tX/dkRBgarOxUzme/iuRI1v5xTEi/+dEI7PLi8jAlUwXD8vaavFtIx3
   uXy7oEq3H5sYtuGrZzvlXYC43CrgmmjrY3mWkt8ZaMvwYMSvl0cYWY8zD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="394748489"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="394748489"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 07:56:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="669625073"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="669625073"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 09 Feb 2023 07:56:57 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 413A31C5; Thu,  9 Feb 2023 17:57:35 +0200 (EET)
Date:   Thu, 9 Feb 2023 17:57:35 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mauro Lima <mauro.lima@eclypsium.com>
Cc:     broonie@kernel.org, michael@walle.cc, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: intel: Update help text of PCI driver
Message-ID: <Y+UX7yOrtY0gz4ci@black.fi.intel.com>
References: <20230208175253.117714-1-mauro.lima@eclypsium.com>
 <Y+SHH2+VqLoQ+6Ss@black.fi.intel.com>
 <CAArk9MM4ZBL=_+xcJzb3X7yGyKQ6knbbsKAS+y_09Vs6pD4W=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAArk9MM4ZBL=_+xcJzb3X7yGyKQ6knbbsKAS+y_09Vs6pD4W=w@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 09, 2023 at 11:16:36AM -0300, Mauro Lima wrote:
> Hi Mika,
> >   "Say N here unless you want to overwrite the flash memory.."
> >
> > At least to me this means that if you enable this option your flash
> > memory will be overwritten.
> Do you have a suggestion for the "Say N here" text? Maybe remove it
> since this is safe for use now? I found it difficult to rephrase it

Agree, just remove it.
