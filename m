Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97B06CCB24
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 22:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjC1UAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 16:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjC1UAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 16:00:42 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26F640CA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 13:00:06 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id z11so8816166pfh.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 13:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680033571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/yvlhEoGf4lYD0w5w4illgGKFOLps9NjXpDI+7ErcQ=;
        b=Kj4ahUJ17/TklSj8P4aYyhNWSNUggUnfHpq42Yf2/g2G1VGWGWrewPLvp9vsLX/JEg
         Bo8mZjMkfy7Ctlho2KRKOpKqTbOfwp+ZKHRKs6VdamQXWlk+XXleJft4Oz61Oo6NQ4pw
         KGYJwhnhB3/D0jfIu8miCDACYf921OreR3HQSswBQW4rpuJCq8+F+dboOuddBBTNRJ7Q
         VAjey0lem6IOqAD6Q/8oNVUFh4Oe+mz5d1NunBWyGOByo8e7HkQXRnaO9wXGbSxcVuOU
         k+XH0lQKF/eHBchip2FdOmhmF1eQBFBUO8i0IDxZ9EOdGZNFd8SUBL8dWE5arhzeF1Al
         3IIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680033571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/yvlhEoGf4lYD0w5w4illgGKFOLps9NjXpDI+7ErcQ=;
        b=mxJvARMmlHWfSliNFrPCh83kMBb1ZOhE4sNVXkNdo9w0DCxmB5Mode51QRbDSvzHNp
         rtcDMIxF8NKfV6Lrx3mc5qH2o9c78TVfjJpaFi/tRyKJoL2DosmmHbc09RpItVs0mCgl
         3NaYs3lFj54oa+3kpAT/gDJLlncsRDmr9LX8CeiSErQzWAegVM4W7xV465s2Atpq/0eh
         Js/911Xoxji6FzlFm5rv/5fR5ZzVA3OrVH887+TaZEqfdaQLVGNOWDfcha5V3DORb2mT
         6LyUu5nS7XHTd3vl2kFJwpPo+dMG5G8NFFe1F3AujOOedkJO/crN/2dvFtk3AV2rAhap
         fllA==
X-Gm-Message-State: AAQBX9fZLaQXMSXp53NW9OrOE6RUyGADP9rXq2D+/4jWXwh4J05YiHWH
        /Y/YewSD5IAlqgso9WlLSlM5J+CBmR3tzgHKx+vsYQ==
X-Google-Smtp-Source: AKy350a02nhWjZJNaefPpoZ0AZzLMqgU+rjEYIaK5jw3IZfaHRS4Bp2uRB/lOVaXyN/t2Dcrapc37Bok73ZdIIbqPUU=
X-Received: by 2002:a63:5a47:0:b0:513:2523:1b5f with SMTP id
 k7-20020a635a47000000b0051325231b5fmr4363099pgm.3.1680033570922; Tue, 28 Mar
 2023 12:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230326062039.341479-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAAYXXYxC++kRW_Kg0jieaxuwzTC2hu-9SxRjsHH_kqZW_DTE7Q@mail.gmail.com>
In-Reply-To: <CAAYXXYxC++kRW_Kg0jieaxuwzTC2hu-9SxRjsHH_kqZW_DTE7Q@mail.gmail.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Tue, 28 Mar 2023 12:59:18 -0700
Message-ID: <CAAH4kHZWW6QsMcLCLYwRo25i6d6Uhg+=rTeoVV7yrGHqUWwFUQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] TDX Guest Quote generation support
To:     Erdem Aktas <erdemaktas@google.com>, Chong Cai <chongc@google.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        Du Fan <fan.du@intel.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Chong Cai

Adding a colleague per his request since he's not subscribed to the list ye=
t.

On Mon, Mar 27, 2023 at 10:36=E2=80=AFAM Erdem Aktas <erdemaktas@google.com=
> wrote:
>
> On Sat, Mar 25, 2023 at 11:20=E2=80=AFPM Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> >
> > Hi All,
> >
> > In TDX guest, the attestation process is used to verify the TDX guest
> > trustworthiness to other entities before provisioning secrets to the
> > guest.
> >
> > The TDX guest attestation process consists of two steps:
> >
> > 1. TDREPORT generation
> > 2. Quote generation.
> >
> > The First step (TDREPORT generation) involves getting the TDX guest
> > measurement data in the format of TDREPORT which is further used to
> > validate the authenticity of the TDX guest. The second step involves
> > sending the TDREPORT to a Quoting Enclave (QE) server to generate a
> > remotely verifiable Quote. TDREPORT by design can only be verified on
> > the local platform. To support remote verification of the TDREPORT,
> > TDX leverages Intel SGX Quoting Enclave to verify the TDREPORT
> > locally and convert it to a remotely verifiable Quote. Although
> > attestation software can use communication methods like TCP/IP or
> > vsock to send the TDREPORT to QE, not all platforms support these
> > communication models. So TDX GHCI specification [1] defines a method
> > for Quote generation via hypercalls. Please check the discussion from
> > Google [2] and Alibaba [3] which clarifies the need for hypercall based
> Thanks Sathyanarayanan for submitting patches again.
>
> I just wanted to reiterate what I said before that having a clean
> TDVMCALL based interface to get TDX Quote without any virtio/vsock
> dependency  is critical for us to support many use cases.



--=20
-Dionna Glaze, PhD (she/her)
