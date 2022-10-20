Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F78606230
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 15:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiJTNt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 09:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiJTNsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 09:48:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090C55B9CA
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 06:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666273734; x=1697809734;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=DFlm0KbEbGovx+beuTWPd+BvaHeRPvibkM66WhpiDVg=;
  b=hzccy7yx9M2GoA/wDDb8BTZawXgFkbjAMJZTQxtjB8YLnNJXt4P4NHGl
   ez53LXlAqHeI856eOXPs8baG/LwM0eO4AH/aYmMisH2OLRjZd4D1L5TK3
   vl6FH32SIFfNoG8NY4svMmd9i8fvdwu30OSiCpKGZhpXXS7nkmBnLLHpk
   iKomBaQP+Pa/BcWz8WFpaeXnSQPDRxDTGwiY7aA27kJFGaPh8ABcgXUsC
   qKfwkXNzA47gdx1B7kNCpycKuTD1v2Zyop8Bo27e+r9InlT0TpjXSv/o4
   FFeWGcNzr4uN8i1zLoEA/526TprDcPObmgXAp+FCqnVq1ZXf2Jawq1wOO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="294105178"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="294105178"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 06:48:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="734847691"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="734847691"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 20 Oct 2022 06:48:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1olVuj-00AZSH-2R;
        Thu, 20 Oct 2022 16:48:49 +0300
Date:   Thu, 20 Oct 2022 16:48:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Backlight for v6.1
Message-ID: <Y1FRwfeX+ynmHxPm@smile.fi.intel.com>
References: <Yz18QA27+gN0oaM3@google.com>
 <CAHk-=whK-q1W-X0q0f_nBJ9sKyta-DVJhEAS4BF_oKAVAUQ4Jw@mail.gmail.com>
 <Y0AmmR2NfKc/Y7Mb@google.com>
 <CAHk-=wg=hh8xkPjiySnjAyR66AG64eyZ1Y9gHw+MCs8uuSZReA@mail.gmail.com>
 <Y0HB3K8IRVhX5IvT@smile.fi.intel.com>
 <CAHk-=wixtjmiENLbc1=Hds3mMSjVRA3ZiwXN7yg8mw_1MCg_QQ@mail.gmail.com>
 <d66fa3ea-1efe-e7da-be80-89507067e2a9@redhat.com>
 <CAHk-=wgF_0+au4cz-ZmH4qOpgDWmmbJC101fh_RVAbsJRH7d-Q@mail.gmail.com>
 <189ed242-4ccb-4935-ede0-c5807d7b5083@redhat.com>
 <e0fb158f-81af-8f3d-5d8b-c4c423feec6c@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e0fb158f-81af-8f3d-5d8b-c4c423feec6c@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 08:31:33PM -0700, Randy Dunlap wrote:
> On 10/9/22 05:58, Hans de Goede wrote:
> > On 10/9/22 01:23, Linus Torvalds wrote:
> >> On Sat, Oct 8, 2022 at 12:59 PM Hans de Goede <hdegoede@redhat.com> wrote:

...

> >> Because if it depends on some symbols from I2C_DESIGNWARE_PLATFORM,
> >> and that one can be a module, then the Intel PMIC driver also needs to
> >> be built as a module to just get the build coverage, at least.
> 
> I don't see intel_soc_pmic_crc.c using any direct calls into
> i2c-designware-platform code. If it calls into it, it must be thru some
> indirect pointers (?).

It's on hardware level, the PMIC is connected to the I²C host controller,
which is Synopsys DesignWare and being services by the respective driver.

Any access to the PMIC's registers requires the I²C to be involved.
What we talked above is even bigger loop, that takes AML code in
the chain.

-- 
With Best Regards,
Andy Shevchenko


