Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B6F703FFD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 23:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245605AbjEOVln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 17:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245218AbjEOVll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 17:41:41 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA3D618D;
        Mon, 15 May 2023 14:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684186900; x=1715722900;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YT+jpmKKG29CORJ7DZIqHysBrg87OzibafnqwKC9Ue4=;
  b=Q3yUqvqQJidAFvNpjgOWVZUoE6qc+cmObM04KPF0nivZzUM0qgGlRJwr
   1zI1zdyCZM4GRVL/ME9hacVx6HIbsYFZvjcDZz4V+OBPwjUN+gS8jGx0o
   +L13Esl12taOFBqj1IHQgO2Ao7FJj3435l85xycD3BY4Ev/K+xqXXtZq4
   ykj+JVcJoZolUcW2MztFIegubmfl7p2cxaKWk38R/KmdwVnJRxKqJccOm
   44NQsUMeIlsPJ+KDVfNmZxFUOJEKDFSYdbjvrFit720CEPz1z3t8X+WPx
   umJyDKS8S/kbYK5fMtZ04CmWTNMudH3rFhOd6jKdnjLOX3TmpKc42vo1j
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="350155543"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="350155543"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 14:41:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="695184571"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="695184571"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 15 May 2023 14:41:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pyfwg-000753-2M;
        Tue, 16 May 2023 00:41:30 +0300
Date:   Tue, 16 May 2023 00:41:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3 2/3] leds: simatic-ipc-leds-gpio: split up into
 multiple drivers
Message-ID: <ZGKnCmPbAw17R+sn@smile.fi.intel.com>
References: <20230515150352.30925-1-henning.schild@siemens.com>
 <20230515150352.30925-3-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515150352.30925-3-henning.schild@siemens.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 05:03:51PM +0200, Henning Schild wrote:
> In order to clearly describe the dependencies between the GPIO
> controller drivers and the users the driver is split up into a core,
> two drivers and a common header.

AFAIU the GPIO lookup tables need a terminator entry.

-- 
With Best Regards,
Andy Shevchenko


