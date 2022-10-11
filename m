Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15CE5FB780
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 17:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiJKPl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 11:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiJKPle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 11:41:34 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02EC31220;
        Tue, 11 Oct 2022 08:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665502297; x=1697038297;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cYpCJz7OhFUxc5+oKcS7CVxf4L5yvVH/ZQYUtwQ8NTo=;
  b=TN57WBSoT3NKOXgaeDU5NmmIkQ7i0A+Rg+b4oG1WaGI2ofagzZOeNqe+
   ml8HcQfVzoS2EVMfwDA2e5b+onG4jg2bgZtuz9Ff8Xnuw1Rg+qD3fLzg3
   xw/y9xKIxo3a9Yh3emK+cHInJz3Z0jMR+SZ8VgY2J5GPzvyN2jVrwKO+M
   we095ka3dX6Qc+hauhPcFAVwBukVxR2Z6oDH5awV+cet2Lhlnkoz4nCxz
   VfMoSf3z5yvhPHAHLMJmT9NlQ38A8e+q7gQPKGRc3XCqL5TGi3B+IFkSg
   N3KXnJ7VKilAw89EZkZHxu5PH++BX749/MPVAz0K/N9sykII3uhFtNSY8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="284916051"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="284916051"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 08:31:08 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="659569819"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="659569819"
Received: from makozuch-mobl2.amr.corp.intel.com (HELO [10.209.39.67]) ([10.209.39.67])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 08:31:05 -0700
Message-ID: <3b5bfa95-ff64-0e8b-44a3-8b67b767ffd6@intel.com>
Date:   Tue, 11 Oct 2022 08:31:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH] Remove Intel compiler support
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ia64@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>, Len Brown <lenb@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Tom Rix <trix@redhat.com>, devel@acpica.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20221011031843.960217-1-masahiroy@kernel.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221011031843.960217-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/22 20:18, Masahiro Yamada wrote:
> I am sending this to Linus and the x86 maintainers with RFC.
> If somebody is still using ICC, please speak up!

Yeah, the bit rot is not a good sign.  I honestly can't remember seeing
anyone actually use icc during my entire tenure at Intel.  I'll ask
around to see if there's any plausible reason to fix this up and keep
it.  But, I'm not holding my breath.

