Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFB36EE45C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 17:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbjDYPCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 11:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbjDYPCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 11:02:42 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9BC46B7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 08:02:40 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-552e1cb08e0so47084927b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 08:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682434959; x=1685026959;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pZ3BGGNQ6rZtpR453LXsl6Itbxm0bwQy5BQoZPJ3oOU=;
        b=gUsxX26NXCZ6r14dXeXTp21glO0SrEWZa0rLsi3b4nj9YECEk48w42dZ5zaVPa7WY/
         VEQpikWRZ8Jv85GYPAwmZ4OIBWRu7lUH9EV+MOxZD9iV6G4Yz0SKw641h9NbsLZc+yef
         aF7N3A2XQ3Qbw55iU5AV/KuK1BvM8NFrT1xyOA/e5KBFsZbEWAXo1L0X42nn8wUFapMf
         mUzCwhzdaTYHiUybm/V5DUKF0QzrYT8mWu0OL+/XsLbacOgIunGO40YmgbKi/nZsxfAN
         3IadH7enSVVuLeKUZv5uu42FK34DVvzvZIVy3onO8tQRi1MC7axcQ7EIBWNLi4uvTiMk
         AS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682434959; x=1685026959;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pZ3BGGNQ6rZtpR453LXsl6Itbxm0bwQy5BQoZPJ3oOU=;
        b=anFRz4MbOOpogC0NvWyXTrMeI9lPQQocNyw17dusZ3iwte6ntnoeNMgyMugBcgX1N7
         OPaBdJX+gYJkfBhGdMGBs4GSXJ2G5893NuoHl6n+n70lgYCHP3+otxVolyUDHAhV/C/o
         wTyPZrMUGvNDQW/SOf1Cp3R1vtKGmgeenEWYvcAqVi1gXagCIvgaC8JJi4kLSr6TiuHg
         YJKUgp9gh2zhRJZ5xsbSgWvk7iSTOSWDm+MasVHRh1MIr4nyK3tLpXxDAvBzLG1m027m
         rMYhlUQzxKTxL3ZfBOI3WLNKlr+skvbClFNH3ri4BW4NzYoXD2+G7FViqGLb2VjWZ8nq
         2wPA==
X-Gm-Message-State: AAQBX9cqT8fJ/u4wVjRrZh1SrXNuV0rPbEZiBux0TH6r9E4h0/3US3/x
        l3RT4NesYjD3WYagU5J6xnQS8WtX1kE=
X-Google-Smtp-Source: AKy350YDAZbkOQRK5g6tYkXR/oEveOOfRFHQC7RKfIoKTzQYKWd2HI7WCN0BwwrDGeWs5JNKrBjyDPSMfRs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:b60f:0:b0:54f:bb6f:3deb with SMTP id
 u15-20020a81b60f000000b0054fbb6f3debmr8642876ywh.4.1682434959555; Tue, 25 Apr
 2023 08:02:39 -0700 (PDT)
Date:   Tue, 25 Apr 2023 08:02:38 -0700
In-Reply-To: <20230327141816.2648615-1-carlos.bilbao@amd.com>
Mime-Version: 1.0
References: <20230327141816.2648615-1-carlos.bilbao@amd.com>
Message-ID: <ZEfrjtgGgm1lpadq@google.com>
Subject: Re: [PATCH] docs: security: Confidential computing intro and threat model
From:   Sean Christopherson <seanjc@google.com>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ardb@kernel.org, kraxel@redhat.com,
        dovmurik@linux.ibm.com, elena.reshetova@intel.com,
        dave.hansen@linux.intel.com, Dhaval.Giani@amd.com,
        michael.day@amd.com, pavankumar.paluri@amd.com,
        David.Kaplan@amd.com, Reshma.Lal@amd.com, Jeremy.Powell@amd.com,
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023, Carlos Bilbao wrote:
> +Kernel developers working on confidential computing for the cloud operate
> +under a set of assumptions regarding the Linux kernel threat model that
> +differ from the traditional view. In order to effectively engage with the
> +linux-coco mailing list and contribute to its initiatives, one must have a
> +thorough familiarity with these concepts. This document provides a concise,
> +architecture-agnostic introduction to help developers gain a foundational

Heh, vendor agnostic maybe, but certainly not architecture agnostic.

> +understanding of the subject.
> +
> +Overview and terminology
> +========================
> +
> +Confidential Cloud Computing (CoCo) refers to a set of HW and SW

As per Documentation/security/secrets/coco.rst and every discussion I've observed,
CoCo is Confidential Computing.  "Cloud" is not part of the definition.  That's
true even if this discussion is restricted to CoCo VMs, e.g. see pKVM.

> +virtualization technologies that allow Cloud Service Providers (CSPs) to

Again, CoCo isn't just for cloud use cases.

> +provide stronger security guarantees to their clients (usually referred to
> +as tenants) by excluding all the CSP's infrastructure and SW out of the
> +tenant's Trusted Computing Base (TCB).

This is inaccurate, the provider may still have software and/or hardware in the TCB.

And for the cloud use case, I very, very strongly object to implying that the goal
of CoCo is to exclude the CSP from the TCB.  Getting out of the TCB is the goal for
_some_ CSPs, but it is not a fundamental tenant of CoCo.  This viewpoint is heavily
tainted by Intel's and AMD's current offerings, which effectively disallow third
party code for reasons that have nothing to do with security.

https://lore.kernel.org/all/Y+aP8rHr6H3LIf%2Fc@google.com

> +While the concrete implementation details differ between technologies, all
> +of these mechanisms provide increased confidentiality and integrity of CoCo
> +guest memory and execution state (vCPU registers), more tightly controlled
> +guest interrupt injection,

This is highly dependent on how "interrupt" is defined, and how "controlled" is
defined.

> as well as some additional mechanisms to control guest-host page mapping.

This is flat out wrong for SNP for any reasonable definition of "page mapping".
SNP has _zero_ "control" over page tables, which is most people think of when they
see "page mapping".

> More details on the x86-specific solutions can be
> +found in
> +:doc:`Intel Trust Domain Extensions (TDX) </x86/tdx>` and
> +:doc:`AMD Memory Encryption </x86/amd-memory-encryption>`.

So by the above definition, vanilla SEV and SEV-ES can't be considered CoCo.  SEV
doesn't provide anything besides increased confidentiality of guest memory, and
SEV-ES doesn't provide integrity or validation of physical page assignment.

> +The basic CoCo layout includes the host, guest, the interfaces that
> +communicate guest and host, a platform capable of supporting CoCo,

CoCo VMs...

> and an intermediary between the guest virtual machine (VM) and the
> underlying platform that acts as security manager::

Having an intermediary is very much an implementation detail.

> +Confidential Computing threat model and security objectives
> +===========================================================
> +
> +Confidential Cloud Computing adds a new type of attacker to the above list:
> +an untrusted and potentially malicious host.

I object to splattering "malicious host" everywhere.  Many people are going to
read this and interpret "host" as "the CSP", and then make assumptions like
"CoCo assumes the CSP is malicious!".  AIUI, the vast majority of use cases aren't
concerned so much about "the CSP" being malicious, but rather they're concerned
about new attack vectors that come with running code/VMs on a stack that is
managed by a third party, on hardware that doesn't reside in a secured facility,
etc.

> +While the traditional hypervisor has unlimited access to guest data and
> +can leverage this access to attack the guest, the CoCo systems mitigate
> +such attacks by adding security features like guest data confidentiality
> +and integrity protection. This threat model assumes that those features
> +are available and intact.

Again, if you're claiming integrity is a key tenant, then SEV and SEV-ES can't be
considered CoCo.

> +The **Linux kernel CoCo security objectives** can be summarized as follows:
> +
> +1. Preserve the confidentiality and integrity of CoCo guest private memory.

So, registers are fair game?

> +2. Prevent privileged escalation from a host into a CoCo guest Linux kernel.
> +
> +The above security objectives result in two primary **Linux kernel CoCo
> +assets**:
> +
> +1. Guest kernel execution context.
> +2. Guest kernel private memory.

...

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7f86d02cb427..4a16727bf7f9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5307,6 +5307,12 @@ S:	Orphan
>  W:	http://accessrunner.sourceforge.net/
>  F:	drivers/usb/atm/cxacru.c
>  
> +CONFIDENTIAL COMPUTING THREAT MODEL

This is not generic CoCo documentation, it's specific to CoCo VMs.  E.g. SGX is
most definitely considered a CoCo feature, and it has no dependencies whatsoever
on virtualization.

> +M:	Elena Reshetova <elena.reshetova@intel.com>
> +M:	Carlos Bilbao <carlos.bilbao@amd.com>

I would love to see an M: or R: entry for someone that is actually _using_ CoCo.

IMO, this document is way too Intel/AMD centric.
