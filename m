Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9C675075E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjGLMAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbjGLMAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:00:50 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BA51BEC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:00:27 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 548D21EC0CAF;
        Wed, 12 Jul 2023 14:00:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1689163225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=J1nbq+Flb3xWaMjMRyH8lLNErBvozlvfas8/OBqBdaA=;
        b=LUYU17FGQjunOIsffE5Q9g+h6T1HJW+eV9N7ZGpV93yzm55MeXxEtHUxLOT06Ycfs0bE/V
        qKaIaw6kPuToq72Nnzm/T6VmVfgoRYAF9YPUW1Rc3zFvB/MZYUmclEUqyaswBCTj+cxu4P
        YRHtaQomlbSMEJGoNAHDDEX7tqXAieg=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eAP0VmbZHX2N; Wed, 12 Jul 2023 12:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1689163222; bh=J1nbq+Flb3xWaMjMRyH8lLNErBvozlvfas8/OBqBdaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e7ooaicP5bzfGbenwSFp5l/E4k8cNlwbvX7maVZi2+gdzCNZTXJu3DDmekDqm6wW6
         Rmcd+BH0Yc+Hxc55nVQjtq6HyuErnoNrdYvktJ0ubLBI+eImIfzPCwOii38Y51aVfw
         Mw91xmjpSvnwKChzy7Y/Ok2XXjPwfgv5t85trmW3M2wKC79440toTOy3ixri0v83MU
         sWpFsl13SjQMrZNDFGCZoDY5f8G6BTDzZ/Jspc5BQhiHGHvHdRrbc111HvyB8gZnun
         CLLu5vzVYzrMDZsvVNFKbR1BU555FgdPb/Wi524LadW7VyPSKBrscl0ZXqW57SGgbG
         d0nkDvPNYG9CjYWSiZHz2zyM7/Ek5SiDJKUmhjgea0yeUU2Bk/xGMFCqaj2VfSjvkV
         oIKzfMxecGcBQRzhhrTOO5VLZIQ3NN6PX2U/HkPehOYfpQXfS9FXt/Kokl1b9ZXNVy
         O2Q1EaYNPvqPlLADd5fRJHaDx1sSEel6d/NqBgTJbSgM96isgPycR5TCNPZESH349v
         wSUx9cVsxpF9KMaVPbJX6hxXBE8HtTXmyeZsYhlXJjAufogAMqFhmLVRILNWFXRMgj
         G3LiT55Ay7cZPfq0fDOb7y7/gTVzNesSGk0uqSFnIeDite44ZDHX3Se4akzduyDIHc
         RpRelWVA1MQnUwbREumzEjc4=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 03A9440E0140;
        Wed, 12 Jul 2023 12:00:06 +0000 (UTC)
Date:   Wed, 12 Jul 2023 14:00:02 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, bluca@debian.org,
        lennart@poettering.net, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
Message-ID: <20230712120002.GIZK6Vwga6DlJqdjEh@fat_crate.local>
References: <20230711154449.1378385-1-eesposit@redhat.com>
 <7E9D397B-439F-484C-B950-9094605A7B4D@zytor.com>
 <5e01b6a5-f993-f99d-41a0-ab671ec598f8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5e01b6a5-f993-f99d-41a0-ab671ec598f8@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 08:19:32AM +0200, Emanuele Giuseppe Esposito wrote:
> And any comment on the SBAT string itself? I would like to get an
> agreement on
> "linux,1,The Linux Developers,linux,$(KERNELVERSION),https://linux.org"
> before we use it as semplate also for downstream.

Yeah, looks useless to me. With your patch I get:

$ cat linux.sbat
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
linux,1,The Linux Developers,linux,6.5.0-rc1,https://linux.org

But my branch is:

$ git describe
v6.5-rc1-6-g3f01e9fed845

So your thing needs to enable CONFIG_LOCALVERSION_AUTO or so which
allows for uniquely identifying the build. At least I think it did at
some point. So that you can do stuff like:

$ file vmlinux
vmlinux: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, BuildID[sha1]=19f22ac85675ea30042fb703373d97c460bb5a61, with debug_info, not stripped

and you have a build ID sha there.

But not even that works because if I change the source, I still get the
same sha. So it needs to be an mechanism which identifies the kernel
image uniquely.

And then why does it have to be a separate section? All those
requirements need to be written down.

And regardless what you do, this looks like a contract between the
kernel and userspace tools so it absolutely needs to be documented
somewhere prominently - not in a commit message with links to flaky URLs
which would probably change in the future - and explained what the tools
parse and where one can find that parsing code.

Because if we go and change that, we need to be able to verify whether
we're not breaking any userspace tools.

Actually, I wouldn't mind even having a small script which does the
parsing and which we can use to check that we're not breaking things.

Also, while building this says:

objcopy --set-section-alignment '.sbat=512' --add-section .sbat=linux.sbat arch/x86/boot/bzImage;
objcopy: arch/x86/boot/st2fStm6:.sbat: section below image base

So you need to make it quiet.

And so on and so on...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
