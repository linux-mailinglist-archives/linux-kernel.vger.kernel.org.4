Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFBD6FBBD7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 02:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbjEIAHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 20:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjEIAH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 20:07:28 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE70B49D9
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 17:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683590847; x=1715126847;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AU0Xk5S1RJCxxN3bXhs+gF6gnmdjNOad1WJQrl0JRM4=;
  b=BGXsJHvkKlPLhhBpoBQ5mfaRa6hXpGo3IcS5cfpe5HwCSkBDRQWCyono
   Pa+atNmSn2+i91ovvDQXVk1WbnUTzUP69LGpALIP1WWGTIQPNfuuxtQjW
   KuXJtNbPrS0b0hcC5cYWdHEpDmr9Bh+RYzKqv4DFY0x96G9V61TirDpYQ
   L3fzJYNEtJYknZixIGLoxPeSk8TY5wfd0YK0tNr6KqmVXZOww+r4RINO/
   FOB+e9Ay0D29/cDVAiYDoxnI/G0bzF5aXoncvtmjI3UJGfxafL6tXMlwW
   UZ9Bamn5UUU08v/afxYP47FrVvshyVNPG5MVipAa4lbtsMnMmN2YX7a5J
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="436097881"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="436097881"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 17:07:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="763601856"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="763601856"
Received: from ahdamali-mobl.amr.corp.intel.com (HELO [10.212.29.166]) ([10.212.29.166])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 17:07:27 -0700
Message-ID: <27770379-5e65-d231-f7ee-dff3975eeeda@intel.com>
Date:   Mon, 8 May 2023 17:07:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [GIT PULL] x86/shstk for 6.4
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <20230424212130.590684-1-dave.hansen@linux.intel.com>
 <CAHk-=whn3F1k263SZNUVQK195tcCMAo5E_WbmjUE0qFC5rWg=w@mail.gmail.com>
 <4433c3595db23f7c779b69b222958151b69ddd70.camel@intel.com>
 <148b3edb-b056-11a0-1684-6273a4a2d39a@intel.com>
 <CAHk-=wiuVXTfgapmjYQvrEDzn3naF2oYnHuky+feEJSj_G_yFQ@mail.gmail.com>
 <CAHk-=wiB0wy6oXOsPtYU4DSbqJAY8z5iNBKdjdOp2LP23khUoA@mail.gmail.com>
 <4171c4b0-e24b-a7e2-9928-030cc14f1d8d@intel.com>
 <CAHk-=wiVLvz3RdZiSjLNGKKgR3s-=2goRPnNWg6cbrcwMVvndQ@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAHk-=wiVLvz3RdZiSjLNGKKgR3s-=2goRPnNWg6cbrcwMVvndQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/23 16:31, Linus Torvalds wrote:
> On Mon, May 8, 2023 at 3:57 PM Dave Hansen <dave.hansen@intel.com> wrote:
...
>> This behavior is gone on shadow stack CPUs
> 
> Ok, so Intel has actually tightened up the rules on setting dirty, and
> now guarantees that it will set dirty only if the pte is actually
> writable?

Yep:

	Specifically, a processor that supports CET will never set the
	dirty flag in a paging-structure entry in which the R/W flag is
	clear.

and this was _absolutely_ one of the things the hardware folks did for
the benefit of software.

As for the mm->users==1 optimization, seems like something sane to
explore.  I can't think of any ways off the top of my head that it would
break, but I'll go take a closer look.
