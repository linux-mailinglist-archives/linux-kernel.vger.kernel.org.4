Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477986EF814
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 18:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240794AbjDZQDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 12:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239482AbjDZQDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 12:03:34 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394374EF3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 09:03:31 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b8f4c437ce5so12379725276.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 09:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682525010; x=1685117010;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1iOXlTlBLlGt+xFnlJYCk9LyE8NZedUUmTtvF/W7cl8=;
        b=h+7lAviaHcHoFJpqy3l+q4CabqtBWTwMXj6h3C+ydRYC7L5NH31UBwdxn/KILMf1vm
         Y3vhdFcyJJxaJBnjdPnWm7EBsjBS8kuNRT0+c+ooFTlTSiIAeM+ZhPZ+v4avFK2rF6da
         NKHHFZS93BeoFnmnVNHb70DY2nYMrEXtIMaEcvAzh9FEsQlC+lu4UZrSdQJNIi3TbNiN
         Osqj2HWbJV565qJluzmWFQ2Zx94MqcPWBMekVUXkmQ0ynAuX+95+bgjNZRWPsXuaW3gU
         EXWxsZ29GFTlMsTaKN2ZOqlgY92cP9ECTwdj+vbRvLIyJcH5f/MnuTDBzk0s/4Dcuuor
         UogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682525010; x=1685117010;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1iOXlTlBLlGt+xFnlJYCk9LyE8NZedUUmTtvF/W7cl8=;
        b=SbSymgWVfJOofi19Y045zCzLOLh+F2BI7/EnxEx3jkqE6kaXfqmPzlBlNVy+MKufu3
         2Z8nGI4TUp9m/SLiHUmBvZY33INxEfoYNaJpjYVMuk1xsOpOpsyRldw21MCRQYlLtdSb
         IaYbfAqnvzTKrWbFuF2H3nIYF0LI57Uu0N54TpvrsSU/K+7NAsJ5QKxpBhx3T8qn3fCZ
         ko+x3k7A08+XP05qw1R/zUl7U1enP1fWc/PNaVQ0eeVjPIKToOpvqXHgBirObl8BP9z/
         e/yLaeSCYMA5WGDEn2lDLMLcO4nytoFxRBXIJiEaVusDmw9fy/evB905autDZ/J0ZhqL
         ePiw==
X-Gm-Message-State: AAQBX9chJ7f8kRbwVtloeh0FeCRuqwdISnQRhzq5ItJxvQBzX80ByESu
        uvKYhAu7nkqiWYSgj3z34WK26lDRuhw=
X-Google-Smtp-Source: AKy350bLi2qJ+4nzU1ANPOt2oieWNNI6eHJyZmf0N2WaN8R6KPw5aRqvu3QGqGyegbPKHISQlL/Sdaz4cD4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:cac4:0:b0:b8f:1d2c:243f with SMTP id
 a187-20020a25cac4000000b00b8f1d2c243fmr7979508ybg.1.1682525010384; Wed, 26
 Apr 2023 09:03:30 -0700 (PDT)
Date:   Wed, 26 Apr 2023 09:03:28 -0700
In-Reply-To: <da1c807e-66b7-7e9f-143d-44b6f7389b50@intel.com>
Mime-Version: 1.0
References: <20230327141816.2648615-1-carlos.bilbao@amd.com>
 <ZEfrjtgGgm1lpadq@google.com> <da1c807e-66b7-7e9f-143d-44b6f7389b50@intel.com>
Message-ID: <ZElLUMDhIZPoG87K@google.com>
Subject: Re: [PATCH] docs: security: Confidential computing intro and threat model
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
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
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023, Dave Hansen wrote:
> On 4/25/23 08:02, Sean Christopherson wrote:
> >> +While the traditional hypervisor has unlimited access to guest data and
> >> +can leverage this access to attack the guest, the CoCo systems mitigate
> >> +such attacks by adding security features like guest data confidentiality
> >> +and integrity protection. This threat model assumes that those features
> >> +are available and intact.
> > Again, if you're claiming integrity is a key tenant, then SEV and SEV-ES can't be
> > considered CoCo.
> 
> This document is clearly trying to draw a line in the sand and say:
> 
> 	CoCo on one side, non-CoCo on the other
> 
> I think it's less important to name that line than it is to realize what
> we need to do on one side versus the other.
> 
> For instance, if the system doesn't have strong guest memory
> confidentiality protection, then it's kinda silly to talk about the
> guest's need to defend against "CoCo guest data attacks".
> 
> Sure, the mitigations for "CoCo guest data attacks" are pretty sane even
> without all this CoCo jazz. But if your goal is to mitigate damage that
> a VMM out of the TCB can do, then they don't do much if there isn't
> VMM->guest memory confidentiality in the first place.
> 
> So, sure, CoCo implementations exist along a continuum.  SGX is in there
> (with and without integrity protection), as are SEV=>SEV-ES=>SEV and
> MKTME=>TDX.
> 
> This document is making the case that the kernel should go to some new
> (and extraordinary) lengths to defend itself against ... something.

Then name the document something other than confidential-computing.rst, e.g.
tdx-and-snp-threat-model.rst.  Because this doc isn't remotely close to achieving
its stated goal of providing an "architecture-agnostic introduction ... to help
developers gain a foundational understanding of the subject".  IMO, it does more
harm than good on that front because it presents Intel's and AMD's viewpoints as
if they are widely accepted for all of CoCo, and that is just flagrantly false.

 : In order to effectively engage with the linux-coco mailing list and contribute
 : to ongoing kernel efforts, one must have a thorough familiarity with these
 : concepts.  Add a concise, architecture-agnostic introduction and threat model
 : to provide a reference for ongoing design discussions and to help developers
 : gain a foundational understanding of the subject.
