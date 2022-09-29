Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554C15EF2B8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbiI2JwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbiI2Jv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:51:59 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87E4121E77;
        Thu, 29 Sep 2022 02:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664445117; x=1695981117;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DdeAyF4XrN0ldruY1n6vOl3bjhSuJl7qyM1T/77uKhA=;
  b=er/eyMLu/4qbeVlM3FeWIFffkPVnKaH0zF/mu8yZ1Qz1wDphSCCk1hCz
   M+Vd51aoZ+F9xA1p+0jL8to8oL3cBPDfn4RBcrfO9fLr85zZsN8KYa6O9
   MqHGVlrOh+iDdIfzDI3h6MkMgcZS1jqG+6kJWMV2AwKAg6l2irg+jVPXd
   nJYXKv5Zun2Uz9BwhbxQj7RI0Z3h4k0MpbCs5lfQN3NgKIUpYmI4ZTRKe
   v9DnCKCGoIOo5yXbcphjBy4IXQkh8D97J/xRKeMywC7SBtB9419gistc6
   Y5N+FIMYmpuxLX3x8FEJU6g/ZbruBw3ejsk7cY48+GIoxS9ysX0vFL+as
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="363692616"
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="363692616"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 02:51:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="573393766"
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="573393766"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 29 Sep 2022 02:51:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1odqCt-009Ks1-0N;
        Thu, 29 Sep 2022 12:51:51 +0300
Date:   Thu, 29 Sep 2022 12:51:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     hdegoede@redhat.com, markgross@kernel.org, rafael@kernel.org,
        lenb@kernel.org, hmh@hmh.eng.br, matan@svgalib.org,
        corentin.chary@gmail.com, jeremy@system76.com,
        productdev@system76.com, mario.limonciello@amd.com,
        pobrn@protonmail.com, coproscefalo@gmail.com,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] platform/x86: dell: Add new dell-wmi-ddv driver
Message-ID: <YzVqtreGq0v7vhBm@smile.fi.intel.com>
References: <20220927204521.601887-1-W_Armin@gmx.de>
 <20220927204521.601887-3-W_Armin@gmx.de>
 <YzQmQw0hEwzXV/iz@smile.fi.intel.com>
 <34774c9d-1210-0015-f78e-97fdf717480c@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34774c9d-1210-0015-f78e-97fdf717480c@gmx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 10:57:16PM +0200, Armin Wolf wrote:
> Am 28.09.22 um 12:47 schrieb Andy Shevchenko:
> > On Tue, Sep 27, 2022 at 10:45:21PM +0200, Armin Wolf wrote:

Side note: When answering to emails, please remove unrelated context, do not
make this the answering party problem.

-- 
With Best Regards,
Andy Shevchenko


