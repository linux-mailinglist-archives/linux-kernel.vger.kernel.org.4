Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004286C62E7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjCWJJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjCWJJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:09:21 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6D276B8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 02:09:19 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id x1so25753345qtr.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 02:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679562558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByZB1dfpBLtRSxR4wsct9Rq4cdr9+sGmdoakL+D6enU=;
        b=iN4k2v093EH2wRtAGHgKQHcyCb0UcLnGPIRyMhAJ7F7+eR6HqMaOd7shNGBW+Dy+Qb
         L03DkTJZcB3APXNEHS0LEJPsHIO/yiJl3FhxvUfav1mD04iy10MsuDdxO+Cr+8+zH5Qn
         SWRKeSnim0idtWVYh4B6ttEIqldnquUCRsAG6SKdzmzj6LZy5a+yKFxReA2rtHkvmS+T
         c4Uirl5eERJAhUF/iCpamCSf4VaYC0sLGUk+gCNStDAZOxnJyzVgzOOMr08sUf+0vrpe
         pWutZQ3YTMhkP/crDSILGU9x2kTHEWeewATPFS0xMaovrLUO5gbSBHCWafgh7aNFc368
         zOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679562558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ByZB1dfpBLtRSxR4wsct9Rq4cdr9+sGmdoakL+D6enU=;
        b=sbl7sh9P29uY5Fl5UgNt2hb9iHCmWas0L06++9T7Vxg/iMPZkkt1tk6W3/n997h1t+
         3GTVGHGF4DSttOqr66omX6GrJ7B7lVB0dfuMbigCdkKay3OJzW+XfAQrxRcbQ+XdbXYt
         0rPYfvAlgcnlszjDFdIy1YyKF1uAws6FbOXCdEfWpCRmifFdHW4ma9BC9O5vJXXIKjHv
         3+sGo7pVIaGWDNiqCz2rZyqRsKH2D4vSd6W7C+H245Qs1gdphIFi5+q+IH/tzhlb1Mwv
         iLwGCjhZ5HSPybmWCXoo0z1+5VDC13jCs3MnVlKKrt//fRIrpDRuImE5ysGapAeeMZJL
         lSbw==
X-Gm-Message-State: AO0yUKUQcNYFRsOAy71S9QnALwr8l62bbU2WcVkbNHm+5ymcrxblQk1g
        l99KFYto/cZPVCef9SR7dsg90IlAPgHK4lB/tK+xxw==
X-Google-Smtp-Source: AK7set/+4ywgAlTaCsgGxm3/dod0QQalCnShIMRyRvo4q8aAl8ElohRI3/lqce8EiFR3wqz50KK5uuSf+M/eAmK8KvQ=
X-Received: by 2002:a05:622a:2c1:b0:3e0:755f:c0e5 with SMTP id
 a1-20020a05622a02c100b003e0755fc0e5mr2323439qtx.9.1679562558382; Thu, 23 Mar
 2023 02:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230320172620.18254-1-james.morse@arm.com> <20230320172620.18254-10-james.morse@arm.com>
 <CALPaoCgXYBphe+toVBmF6eGKz8sCHYsaTvvd5ZnrJBf07tjbzg@mail.gmail.com>
In-Reply-To: <CALPaoCgXYBphe+toVBmF6eGKz8sCHYsaTvvd5ZnrJBf07tjbzg@mail.gmail.com>
From:   Peter Newman <peternewman@google.com>
Date:   Thu, 23 Mar 2023 10:09:07 +0100
Message-ID: <CALPaoCgnHYwpyVy_aPafPm6-v+DqirXSbVBLP_wx6jEp8pNBOA@mail.gmail.com>
Subject: Re: [PATCH v3 09/19] x86/resctrl: Queue mon_event_read() instead of
 sending an IPI
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
        Xin Hao <xhao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 3:07=E2=80=AFPM Peter Newman <peternewman@google.co=
m> wrote:
> On Mon, Mar 20, 2023 at 6:27=E2=80=AFPM James Morse <james.morse@arm.com>=
 wrote:
> >
> > x86 is blessed with an abundance of monitors, one per RMID, that can be
>
> As I explained earlier, this is not the case on AMD.
>
> > read from any CPU in the domain. MPAMs monitors reside in the MMIO MSC,
> > the number implemented is up to the manufacturer. This means when there=
 are
> > fewer monitors than needed, they need to be allocated and freed.
> >
> > Worse, the domain may be broken up into slices, and the MMIO accesses
> > for each slice may need performing from different CPUs.
> >
> > These two details mean MPAMs monitor code needs to be able to sleep, an=
d
> > IPI another CPU in the domain to read from a resource that has been sli=
ced.
>
> This doesn't sound very convincing. Could mon_event_read() IPI all the
> CPUs in the domain? (after waiting to allocate and install monitors
> when necessary?)

No wait, I know that isn't correct.

As you explained it, the remote CPU needs to sleep because it may need
to atomically acquire, install, and read a CSU monitor.

It still seems possible for the mon_event_read() thread to do all the
waiting (tell remote CPU to program CSU monitor, wait, tell same remote
CPU to read monitor), but that sounds like more work that I don't see a
lot of benefit to doing today.

Can you update the changelog to just say the remote CPU needs to block
when installing a CSU monitor?

Thanks!
-Peter
