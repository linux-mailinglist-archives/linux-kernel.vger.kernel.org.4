Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775885F62AB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiJFIaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiJFIaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:30:22 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA373167DE;
        Thu,  6 Oct 2022 01:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665045020; x=1696581020;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=p145ntU9QNRXpDPuVN87WcpkTwAW9lcMxG8ANKDfxXI=;
  b=U8qFFTBVXDp9gcpV5oF7gsIGjE8BRaKodiT7vCvT5Vaw1NX0YHAmwXgw
   DVxG2tpObCDboNjROJXATrrjABwPSNHuc1frRWSeOMzwGXcV9W9GEs+4c
   jW5Ff354e/TvCv/7hKb5pjzrxsBXlW31pwygdi3Z275gUMjd4MRDz6IGy
   CN06DUwUie9HGRQf3An+fFoErpa0Ijhn7VuuWUeZbsU1wxw3oXNBy8Z/5
   /hMFI9PTcHeZVWFugaeMPmKkHpaCN2x8jzvwx0rF4R+2iJiVQyRVE1A/N
   akERyPQyRdqUyVzvVNwDFJV+i3ZDga/FPXsdPGiD13EX0QPy+BDKNf00z
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="304377611"
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="304377611"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 01:29:43 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="575742350"
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="575742350"
Received: from pkastovs-mobl.ger.corp.intel.com (HELO localhost) ([10.252.61.167])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 01:29:41 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] docs: improve the HTML formatting of kerneldoc
 comments
In-Reply-To: <20221006065329.787c2592@sal.lan>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20221004201222.281845-1-corbet@lwn.net>
 <20221004201222.281845-6-corbet@lwn.net> <87r0zmqkao.fsf@intel.com>
 <20221006065329.787c2592@sal.lan>
Date:   Thu, 06 Oct 2022 11:29:40 +0300
Message-ID: <875ygxqrrf.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Oct 2022, Mauro Carvalho Chehab <mchehab@kernel.org> wrote:
> Em Wed, 05 Oct 2022 19:58:39 +0300
> Jani Nikula <jani.nikula@linux.intel.com> escreveu:
>
>> On Tue, 04 Oct 2022, Jonathan Corbet <corbet@lwn.net> wrote:
>> > Make a few changes to cause functions documented by kerneldoc to stand out
>> > better in the rendered documentation.  Specifically, change kernel-doc to
>> > put the description section into a ".. container::" section, then add a bit
>> > of CSS to indent that section relative to the function prototype (or struct
>> > or enum definition).  Tweak a few other CSS parameters while in the
>> > neighborhood to improve the formatting.  
>> 
>> Way back I tried to keep the formatting changes minimal to avoid opening
>> that particular can of worms along with the rest of the Sphinx
>> transition.
>> 
>> But I do wonder if people find value in repeating e.g. the struct
>> definitions in the documentation. I'd argue the rendered documentation
>> is more for an overview, and if you need to know the exact details,
>> you'll be in the editor typing code and you can look up the actual
>> definition in source. Having the definition feels maybe a bit excessive.
>
> I have split thoughts regards to it. The advantage of having the
> struct definition there is to allow checking the type of each argument,
> which is useful. It also provide a way to double-check if the parser
> is dealing well with the argument, but, on the counter-side, the
> type printed by kernel-doc may not be identical to what's inside the
> Kernel, on some special cases, as the parse logic for arguments is
> complex. The same applies on functions and macros.

Two alternatives to removing it come to mind:

- Generating links to git.kernel.org at right version, file and line.

- A collapsible (and collapsed by default) code box. I think this needs
  html/css hacking, not possible in Sphinx out of the box.

>> 
>> We also don't use Sphinx C Domain's ".. c:member::" for struct/union
>> members, 
>
> I'm wondering how much extra build time this would impact ;-)
> If the impact is not huge, I'm in favor of using it.
>
>> or ".. c:enumerator::" for enumeration contants. 
>
> This one can be more problematic, as it could break existing
> cross-references.

Certainly.

>
>> They provide arguably nicer rendering out of the box than our stuff.
>
> Agreed.
>
>> The Sphinx way to do parameter lists would be field lists i.e. ":param
>> foo: description". Ditto for return values ":return: description". (Not
>> saying we should convert the comments, but kernel-doc the script could
>> emit those.)
>> 
>> Perhaps we'd be better off going towards Sphinx standard usage than
>> tweaking our own thing?
>> 
>> I'm afraid I don't have the time to work on this. Talk is cheap and all
>> that. My two cents.
>> 
>> Anyway, here are some examples how this might look like: [1].
>> 
>> 
>> BR,
>> Jani.
>> 
>> 
>> 
>> [1] https://hawkmoth.readthedocs.io/en/latest/examples.html
>
> It reminds that we're currently lacking a  way to describe non-macro
> #defines. In special for bit-based defines, it would be nice to have
> a good way to document them, without needing to convert defines into 
> enums.

ITYM simple or non-function-like macros. Sphinx supports ".. macro::"
for that nowadays, but don't know since what version. That's what I use
in Hawkmoth, and ".. function::" for macros with args.

BR,
Jani.

>
> Regards,
> Mauro

-- 
Jani Nikula, Intel Open Source Graphics Center
