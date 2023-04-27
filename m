Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058346F0C21
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 20:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243639AbjD0SrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 14:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244617AbjD0SrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 14:47:22 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8710744A3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 11:47:20 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4edc63e066fso14309e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 11:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682621239; x=1685213239;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wip6JELstgrRrpm5rCuzpjQkrpjo14HwVjyh7pTJ+vU=;
        b=O9k7tDF9Y3pUKc/7NYlOGrwEzrRFMQ4BaLQtEBtZPgzEo8b9WoXyteDbur9yze8Yvh
         fPIz7+JuXbsV5V6y3xia++F937NdIu4ykVRZBNgi/wJ0TMLhfOPjkO3k+BnhF1+aqdo3
         qe4p21gu2WdBK16R1usVXjF1gVfxwYzk+kDEE5m7q7FF09DxSxVi2X7cMQ7rmPJlW+3u
         09DkFKuvWCh9K4ZLM0GEh1E+d7m1Xfv+vaPxUJflZO56pZd4rnM0Z8R2NK2IJBTIdp/7
         iueJhsPKCtCCntQa7k90KmDqVlFDTIrP4CslTzwccR3UOcgJ4JJ6iG/B5SHtVYa5jJrS
         ojCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682621239; x=1685213239;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wip6JELstgrRrpm5rCuzpjQkrpjo14HwVjyh7pTJ+vU=;
        b=GNlOB/OmZAFJ+sm5DwQ6BaF+42k5oYY3HxL6/SDKF++7QTgtp03Y6ISrg1WS/nrko9
         Efm9PphDxG686YsP5YqeG9F5OKz+596/GqG1MFlZhtEOmH8ymR5tO8A3WEkfU34bE4Qu
         SDAWiuVLmObJooH80xz2yQY7jjHpjj/y0PwwgePshjEmEDUcYsgV2LS3HNx5LopDykZi
         A8Q8A7SYTkr/M7H9b1fyQnnaer/AZ62B2mzI65lz7lvO5Kyk+TVwKACuKPfl785I7IWh
         0TYiO/iZKcua5hCZVZJXLrPY7RffTty8C2531+lVtg4VrGIz6KzUNSNfBC7lWIDusAs6
         RKyA==
X-Gm-Message-State: AC+VfDzn1XCSMSaAOmWbYhIa9bBR9R60i9N9dtDzNWyexeXLhMvhKvan
        V5ej5BXG8Sifcm4jOGIJSr/Ycrpr88OU/eZtwAh+5Q==
X-Google-Smtp-Source: ACHHUZ7mDTKk9IEa4gpcVK2FT9eyYyaSsg6RFbKE6nat44jZDnlq3L9rw5ZeAmNqI1z9D3uMpuWicwY76KcinJoxqCc=
X-Received: by 2002:a05:6512:b83:b0:4ed:3ca3:9856 with SMTP id
 b3-20020a0565120b8300b004ed3ca39856mr14699lfv.3.1682621238615; Thu, 27 Apr
 2023 11:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230327141816.2648615-1-carlos.bilbao@amd.com> <ZEfrjtgGgm1lpadq@google.com>
In-Reply-To: <ZEfrjtgGgm1lpadq@google.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Thu, 27 Apr 2023 12:47:06 -0600
Message-ID: <CAMkAt6ohvgj6h=jySx0684MiF7GZt_Q7AZK5uyU2PRKomg=rgw@mail.gmail.com>
Subject: Re: [PATCH] docs: security: Confidential computing intro and threat model
To:     Sean Christopherson <seanjc@google.com>
Cc:     Carlos Bilbao <carlos.bilbao@amd.com>, corbet@lwn.net,
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

>
> > +understanding of the subject.
> > +
> > +Overview and terminology
> > +========================
> > +
> > +Confidential Cloud Computing (CoCo) refers to a set of HW and SW
>
> As per Documentation/security/secrets/coco.rst and every discussion I've observed,
> CoCo is Confidential Computing.  "Cloud" is not part of the definition.  That's
> true even if this discussion is restricted to CoCo VMs, e.g. see pKVM.
>
> > +virtualization technologies that allow Cloud Service Providers (CSPs) to
>
> Again, CoCo isn't just for cloud use cases.

Agreed Cloud should not be included in the definition. pKVM may be
considered CoCo and its current usage is protecting secrets on a
single device. CoCo features could be used with-in a single
organization to add extra protection to high value secrets.

>
> > +provide stronger security guarantees to their clients (usually referred to
> > +as tenants) by excluding all the CSP's infrastructure and SW out of the
> > +tenant's Trusted Computing Base (TCB).
>
> This is inaccurate, the provider may still have software and/or hardware in the TCB.
>
> And for the cloud use case, I very, very strongly object to implying that the goal
> of CoCo is to exclude the CSP from the TCB.  Getting out of the TCB is the goal for
> _some_ CSPs, but it is not a fundamental tenant of CoCo.  This viewpoint is heavily
> tainted by Intel's and AMD's current offerings, which effectively disallow third
> party code for reasons that have nothing to do with security.
>
> https://lore.kernel.org/all/Y+aP8rHr6H3LIf%2Fc@google.com
>

How about phrasing like "CoCo allows its users to pick and choose
which pieces of software system to trust and gives the ability to
attest the state of trusted components"

Maybe some customers want to exclude or attest to the entire CSP infra
and SW. But it seems likely that customers may want to use and trust
some components of a CSP. For instance you may enable CoCo on a
workload but then trust the CSP's IAM implementation to make sure data
only enters those CoCo workloads.

>
> > +Confidential Computing threat model and security objectives
> > +===========================================================
> > +
> > +Confidential Cloud Computing adds a new type of attacker to the above list:
> > +an untrusted and potentially malicious host.
>
> I object to splattering "malicious host" everywhere.  Many people are going to
> read this and interpret "host" as "the CSP", and then make assumptions like
> "CoCo assumes the CSP is malicious!".  AIUI, the vast majority of use cases aren't
> concerned so much about "the CSP" being malicious, but rather they're concerned
> about new attack vectors that come with running code/VMs on a stack that is
> managed by a third party, on hardware that doesn't reside in a secured facility,
> etc.
>
> > +While the traditional hypervisor has unlimited access to guest data and
> > +can leverage this access to attack the guest, the CoCo systems mitigate
> > +such attacks by adding security features like guest data confidentiality
> > +and integrity protection. This threat model assumes that those features
> > +are available and intact.
>
> Again, if you're claiming integrity is a key tenant, then SEV and SEV-ES can't be
> considered CoCo.

Hmm the doc mentions "untrusted and potentially malicious host." but
seems to take the stance the CoCo requires tech where malicious host
deprivelleging is possible. But as Sean points out there may be valid
CoCo theat models where the host is trusted, or trusted to be benign
like SEV and SEV-ES.

I think this doc could use some more nuance so that less strict
threat-models are supported.

Also in regard to "malicious host" I think we can use this term since
that could be a valid threat. And in general I think cloud customers
are sophisticated enough to understand that a single lone malicious
host is far different than a malicious CSP. CSPs are in general large
organizations with many services of which VMs or "enclaves" are only a
small part.
