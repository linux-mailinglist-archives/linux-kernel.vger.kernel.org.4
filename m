Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC913643B66
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 03:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiLFCl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 21:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiLFCly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 21:41:54 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F9FB7DD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 18:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670294513; x=1701830513;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=FZAHxGmeLgTvz+h4faOmVd/+icSg6LznsgsEN+s6FS8=;
  b=WJW0gxQWUcDRerYlFGQyUBoYTt3l2tLIqogogbScLI4l4/8Vbd6xqJxn
   ftzCTxJQk+m8/euyzcM0PDRkilg8FK8unIEs90ieKZIL8zZYOB5Mqj73j
   khezfIWa9cGO9Pe/CwdbBFcGoXFHYK1MzgRgHg6nLaocAQJh00r34azTI
   qvqPyKFU9C5KCqrTbEEtJqCp2/eIZpWeModDYGWgvGLi3fM7MpEO6lNov
   QNYF9J4lxVy2e6dlFsNU8d2b505AGoFVQwihxVMojy9dXztV6bcNbICXM
   tFSrXiIhoUm1MQYis2yMfmNEwpZGdHVp6eNwHfcIqgdMaQRMBr4bwKYJV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="315226072"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="315226072"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 18:41:53 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="974910264"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="974910264"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 18:41:50 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     kernel test robot <yujie.liu@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Andrew Morton <akpm@linux-foundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com
Subject: Re: [linux-next:master] [mm] f1a7941243: unixbench.score -5.1%
 regression
References: <202212051324.182a6363-yujie.liu@intel.com>
        <CALvZod4CD+O7-ynGAHU-6vxE6CbSmuQei1=SVJsx0zFfQdmV2g@mail.gmail.com>
Date:   Tue, 06 Dec 2022 10:41:00 +0800
In-Reply-To: <CALvZod4CD+O7-ynGAHU-6vxE6CbSmuQei1=SVJsx0zFfQdmV2g@mail.gmail.com>
        (Shakeel Butt's message of "Mon, 5 Dec 2022 09:18:28 -0800")
Message-ID: <875yepfe4j.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Shakeel Butt <shakeelb@google.com> writes:

> On Sun, Dec 4, 2022 at 9:56 PM kernel test robot <yujie.liu@intel.com> wr=
ote:
>>
>> Greeting,
>>
>> FYI, we noticed a -5.1% regression of unixbench.score due to commit:
>>
> [...]
>> 9cd6ffa60256e931 f1a7941243c102a44e8847e3b94
>> ---------------- ---------------------------
>>          %stddev     %change         %stddev
>>              \          |                \
>>       7917            -5.1%       7509        unixbench.score
>
> What is unixbench.score?

Should be benchmark throughput.

>>      10485           -12.1%       9216        unixbench.time.maximum_res=
ident_set_size

This should reflect accuracy change of per_cpu_counter.

>>   37236706            -5.1%   35324104        unixbench.time.minor_page_=
faults

The reduction is same as benchmark score.  So I think this reflect the
nature of time-bound testing (instead of workload-bound).

> For above two, is negative change good or bad?
>
>>       0.98 =C4=85 20%      +0.7        1.64 =C4=85 38%  perf-profile.cal=
ltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x=
64_sys_openat
>>       2.12 =C4=85 19%      +0.8        2.96 =C4=85 13%  perf-profile.cal=
ltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_=
page_fault
>>       2.35 =C4=85 13%      +0.9        3.28 =C4=85 13%  perf-profile.cal=
ltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_p=
age_fault.asm_exc_page_fault
>>       0.14 =C4=85 74%      +0.4        0.55 =C4=85 32%  perf-profile.chi=
ldren.cycles-pp.do_task_dead
>>       0.04 =C4=85223%      +0.4        0.47 =C4=85 49%  perf-profile.chi=
ldren.cycles-pp.__mmdrop
>
> Also how should I interpret the above perf-profiles?

It appears that the changes of handle_mm_fault() and __mmdrop() are
related to the code of the commit?  That is, for this specific workloads
(not so unpractical), the operations become slower?

Best Regards,
Huang, Ying
