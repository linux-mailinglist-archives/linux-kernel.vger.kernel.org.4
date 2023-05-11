Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6246FF7B7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238468AbjEKQpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238475AbjEKQph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:45:37 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A857769D;
        Thu, 11 May 2023 09:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683823531; x=1715359531;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UczabKdilmgU9aiW6/OArG+bSHVPW/I0DRgqu9f1Ry0=;
  b=GdKv2OPhCYnMvNzoZ62pMoa+f6wfmjmNYimbbbTSLM2MZiijhcckdjaW
   jHUJvB19QV+1FgK3maUIUMKDOhqx9Me+H17VW+wC7x9/VSaN8PkFmPagC
   Yzfvh/73heAw7+eJ+tnxBJS7f4F0t6LIG8CF9e6ZzibGd4i78XSbbEGi6
   0emaVbJWoNsmn4BXUplYBdImXr+H85B1wPdQmtAx5a9h4SpXUHLSTTRnY
   Vd16ewSkflor3CsvqCqhxBK/+Ghbrr/Roc545FKlmFk54O063n1rocQcB
   yQT5bdJuUa18knSRRDsnh4saWubUrFzJzdubgq20BUUSBQFjwYvGwoe2u
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="348038401"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="348038401"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 09:45:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="824043617"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="824043617"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 09:45:24 -0700
Date:   Thu, 11 May 2023 09:45:22 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>, rafael@kernel.org,
        srinivas.pandruvada@linux.intel.com, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powercap: RAPL: Add Power Limit4 support for Meteor Lake
 SoC
Message-ID: <ZF0bosUa2moFCoOj@agluck-desk3.sc.intel.com>
References: <20230215123249.4473-1-sumeet.r.pawnikar@intel.com>
 <28ead36b-2d9e-1a36-6f4e-04684e420260@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28ead36b-2d9e-1a36-6f4e-04684e420260@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 07:55:08AM -0700, Dave Hansen wrote:
> Could you please fix this up?  As penance, you could even fix the _ANY
> defines so that people can't do this accidentally any longer.

See the X86_MATCH_INTEL_FAM6_MODEL() for how to do this right.

-Tony
