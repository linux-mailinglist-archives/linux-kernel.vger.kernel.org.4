Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8B86AB453
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 02:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjCFB0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 20:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCFB0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 20:26:42 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C78113523;
        Sun,  5 Mar 2023 17:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678066001; x=1709602001;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=SYiWV6H9JK7F7vaGe6QefXnmtObmczypmjB7wdKdQiI=;
  b=V6mZ0pHE7rUBLzbLq16ESR7umxMMGL6Lcct96+AeoHRSi8o+mpFnTnlJ
   EOXrC+1aaB4H5xCJrZt3CKaW0lleq/SNN73MyemonvgDbUk5hl09NoEh5
   emdPQDKOQK5X89Ss72Vz8h+bQo5sOK2pAKvr1iVRd1+PQz6mBS4IA2QIQ
   Ljhb+Sdyl3VpdFVKnzLL96jedQS9yHImdLyZd/vhAJr1tkMW8fwftJlsO
   ttilcqZaSQL/SMbIY28+aiF8dnbTeHbG/BJrh7SWakOfPMCQTseEunzwx
   G89AkON6q8+NiN/xVgaxyy9qcWPvYsnvAx061KSB/aEnMLFj2UUrxZto4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="400269683"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="400269683"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 17:26:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="850121767"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="850121767"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 17:26:38 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] hotfixes for 6.3-rc1
References: <20230304131528.4645d19a2ab897fb7518159e@linux-foundation.org>
        <CAHk-=wj9guryjifHyr26w73ta+kNeoHtGde682Z5N6OSjKu4UQ@mail.gmail.com>
        <20230304152058.de91bf7abf424383ce31d500@linux-foundation.org>
        <CAHk-=wiHX2NQiVH8uQZ_U8vB=qnzmQHauGAqAkC=4ZWp95ya8w@mail.gmail.com>
Date:   Mon, 06 Mar 2023 09:25:06 +0800
In-Reply-To: <CAHk-=wiHX2NQiVH8uQZ_U8vB=qnzmQHauGAqAkC=4ZWp95ya8w@mail.gmail.com>
        (Linus Torvalds's message of "Sat, 4 Mar 2023 15:37:11 -0800")
Message-ID: <87jzzu7jt9.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Linus,

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, Mar 4, 2023 at 3:21=E2=80=AFPM Andrew Morton <akpm@linux-foundati=
on.org> wrote:
>>
>> Ah. Ying did it this way:
>
> Yeah, I saw that patch flying past, but I actually think that it only
> silences the warning almost by mistake. There's nothing fundamental in
> there that a compiler wouldn't just follow across two assignments, and
> it just happens to now not trigger any more.
>
> Assigning to a union entry is a more fundamental operation in that
> respect. Not that the compiler still doesn't see that it's assigning a
> value that in the end is not really type compatible, so a different
> version of gcc could still warn, but at that point I feel like it's
> more of an actual compiler bug than just "oh, the compiler didn't
> happen to follow the cast through a temporary".

Yes.  Your fix is much better.  This can be used for
__page_set_anon_rmap() family too to make the code look better?

Best Regards,
Huang, Ying
