Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED9F697B78
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 13:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjBOMIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 07:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBOMI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 07:08:29 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A02C2A987;
        Wed, 15 Feb 2023 04:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676462908; x=1707998908;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DYpXXhUbajYvp9CAwgR03lGdhtEFU9c+JaHUOcAL/20=;
  b=dbvvEfyKY+Qr0mXnjXDpqBIbBzS6YiRzagk7WRoCk2tSKrB2w5ozbF6D
   nGwqbyulBCOJEMT3LApXdSK1i5M2HkUu4IHVVtqgJ4W+qeEQCKfwflCCV
   to/7yQCgFWWSj1kquQylWlAWsof0GrWn5M1ohU5BSSuUjFBSidh/JyYH1
   IFpaOM5aaTHfEWXodDy9DsIUZ1qKGxSwm/nEzITuNzu2OcF3HHmJwsVaL
   bFfF1KJ3iEJlxU34B4JuMsxGs+iyeLaBbvZIiLre85C46SbYNspP59e1c
   pswUri2lddSdnL4U9CFu/zMHTerhY0q2pKtPmCe6RCki+yTR3I0pnLuQu
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="319446418"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="319446418"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 04:08:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="702009547"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="702009547"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 15 Feb 2023 04:08:21 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id CDC341A6; Wed, 15 Feb 2023 14:09:01 +0200 (EET)
Date:   Wed, 15 Feb 2023 14:09:01 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com
Subject: Re: [PATCH] gpiolib: acpi: remove redundant declaration
Message-ID: <Y+zLXZsiZljl0z5t@black.fi.intel.com>
References: <20230215120004.9693-1-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230215120004.9693-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 05:30:04PM +0530, Raag Jadav wrote:
> Remove acpi_device declaration, as it is no longer needed.
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
