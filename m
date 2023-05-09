Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232FB6FCDEA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 20:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbjEISic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 14:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjEISi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 14:38:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B826359A;
        Tue,  9 May 2023 11:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683657509; x=1715193509;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8KLofvuwjuzCeRiT9wzzuN9VTnSIeEnud3i/p91LRjg=;
  b=EEOwMyjwrg5wBo6sXmXavLyvRgkwrcYWnYrGXN9ZM9cAflCWLWpz/yh3
   vQB+vZF70IgIsZGB4WducxZ6FMh8mscc40wVZcIdSF0GwC1PQcCg+q5LA
   lXtLPQslWCGay0zirhZ9wJI0tfDc3GrhFlC2StrYc2J2enavGhjIaUQ5M
   p/28raFDFOk/4nuDixN3nhvNV1yegAx6EJ6KbTlEfe4Rz0jsEFEiDYBv2
   Qb5fwx9F39+NWxUIZgPYt8PVV2AczIwL0zh4gy4KXTmD1Cv8B7CPYYN26
   m9aOfXDwllF18GysfL9V9ZJHCuGioj/vhA9CyC7VIrSQYSY2q8vNyr8vo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="330385097"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="330385097"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 11:38:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="698998155"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="698998155"
Received: from dcourtn1-desk1.amr.corp.intel.com (HELO [10.212.182.218]) ([10.212.182.218])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 11:38:28 -0700
Message-ID: <ea00d762-b0df-ab72-988b-98c62ffc7949@intel.com>
Date:   Tue, 9 May 2023 11:38:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] x86: make config X86_FEATURE_NAMES visible with EXPERT
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230509084007.24373-1-lukas.bulwahn@gmail.com>
 <7cbe80f0-dcc3-bfc3-3bd8-c9f96704618d@intel.com>
 <CAKXUXMxO4b-8wT-88fJ=++woH-p79_4R-vUr=aELNFYinGcEuw@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAKXUXMxO4b-8wT-88fJ=++woH-p79_4R-vUr=aELNFYinGcEuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/23 11:20, Lukas Bulwahn wrote:
> On Tue, May 9, 2023 at 4:07 PM Dave Hansen <dave.hansen@intel.com> wrote:
>>
>> On 5/9/23 01:40, Lukas Bulwahn wrote:
>>> Commit 6a108a14fa35 ("kconfig: rename CONFIG_EMBEDDED to CONFIG_EXPERT")
>>> introduces CONFIG_EXPERT to carry the previous intent of CONFIG_EMBEDDED
>>> and just gives that intent a much better name.
>>
>> That was quite the changelog, and I'm still not quite sure:
>>
>> What is the problem with the existing code?
>>
>> What is the end user visible impact of this problem and of this proposed
>> change?
>>
> 
> Thanks, Dave, for your feedback.
> 
> The commit message is so lengthy, as I copied it from the original
> cover letter into each commit, but I agree with your feedback.

Uhh...  *What* cover letter?  A cover letter is usually the 0/NN message
in a patch series.  It is not obvious at *all* that this plain
non-numbered patch is part of a series.

> So maybe this commit message fits better:
> 
> To simplify build configurations, the CONFIG_EMBEDDED is to be
> removed. All configs that are only visible with CONFIG_EMBEDDED=y
> shall be now visible with CONFIG_EXPERT=y.
> 
> In the x86 architecture, the config X86_FEATURE_NAMES is visible when
> CONFIG_EMBEDDED is enabled. Now, make the config X86_FEATURE_NAMES
> visible when CONFIG_EXPERT is enabled.
> 
> Dave, what do you think? If that is good enough for you, I will send
> an updated patch with that commit message.

CONFIG_EMBEDDED is being removed:

	<INSERT LINK HERE>

That means that everything in Kconfig that uses CONFIG_EMBEDDED needs to
switch over to something else.

Move X86_FEATURE_NAMES over to CONFIG_EXPERT instead of CONFIG_EMBEDDED.

--

This actually isn't _great_ for x86.  We hid X86_FEATURE_NAMES behind
EMBEDDED because we didn't want to see it 99% of the time.  But just
about everyone uses EXPERT=y, so the end result here is that everyone
will now see X86_FEATURE_NAMES.

Oh well.  It's just one Kconfig option.  Not a big deal.
