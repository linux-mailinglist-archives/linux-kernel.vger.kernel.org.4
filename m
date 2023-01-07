Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0186D660B25
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 01:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236679AbjAGA7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 19:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236686AbjAGA7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 19:59:09 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B60C271A8
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 16:59:08 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id a64so3241156vsc.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 16:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KS6l6BAEH3XPDAy29s90J7bqb3XCkbf4Z/0eJirx40=;
        b=p6uPmPY4JsEKXAGOXdSyQSZTAozm2PObLWUzPd94dXPj4jTHlIlWbnTiHw6UiaTQBv
         w9g3UKJ7sMHkfiZxVHP0XwOpwuJV7n/H9WnhNmU6K+7qF7uO6dGABem+QhJVEBv4NFxp
         P1cOG6c6/ymEA9I42qe9g5F8Oy6UzB0o0ZQK76gIYZ8gBhFyiN4dtuENyu0/WtXkBbel
         qztEc4IIZUKNWsR8b7is2Ad0ueNis4noAotBKgS+gi/OgT+hIn7XEaDyI/DNQPUCxAz2
         oqwnL7f32pTv9FxDyM50ZRuBlcnEH9DRZpV9YZa1/zripPefq/e2npM+OhJNEmJux2us
         /31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2KS6l6BAEH3XPDAy29s90J7bqb3XCkbf4Z/0eJirx40=;
        b=0ZEdvV7iHVrgSfgFFHyt3B/RhxR/wkubXxMpt1F/vJnQb3P30L4bW5R+2ey9fKUW41
         qtYVp/4fJNxaLtJHDAmDcjUrCcJscJoJ/6ZYfLsjnuBDdYOd3L585N6zL6o+jexRSTa2
         wee1cUpR1uPHTkan0K9ROigcU1vPG0vdhZyCI1sLbidFlx2Omf2wEfwbZe0HJEQmOr3e
         I7CgQiGMH2lGCjVaC3nXqWrd4ngYzaHZRil+Zpz0qOKEn/YxoxpjetQ69fRAK5SFS2dO
         bxpacQ50Ihcb2uSD8tdZMBRbt6bDNyb0xYll1BoU7N4YHXsPPEjNq4OLBZoWmCyaH6R4
         e9hg==
X-Gm-Message-State: AFqh2kpYFHP1ZKq/0oyNNjGVjbPkrqB4P7GVnNEIPxXyjdkuF19rT9e0
        5ltPdxz2Q4YY6K/vO8yi/UPKuEahD6xW5xdkzlvY+Q==
X-Google-Smtp-Source: AMrXdXvFUVE8SJEu+p6Nh4kzIUzaushSy7NfULcVQ8MenH3Pdeg3qxdY5HmhelEPQILO7dcDmsRYUbydUKOuQGbzU1s=
X-Received: by 2002:a05:6102:3081:b0:3ce:d79a:a728 with SMTP id
 l1-20020a056102308100b003ced79aa728mr481898vsb.19.1673053147392; Fri, 06 Jan
 2023 16:59:07 -0800 (PST)
MIME-Version: 1.0
References: <7c09d15b-40bc-c6a0-3282-a94e9d9c36be@intel.com>
 <a69faebb-11e8-b386-d591-dbd08330b008@linux.alibaba.com> <51d486c9-4689-c2d6-0db4-4e3754a058db@linux.alibaba.com>
 <6b8f415f-1a29-5c0c-1373-3b08aba735e6@intel.com>
In-Reply-To: <6b8f415f-1a29-5c0c-1373-3b08aba735e6@intel.com>
From:   Erdem Aktas <erdemaktas@google.com>
Date:   Fri, 6 Jan 2023 16:58:56 -0800
Message-ID: <CAAYXXYxxs2zy_978GJDwKfX5Hud503gPc8=1kQ-+JwG_kA79mg@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] x86/tdx: Add Quote generation support
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Guorui Yu <GuoRui.Yu@linux.alibaba.com>, ak@linux.intel.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        isaku.yamahata@gmail.com, jun.nakajima@intel.com,
        kai.huang@intel.com, khalid.elmously@canonical.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        marcelo.cerri@canonical.com, mingo@redhat.com,
        philip.cox@canonical.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, tglx@linutronix.de,
        tim.gardner@canonical.com, tony.luck@intel.com, wander@redhat.com,
        x86@kernel.org, "Du, Fan" <fan.du@intel.com>,
        Chong Cai <chongc@google.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I apologize for bumping an old thread up and getting in the discussion
this late.

Bumping this thread because as Chong mentioned below, it is essential
for us to have TDG.VP.VMCALL<GetQuote> interface as we do not
enable/support virtio in many use cases.
Coming from the  "Add TDX Guest Attestation support patch set [1]"
which does not have the Quote support as per Dave's review suggestion,
I am looking for what our options are here.

@Hansen, Dave  : as far as I understand your concerns were:

>>Do we *REALLY* need specific driver functionality for this? For
>>instance, is there no existing virtio device that can send blobs back and=
 forth?

As Chong and I said, we have to have a vsock alternative solution if
we want to provide TDX based products for our customers. Otherwise it
will really limit our ability to adopt this technology.

>> You're basically saying that every confidential computing technology
>> should have its own host user <-> guest kernel <-> guest user ABI.
>> That's insanity.  If we do this, we need *one* interface that says "talk
>> to the hypervisor" that's common for all hypervisors and hardware
>> vendors, or at least more than *one*.

This is already happening, right? AMD has GHCB ABI while intel has
GHCI. Also there is already a guest driver and IOCTL interface for
TDREPORT, so would it be really that insane to have another IOCTL
interface for GetQuote?

I would like to get your opinion on how we can progress on this?

-Erdem

[1] https://lore.kernel.org/lkml/20221116223820.819090-1-sathyanarayanan.ku=
ppuswamy@linux.intel.com/t/#m341e6475982318d74be160c09a1856ad87e184cf

> From: Chong Cai <chongc@google.com>
> Date: Fri, Jan 6, 2023 at 2:02 PM
> Subject: Re: [PATCH v8 5/5] x86/tdx: Add Quote generation support
> To: Nakajima, Jun <jun.nakajima@intel.com>
> Cc: <ak@linux.intel.com>, <bp@alien8.de>, <dave.hansen@intel.com>, <dave.=
hansen@linux.intel.com>, <hpa@zytor.com>, <isaku.yamahata@gmail.com>, <kai.=
huang@intel.com>, <khalid.elmously@canonical.com>, <kirill.shutemov@linux.i=
ntel.com>, <linux-kernel@vger.kernel.org>, <marcelo.cerri@canonical.com>, <=
mingo@redhat.com>, <philip.cox@canonical.com>, <sathyanarayanan.kuppuswamy@=
linux.intel.com>, <tglx@linutronix.de>, <tim.gardner@canonical.com>, <tony.=
luck@intel.com>, <wander@redhat.com>, <x86@kernel.org>
>
>
> Hi everyone,
>
>
> Sorry for being late in the discussion.
>
>
> We just want to add that we have use cases where virtio/vsock is not supp=
orted at all; therefore, getquote TDVMCALL support is required for us to ad=
opt this technology.
>
>
> Is there anything we can help here?
>
>


On Sun, Nov 20, 2022 at 6:26 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 11/20/22 18:04, Guorui Yu wrote:
> > Kindly ping for any comments here?
>
> No comments from me!
>
> Seriously, this is from June.  I honestly have no idea what this patch
> is for or why you're asking about it.  If it were  important, I would
> have expected a new post with a new cover letter telling me some time in
> the past 5-6 months.
>
> Oh, and btw, I haven't seen you reviewing any other x86 submissions
> during that past 5-6 months either.  I'm tend to be more likely to bump
> things up near the front of the queue for folks that are helping to keep
> the queue short and manageable.
