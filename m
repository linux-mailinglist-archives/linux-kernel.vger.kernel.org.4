Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4616C3CD7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 22:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjCUVi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 17:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCUViZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 17:38:25 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96141DBDF
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 14:38:24 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id k4-20020a17090aef0400b0023fcccbd7e6so1856630pjz.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 14:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679434704;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G0Rv+FDCbn7GlG8ZYRl57/7tDeYBLpzwRQIrpn91yhA=;
        b=SGuneyhBonT7AIGMuI+e9aO8lp958VZS9TQHcNvOO0mQKDB1I84+TJ/UvPepRDNdct
         qTNizvZq81n0b69qICnOZDdkyeJJ2PCjsA8F3LLNq0+LD8uRNa6dCMqKgWFPCOJBbsIQ
         4p8jiQK41FKlcp4Du10z5+SR3bMwr5f+nQOwG3hI04LdMqsEsqhjFI8WfQp8gRPPXY1i
         E1GS2+YzVHH13nE8sTqiCX/P5AsBv5rfAjQO8tK28oWc6SfV+UhYPhtvjhZy4ZqW0L28
         cZHcxxtdMfefkvJwYK4LSzDt1JVXaYlLqHtgawwPkwHboNIluET7UoAwH1+92SNQ4/1E
         95ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679434704;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G0Rv+FDCbn7GlG8ZYRl57/7tDeYBLpzwRQIrpn91yhA=;
        b=idkLsibHe/8upu62SXXmI1Uy/Gi1cGKKd/NP5wVGmbeFzKHi9pxMBgSeVO7Lg5EPh2
         1ujHqzaKfJwtUczzq5+lmOc/TJJ07d6aNF97bVSErGeX4D/IQnrsGoOygW6bokAnYerO
         Ah3l020QKrmRzrL1zStj3qhc3aIlugAt5fh8165oNQXUTC4LoVWyjlvktbCbEkNvA08u
         IhcIfAG+2j4a29xc0OyyhISesWuNZ4MwA7RpvTvbLBaFMOZLArhfQJ4yxPPX7NAyq49U
         hBpNqO1yOnzNMCQvpPxzaog9moh6TwRKAUvlRvqdmNzGz03EO1+xa7uFdN9d2o4rWBeM
         ssnQ==
X-Gm-Message-State: AO0yUKWK9hdj7XQVKw82IPC9RC3X2t5+m0GjLfoFMBJcjzCUD4zNHqeE
        io0A016LOlbVr/QVoLEAWUt+/QckgTc=
X-Google-Smtp-Source: AK7set9Ad2gBkvSRJpVrwWh1laoJXrL8OL7BCZkq1AP5GX4jqPjlsahoWbJH6kgiGOfeo3/4qdRwOX0/yFI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:66d4:0:b0:507:68f8:4369 with SMTP id
 c20-20020a6566d4000000b0050768f84369mr121854pgw.12.1679434704147; Tue, 21 Mar
 2023 14:38:24 -0700 (PDT)
Date:   Tue, 21 Mar 2023 14:38:22 -0700
In-Reply-To: <ZBoMIJipRtmvsNXg@google.com>
Mime-Version: 1.0
References: <20230211014626.3659152-1-vipinsh@google.com> <ZBTwX5790zwl5721@google.com>
 <ZBj9L2VUjEbWbgcS@google.com> <CAHVum0feM8hnD-+dXF4jiug8tmpm9GBAh619Xf279LNSm=Jozw@mail.gmail.com>
 <ZBoMIJipRtmvsNXg@google.com>
Message-ID: <ZBojzhwQcFJrY4jw@google.com>
Subject: Re: [Patch v3 0/7] Optimize clear dirty log
From:   Sean Christopherson <seanjc@google.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     pbonzini@redhat.com, bgardon@google.com, dmatlack@google.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
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

On Tue, Mar 21, 2023, Sean Christopherson wrote:
> It won't.  MMU_WARN_ON() is dead code without manual modification to defi=
ne MMU_DEBUG.
> Part of the reason I used MMU_WARN_ON() was to remind myself to send a pa=
tch/series
> to overhaul MMU_WARN_ON[*].  My thought/hope is that a Kconfig will allow=
 developers
> and testers to run with a pile of assertions and sanity checks without im=
pacting
> the runtime overhead for production builds.
>=20
> [*] https://lore.kernel.org/all/Yz4Qi7cn7TWTWQjj@google.com/

Ugh, I'm definitely sending that patch, MMU_DEBUG has bitrotted and broken =
the
build yet again.

arch/x86/kvm/mmu/mmu.c: In function =E2=80=98kvm_mmu_free_shadow_page=E2=80=
=99:
arch/x86/kvm/mmu/mmu.c:1738:15: error: implicit declaration of function =E2=
=80=98is_empty_shadow_page=E2=80=99; did you mean =E2=80=98to_shadow_page=
=E2=80=99? [-Werror=3Dimplicit-function-declaration]
 1738 |  MMU_WARN_ON(!is_empty_shadow_page(sp->spt));
      |               ^~~~~~~~~~~~~~~~~~~~
include/asm-generic/bug.h:110:25: note: in definition of macro =E2=80=98WAR=
N_ON_ONCE=E2=80=99
  110 |  int __ret_warn_on =3D !!(condition);   \
      |                         ^~~~~~~~~
arch/x86/kvm/mmu/mmu.c:1738:2: note: in expansion of macro =E2=80=98MMU_WAR=
N_ON=E2=80=99
 1738 |  MMU_WARN_ON(!is_empty_shadow_page(sp->spt));
      |  ^~~~~~~~~~~

