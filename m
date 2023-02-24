Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A306A1525
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 04:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjBXDCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 22:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjBXDCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 22:02:53 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FC844AC;
        Thu, 23 Feb 2023 19:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677207772; x=1708743772;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=v+OHKdxrw/nM2qX9sYd6aRRdtAU9Je2UuBYcv5BP8wY=;
  b=ORXA0fGA0ddSDJv3UVLZt/DPKqvSToIcFcAHp1ATnBLMicjl+5JJ/xmG
   eIf6i/R5AMbNzz9P5/EihzxLf2uh3ArGJ39OD6atbBIlDKvQqdjE1iIDw
   Vk1s4nP8ykfoMVMGNpoT0IL2swM9wIMZqemueL5LEKIjMKlnNKAeUNvFC
   euBFwu+mZVjWm8HSvXOn6BA0aJrMmemqUEhRn+0mskmLTkrZLUHStD9B3
   /Q3MHvZp1io2pUkgG5IrHiH+JGfOtpFFc/psgZ1woA5az3YXqZUXxPous
   h6rd1geuIfqtUQYZqWzBDAxFZjkzSrinxKsThzkTCg9bRgdKmKKMXOZlp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="331117111"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="331117111"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 19:02:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="918274147"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="918274147"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 19:02:45 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        Vishal Moola <vishal.moola@gmail.com>,
        Paulo Alcantara <pc@cjr.nz>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Xin Hao <xhao@linux.alibaba.com>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] MM updates for 6.3-rc1
References: <20230220135225.91b0f28344c01d5306c31230@linux-foundation.org>
        <CAHk-=whAAOVBrzwb2uMjCmdRrtudGesYj0tuqdUgi8X_gbw1jw@mail.gmail.com>
Date:   Fri, 24 Feb 2023 11:01:49 +0800
In-Reply-To: <CAHk-=whAAOVBrzwb2uMjCmdRrtudGesYj0tuqdUgi8X_gbw1jw@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 23 Feb 2023 17:33:37 -0800")
Message-ID: <87cz5zdaw2.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

>
>  - gcc 12.2.1 quite reasonable complains about some of the new MM code:
>
>     mm/migrate.c: In function =E2=80=98__migrate_folio_extract=E2=80=99:
>     mm/migrate.c:1050:20: note: randstruct: casting between randomized
> structure pointer types (ssa): =E2=80=98struct anon_vma=E2=80=99 and =E2=
=80=98struct
> address_space=E2=80=99
>
>      1050 |         *anon_vmap =3D (void *)dst->mapping;
>           |         ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
>
>    and while this doesn't cause a build failure ("note" is different
> from "warning"), I do think something needs to be done. Gcc is right.
> This code seems to *work* simply because it's intentionally
> mis-casting pointers,

Yes.  The mis-casting is intentional.  I just need some place to hold
the data temporarily (save in __migrate_folio_record() and clear in
__migrate_folio_extract()).  And "dst" is newly allocated folio.

> but I think it needs to be seriously looked at and something done to
> make gcc happy (and a *LARGE* comment about it).

Sure.  I will check whether there's some way to make gcc happy and add
some comments about that.  There's some comments for
__migrate_folio_extract(), but that's isn't enough apprently.)

> That last note is not some merge result, it's purely about the new MM cod=
e.
>

[snip]

Best Regards,
Huang, Ying
