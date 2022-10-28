Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0234C61149F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiJ1OdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJ1OdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:33:16 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24601CFC57;
        Fri, 28 Oct 2022 07:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666967595; x=1698503595;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EG6Xc17sfjqoQRo9S9ammovQWB/2rTObQJFbKlUcXdU=;
  b=h7b6AR6oEczAmdTAixrUQQWkznMvKalM2hlt3vXjmGgb+VOBT+Kg/3/n
   GnuJ6G+NGAFJxn4wL4qe+UHJJinBFkwnlRVu5Lg9j/bh7F1on4w/jr4Cg
   4Y2/R7rTEKxURwR5Jpz2KfuBR11g2j0sXjR1gPp3mZahZl74hKbgNMPom
   3JMIgthLMM1HDRo+kWuJk1nV0Mzy37bny4KeRgkfe16DTaag9wvSsabV2
   Pszf4sZTkUfhbgQAILKHf5iDm/g0ulJWvnm8FCOpqYsaAPdS7Di0hRv0f
   cazMJ0DYrEhqR5As0jToWEzZuqUYuH3VHWYhp4cA8yHCrNeEhYbA5I3gY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="291801971"
X-IronPort-AV: E=Sophos;i="5.95,221,1661842800"; 
   d="scan'208";a="291801971"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 07:33:14 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="877980830"
X-IronPort-AV: E=Sophos;i="5.95,221,1661842800"; 
   d="scan'208";a="877980830"
Received: from jbandiax-mobl.amr.corp.intel.com (HELO [10.209.126.71]) ([10.209.126.71])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 07:33:14 -0700
Message-ID: <fcd3d702-d645-2847-d8ee-0fb4734258c6@intel.com>
Date:   Fri, 28 Oct 2022 07:33:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: boot failure of linux-next due to 1248fb6a8201 ("x86/mm:
 Randomize per-cpu entry area")
Content-Language: en-US
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
References: <Y1vZKg6UHjdUZt1W@debian>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Y1vZKg6UHjdUZt1W@debian>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/22 06:29, Sudip Mukherjee (Codethink) wrote:
> I will be happy to test any patch or provide any extra log if needed.
> Though I am not sure how I will collect extra logs (if needed) as there
> was no output from qemu.

Could you share your qemu config?  The command-line would be fine.  Does
it have a serial console set up?
