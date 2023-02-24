Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07AA96A21E1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 19:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjBXS65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 13:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjBXS6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 13:58:55 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA901B2D5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 10:58:54 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536bbaeceeaso2644627b3.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 10:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8eyNjfwQBa7qLFsUu3bNYeTJLQHqdWa7casCsIOp2RI=;
        b=SzvTDJrrScZV4TBTvzgyM+LouwGgypUKGGsGW/TbVp60IWUa1NjVp70moEMh8L+wlv
         ot6Zj4qfJ/qaroOWOWo9uFqvoAxz/UN0rxDm1diqqKC2IRNZRtIS6MD8aFtK57o9cmFb
         SPjVw2jpiMexZeRyZm9tDPLzZ/XtaFMPodVICUs0e+4GTfDc2DzOWFeXqgtGaWxPHZUl
         F96P53A9KfA4kDw6QD14PCR0rwUXHL3bJ3o50Cr/DDMV3Z7JGwQI+UtkEaWj5YKm6Nzz
         centoG0WRU0X6x2dSVU/u5MXhFWtDAaBnipEnBcWFSVam0mLdSqPr9O93d7y9DniBkfh
         h/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8eyNjfwQBa7qLFsUu3bNYeTJLQHqdWa7casCsIOp2RI=;
        b=BUKzKPWFCp5K3KiBBGdxwc70e9Fumdph9L5CqefRYZp1MMXQin0AaFSPuBiGreZV1J
         v7cmXPW6qZ81YCHcAGo+tKQPSITU5MUpcHt54FsPg6TI/iQ2aqRwICAlc8F1K4EF93tu
         Vh7SXqqM1b1QEdZatewHgJjVfDK2yfMgyRw3ZezXqZjXvLwibHZrgVEuz4FOMi2M6eVq
         1smie561GbKugqd1KDU/rCvfOlHFHW/u/B/uuoIh7uX2XFy55aAzsh5XnT7DZAxFVh+D
         6PIJ7UwY4R5vxI22k9QK5H3gMLGq0DEmWpmZO5vYtirk8oUqvcmfBVCHHBGxe5P6eMlA
         Nt3g==
X-Gm-Message-State: AO0yUKW8kB9ew8gl6qSDJg8Jo6RZ3u63hqish5rre1ewQ9P3X9hyJYKm
        TR3HPkn2LA+xyukF2oE1USlk14SMCgg=
X-Google-Smtp-Source: AK7set+fB1FfnV7TXXPKAJPp2lud32TvUcgHqwB/gdL19Z9Bb0IlPQP9AAU24+i2w2pIC0sUcgq8CUX3kuE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a5b:a10:0:b0:97c:863e:6d91 with SMTP id
 k16-20020a5b0a10000000b0097c863e6d91mr819065ybq.227.1677265133190; Fri, 24
 Feb 2023 10:58:53 -0800 (PST)
Date:   Fri, 24 Feb 2023 10:58:51 -0800
In-Reply-To: <7b6d4c14-ebde-1bc3-04de-59cae9d4b7be@quicinc.com>
Mime-Version: 1.0
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212417.3315422-1-quic_eberman@quicinc.com> <CA+EHjTxEeiBWXJMCnv0V+5n=jB8w=m0EFdgK=FKtSqKOkiaChg@mail.gmail.com>
 <7b6d4c14-ebde-1bc3-04de-59cae9d4b7be@quicinc.com>
Message-ID: <Y/kI66qQFJJ6bkTq@google.com>
Subject: Re: [PATCH v10 12/26] gunyah: vm_mgr: Add/remove user memory regions
From:   Sean Christopherson <seanjc@google.com>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Fuad Tabba <tabba@google.com>, Alex Elder <elder@linaro.org>,
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
        Quentin Perret <qperret@google.com>,
        Will Deacon <will@kernel.org>,
        "smoreland@google.com" <smoreland@google.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023, Elliot Berman wrote:
> 
> 
> On 2/24/2023 2:19 AM, Fuad Tabba wrote:
> > Hi,
> > 
> > On Tue, Feb 14, 2023 at 9:26 PM Elliot Berman <quic_eberman@quicinc.com> wrote:
> > > 
> > > 
> > > When launching a virtual machine, Gunyah userspace allocates memory for
> > > the guest and informs Gunyah about these memory regions through
> > > SET_USER_MEMORY_REGION ioctl.
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
> investigate how/if it can suit Gunyah usecases.

Can you provide Gunyah's requirements/rules and use cases as they relate to memory
management?  I agree with Fuad, this is pretty much exactly what memfd_restricted()
is intended to handle.  If Gunyah has a unique requirement or use case, it'd be
helpful to find out sooner than later.  E.g.

  1. What is the state of memory when it's accepted by a VM?  Is it undefined,
     i.e. the VM's responsibility to initialize?  If not, is it always
     zero-initialized or can memory be populated by the RM?

  2. When exclusive/private memory is reclaimed, can the VM's data be preserved,
     or is it unconditionally

  3. How frequently is memory transition allocated/reclaimed?

  4. Are there assumptions and/or limitations on the size or granlarity of
     memory objects?

  5. Can memory be shared by multiple VMs but _not_ be accessible from the RM?

  6. etc. :-)

Thanks!
