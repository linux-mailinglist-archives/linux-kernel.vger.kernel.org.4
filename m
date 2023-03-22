Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA306C53C5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjCVSeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjCVSeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:34:10 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFBC1B565;
        Wed, 22 Mar 2023 11:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679510049; x=1711046049;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9NAyFsvY5+wb9A+DTRm5DkiLvM20CJJWJW3U7Px2UqU=;
  b=RrSdMyED94YwKI9ngRKOU56iCNM9vLOZRIbti95Ed9ZYO/qlvPVzA9Fu
   xN4BtslWsfpkZ57jIZjDt/G5cr3K2bg34+gtXgFcsFyqSGDz5qmOqXDVm
   bF2dwQDON0f64ArcMYTC3lmdUYxwefBpGa92VDS5qGEYpNx/vwFxBxTF/
   4/OHkfvcS0Wnnvh68SL4K77JgpvjCEOWtt+sYUlovFQQYngtWfXD/nizH
   bxzlV7mObGH4PdjAMEy1mUVpSbk+d70xv9HGmDrc13BSSJS+KGPCdPZcp
   JM1W5u0VqLz4ZyJWCzh4jixOw1Ad/DGxzWQC13gKuBAmpIX1fUSU1i8H8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="341660702"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="341660702"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 11:34:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="712359834"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="712359834"
Received: from mtfreder-mobl1.amr.corp.intel.com (HELO [10.209.35.23]) ([10.209.35.23])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 11:34:08 -0700
Message-ID: <18431bad-8595-143b-e8af-14e448af871c@intel.com>
Date:   Wed, 22 Mar 2023 11:34:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] x86/ACPI/boot: Improve __acpi_acquire_global_lock
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230320212012.12704-1-ubizjak@gmail.com>
 <CAJZ5v0jAysMPb180tMMmoGBEewENKn-fW7bwzGyMVv4wUrX=LA@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAJZ5v0jAysMPb180tMMmoGBEewENKn-fW7bwzGyMVv4wUrX=LA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/23 11:24, Rafael J. Wysocki wrote:
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> or please let me know if you want me to pick this up (in which case it
> will require an ACK from one of the x86 maintainers).

I'll pull it into x86/acpi.  I'm kinda shocked the compiler is so
clueless, but this makes the C code more readable anyway.  Win/win, I guess.
