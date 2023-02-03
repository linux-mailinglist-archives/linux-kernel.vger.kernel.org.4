Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4DA689437
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 10:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjBCJpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 04:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbjBCJox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 04:44:53 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562A59AFDE;
        Fri,  3 Feb 2023 01:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675417476; x=1706953476;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=/tdpS1Qw1gaKBHKKO9C6ohbaeZRzAMBlN/mzMNnDRL4=;
  b=jinbuvO4WpmCmygFTEZocpFN9P9c3hw3mcNHB6lCeS/JTm1fCxZm7zIr
   DUHBhyHCK9T21HB4C/IpZOsB3C6JmB+abssY5+5SoUi9YCU6RoxJP+7ho
   SeDxssAIvk2uPnKy1KigQXXWil19pXqdruadWeeBz047i9ivrVyoP4YlF
   qtJo8hJVr0tkwlp/1+30VUZ1ZWLrdMNDdZdqyOD+VZS7x86hKeuBFZirK
   eeedPwgiAr+Aa/XmNdcItD1kX6mD+aeuCYt66gnLuHnYQNWtM6q4BaIPA
   5elNu8mq09+4VL1kTKn/HQF6aKMmrk6k0U+/G0GqvsvLziCRB58PjcCtB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="326401556"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="326401556"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 01:44:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="643210452"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="643210452"
Received: from cciobanu-mobl.ger.corp.intel.com (HELO localhost) ([10.252.35.96])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 01:44:11 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH v1] docs: describe how to quickly build Linux
In-Reply-To: <ee3a168f-66e3-14a3-3890-90dc5c8153d1@leemhuis.info>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <fabdb45fa44db2531f0dbe5e88545c49dfb87040.1675252073.git.linux@leemhuis.info>
 <1f217c94-b90f-359a-2142-0d3ae5d84fc6@leemhuis.info>
 <20230202150856.lchr76nqih3vdul6@nitro.local>
 <ee3a168f-66e3-14a3-3890-90dc5c8153d1@leemhuis.info>
Date:   Fri, 03 Feb 2023 11:44:08 +0200
Message-ID: <877cwz13tj.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Feb 2023, Thorsten Leemhuis <linux@leemhuis.info> wrote:
> On 02.02.23 16:08, Konstantin Ryabitsev wrote:
>> On Thu, Feb 02, 2023 at 12:15:36PM +0100, Linux kernel regression tracking (Thorsten Leemhuis) wrote:
>>> Then I tried creating a shallow clone like this:
>>>
>>> git clone
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>> --depth 1 -b v6.1
>>> git remote set-branches --add origin master
>>> git fetch --all --shallow-exclude=v6.1
>>> git remote add -t linux-6.1.y linux-stable
>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
>>> git fetch --all --shallow-exclude=v6.1
>>>
>>> This took only roundabout 2 minutes and downloads & stores ~512 MByte
>>> data (without checkout).
>> 
>> Can we also include the option of just downloading the tarball, if it's a
>> released version? That's the fastest and most lightweight option 100% of the
>> time. :)
>
> Don't worry, that was in there and will stay in there:
>
> +   If you plan to only build one particular kernel version, download
> its source
> +   archive from https://kernel.org; afterwards extract its content to
> '~/linux/'
> +   and change into the directory created during extraction.

The trouble is, if this is for someone who needs to try kernels for
debugging, a typical idea is to ask them to revert something or apply a
patch. All the guides for that will be 'git revert' and 'git am'. Bisect
is right up there on the list too. And then they'll first grab a tarball
and fail, then do a shallow copy and fail, and then finally get a full
one... :p

BR,
Jani.


>>> Not totally sure, but the shallow clone somehow feels more appropriate
>>> for the use case (reminder, there is a "quickly" in the document title),
>>> even if such a clone is less flexible (e.g. users have to manually add
>>> stable branches they are interested it; and they need to be careful when
>>> using git fetch).
>>>
>>> That's why I now strongly consider using the shallow clone method by
>>> default in v2 of this text. Or does that also create a lot of load on
>>> the servers? Or are there other strong reason why using a shallow clone
>>> might be a bad idea for this use case?
>> 
>> As I mentioned elsewhere, this is only a problem when it's done in batch mode
>> by CI systems. A full clone uses pregenerated pack files and is very cheap,
>> because it's effectively a sendfile operation. A shallow clone requires
>> generating a brand new pack, compressing it, and then keeping it around in
>> memory for the duration of the clone process. Not a big deal when a few humans
>> here and there do it, but when 50 CI nodes do it all at once, it effectively
>> becomes a DDoS. :)
>
> Thx again for your insights, much appreciated.
>
> Ciao, Thorsten

-- 
Jani Nikula, Intel Open Source Graphics Center
