Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE52714D5E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 17:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjE2Pud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 11:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjE2Pub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 11:50:31 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92109C4;
        Mon, 29 May 2023 08:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685375430; x=1716911430;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=mMZh0kAlYL2zmA97tU/xmL590jHHYcGK+jhWW5T1MvI=;
  b=h3fRTwWYo47xtPQmKwwZC3oj/0S8IFN0x0d/6H3/QFhQ/uvJBFc8C0Jm
   V9M66H1b5iZ2H4UOXp3B6W7kE5QMDE9N4cNGwi9NB/7xmIbxgtW03qd4v
   gKQxdNAphm8uEb6GCMS/AEJG3sqmxZlPfkCnmEh1nOamSkV9zIjOEhf2c
   VSys3SrKbZQcprUuayU8j4i0V7v/wQBPTtjYvZP1Mi2eIGz0W+SKdGqse
   vzEO98zr0VfsjaOXLNv1Qp6mkJhp6ROZ/HVhO2l8W58HOByUK92GDhdkH
   gC1NJxxV2SpMMkC1jasVlu1xNvh+Jins7+SmwROoBy/Ltdqn7Zx8lQAWu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="418217876"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="418217876"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 08:50:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="700306400"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="700306400"
Received: from btaubert-mobl1.ger.corp.intel.com ([10.252.55.237])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 08:50:27 -0700
Date:   Mon, 29 May 2023 18:50:24 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Mark Pearson <mpearson-lenovo@squebb.ca>
cc:     Hans de Goede <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] platform/x86: think-lmi: Correct System password
 interface
In-Reply-To: <e71b1911-5105-4e19-9c86-6146f07a6b00@app.fastmail.com>
Message-ID: <3b2dfd18-a6f2-46a6-19dd-4ee95d5e9471@linux.intel.com>
References: <mpearson-lenovo@squebb.ca> <20230526171658.3886-1-mpearson-lenovo@squebb.ca> <20230526171658.3886-2-mpearson-lenovo@squebb.ca> <ff5513d9-ecf-50d3-1bb3-644a1d2c2347@linux.intel.com> <e71b1911-5105-4e19-9c86-6146f07a6b00@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1304189898-1685375198=:2737"
Content-ID: <54c48c31-1276-8f71-a0-d2d9119cb7b@linux.intel.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1304189898-1685375198=:2737
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <3bfa6cb0-ce43-6b19-c661-90466faeb9c3@linux.intel.com>

On Mon, 29 May 2023, Mark Pearson wrote:

> Thanks Ilpo
> 
> On Mon, May 29, 2023, at 7:36 AM, Ilpo Järvinen wrote:
> > On Fri, 26 May 2023, Mark Pearson wrote:
> >
> >> The system password identification was incorrect. This means that if
> >> the password was enabled it wouldn't be detected correctly; and setting
> >> it would not work.
> >> Also updated code to use TLMI_SMP_PWD instead of TLMI_SYS_PWD to be in
> >> sync with Lenovo documentation.
> >> 
> >> Correct these mistakes.
> >> 
> >> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> >
> > Missing Fixes tag?
> 
> Yes - will add.
> 
> >
> >> ---
> >> Changes in v2:
> >>  - Updated define name to be SMP_PWD instead of SYS_PWD
> >>  - Clarified in comments what each password type is.
> >> Changes in v3: None. Version bump with rest of series
> >> 
> >>  drivers/platform/x86/think-lmi.c | 14 +++++++-------
> >>  1 file changed, 7 insertions(+), 7 deletions(-)
> >> 
> >> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> >> index 2745224f62ab..c7e98fbe7c3d 100644
> >> --- a/drivers/platform/x86/think-lmi.c
> >> +++ b/drivers/platform/x86/think-lmi.c
> >> @@ -168,11 +168,11 @@ MODULE_PARM_DESC(debug_support, "Enable debug command support");
> >>   */
> >>  #define LENOVO_CERT_THUMBPRINT_GUID "C59119ED-1C0D-4806-A8E9-59AA318176C4"
> >>  
> >> -#define TLMI_POP_PWD (1 << 0)
> >> -#define TLMI_PAP_PWD (1 << 1)
> >> -#define TLMI_HDD_PWD (1 << 2)
> >> -#define TLMI_SYS_PWD (1 << 3)
> >> -#define TLMI_CERT    (1 << 7)
> >> +#define TLMI_POP_PWD (1 << 0) /* Supervisor */
> >> +#define TLMI_PAP_PWD (1 << 1) /* Power-on */
> >> +#define TLMI_HDD_PWD (1 << 2) /* HDD/NVME */
> >> +#define TLMI_SMP_PWD (1 << 6) /* System Management */
> >> +#define TLMI_CERT    (1 << 7) /* Certificate Based */
> >
> > Whe you're adding Fixes tag, please make this change minimal by just 
> > adding TLMI_SMP_PWD.
> >
> > The rest of these define changes are a good too but it's unrelated to the 
> > actual fix so they should be in a separate patch. And once you move it 
> > into own change, convert to BIT() while at it.
> 
> I was asked previously to clarify what SMP stood for so added the 
> comment and it seemed odd to only clarify one and not the others. 
> Can I push back on this request. Doing two separate patches for just 
> that doesn't make sense to me.

I did not mean removing TLMI_SMP_PWD's comment from this patch just to add 
it in the another but the comments to the other bits which should go into 
their own patch. The thing here is that fixes should be made minimal to 
comply with stable rules.

-- 
 i.
--8323329-1304189898-1685375198=:2737--
