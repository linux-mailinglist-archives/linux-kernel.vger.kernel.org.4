Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBF76A3ED4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjB0Jzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjB0Jzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:55:50 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363E91B316
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 01:55:43 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id m6so7749577lfq.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 01:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhaELgleS6+r+Ibfx7TrEKluNYIWjG4LoxKJl7PWG5U=;
        b=Pv5L5SFIBIKlbiDrf20eyYOxXqDu4tIMuaF7OCiVWutcAYW9vA5wMU4sMuFvpKVM9P
         BRTsL77XTKS75AVm9PTrfthBrrqn9Yb1vpJUKmAmjzrwO/1QLt5RY3JR2TORrYLOn7r6
         ZWjiR0bsNpktEgaoamv5CeD50tvanAqBvDG8guLdBk9EgaQ5TpJ+DdRVffbHAWu3NF2j
         88aliUG9pEuMvv0eHAowiAagjmMqCC2oHtA7U8jriAS++fZdTmDLJtYwFgBaD08fhOHK
         xujFFMJvumRb4SBbfdzClnV6arnZBMI0Hk5Rrj+U73I7/aeeonCC550VgqJLC62mjenT
         piYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZhaELgleS6+r+Ibfx7TrEKluNYIWjG4LoxKJl7PWG5U=;
        b=IRaDBo+o6Lx5iLm1LtJYcXF1QylkyZS9Wy79mER8OVPDog1sZmcfXhxgMzjq0TaZ7O
         /9pbmDOH8JqwG9cOrD+y1ME/0vCbS6oqRIrcYIdxOQoo752zm6CdC3Ir3SgZpBO9i3ni
         kOVFxTrGBo0x3y9k+fGBIPHVyEpQ9BFej5KNSH/Hd2V2zfwfXIcA2tjazBmo4kopzgNI
         ta06yV8SagLytrao66THr3K9JhKn2Ib2F0r983zFD+yylx/ChGGctr/b3IS4i/jgPchs
         HtlA6eXnkuLjHZN4vPCeuVdhV6tVFQZUWLHUNbimrCjkbXHm5TN3jZiA3gBZALmgTQQ9
         h6xg==
X-Gm-Message-State: AO0yUKUVYnOiCy4CgauRL605WqOuuWs2kgE0D2VtsHf3DdjbQa0kE8yu
        cpgnXndQUJlqx4KDWEzDHgAEq3FNOY22DXRE937+8g==
X-Google-Smtp-Source: AK7set+eRFLwmofDycetmUw4kVPKIe20hDcCWvU1Q09bxSkaosoMqAzmXAjjIx3XbLUV25e/AgPwzszOwhyIFFWoK3k=
X-Received: by 2002:a05:6512:b10:b0:4dd:9eb6:444e with SMTP id
 w16-20020a0565120b1000b004dd9eb6444emr3712409lfu.5.1677491741277; Mon, 27 Feb
 2023 01:55:41 -0800 (PST)
MIME-Version: 1.0
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212417.3315422-1-quic_eberman@quicinc.com> <CA+EHjTxEeiBWXJMCnv0V+5n=jB8w=m0EFdgK=FKtSqKOkiaChg@mail.gmail.com>
 <7b6d4c14-ebde-1bc3-04de-59cae9d4b7be@quicinc.com>
In-Reply-To: <7b6d4c14-ebde-1bc3-04de-59cae9d4b7be@quicinc.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Mon, 27 Feb 2023 09:55:05 +0000
Message-ID: <CA+EHjTzZu4m_RGU0dbNjXhfHLRsHqnAWS24ZhL2SK0hV5M39dQ@mail.gmail.com>
Subject: Re: [PATCH v10 12/26] gunyah: vm_mgr: Add/remove user memory regions
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Quentin Perret <qperret@google.com>,
        Will Deacon <will@kernel.org>,
        "smoreland@google.com" <smoreland@google.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi,

On Fri, Feb 24, 2023 at 6:08 PM Elliot Berman <quic_eberman@quicinc.com> wrote:
>
>
>
> On 2/24/2023 2:19 AM, Fuad Tabba wrote:
> > Hi,
> >
> > On Tue, Feb 14, 2023 at 9:26 PM Elliot Berman <quic_eberman@quicinc.com> wrote:
> >>
> >>
> >> When launching a virtual machine, Gunyah userspace allocates memory for
> >> the guest and informs Gunyah about these memory regions through
> >> SET_USER_MEMORY_REGION ioctl.
> >
> > I'm working on pKVM [1], and regarding the problem of donating private
> > memory to a guest, we and others working on confidential computing
> > have faced a similar issue that this patch is trying to address. In
> > pKVM, we've initially taken an approach similar to the one here by
> > pinning the pages being donated to prevent swapping or migration [2].
> > However, we've encountered issues with this approach since the memory
> > is still mapped by the host, which could cause the system to crash on
> > an errant access.
> >
> > Instead, we've been working on adopting an fd-based restricted memory
> > approach that was initially proposed for TDX [3] and is now being
> > considered by others in the confidential computing space as well
> > (e.g., Arm CCA [4]). The basic idea is that the host manages the guest
> > memory via a file descriptor instead of a userspace address. It cannot
> > map that memory (unless explicitly shared by the guest [5]),
> > eliminating the possibility of the host trying to access private
> > memory accidentally or being tricked by a malicious actor. This is
> > based on memfd with some restrictions. It handles swapping and
> > migration by disallowing them (for now [6]), and adds a new type of
> > memory region to KVM to accommodate having an fd representing guest
> > memory.
> >
> > Although the fd-based restricted memory isn't upstream yet, we've
> > ported the latest patches to arm64 and made changes and additions to
> > make it work with pKVM, to test it and see if the solution is feasible
> > for us (it is). I wanted to mention this work in case you find it
> > useful, and in the hopes that we can all work on confidential
> > computing using the same interfaces as much as possible.
>
> Thanks for highlighting the memfd_restricted changes to us! We'll
> investigate how/if it can suit Gunyah usecases. It sounds like you
> might've made memfd_restricted changes as well? Are those posted on the
> mailing lists? Also, are example userspace (crosvm?) changes posted?

I have posted kvmtool changes to make it work with memfd_restricted
and pKVM as an RFC [1] (git [2]). I haven't posted the arm64 port, but
it's in a git repo [3]. Chao has a repository with qemu support (TDX)
as well [4].

Eventually, we're likely to have crosvm support as well. If you're
interested, I can keep you CCed on anything we post upstream.

Cheers,
/fuad

[1] https://lore.kernel.org/all/20221202174417.1310826-1-tabba@google.com/
[2] https://android-kvm.googlesource.com/kvmtool/+/refs/heads/tabba/fdmem-v10-core
[3] https://android-kvm.googlesource.com/linux/+/refs/heads/tabba/fdmem-v10-core
[4] https://github.com/chao-p/qemu/tree/privmem-v10

>
> Thanks,
> Elliot
>
> >
> > Some comments inline below...
> >
> > Cheers,
> > /fuad
> >
> > [1] https://lore.kernel.org/kvmarm/20220519134204.5379-1-will@kernel.org/
> > [2] https://lore.kernel.org/kvmarm/20220519134204.5379-34-will@kernel.org/
> > [3] https://lore.kernel.org/all/20221202061347.1070246-1-chao.p.peng@linux.intel.com/
> > [4] https://lore.kernel.org/lkml/20230127112932.38045-1-steven.price@arm.com/
> > [5] This is a modification we've done for the arm64 port, after
> > discussing it with the original authors.
> > [6] Nothing inherent in the proposal to stop migration and swapping.
> > There are some technical issues that need to be resolved.
> >
> > <snip>
> <snip, looking at comments in parallel>
