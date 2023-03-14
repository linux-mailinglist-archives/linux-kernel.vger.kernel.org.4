Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882D06B9AC0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjCNQKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjCNQKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:10:41 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0382E9F054
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678810233; x=1710346233;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZZ1GkwZzOOfbuECIVG//M3pZbtjDLpfRYC2hiYAiNVI=;
  b=bsZIEf01gqYZfNq4t9gd+L3u6xvzUaYApTu+H2l7MWqkG7lxLNsF0ICs
   FKvi/rBl5+ZYvOGu8h346xeQBNV5S10jUq/ehpeFmzLIdWB7Yw0rYutF3
   THWzyhb98feLr4ZrYgFVRhIkj3qN8Q3RiR9liKDWGpqDhO/4lHANCQ5mz
   KFct3bx2M8o28Ec+j6O9bZrlxxB6p+7W7hrMQrSmaB2hTHv1SgNoKuH6E
   EuBHF0tIzrciKOY8X7SSyB5PFCBcTGbnPEH3GwVVzePH0DeDxGtlqlcR2
   NuVsQr4DHRlnrSJ4CW94imQ4yGLSzh8u3OKL0snxXbl3cTkcv7LtzcZt6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="337496398"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="337496398"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 09:04:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="629085030"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="629085030"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.140.184])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 09:04:54 -0700
Date:   Tue, 14 Mar 2023 09:04:53 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Kloudifold <cloudifold.3125@gmail.com>,
        teddy.wang@siliconmotion.com, sudipm.mukherjee@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: sm750: Rename function to avoid CamelCase
Message-ID: <ZBCbJR2RVzc7Wr4g@aschofie-mobl2>
References: <ZA+K6OdPe21k8F2k@CloudiRingWorld>
 <64f9d3ca-268e-71ae-4a6d-b71315a8406e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64f9d3ca-268e-71ae-4a6d-b71315a8406e@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 01:07:59AM +0100, Philipp Hortmann wrote:
> On 3/13/23 21:43, Kloudifold wrote:
> > The sm750 driver had some functions named in CamelCase,
> > which violates the kernel's naming convention.
> > In this patch, I rename these functions to snake case,
> > which is the expected style.
> 
> Hi,
> please make the Subject more unique. Many patches could have this name.
> Look for examples in:
> https://lore.kernel.org/linux-staging/
> 
> Please use your full name consisting of a given name and a family name in
> front of your email. Or is this not possible and "Kloudifold" is both?

Kloudifold,

It'll probably take a bit for the change, allowing pseudonyms, to become
common knowledge. When the question comes up, you can just point to the
latest update to Documentation/process/submitting-patches.rst as I've
done below.

Phillip,
I commented similar to you, and then discovered this:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d4563201f33a022fc0353033d9dfeb1606a88330

Pseudonyms now allowed.

Alison

> > This v2 patch was prompted by an error reported by the
> > Linux test robot, which detected the compile error.
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Link: https://lore.kernel.org/oe-kbuild-all/202303110849.X24WnHnM-lkp@intel.com/
> > 
> > Signed-off-by: Kloudifold <cloudifold.3125@gmail.com>
> 
> The explanation what has changed needs to be below the ---
> but your Signed-off-by: is not allowed to be below this ---
> Look for examples of v2 in:
> https://lore.kernel.org/linux-staging/
> 
> Thanks
> 
> Bye Philipp
> 
