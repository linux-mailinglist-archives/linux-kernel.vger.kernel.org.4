Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCF16B994E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 16:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjCNPb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 11:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjCNPbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:31:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7AFB06D3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678807824; x=1710343824;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QvJzZ3242dMhNPCkEyzhBjsZMjFhooKtyCNrrCWyChc=;
  b=gk/AmzxfnOsqp4aT3OLJ2QfE2EqTdcpKGuKeCv8mt9jmBZyPDdDg6ZsS
   1mnOY+PP51hHXHMYz7dPfguZDT5gE5JlbovlBrv0SQr4Vtw+LLrWy2aop
   fruatXOEsOhEGqGH4cLcRMtul2+r5Ja5n6YXnWuCi6EZIfMG1ohaQbRcS
   8inyW8N4sdH0K/U2w3e1DZCq5m1oo7Xsqsrfz8DFyAvAgswfjijV/3bfG
   6yX9gQ7Bkr06vgQFX8A+7EQgmmo1KpUsd+m51CZwhyGvX4V+NXTFTyNfc
   P1wy8mBA1OwNIOcChOgQAQpcSF+8k63aaWJjTagESv92TAMwSBozo8/Pd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="336150517"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="336150517"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 08:29:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="853240212"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="853240212"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.140.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 08:29:49 -0700
Date:   Tue, 14 Mar 2023 08:29:48 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Kloudifold <cloudifold.3125@gmail.com>,
        teddy.wang@siliconmotion.com, sudipm.mukherjee@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: sm750: Rename function to avoid CamelCase
Message-ID: <ZBCS7DR9dZH1yds8@aschofie-mobl2>
References: <ZA+K6OdPe21k8F2k@CloudiRingWorld>
 <ZA/+JlgWfdg2wH8B@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZA/+JlgWfdg2wH8B@debian.me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 11:55:02AM +0700, Bagas Sanjaya wrote:
> On Tue, Mar 14, 2023 at 04:43:20AM +0800, Kloudifold wrote:
> > The sm750 driver had some functions named in CamelCase,
> > which violates the kernel's naming convention.
> > In this patch, I rename these functions to snake case,
> > which is the expected style.
> > 
> > This v2 patch was prompted by an error reported by the
> > Linux test robot, which detected the compile error.
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Link: https://lore.kernel.org/oe-kbuild-all/202303110849.X24WnHnM-lkp@intel.com/
> 
> Hi,
> 
> I'd like to write the patch description as (ignore markdown):
> 
> ```
> sm750 driver has sm750_hw_cursor_* functions, which are named in
> camelcase. Rename them to snake case to follow the function naming
> convention.
> 
> Fixes: <commit that introduces these camelcase function>
> ```

Why are you asking for a Fixes tag on this? 
Seems unusual for a staging driver cleanup.

Alison


> 
> Thanks.
> 
> -- 
> An old man doll... just what I always wanted! - Clara


