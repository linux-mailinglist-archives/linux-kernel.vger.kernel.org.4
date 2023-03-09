Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E016A6B25A5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 14:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjCINld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 08:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjCINlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:41:25 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D500EBFB9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 05:41:20 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id l18so1952936qtp.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 05:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678369279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBMSX2KT9iI5bYFvSfRGZ4nhqkOnFbPkFmBkYXNQFu4=;
        b=CjZnKGVS3gGygHDnjUx9neJcap1uCgWBxvXNsoVc/MOJTqnu5T9A9DQ4HOCywJRWW1
         zq9yLOsImhAJ15Qad/Xpxi7X6jvcAYHXv/20Mn48lYjRv+nXFbyrMNg6fYB9oTLHNejo
         zgY0aFJUhlx8H2F/XP0XujTTsFJDSrn21OCyp/de4EM6OuCDoBdYA59hW+V5H+rBswl2
         UlKfeOqshVwcPb1DjsBwAEY0zZ41PkpsyqrkC6qcTf4k7O0QgfjRYbY39Cry2wge+Acc
         llEmKAqG0Ez+4WzmoQxc07dw9MOwC+HqV6+oSHXOiIGQYUis6GEX9xXpK8a64HpPORYu
         YC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678369279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rBMSX2KT9iI5bYFvSfRGZ4nhqkOnFbPkFmBkYXNQFu4=;
        b=bj8nQpOt9Gy5FZGa3uZR/kwdvkScL/Kx5nYRHQ5QeM6j0q7LwwZ0h2D0MaQflTE9kN
         DxfuYY0JLi3yE/YOC3hN+gGg7by75mSsEeSalHjVZwmaHXRrEKSrz8vz5Qakwb9tYzhP
         +nRto+zPmt0P2M1MbUKmMkCF6II1pJ5V/cJ0kZYcGkyvV3NStEQeaS+X4nvxmZgZSSBL
         /kD+OfoXiiFtusNGYEro09ZeAzhMeZpX8PxM+4jLrhv/C+BwxsHhahCh7JFLi6abNtKs
         eKMft8/XvNbHJzgzz4Dw78xRipptJcIiuRjegNb9BcWYcRYt2oO5Shk74+MuSVcslSnc
         gxuA==
X-Gm-Message-State: AO0yUKXxrbbsdzD9bLzm8sGwjOE2s6GvIzHaO32+EdZ7phOhmtqIDm6a
        VYo7H1Hmysd8xK6w9DUKlZkbAR7Y8F2V0JUbss651A==
X-Google-Smtp-Source: AK7set+NOfZnOGi5ixVViiFopcY/3havE855p1RMZb9y67AWdALj1OBYoN8QN4pqtB2GXDgA8O2590ZsFhV9YDkpEzE=
X-Received: by 2002:ac8:6103:0:b0:3bf:dd4c:1fcc with SMTP id
 a3-20020ac86103000000b003bfdd4c1fccmr6679009qtm.9.1678369279031; Thu, 09 Mar
 2023 05:41:19 -0800 (PST)
MIME-Version: 1.0
References: <20230113175459.14825-1-james.morse@arm.com> <20230113175459.14825-10-james.morse@arm.com>
 <CALPaoCg4T52ju5XJC-BVX-EuZUtc67LruWbgyH5s8CoiEwOUPw@mail.gmail.com>
 <c3ca6d66-e58c-8ace-e88e-45ded5de836f@arm.com> <CALPaoCik0j7ATCv-He5HWVqbL+3njpqO1fhF5FQJO7qqT1zR3w@mail.gmail.com>
 <c8d85eae-e291-99a6-509c-94c41514ac16@arm.com>
In-Reply-To: <c8d85eae-e291-99a6-509c-94c41514ac16@arm.com>
From:   Peter Newman <peternewman@google.com>
Date:   Thu, 9 Mar 2023 14:41:08 +0100
Message-ID: <CALPaoCgEaT2oax35ezRydUZwL9bMmMFFr2wRqPe4VYAnEQ-GGg@mail.gmail.com>
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

On Wed, Mar 8, 2023 at 6:45=E2=80=AFPM James Morse <james.morse@arm.com> wr=
ote:
> On 06/03/2023 13:14, Peter Newman wrote:
> > On Mon, Mar 6, 2023 at 12:34=E2=80=AFPM James Morse <james.morse@arm.co=
m> wrote:
>
> > Instead, when configuring a counter, could you use the firmware table
> > value to compute the time when the counter will next be valid and retur=
n
> > errors on read requests received before that?
>
> The monitor might get re-allocated, re-programmed and become valid for a =
different
> PARTID+PMG in the mean time. I don't think these things should remain all=
ocated over a
> return to user-space. Without doing that I don't see how we can return-ea=
rly and make
> progress.
>
> How long should a CSU monitor remain allocated to a PARTID+PMG? Currently=
 its only for the
> duration of the read() syscall on the file.
>
>
> The problem with MPAM is too much of it is optional. This particular beha=
viour is only
> valid for CSU monitors, (llc_occupancy), and then, only if your hardware =
designers didn't
> have a value to hand when the monitor is programmed, and need to do a sca=
n of the cache to
> come up with a result. The retry is only triggered if the hardware sets N=
RDY.
> This is also only necessary if there aren't enough monitors for every RMI=
D/(PARTID*PMG) to
> have its own. If there were enough, the monitors could be allocated and p=
rogrammed at
> startup, and the whole thing becomes cheaper to access.
>
> If a hardware platform needs time to do this, it has to come from somewhe=
re. I don't think
> maintaining an epoch based list of which monitor secretly belongs to a PA=
RTID+PMG in the
> hope user-space reads the file again 'quickly enough' is going to be main=
tainable.
>
> If returning errors early is an important use-case, I can suggest ensurin=
g the MPAM driver
> allocates CSU monitors up-front if there are enough (today it only does t=
his for MBWU
> monitors). We then have to hope that folk who care about this also build =
hardware
> platforms with enough monitors.

Thanks, this makes more sense now. Since CSU data isn't cumulative, I
see how synchronously collecting a snapshot is useful in this situation.
I was more concerned about understanding the need for the new behavior
than getting errors back quickly.

However, I do want to be sure that MBWU counters will never be silently
deallocated because we will never be able to trust the data unless we
know that the counter has been watching the group's tasks for the
entirety of the measurement window.

Unlike on AMD, MPAM allows software to control which PARTID+PMG the
monitoring hardware is watching. Could we instead make the user
explicitly request the mbm_{total,local}_bytes events be allocated to
monitoring groups after creating them? Or even just allocating the
events on monitoring group creation only when they're available could
also be marginably usable if a single user agent is managing rdtgroups.

Thanks!
-Peter
