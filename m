Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575396AFB63
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 01:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjCHAkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 19:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjCHAkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 19:40:06 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83938A7A97
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 16:39:28 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id z19-20020a056a001d9300b005d8fe305d8bso8128464pfw.22
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 16:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678235966;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pO5LEPwxpw+Rwg+dzrdq53eV/hbI3zuzkfxYZDBtRwU=;
        b=bod3wxiSjf2psTwagGAmXUrRVUb9j7QcfetCjFHIlshOioY/4/54Pi87FDqOmPWxso
         QM78MWdyycMqdZXV5JdJwou3R7KVHEC82646maZ96R0itIUWzKBfe5hZeqBouU5iBFfq
         rOEk3UMYmK77B02jx0lDeYYknkImkZceETyxUOLIPajwgWZ9F30Uy8Iv/x3MMBgPOuxT
         QaB1hK24wUoFrTxxkBMLZjOLxKnnd7RNRMP8w9aWbbJt57WvsnGnfPw7/FzPSi7XIfC8
         J+1OCufyuIFYe0ZhALKh/nZBn6kC0xthJEnN4oKLMn9E/uEC1l7/I7fFE51rVjoHDbdy
         YDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678235966;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pO5LEPwxpw+Rwg+dzrdq53eV/hbI3zuzkfxYZDBtRwU=;
        b=kiAOlvE984OOQIWjL77Dcgr2sTYKq1ggSXzQa7QBdzyEu39m9RomxKjr6OyhJqp6jk
         s0MjxywYHwnN4+oIXDdneKKywPKMBd5BYBVYtSA58CLWD0VyP/kWIfLda66I8i40y/B/
         kTtLPXWojf2t4pqgiSlR7sdwBLiS8xNjQdf5ryOjLqgVaHjzbtE57kz4zhbetFsJay0b
         vNaxrv1vUvKZVNPIGO0ArNsNI7PJHFfMM4mRHjE3MUU39Hs7SFAPC8l6fYFdXHIK98Ez
         qqp8AF5vdQa3kxZs38lPJqXqyyoah5/h3sVRnzfizJvXiyZbW9DxiIiB+aIscxkPGqol
         RATA==
X-Gm-Message-State: AO0yUKUZLmIsM0w38oSX9TAkbTY6KpL5zz6XL1ufEh8w60ClmLio5Pvj
        b5kPM74Sh/VMSPb8tviXIQT3Ad0fjtc=
X-Google-Smtp-Source: AK7set8hN4h+Z8/XM6sD4ErrHJY2upCtqu7y/ohBt5Q9bXpWtOWvV04VlnTaGwlL6r1j374n1NuMdNhNoyQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1088:b0:237:6178:297d with SMTP id
 gj8-20020a17090b108800b002376178297dmr6129886pjb.2.1678235966066; Tue, 07 Mar
 2023 16:39:26 -0800 (PST)
Date:   Tue, 7 Mar 2023 16:39:24 -0800
In-Reply-To: <CABgObfa1578yKuw3sqnCeLXpyyKmMPgNaftP9HCdgHNM9Tztjw@mail.gmail.com>
Mime-Version: 1.0
References: <20230227171751.1211786-1-jpiotrowski@linux.microsoft.com>
 <ZAd2MRNLw1JAXmOf@google.com> <CABgObfa1578yKuw3sqnCeLXpyyKmMPgNaftP9HCdgHNM9Tztjw@mail.gmail.com>
Message-ID: <ZAfZPA5Ed7STUT2B@google.com>
Subject: Re: [PATCH] KVM: SVM: Disable TDP MMU when running on Hyper-V
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Tianyu Lan <ltykernel@gmail.com>,
        Michael Kelley <mikelley@microsoft.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023, Paolo Bonzini wrote:
> On Tue, Mar 7, 2023 at 6:36=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> > Thinking about this more, I would rather revert commit 1e0c7d40758b ("K=
VM: SVM:
> > hyper-v: Remote TLB flush for SVM") or fix the thing properly straitawa=
y.  KVM
> > doesn't magically handle the flushes correctly for the shadow/legacy MM=
U, KVM just
> > happens to get lucky and not run afoul of the underlying bugs.
>=20
> I don't think it's about luck---the legacy MMU's zapping/invalidation
> seems to invoke the flush hypercall correctly:

...for the paths that Jeremi has exercised, and for which a stale TLB entry=
 is
fatal to L2.  E.g. kvm_unmap_gfn_range() does not have a range-based TLB fl=
ush
in its path and fully relies on the buggy kvm_flush_remote_tlbs().

In other words, KVM is getting lucky :-)

> Jeremi, did you ever track the call stack where
> hyperv_nested_flush_guest_mapping is triggered?

I don't think it matters.  As above, it only takes one path where KVM is fu=
lly
relying on kvm_flush_remote_tlbs() for the whole thing to fall apart.
