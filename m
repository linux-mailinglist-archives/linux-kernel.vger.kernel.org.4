Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AE35F5754
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 17:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiJEPTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 11:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJEPT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 11:19:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E5975CC1;
        Wed,  5 Oct 2022 08:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664983169; x=1696519169;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MhpH7OK6hRIKWqO2KUFUVILuqkRWDlod+ealvOdarCM=;
  b=KMoLY5GH40Hf6JB9XvhphvuMqkM9Dg4i3opOlB+rPT3s5k7MqnJ+oYkp
   O2jpkLbRQrcKH0vV2Ud0aj+2nJchoX1u1RS/N1mq3G/z2JBXfYxBe4W2Z
   o+iMYMsgXezdhiCHH4Kyf+pqt+PxW74Dduf0Mb4EI0zjQQycScGSpi8+I
   sITVTfqtkYJv6AaSqfYxyUqt0uTf4LCbvdPAaJWnBi7//5umVVEK9JIXU
   Yav+a1eiouO4fLCot1M+W77Wa5pXrm1TGu6w44Nu5BaVJ3jenEvOLK7VI
   YFGi9pu6/KFeR3g2FirdToWPL4cVCSf8O+CsLCnoqEzYtqFO0C7BlpRRU
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="283554784"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; 
   d="scan'208";a="283554784"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 08:19:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="602041976"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; 
   d="scan'208";a="602041976"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 05 Oct 2022 08:19:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1og6B9-002iJB-02;
        Wed, 05 Oct 2022 18:19:23 +0300
Date:   Wed, 5 Oct 2022 18:19:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v1 1/2] device property: Introduce
 fwnode_device_is_compatible() helper
Message-ID: <Yz2genlaPcji+XKp@smile.fi.intel.com>
References: <20221005143812.33503-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005143812.33503-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 05:38:11PM +0300, Andy Shevchenko wrote:
> The fwnode_device_is_compatible() helper searches for the
> given string in the "compatible" string array property and,
> if found, returns true.

Scratch this, it has some flaws.

-- 
With Best Regards,
Andy Shevchenko


