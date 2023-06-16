Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BD7733331
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbjFPOKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345546AbjFPOKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:10:03 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36B82720
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 07:10:02 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-43de86a069fso217530137.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 07:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686924602; x=1689516602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UG/iG1PP3VNbKBwZi98yGZ3Q4NgI6Gz0Wj5eZD3quA=;
        b=4mz4fQHxunRllolc/a4/JUKfBDYsgE6Pk9GbP+mJbTRDox331R06d3oF+9cfnFBN1C
         YQlL92eq5vXzbvreNR89PsMAcy7JfnGhqs5iOlyTUy0mQ6ULdEC5xNMhTBzJStJeOBwh
         KmLL7Pa+3iNd7sdkonM2t5Ic3B5xCxkZsQB4HXPKarzYNwK+8M65yDYqvOI5LrWo9KNl
         KMjPjZMIVQwsaxkTnPh1tiLbg5SBlt8DuCRB0EZmjuZdyLPAAJt6eg9EA+SXgiuEK8CA
         u9BMt4rd3ZloTzh/C4N56QrFJdPaJvliwnB/a7EotYuOlFD5mueIRnKBg4zgzbyrCoxM
         +bDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686924602; x=1689516602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0UG/iG1PP3VNbKBwZi98yGZ3Q4NgI6Gz0Wj5eZD3quA=;
        b=CjhADB73kyr1fypaEwwvgsbMkS7ITewGURYC+OS7Hls8798E4wN0BBfkcpMBp16qRV
         BHjReLQ5Fs93bWfXUPt8zt9A8TlArn3OOvEYN1wGv1nvXbDmLR6rDME8Ou1hFB0gmv0Y
         uP7sDjfCPQYOCT6HaniHZdi98l2oKpdiT+0JWS3R48X63XRC7yCIo2qQe4JDoAAWDX/g
         yy7OFlKkILlMf8exBu7gS3HISoS/JuoORqoFKKWVszL4nd2Rvnhvk0BWVWZGzbYDv3Hu
         BysxTcye33RR6MI44QBPWek/5bs1vN1HjWBLDBBmLHYg2s2oLB6T6JRvSxOP8ZhFJL1E
         AGgw==
X-Gm-Message-State: AC+VfDyhCHHEMT2wkWwhf2Le9i943ZVFQn2LOSqle9yPdJJJ3oqZvqIz
        vg5FxGq9mcChDnnPg4P6mkvO/DKvGTp3vwmitLiMrw==
X-Google-Smtp-Source: ACHHUZ4YeKHrxTY2/2Olc1L4hzuMRn/MfTdbY/qdTIZGERtkOW3HPCFKITqBbDBpQE0mIMl/r7/Yibv+qEWH9+xCU/c=
X-Received: by 2002:a67:e9d5:0:b0:440:9ab7:e2fb with SMTP id
 q21-20020a67e9d5000000b004409ab7e2fbmr406809vso.6.1686924601531; Fri, 16 Jun
 2023 07:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230612164727.3935657-1-carlos.bilbao@amd.com>
 <ZIihRqZljMaMRGcK@google.com> <DM8PR11MB5750D16B08B769173DCD740AE75AA@DM8PR11MB5750.namprd11.prod.outlook.com>
 <ZInLlkXsgnej9ZpT@google.com> <001aa2ed-2f78-4361-451d-e31a4d4abaa0@semihalf.com>
 <ZIxqAXhy1tCVpzz7@google.com>
In-Reply-To: <ZIxqAXhy1tCVpzz7@google.com>
From:   Allen Webb <allenwebb@google.com>
Date:   Fri, 16 Jun 2023 09:09:50 -0500
Message-ID: <CAJzde06TP5D1UAko6tJmdPt-0Ja4cnByWEDF0c6KJ4k__WjODg@mail.gmail.com>
Subject: Re: [PATCH v2] docs: security: Confidential computing intro and
 threat model for x86 virtualization
To:     Sean Christopherson <seanjc@google.com>
Cc:     Dmytro Maluka <dmy@semihalf.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        Jason CJ Chen <jason.cj.chen@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "kraxel@redhat.com" <kraxel@redhat.com>,
        "dovmurik@linux.ibm.com" <dovmurik@linux.ibm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
        "michael.day@amd.com" <michael.day@amd.com>,
        "pavankumar.paluri@amd.com" <pavankumar.paluri@amd.com>,
        "David.Kaplan@amd.com" <David.Kaplan@amd.com>,
        "Reshma.Lal@amd.com" <Reshma.Lal@amd.com>,
        "Jeremy.Powell@amd.com" <Jeremy.Powell@amd.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dgilbert@redhat.com" <dgilbert@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dinechin@redhat.com" <dinechin@redhat.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "berrange@redhat.com" <berrange@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>, "tytso@mit.edu" <tytso@mit.edu>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "richard.weinberger@gmail.com" <richard.weinberger@gmail.com>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "cdupontd@redhat.com" <cdupontd@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "sameo@rivosinc.com" <sameo@rivosinc.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "security@kernel.org" <security@kernel.org>,
        Larry Dewey <larry.dewey@amd.com>, android-kvm@google.com,
        Dmitry Torokhov <dtor@google.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Patryk Duda <pdk@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 8:56=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Fri, Jun 16, 2023, Dmytro Maluka wrote:
> > On 6/14/23 16:15, Sean Christopherson wrote:
> > > On Wed, Jun 14, 2023, Elena Reshetova wrote:
> > >> Not having a network access requirement doesn=E2=80=99t implicitly i=
nvalidate the
> > >> separation guarantees between the host and guest, it just makes it e=
asier
> > >> since you have one interface less between the host and guest.
> > >
> > > My point is that if the protected guest doesn't need any I/O beyond t=
he hardware
> > > device that it accesses, then the threat model is different because m=
any of the
> > > new/novel attack surfaces that come with the TDX/SNP threat model don=
't exist.
> > > E.g. the hardening that people want to do for VirtIO drivers may not =
be at all
> > > relevant to pKVM.
>
> ...
>
> > But I think I get what you mean: there is no data transfer whereby the
> > host is not an endpoint but an intermediary between the guest and some
> > device. In simple words, things like virtio-net or virtio-blk are out o=
f
> > scope. Yes, I think that's correct for pKVM-on-x86 use cases (and I
> > suppose it is correct for pKVM-on-ARM use cases as well). I guess it
> > means that "guest data attacks" may not be relevant to pKVM, and perhap=
s
> > this makes its threat model substantially different from cloud use
> > cases.
>
> Yes.
>
> > >>>> +This new type of adversary may be viewed as a more powerful type
> > >>>> +of external attacker, as it resides locally on the same physical =
machine
> > >>>> +-in contrast to a remote network attacker- and has control over t=
he guest
> > >>>> +kernel communication with most of the HW::
> > >>>
> > >>> IIUC, this last statement doesn't hold true for the pKVM on x86 use=
 case, which
> > >>> specifically aims to give a "guest" exclusive access to hardware re=
sources.
> > >>
> > >> Does it hold for *all* HW resources? If yes, indeed this would make =
pKVM on
> > >> x86 considerably different.
> > >
> > > Heh, the original says "most", so it doesn't have to hold for all har=
dware resources,
> > > just a simple majority.
> >
> > Again, pedantic mode on, I find it difficult to agree with the wording
> > that the guest owns "most of" the HW resources it uses. It controls the
> > data communication with its hardware device, but other resources (e.g.
> > CPU time, interrupts, timers, PCI config space, ACPI) are owned by the
> > host and virtualized by it for the guest.
>
> I wasn't saying that the guest owns most resources, I was saying that the=
 *untrusted*
> host does *not* own most resources that are exposed to the guest.  My und=
erstanding
> is that everything in your list is owned by the trusted hypervisor in the=
 pKVM model.
>
> What I was pointing out is related to the above discussion about the gues=
t needing
> access to hardware that is effectively owned by the untrusted host, e.g. =
network
> access.

The network case isn't a great example because it is common for user
space applications not to trust the network and to use verification
schemes like TLS where trust of the network is not required, so the
trusted guest could use these strategies when needed. There wouldn't
be any availability guarantees, but my understanding is that isn't in
scope for pKVM.

In the case where the host owns a TPM and the guest has to cooperate
with the host to communicate with the TPM. There are schemes for
establishing trust between the TPM and the trusted guest with various
properties (authentication, confidentiality, integrity, etc.). This
does have the downside of additional complexity, but comes with the
benefit of also being resistant to attacks like monitoring the SPI
lines going to the TPM.

Did you have particular situations in mind for resources that would be
owned by the host and needed by the trusted guest?
