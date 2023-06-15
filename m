Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC36731AF9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344954AbjFOOOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344941AbjFOOO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:14:29 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B163A1FC2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 07:14:28 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-565de4b5be5so27320837b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 07:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686838468; x=1689430468;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7viRfd/Ct8U5RrqgvCgGqBfozF7RQD4igs0DqRCL6cE=;
        b=N/9efvZeguJ9mTYp5uqlZJJgM9UzRYdeH+vy0nBO00FHtIhj1v5S8J8uFMHxXAdPq5
         HMY7gCgct/iykDoEMY/UG1qvaS4tT96uzlhEPWL0wuon7fNHgp+8zvFR59EqaGk0IcR5
         GIOIV7t4D2hGoqqUlwNaHk7O/lN3NwsHonXsFnvPwEXiapoG1W/+AS4q2pjBmrakJSVF
         yBuwQ8oL0P8aYozIPFw4J1XAu0B0MLnP7ZuaGljQ1bIP+UL6K+Kg4Wn6tI5ZM7QUJHq1
         DHMrSnuQrFIh+FjNv6J2EzUG6FbU+pYRhEnJGAtfHyCFNX57WYLzlhP+493R4eeaCpDG
         TlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686838468; x=1689430468;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7viRfd/Ct8U5RrqgvCgGqBfozF7RQD4igs0DqRCL6cE=;
        b=YuNkDqpYpDcw96AWgax8pUBg7MPep2RUbqH6BLTuwfCBh8dPjxWlgWE36/TQtI/WwY
         DbSOQOnG/rwgW86SgTctmx/VYh/FtDzDSMOsuc13pShdBslqM5FMcaYO3UtLHmYRggzX
         I2SYsPFYRowExvCARguebRw1CUoVVsblvfR7mVKrnaSiA9t2y6AMWcR40C/EKWvQcwxO
         XsNn4kMe1kzNArqLCh9AyznBeEv8nXivYqe3GqMHvaGmvMBAJ7DId7CQ17LGhoeKEPMO
         OLQJY/rlkWgzoUXBw83ufvxeuEeY8LB6zEtkb/wmEJbjeyBuCzM8cDC9wqrZIeDrnsdW
         lGNQ==
X-Gm-Message-State: AC+VfDx4ujro+ZzO1n/hZJfrGj0WdupO0nlNFt7Yeou/VBQ2Kbyz0r6A
        DGba/n1ZZPqhTZeVh9IMSRQRmTQwOHE=
X-Google-Smtp-Source: ACHHUZ6EIKcKvq/hS/fOZS8agFpvn3GY3pzYqorAftldiJlQkHc522gAG3GeNLMI7TYIN2aK4x1LHQhybZ4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:bc0f:0:b0:56d:2abf:f0c with SMTP id
 a15-20020a81bc0f000000b0056d2abf0f0cmr2288100ywi.10.1686838467967; Thu, 15
 Jun 2023 07:14:27 -0700 (PDT)
Date:   Thu, 15 Jun 2023 07:14:26 -0700
In-Reply-To: <ZIrONR6cSegiK1e2@linux.dev>
Mime-Version: 1.0
References: <20230606192858.3600174-1-rananta@google.com> <ZImwRAuSXcVt3UPV@linux.dev>
 <CAJHc60wUSNpFLeESWcpEa5OmN4bJg9wBre-2k8803WHpn03LGw@mail.gmail.com> <ZIrONR6cSegiK1e2@linux.dev>
Message-ID: <ZIscwv1NABW+wZ4J@google.com>
Subject: Re: [PATCH v5 0/7] KVM: arm64: Add support for FEAT_TLBIRANGE
From:   Sean Christopherson <seanjc@google.com>
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     Raghavendra Rao Ananta <rananta@google.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jing Zhang <jingzhangos@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023, Oliver Upton wrote:
> +cc Sean
>=20
> On Wed, Jun 14, 2023 at 06:57:01PM -0700, Raghavendra Rao Ananta wrote:
> > On Wed, Jun 14, 2023 at 5:19=E2=80=AFAM Oliver Upton <oliver.upton@linu=
x.dev> wrote:
> > >
> > > Hi Raghavendra,
> > >
> > > On Tue, Jun 06, 2023 at 07:28:51PM +0000, Raghavendra Rao Ananta wrot=
e:
> > > > The series is based off of upstream v6.4-rc2, and applied David
> > > > Matlack's common API for TLB invalidations[1] on top.
> > >
> > > Sorry I didn't spot the dependency earlier, but this isn't helpful TB=
H.
> > >
> > > David's series was partially applied, and what remains no longer clea=
nly
> > > applies to the base you suggest. Independent of that, my *strong*
> > > preference is that you just send out a series containing your patches=
 as
> > > well as David's. Coordinating dependent efforts is the only sane thin=
g
> > > to do. Also, those patches are 5 months old at this point which is
> > > ancient history.
> > >
> > Would you rather prefer I detach this series from David's as I'm not
> > sure what his plans are for future versions?
> > On the other hand, the patches seem simple enough to rebase and give
> > another shot at review, but may end up delaying this series.
> > WDYT?
>=20
> In cases such as this you'd typically coordinate with the other
> developer to pick up their changes as part of your series. Especially
> for this case -- David's refactoring is _pointless_ without another
> user for that code (i.e. arm64). As fun as it might be to antagonize
> Sean, that series pokes x86 and I'd like an ack from on it.
>=20
> So, please post a combined series that applies cleanly to an early 6.4
> rc of your choosing, and cc all affected reviewers/maintainers.

+1
