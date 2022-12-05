Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A44642E85
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 18:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiLERTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 12:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbiLERSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 12:18:48 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066BD205EE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 09:18:40 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id c140so15286837ybf.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 09:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/Nonq3ctTs1UWfb6KWW7MIlmF7kFHhRG27VQydMtVk=;
        b=lFSZfm4kDAFsl8Bae1pr7+oePLNotDcRIIDlIY5J8R4O0WC0aEVF0wcgS5RWNmniso
         txXy+BNgs9f8iTbaG5ahYH79+AdjemxKo5xKnqmnLh/vAsqi92wfqhVk6KgKrnzEu200
         sK66uLMEezea15MPVJg+y47XZbPzcLTme3ywb/HGqTxWuSEGIkt1Zw7oH2FAEygSQRbY
         ZJXPCPxAh3Ed+nxSir+x09p8Pejz+1SKW5K92Qp6RIKYNbqwUgjD9GYeXcOLD2VcHEFG
         nwcHRySs2889m4rg93crVDccyBkbNyEq2BPvpkIRhEEmi6rRN7crHILQjVKnK0MvgLeM
         ejTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/Nonq3ctTs1UWfb6KWW7MIlmF7kFHhRG27VQydMtVk=;
        b=GqkHrlfZK9iXRm8xaYEpJQPdKVN1BG6e1ca19C7HwcMMjBnldu1vRSUJc/5fYP+CgB
         /PWCcF/ufJbmunvP4phHolf3KsMtJkdD0JQyprtPHK82KkuJY4N2c8k6utfr6T5zuDb1
         TvWrHcMQz/6w6YkOQjdQ2Ox1rU9VJh3Tde3qrheToYvvCdP1qUj65uZqmX5Q6N1+CtOR
         yVZXzFrb0kYDaAGEU/KjhCPvaD8thUu6cawrWbVrgQAU4r2gv8OgMtzFN2TnlOpwNbMx
         fsKnejSDYm97Q+2F/tThQiCJk09yL0UoSsQU+Z+U5W01VFC7cOMCaGG5UlHz4sYEQvbI
         4QKg==
X-Gm-Message-State: ANoB5pl49CvRdDuNlFeZB5jCUIA+6niU5PuIYBYOb99wxKcKgiXg+lkk
        Cj+efsHdX/YMqiXTGe45j+W5vDuHCT1dk6VcKBmv1Q==
X-Google-Smtp-Source: AA0mqf4WwhfDj4SfV0gayow9/xNOHxtZYvzoJMotYVfsb0rBXTMBhrwctNTPhYy7zkevJoo6TTUBFkTVlmi+HMGTjjc=
X-Received: by 2002:a5b:841:0:b0:6e5:92af:5731 with SMTP id
 v1-20020a5b0841000000b006e592af5731mr59525430ybq.228.1670260719051; Mon, 05
 Dec 2022 09:18:39 -0800 (PST)
MIME-Version: 1.0
References: <202212051324.182a6363-yujie.liu@intel.com>
In-Reply-To: <202212051324.182a6363-yujie.liu@intel.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 5 Dec 2022 09:18:28 -0800
Message-ID: <CALvZod4CD+O7-ynGAHU-6vxE6CbSmuQei1=SVJsx0zFfQdmV2g@mail.gmail.com>
Subject: Re: [linux-next:master] [mm] f1a7941243: unixbench.score -5.1% regression
To:     kernel test robot <yujie.liu@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 4, 2022 at 9:56 PM kernel test robot <yujie.liu@intel.com> wrot=
e:
>
> Greeting,
>
> FYI, we noticed a -5.1% regression of unixbench.score due to commit:
>
[...]
> 9cd6ffa60256e931 f1a7941243c102a44e8847e3b94
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>       7917            -5.1%       7509        unixbench.score

What is unixbench.score?

>      10485           -12.1%       9216        unixbench.time.maximum_resi=
dent_set_size
>   37236706            -5.1%   35324104        unixbench.time.minor_page_f=
aults

For above two, is negative change good or bad?

>       0.98 =C4=85 20%      +0.7        1.64 =C4=85 38%  perf-profile.call=
trace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x6=
4_sys_openat
>       2.12 =C4=85 19%      +0.8        2.96 =C4=85 13%  perf-profile.call=
trace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_p=
age_fault
>       2.35 =C4=85 13%      +0.9        3.28 =C4=85 13%  perf-profile.call=
trace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_pa=
ge_fault.asm_exc_page_fault
>       0.14 =C4=85 74%      +0.4        0.55 =C4=85 32%  perf-profile.chil=
dren.cycles-pp.do_task_dead
>       0.04 =C4=85223%      +0.4        0.47 =C4=85 49%  perf-profile.chil=
dren.cycles-pp.__mmdrop

Also how should I interpret the above perf-profiles?
