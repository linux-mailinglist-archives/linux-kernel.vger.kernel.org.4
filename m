Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCF76A98ED
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 14:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjCCN5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 08:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCCN5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 08:57:30 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0030661508
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 05:57:28 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v16so2406662wrn.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 05:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677851847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hrHDSk+aKQWG+5fv3AwNWB+cSl2suAJ8jLnBdEelixg=;
        b=wA0JLwiXTgP78aOg9Fy3S212QN3lFzf2xs0OkU4uR31gq+5+VXY70j7NEr2MI0kFNV
         aw799C8JRza89IaPD0o+Fs2abJDPkOBqyXasvRBRxd0f6rMlI8Ny5gNw1NpOpezNqLzA
         B0l375Z2imh4lIC0h9fvMZ8LoX3n6XaSES2/wj2PeCobmWfQDNYS7Y4kUyvxPWNYMgjW
         eWayThJDFs4mFcKfGpAJIXj/g+NjvilR1orOgShnTKWoprXtrzv95Jnv9y+vBN5qqvq8
         Hx4zUOADzcq/Z9tx/fvFnlSCgniS4bsZmRdSEGN3H+bIIgSPkYfifD4O5vUULy29Mjzm
         gtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677851847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrHDSk+aKQWG+5fv3AwNWB+cSl2suAJ8jLnBdEelixg=;
        b=SvuPg5PFJ7i/MXnbzw5RzA+NKNYW9UwmJcjpbK3iWTkb3QIg5Z0yu5Nzn72yOCLrur
         SQUmp+oOf443d2APluP0/fS7qUegT84fD5HELjT+OHZxizhxPmypPgiMErYrh/fWHjpG
         YqMXmGm+oEx9kM+auT+Q33rzNdHfiJmnP0w5oeCM/4mgavDll7U1ScLJTLqEme8qa092
         Pwh9f5W894VyVK8bPMp8e2obc/TVi0FP6bqr8fSayBGO62+yv+wj/bpAYKXeg/TAZdAQ
         kz8P4NW+RVruMNO0Wzm0BptNbwrAS04YvWVgFyUxRNHaNpKHhgtMpqvM/gXuRygyJE24
         Ll/g==
X-Gm-Message-State: AO0yUKVftosVTCmrwWCSrT8tzPYl9zU4S3GwSXOhvxxKqfKGHR0kGZ2+
        5huH/lApUkydf5JbhQ222uHWwA==
X-Google-Smtp-Source: AK7set8CZLbAGLTlPG82iW3Ddrry4HX/pR8GcNB6glVvipnsuFTiB+l0Sif0R9izgtavLnk1COykyA==
X-Received: by 2002:a5d:6545:0:b0:2c7:cc8:782c with SMTP id z5-20020a5d6545000000b002c70cc8782cmr4300861wrv.1.1677851847356;
        Fri, 03 Mar 2023 05:57:27 -0800 (PST)
Received: from myrica (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c42c600b003eb192787bfsm2445486wme.25.2023.03.03.05.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 05:57:26 -0800 (PST)
Date:   Fri, 3 Mar 2023 13:57:27 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Andrew Jones <andrew.jones@linux.dev>,
        Jean-Philippe Brucker <jpb@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Fuad Tabba <tabba@google.com>,
        James Morse <james.morse@arm.com>,
        Joey Gouly <Joey.Gouly@arm.com>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Steven Price <steven.price@arm.com>,
        Thomas Huth <thuth@redhat.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.cs.columbia.edu
Subject: Re: [RFC] Support for Arm CCA VMs on Linux
Message-ID: <20230303135727.GA473581@myrica>
References: <Y9PtKJ3Wicc19JF1@myrica>
 <CANW9uyud8RTkqgiL=64wV712QMxtAyubqeyCJ0vpcADJ42VqJA@mail.gmail.com>
 <Y/8Y3WLmiw6+Z5AS@myrica>
 <CANW9uysnvGCwANu+_6dp9+3rvHGOkThT9d0K2qpQV4exdmYWoA@mail.gmail.com>
 <20230303094618.GC361458@myrica>
 <1c91b777-982e-e71a-4829-51744e9555c5@arm.com>
 <20230303113905.GD361458@myrica>
 <20230303120800.ahtyc6et77ig4s27@orel>
 <2418536c-2658-18d6-f70c-c1af5adaa816@arm.com>
 <875ybi0ytc.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875ybi0ytc.fsf@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 02:06:07PM +0100, Cornelia Huck wrote:
> On Fri, Mar 03 2023, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> 
> > On 03/03/2023 12:08, Andrew Jones wrote:
> >> On Fri, Mar 03, 2023 at 11:39:05AM +0000, Jean-Philippe Brucker wrote:
> >>> On Fri, Mar 03, 2023 at 09:54:47AM +0000, Suzuki K Poulose wrote:
> >>>> On 03/03/2023 09:46, Jean-Philippe Brucker wrote:
> >>>>> On Thu, Mar 02, 2023 at 07:12:24AM +0900, Itaru Kitayama wrote:
> >>>>>>>> I've tried your series in Real on CCA Host, but the KVM arch init
> >>>>>>>> emits an Invalid argument error and terminates.
> >>>>>
> >>>>> This was the KVM_SET_ONE_REG for the SVE vector size. During my tests I
> >>>>> didn't enable SVE in the host but shrinkwrap enables more options.
> >>>>
> >>>> Does the Qemu check for SVE capability on /dev/kvm ? For kvmtool, we
> >>>> changed to using the VM instance and that would prevent using SVE,
> >>>> until the RMM supports it.
> >>>
> >>> Yes, QEMU does check the SVE cap on /dev/kvm. I can propose changing it or
> >>> complementing it with a VM check in my next version, it seems to work
> >>> (though I need to double-check the VM fd lifetime). Same goes for
> >>> KVM_CAP_STEAL_TIME, which I need to disable explicitly at the moment.
> >> 
> >> I'm probably missing something since I haven't looked at this, but I'm
> >> wondering what the "VM instance" check is and why it should be necessary.
> >
> > Userspace can check for a KVM_CAP_ on KVM fd (/dev/kvm) or a VM fd
> > (returned via KVM_CREATE_VM).
> >
> >> Shouldn't KVM only expose capabilities which it can provide? I.e. the
> >
> > Correct, given now that we have different "types" of VMs possible on
> > Arm64, (Normal vs Realm vs pVM), the capabilities of each of these
> > could be different and thus we should use the KVM_CAP_ on the VM fd (
> > referred to VM instance above) and not the generic KVM fd.
> 
> Using the vm ioctl is even encouraged in the doc for
> KVM_CHECK_EXTENSION:
> 
> "Based on their initialization different VMs may have different capabilities.
> It is thus encouraged to use the vm ioctl to query for capabilities"
> 
> It would probably make sense to convert QEMU to use the vm ioctl
> everywhere (the wrapper falls back to the global version on failure
> anyway.)

Indeed, I'll see if I can come up with something generic, thanks for the
pointer

Thanks,
Jean
