Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8556D0FA8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 22:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjC3UFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 16:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjC3UFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 16:05:30 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAB4FF19
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 13:05:29 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id k4-20020a17090aef0400b0023fcccbd7e6so6272528pjz.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 13:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680206729;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D4WknbMV482JOlkU+8kBkKp+aZrvDuc8QLsck2Al/rw=;
        b=AXNqLJ4Zginp7joy8mzjRuOzVj/R2VeRjn3PgxJRbDxIdmLVxsjktoehpifpMRh3EJ
         PNfZlMQR4ZBrSccIW9sBqlwzV4jZ5lcPAM98tEzgocdyI/1UZ3EMBc2DCW4/EHFfyd1E
         c/gaP92ZTUva2Y4TWDcwuocIwQj97ge2ZSQ9AszFR4kwIzPBOlZxWzqWgrkX7eniCDwM
         Rz46lBghd3rr3rX85Rbn8jAvYtlfJsvg/9Cse3iT01z4s4TzbLmNrb0W8cZ7oEUvCcSq
         i5imjrYIzjwZ6/NBKDw8fDT7gsKum+SyokGkEDRRzY8+JNfCWESqzgtjaIi8NbSplZN/
         zPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680206729;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D4WknbMV482JOlkU+8kBkKp+aZrvDuc8QLsck2Al/rw=;
        b=xUGIeD/d7DY3FvOCRCN+FqZe5at8Cwphak6D7kEEaoMbSuGJOn1e30o+vvdbVZ3oY0
         zwSxJsBX8qMHTOza12pEsI8Y0+yYrAmwuG7EuJayQYQoAouJeF22xNmefT2KKqwCj+aG
         tATGTo+FXkTWzlDhGcbwVoRq/Iv4fYNZ1oqvaLTZljV0WLR6Sr139NvZznBwEefSgNQE
         NcNmWNjKtpezr2ypcfZgFwEi59WWCwv6GFC8YxIy3o5plNDHliDN29JvCxEH+4owqkpM
         tknaNBCM4ZBjs4ek5U6CfBmI/W43W2r8XdmOM8DbbKrop0XiW4/l6bRwfrBjwLFjA0ZB
         fkEw==
X-Gm-Message-State: AAQBX9cv9R+5zzDDhflepfKknP6JfpQ3djZK/736fab014cZJFUdVdE8
        5iFBMwnEODw2iu/DM4+eV9p+vwA3XhI=
X-Google-Smtp-Source: AKy350bAT1HTzfEUcnzbiPSnaEw8LXPBD+EseXmSHsi0N4Qtv858tlYW2w+r9m7QT52IXYK+W2hz5tITxuE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:7484:b0:1a1:fd0d:1bb with SMTP id
 h4-20020a170902748400b001a1fd0d01bbmr8345969pll.13.1680206729104; Thu, 30 Mar
 2023 13:05:29 -0700 (PDT)
Date:   Thu, 30 Mar 2023 13:05:27 -0700
In-Reply-To: <ZCXnYj3GsoB1Kipo@johallen-workstation.lan>
Mime-Version: 1.0
References: <20221012203910.204793-1-john.allen@amd.com> <Y9B97dZnFnjEHhVf@google.com>
 <d4e15021af4e72d6daba4021feaebf289b676830.camel@intel.com>
 <ZCMpJLAx8//1zLLV@johallen-workstation.lan> <b75c6f20-a99c-a6d4-c1c1-7ae9f016d2af@intel.com>
 <9cf73a9d-d9eb-c6a6-a083-88539a3e78a2@intel.com> <ZCXnYj3GsoB1Kipo@johallen-workstation.lan>
Message-ID: <ZCXotrLbDl6JJaVj@google.com>
Subject: Re: [RFC PATCH 0/7] SVM guest shadow stack support
From:   Sean Christopherson <seanjc@google.com>
To:     John Allen <john.allen@amd.com>, g@google.com
Cc:     Weijiang Yang <weijiang.yang@intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023, John Allen wrote:
> On Thu, Mar 30, 2023 at 01:37:38PM +0800, Yang, Weijiang wrote:
> >=20
> > On 3/29/2023 8:16 AM, Yang, Weijiang wrote:
> > > > Now that the baremetal series has been accepted, how do we want to
> > > > proceed? I think I'd like to send a refreshed version based on the
> > > > version that was accpeted, but I'd want to wait to base it on a new
> > > > version of Weijiang's kvm/vmx series (if one is planned).
> >=20
> > Patch 1/7 did what I wanted to implement to support AMD SHSTK, my next
> > version will continue refactoring them in vmx scope, then=EF=BF=BD your=
 series may
> > pick up the helper and modify accordingly.
> >=20
> > Please note, in my series, I removed check for MSR_IA32_PL{0,1,2}_SSP s=
ince
> > they're not supported right now, but your series supports for the MSRs,=
 so
> > you have to change the helper a bit to adapt to your patches.
>=20
> The reason we decided to include the PL{0,1,2}_SSP MSRs is that even
> though linux doesn't support supervisor shadow stack, a non-linux guest
> OS might support it and could make use of the MSRs. It could be
> something the vmx patches might want to account for as well=20

And emulating/virtualizing those MSRs is mandatory unless KVM can hide thos=
e MSRs
without violating the architecture (been a while since I looked at CET).  I=
f the
architecture does allow enumerating support for userspace but not superviso=
r, then
ideally the two would be enabled separately in KVM, e.g. so that that if on=
e is
completely busted, we might be able to precisely revert only the broken cod=
e.
