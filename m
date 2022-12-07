Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89D7645C2C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 15:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiLGOQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 09:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLGOQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 09:16:01 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B44A4A58E;
        Wed,  7 Dec 2022 06:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670422560; x=1701958560;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=PP7KOTPt4ERsWQH2CfJ+vJdbgsy5iXmqVONYHIHapR4=;
  b=kXZP52tHgBKlRbUjf4cjKgOnQOwPjTpNR2WwLI4f5WkarHsfbCwS2ck/
   77uI5sJzvgVvlKDy+19JAbgPIinlG+EujQoB9rJVsBJf2peG2A9hP3c3C
   Nc/Q/mStPnVlUXk79OnicIORcl5lT7DswP/8Y3k/uNtq8ouJ6MuKaqpsn
   FdqMLbZfJKxCeYM897PM8PsxL6x9++5vszfGsEnMJvZrGbMl8G0eEalZ5
   mhxsxL6shvgP8T/bbm4Fjp5Oei0PSJQEAvbqIRRN85/e4h1Z+aXtJ/N8y
   b9U/p5uZ+dS23Oc9yaya/Cya+lyFP2gs7vb+gvfau7+0xw7rHLCjfwx8V
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="318756464"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="318756464"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 06:15:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="753111853"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="753111853"
Received: from fbackhou-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.36.192])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 06:15:39 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Carlos Bilbao <carlos.bilbao@amd.com>, corbet@lwn.net,
        akiyks@gmail.com, ojeda@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bilbao@vt.edu, konstantin@linuxfoundation.org
Subject: Re: [PATCH v3 1/2] docs: Move rustdoc output, cross-reference it
In-Reply-To: <5887a9cd-b48e-e2af-7639-3f9ff53fcd8a@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20221201204814.2141401-1-carlos.bilbao@amd.com>
 <20221206153151.771038-1-carlos.bilbao@amd.com>
 <20221206153151.771038-2-carlos.bilbao@amd.com> <87359r39gg.fsf@intel.com>
 <5887a9cd-b48e-e2af-7639-3f9ff53fcd8a@amd.com>
Date:   Wed, 07 Dec 2022 16:15:36 +0200
Message-ID: <87lenj1erb.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Dec 2022, Carlos Bilbao <carlos.bilbao@amd.com> wrote:
> On 12/7/22 2:27 AM, Jani Nikula wrote:
>> Also, please don't use "here" as the link text.
>
> Why not?

It's considered bad style, see e.g. [1] or [2] or the plethora of
results you get if you search for "here as the link text".

The link text should describe what's at the destination.

BR,
Jani.


[1] https://ux.stackexchange.com/questions/12100/why-shouldnt-we-use-words-such-as-here-and-this-in-textlinks
[2] https://www.w3.org/QA/Tips/noClickHere


-- 
Jani Nikula, Intel Open Source Graphics Center
