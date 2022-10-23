Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F7D60917F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 08:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiJWGuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 02:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiJWGt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 02:49:59 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826AF4F1B1;
        Sat, 22 Oct 2022 23:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666507797; x=1698043797;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=evPr22dKymT0FB2f0mLWM3Nhy+DwMcrp021ivv+tOrE=;
  b=cC8NJqEdBr/IoZf5sZ8Zjz0fAp/mRePzxo8+60gWQRJvX9dgsUYWUyyJ
   Q8ey31K70y+v4ISfoNCB7/lm6Lh+Fp9kZgfcIJ6UtvkzaWsSyJWZcbjCL
   SZPfiMeE8HTHYuI/yRGRkIbhX40gKFHNeZDGpUtkPtE+Q9KjveYWDBuMe
   aEHczeoIghvyIZ3PW4ZqS7CAkBVEhuxH+nf0EocnQg6niC7qRnVvd2WRt
   YnMD+2BPgLDcneBh0uS/S99rUFU/POph7TFzyFnhceJZ6Fp4YBdaX3ElF
   RJ3gdZjnWJU0SJoD6pjN6SNbO3Xdr2ac7b33Ve2iCpsCDXTQ3CuLCq8ni
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="393551094"
X-IronPort-AV: E=Sophos;i="5.95,206,1661842800"; 
   d="scan'208";a="393551094"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 23:49:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="756249102"
X-IronPort-AV: E=Sophos;i="5.95,206,1661842800"; 
   d="scan'208";a="756249102"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 22 Oct 2022 23:49:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 2A9F0107; Sun, 23 Oct 2022 09:50:15 +0300 (EEST)
Date:   Sun, 23 Oct 2022 09:50:15 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/5] pinctrl: alderlake: Deduplicate COMMUNITY macro
 code
Message-ID: <Y1TkJ0r6PIM/7ng4@black.fi.intel.com>
References: <20221018223427.43579-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018223427.43579-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 01:34:23AM +0300, Andy Shevchenko wrote:
> Define a common COMUNITY macro and supply a variant to it.
                  ^^^^^^^^
COMMUNITY

(ditto for other commit messages)

> This removes some verbosity in macros.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
