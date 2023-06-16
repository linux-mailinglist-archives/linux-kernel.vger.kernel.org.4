Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E16A73335F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344052AbjFPOUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjFPOUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:20:11 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209FA30DE
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 07:20:10 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-53f06f7cc74so562485a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 07:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686925209; x=1689517209;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7kkXzW7flFmwwNgdmJOF/Bq45kulQkYYDELv7ovIE0s=;
        b=RiJzto8bqF5mS6jDezs9b1trpJIIMu8WiPtaI/dBqSOaUte3g34NBpJY00M2wZETCw
         JuxbHe+ZjSkjRKKokqNagwHyDvhgOXDcX6lAwiPANdNiITZUZnUA6KwH6xZvNzD4m7Gn
         nyPdjZCFacInQQZD5E5HdGRqJvTIoqFFl448zQW6enBqgtdBXTg/J0wnfT1Imkel50q9
         2yXQ7JrbSFVw6B8glsYOlTI7GkLE/PzN6oZhFebXaVE/eyvYcTcqsTTf5LA3/OO1ynhX
         ubOgJk2lgj9u43PqdyPqFgjacd7vzw2bmw+h0AaxUTkKWlRoiS7U0tXjrV+lNqLdIHq1
         VpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686925209; x=1689517209;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7kkXzW7flFmwwNgdmJOF/Bq45kulQkYYDELv7ovIE0s=;
        b=fBJ8nJyh37aZ6JskcrErcPdkYDYTMa+hfYv+MuIe+XRW9jJGRhED86Vbzrvv45vIAp
         IjpOFFPoaeAO5I5f1Be6xD3e/vDcEbVLo6bF/vul+bbT0QHVbsHTpAYte4F1/csyglUP
         aqtDvgZkwHc/fy08fQ3pRDwAJnDoxpaWF9x0mtXaMY8el2j5KUpYhtZ5fpg++2GVB/90
         wgP5UK6ooz9e912rWmUACe0AnMIGdT45iWh3LfhW3Ri8krik2Y2Cu9t4Z7pdM5GLjuQD
         jx7fNg9l0IbIWBGcVxcGitg9kJrsvApHnYVVawfO9LFek8aI967KjisjkkBatb4FUai5
         QRmQ==
X-Gm-Message-State: AC+VfDzliggnlpCGxrXeTuh2GgYx8hsCGxZQVeC9bDNpP0SvECGWhLTJ
        W7NjYX9qmd5hkywTeLefNczfKFJf9qc=
X-Google-Smtp-Source: ACHHUZ5k5s1Dv3E8j8iPdrphFfLSmc9JW7weBGs7UOX1rIhuKWrjsGwis9n9lFua0MhUrP1Y+iyk5Js0+pY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:3d05:0:b0:53f:9a37:c199 with SMTP id
 k5-20020a633d05000000b0053f9a37c199mr633876pga.1.1686925209547; Fri, 16 Jun
 2023 07:20:09 -0700 (PDT)
Date:   Fri, 16 Jun 2023 07:20:07 -0700
In-Reply-To: <2cfa3122-6b54-aab5-8a61-41c08853286b@semihalf.com>
Mime-Version: 1.0
References: <20230612164727.3935657-1-carlos.bilbao@amd.com>
 <ZIihRqZljMaMRGcK@google.com> <2cfa3122-6b54-aab5-8a61-41c08853286b@semihalf.com>
Message-ID: <ZIxvl4sMH6N8TrAL@google.com>
Subject: Re: [PATCH v2] docs: security: Confidential computing intro and
 threat model for x86 virtualization
From:   Sean Christopherson <seanjc@google.com>
To:     Dmytro Maluka <dmy@semihalf.com>
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
        bp@alien8.de, security@kernel.org,
        Larry Dewey <larry.dewey@amd.com>, android-kvm@google.com,
        Dmitry Torokhov <dtor@google.com>,
        Allen Webb <allenwebb@google.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Patryk Duda <pdk@semihalf.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023, Dmytro Maluka wrote:
> On 6/13/23 19:03, Sean Christopherson wrote:
> > On Mon, Jun 12, 2023, Carlos Bilbao wrote:
> >> +well as CoCo technology specific hypercalls, if present. Additionally, the
> >> +host in a CoCo system typically controls the process of creating a CoCo
> >> +guest: it has a method to load into a guest the firmware and bootloader
> >> +images, the kernel image together with the kernel command line. All of this
> >> +data should also be considered untrusted until its integrity and
> >> +authenticity is established via attestation.
> > 
> > Attestation is SNP and TDX specific.  AIUI, none of SEV, SEV-ES, or pKVM (which
> > doesn't even really exist on x86 yet), have attestation of their own, e.g. the
> > proposed pKVM support would rely on Secure Boot of the original "full" host kernel.
> 
> Seems to be a bit of misunderstanding here. Secure Boot verifies the
> host kernel, which is indeed also important, since the pKVM hypervisor
> is a part of the host kernel image. But when it comes to verifying the
> guests, it's a different story: a protected pKVM guest is started by the
> (untrusted) host at an arbitrary moment in time, not before the early
> kernel deprivileging when the host is still considered trusted.
> (Moreover, in practice the guest is started by a userspace VMM, i.e. not
> exactly the most trusted part of the host stack.) So the host can
> maliciously or mistakenly load a wrong guest image for running as a
> protected guest, so we do need attestation for protected guests.
> 
> This attestation is not implemented in pKVM on x86 yet (you are right
> that pKVM on x86 is little more than a proposal at this point). But in
> pKVM on ARM it is afaik already working, it is software based (ensured
> by pKVM hypervisor + a tiny generic guest bootloader which verifies the
> guest image before jumping to the guest) and architecture-independent,
> so it should be possible to adopt it for x86 as is.

Sorry, instead of "Attestation is SNP and TDX specific", I should have said, "The
form of attestation described here is SNP and TDX specific".

pKVM's "attestation", effectively has its root of trust in the pKVM hypervisor,
which is in turn attested via Secure Boot.  I.e. the guest payload is verified
*before* it is launched.

That is different from SNP and TDX where guest code and data is controlled by the
*untrusted* host.  The initial payload is measured by trusted firmware, but it is
not verified, and so that measurement must be attested after the guest boots,
before any sensitive data is provisioned to the guest.

Specifically, with "untrusted" inserted by me for clarification, my understanding
is that this doesn't hold true for pKVM when splitting hairs:

  Additionally, the **untrusted** host in a CoCo system typically controls the
  process of creating a CoCo guest: it has a method to load into a guest the
  firmware and bootloader images, the kernel image together with the kernel
  command line. All of this data should also be considered untrusted until its
  integrity and authenticity is established via attestation.

because the guest firmware comes from a trusted entity, not the untrusted host.
