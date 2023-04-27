Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CFA6F0C4A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 21:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244644AbjD0THH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 15:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244649AbjD0THE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 15:07:04 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D034C10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 12:06:54 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4efea87c578so15435e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 12:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682622412; x=1685214412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfDiRfSq+kC18iemI6FYmlOcxjBiiknnRlI3qG2uuas=;
        b=k0072J0dHqpJdFyGK8SUJ1Su9/HrBnV3NUsDVqoiWls1qAJ+eYsHWFpvb6DIyvoIPH
         eANWr9j4w47SGDA4u1bzYV6u4joJhikZCjg4FUbwaKOEf0zOCNbinpuiS+X3iZr8bO4o
         txKXL+8pMS1bVy6XMwJyt5G4+j6mcyqRPUF9wj1cryCL6jIuC7X6OIUWqMOtHblLffsE
         /O/TyxMyAV0ySb95Bm6K/2X9ivi++j49/VSVqje4tBOomP2eB5H4CWIyg+qRB/0uRkW0
         Hhbd+Inbl7cH6dAbwoHlqfQ5uPSH5B8Ezd+4rxFgbYo/ky9YFjDdgsKAuXpOOU7eA2ZA
         Bstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682622412; x=1685214412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nfDiRfSq+kC18iemI6FYmlOcxjBiiknnRlI3qG2uuas=;
        b=BugEDCaCzdjg9/2XPVSZkxuOiDNtAh/kPbNfxKmnHU2Hr4dG4Hlqi9IHklseDTIxOK
         yaCA5YJobdptpNkV8E8OD2jN408cm+Mb+5YJk7h03wOY/i7s/roFarXUc1meZLonnSol
         Cwt6uowRdUqKiKGqSj1NrWT0UuRQ0D91n4YFi7S8hG40jYKkAatKMPa51utWKsMrNlRQ
         OoCzpYZCs+uEKJMcwleJU1TVe2A5MsvXPFVEkSJMirf/t8fNoLhlAFDQ5xGuGxhTQsi7
         CiwDUiq/IWtjflqKwQCoYZtSppsRvktJ3dPfmCwd+UmMU8rSWcfczrV2EytF9ApAdEsK
         kL1Q==
X-Gm-Message-State: AC+VfDy+8djAh4wMczETmW7n+QX5UhTCRGPM1ZlQ4HiMiQGa3p7kvXMs
        sQCbth4EI5tXJnLfEDPTgWq1Hfjk4S5h20Ym8Icaig==
X-Google-Smtp-Source: ACHHUZ5j+pXf+5i7NcphWrWByfvB5zpI3mjciiWsZng4ArLF+Re+VVSlU9YtHjQbqBbFSMJtKCe1DMDIOfJ6fKYJpAM=
X-Received: by 2002:a05:6512:ea7:b0:4ea:e5e2:c893 with SMTP id
 bi39-20020a0565120ea700b004eae5e2c893mr20014lfb.1.1682622412005; Thu, 27 Apr
 2023 12:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230327141816.2648615-1-carlos.bilbao@amd.com>
 <ZEfrjtgGgm1lpadq@google.com> <da1c807e-66b7-7e9f-143d-44b6f7389b50@intel.com>
 <ZElLUMDhIZPoG87K@google.com>
In-Reply-To: <ZElLUMDhIZPoG87K@google.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Thu, 27 Apr 2023 13:06:39 -0600
Message-ID: <CAMkAt6qrrxkFEmsa_Df_PKo8pL7g4MhmkXFGQ19KZ-eqcqA61w@mail.gmail.com>
Subject: Re: [PATCH] docs: security: Confidential computing intro and threat model
To:     Sean Christopherson <seanjc@google.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Carlos Bilbao <carlos.bilbao@amd.com>, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ardb@kernel.org, kraxel@redhat.com, dovmurik@linux.ibm.com,
        elena.reshetova@intel.com, dave.hansen@linux.intel.com,
        Dhaval.Giani@amd.com, michael.day@amd.com,
        pavankumar.paluri@amd.com, David.Kaplan@amd.com,
        Reshma.Lal@amd.com, Jeremy.Powell@amd.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        alexander.shishkin@linux.intel.com, thomas.lendacky@amd.com,
        tglx@linutronix.de, dgilbert@redhat.com,
        gregkh@linuxfoundation.org, dinechin@redhat.com,
        linux-coco@lists.linux.dev, berrange@redhat.com, mst@redhat.com,
        tytso@mit.edu, jikos@kernel.org, joro@8bytes.org, leon@kernel.org,
        richard.weinberger@gmail.com, lukas@wunner.de, jejb@linux.ibm.com,
        cdupontd@redhat.com, jasowang@redhat.com, sameo@rivosinc.com,
        bp@alien8.de, security@kernel.org
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

On Wed, Apr 26, 2023 at 10:03=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Wed, Apr 26, 2023, Dave Hansen wrote:
> > On 4/25/23 08:02, Sean Christopherson wrote:
> > >> +While the traditional hypervisor has unlimited access to guest data=
 and
> > >> +can leverage this access to attack the guest, the CoCo systems miti=
gate
> > >> +such attacks by adding security features like guest data confidenti=
ality
> > >> +and integrity protection. This threat model assumes that those feat=
ures
> > >> +are available and intact.
> > > Again, if you're claiming integrity is a key tenant, then SEV and SEV=
-ES can't be
> > > considered CoCo.
> >
> > This document is clearly trying to draw a line in the sand and say:
> >
> >       CoCo on one side, non-CoCo on the other
> >
> > I think it's less important to name that line than it is to realize wha=
t
> > we need to do on one side versus the other.
> >
> > For instance, if the system doesn't have strong guest memory
> > confidentiality protection, then it's kinda silly to talk about the
> > guest's need to defend against "CoCo guest data attacks".
> >
> > Sure, the mitigations for "CoCo guest data attacks" are pretty sane eve=
n
> > without all this CoCo jazz. But if your goal is to mitigate damage that
> > a VMM out of the TCB can do, then they don't do much if there isn't
> > VMM->guest memory confidentiality in the first place.
> >
> > So, sure, CoCo implementations exist along a continuum.  SGX is in ther=
e
> > (with and without integrity protection), as are SEV=3D>SEV-ES=3D>SEV an=
d
> > MKTME=3D>TDX.
> >
> > This document is making the case that the kernel should go to some new
> > (and extraordinary) lengths to defend itself against ... something.
>
> Then name the document something other than confidential-computing.rst, e=
.g.
> tdx-and-snp-threat-model.rst.  Because this doc isn't remotely close to a=
chieving
> its stated goal of providing an "architecture-agnostic introduction ... t=
o help
> developers gain a foundational understanding of the subject".  IMO, it do=
es more
> harm than good on that front because it presents Intel's and AMD's viewpo=
ints as
> if they are widely accepted for all of CoCo, and that is just flagrantly =
false.

I think changing this document to what Dave is describing is a more
useful doc rather than tdx-and-snp-threat-model.rst. The tdx and snp
threat models are well described by their respective white papers.

Lets do as Dave suggests and "not quibble about where CoCo starts or
ends", but make some definition of CoCo and its overall goals that way
we can start executing on kernel improvements to match those goals.
