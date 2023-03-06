Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49CA6AC088
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjCFNPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjCFNPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:15:06 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7462A153
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 05:14:45 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id c200so3115992qke.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 05:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678108484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mu1V5ydNYkFDja9gdo3UxaY36KT+L6ksIVYOziOfEH0=;
        b=Zg0iww3a8X07I7zja7X2Z/1w7BTxHzwiipcx8eKAE+ud/I7+zn5DKwF2RK5i45ff4b
         ZCHKQ1KStc5u1SBIV2oOvtCvqPltjRbQGAWay+K/7uyPoqRgjy3w2tLISDubgjwOMffv
         ozivGHiVjMcgs0+UySNatd1yvKIBvZsoCVcbb9Z0tgra0h5rAvV+oTWxIqKf3gOZB8T+
         ZqbDh64YmnUSJxZzLS/IHzHofSPnJfolJztEPo+72qpxPrf4K8Tr3TRedljSmgymDCrd
         G0q+m3QfsjSIWjvK20V7ykPndCZ2CR15XlIs7mdyjAg0P8fmNTB8GhEDmkXMqTNHc5cF
         q8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678108484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mu1V5ydNYkFDja9gdo3UxaY36KT+L6ksIVYOziOfEH0=;
        b=DlQTc71NhGf6O5rIYaOJDicdAr/I/HDZKX0n/7zGn9Y7X5u3ohb2Cm/G3n4AbYjUBA
         O6tGFhk+7XwLnha+P22mxj2z++ALebiraY7XWrBZNmjjfzCfZ9wInk/YGXrlJI8nCs+w
         tiD8aQnJlJaqEsLPxDWe6Whtp30Y5hbFRutHR88fNUz+zCRWmVZeC6mMwKPcEypwARCx
         hnMG2DQEIpaJoCpux9zH1jxGnp9hYUxwRK14M9sWRQDtdVj8VdaKg5Rh2eFj3HKfmAA2
         gQzT8mFYu9m+4vMT3V+TGSwmBmkOfUQEFUg/MyRxnhtI9uspJLU9pZK6DAWKi5R+pBwP
         S8hA==
X-Gm-Message-State: AO0yUKV1YVKCHzw5ExwpGpZ+zKDVMvCxJyxYgDFE+T7vowutnDI+ZMxF
        /RDKe8/Oca9rNSC5mHSj+loJuGakVgxg0+KbC2JbGg==
X-Google-Smtp-Source: AK7set8p1hfwjvvTXq5qSX5pqDJS+IK44rIirgoCh1bQeivRW10smgiuXSd46WXqa5rbfo4xpluWs5n12+eKReFmwow=
X-Received: by 2002:a05:620a:125c:b0:741:e175:ade7 with SMTP id
 a28-20020a05620a125c00b00741e175ade7mr2238933qkl.0.1678108484490; Mon, 06 Mar
 2023 05:14:44 -0800 (PST)
MIME-Version: 1.0
References: <20230113175459.14825-1-james.morse@arm.com> <20230113175459.14825-10-james.morse@arm.com>
 <CALPaoCg4T52ju5XJC-BVX-EuZUtc67LruWbgyH5s8CoiEwOUPw@mail.gmail.com> <c3ca6d66-e58c-8ace-e88e-45ded5de836f@arm.com>
In-Reply-To: <c3ca6d66-e58c-8ace-e88e-45ded5de836f@arm.com>
From:   Peter Newman <peternewman@google.com>
Date:   Mon, 6 Mar 2023 14:14:33 +0100
Message-ID: <CALPaoCik0j7ATCv-He5HWVqbL+3njpqO1fhF5FQJO7qqT1zR3w@mail.gmail.com>
Subject: Re: [PATCH v2 09/18] x86/resctrl: Allow resctrl_arch_rmid_read() to sleep
To:     James Morse <james.morse@arm.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        Stephane Eranian <eranian@google.com>
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

Hi James,

On Mon, Mar 6, 2023 at 12:34=E2=80=AFPM James Morse <james.morse@arm.com> w=
rote:
> On 23/01/2023 15:33, Peter Newman wrote:
> > On Fri, Jan 13, 2023 at 6:56 PM James Morse <james.morse@arm.com> wrote=
:
> >> MPAM's cache occupancy counters can take a little while to settle once
> >> the monitor has been configured. The maximum settling time is describe=
d
> >> to the driver via a firmware table. The value could be large enough
> >> that it makes sense to sleep.
> >
> > Would it be easier to return an error when reading the occupancy count
> > too soon after configuration? On Intel it is already normal for counter
> > reads to fail on newly-allocated RMIDs.
>
> For x86, you have as many counters as there are RMIDs, so there is no iss=
ue just accessing
> the counter.

I should have said AMD instead of Intel, because their implementations
have far fewer counters than RMIDs.

>
> With MPAM there may be as few as 1 monitor for the CSU (cache storage uti=
lisation)
> counter, which needs to be multiplexed between different PARTID to find t=
he cache
> occupancy (This works for CSU because its a stable count, it doesn't work=
 for the
> bandwidth monitors)
> On such a platform the monitor needs to be allocated and programmed befor=
e it reads a
> value for a particular PARTID/CLOSID. If you had two threads trying to re=
ad the same
> counter, they could interleave perfectly to prevent either thread managin=
g to read a value.
> The 'not ready' time is advertised in a firmware table, and the driver wi=
ll wait at most
> that long before giving up and returning an error.

Likewise, on AMD, a repeating sequence of tasks which are LRU in terms
of counter -> RMID allocation could prevent RMID event reads from ever
returning a value.

The main difference I see with MPAM is that software allocates the
counters instead of hardware, but the overall behavior sounds the same.

The part I object to is introducing the wait to the counter read because
existing software already expects an immediate error when reading a
counter too soon. To produce accurate data, these readings are usually
read at intervals of multiple seconds.

Instead, when configuring a counter, could you use the firmware table
value to compute the time when the counter will next be valid and return
errors on read requests received before that?

-Peter
