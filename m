Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E07C6CD429
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjC2IOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjC2IN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:13:59 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326A92688;
        Wed, 29 Mar 2023 01:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680077638; x=1711613638;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ialiVnpkXOWTKhS2xTHgcKp65F9jZog73LAgEC6QtiY=;
  b=B1HAgCX9XsFvj6ZKfTfI8Fxok8zmdwAC7qH0QHM6ZOBuo4Truz2i8RBu
   D0Fh2uuZ14mxRLhC7js3gFADENINX6n5QiOu31/2/KSQobQmKahNYzuVi
   xVMFq8peG4JqXqpr6vfkkSb+9BI+LH0jIev+z342Kf/08cwqSujmvSxCl
   5gioaBr4wjUs5O2uUJJ1fXNWHoktnvh2nTpaa3JepULHW/nehtmyhac38
   d92EDOkdwlO2JqCpBDgwOdB8K6fGV55F2B4CA2by1nBfV4JJ5kP1+RxGp
   79zBrApQRYPl32ZHDaEr0pgPczdHxRDc+YgUejF7IFZtBbvaV/EbXukZ6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="338313398"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="338313398"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 01:13:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="773475596"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="773475596"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Mar 2023 01:13:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 3606D79C; Wed, 29 Mar 2023 11:13:56 +0300 (EEST)
Date:   Wed, 29 Mar 2023 11:13:56 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: Re: [PATCH v1 2/2] thunderbolt: Make use of SI units from units.h
Message-ID: <20230329081356.GI33314@black.fi.intel.com>
References: <20230327172017.20078-1-andriy.shevchenko@linux.intel.com>
 <20230327172017.20078-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230327172017.20078-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 08:20:17PM +0300, Andy Shevchenko wrote:
> In a couple of places it seems reasonable to use MEGA intead
> of explicit number. It makes code more readable and robust.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to thunderbolt.git/next, thanks!
