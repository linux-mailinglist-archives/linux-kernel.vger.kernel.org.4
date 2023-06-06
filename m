Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F67E724BDB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237766AbjFFSxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239120AbjFFSxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:53:14 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8639E101
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 11:53:13 -0700 (PDT)
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A04DE3F137
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 18:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686077590;
        bh=O7c9jllOavC2DNF1C1Xfog7N8o3vExmBU6I3qtmzVS0=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=hmrL2LDqLhnNEMoYLFCtMNtAU0cAOSrpCLs0beDmaCfWt9I3lx/S8nVVeAlLGTXd/
         NS2/B3zpXvO9FAx6imMkPxCDxAuXmSoeJUBfYtUYpY8+FaM6EyeTI8SEGVUo18Ipds
         A6seL+OiQmkPDwvOego9aaX7O8A6Np5a+8ojo6FOqSNOLAMDRWYJIqQMnaKgvSA1Sf
         XlYvBubUBetfcFhlG77eDZHgD0cIAN+tTKDqZvEOlIEuGkz7mT2Z2Y8MQXJGAlN8Hi
         Gupqlal8ayBlvCnT5mQTjE2iQU3Ja1MiIQochD5rOT847iVHcboIswyJA5y3L8qKkE
         DN1DWtKTYXHyQ==
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-56942442eb0so95055167b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 11:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686077589; x=1688669589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7c9jllOavC2DNF1C1Xfog7N8o3vExmBU6I3qtmzVS0=;
        b=BXgjtGbJtk0vWPh5CqBgFi68mSvFlwpDUyVavEQwE6Xy7kRLQlrzpsqwuY/RJnvQ59
         wm/ED/p7OOlmOyZGHjo7pPDOemVM0AhXQakORK7l9j0zIswnx5qHbRaQWaGJdF1AzzyO
         mBPPOSE/1d1t0P53SO/FB21N478yTa/4OYdT0b4M35Z3vHx7x/+daeeafBwkwaIncXSq
         +i7glYbPDKJjlN8fepP8oSfs0eSU40BqSiWilSLoMoia1m0o8GCqDtZt74EeoD1XowEn
         qjjpcE8o68v3KT1RMlONKwrQXBAPYGiBkJNffTVFlvzSZzJ4XK919TVeD7pt+Abtc/sU
         9JzQ==
X-Gm-Message-State: AC+VfDz9b1IcdGTtKjE5p7M8KC2d1BU83yhwvUFGQxywPGkXZb4jH8DG
        w808tNqUJHSSYz+DT5pf8ZsNqf+/OwYaWp+TBpNPW57QhqdM/fzvG70NVt8t7a0dOjDMGsZKIbm
        SfyEcJyuNZXMkG0p/gnhO65zTtCMWPdJQvC5lN/I7u+xKanr+ljimS0D+2g==
X-Received: by 2002:a81:8506:0:b0:561:a41d:61cd with SMTP id v6-20020a818506000000b00561a41d61cdmr3256231ywf.46.1686077589645;
        Tue, 06 Jun 2023 11:53:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ638ntLkmBVo/7tTRDckMwwNJGVc7B1PrmgadtZVGh4at7ds3Tk7ua8R6RCLE+v3356OnvzxJS6MixFILTtwa8=
X-Received: by 2002:a81:8506:0:b0:561:a41d:61cd with SMTP id
 v6-20020a818506000000b00561a41d61cdmr3256210ywf.46.1686077589449; Tue, 06 Jun
 2023 11:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230522161249.800829-1-aleksandr.mikhalitsyn@canonical.com>
 <20230522161249.800829-3-aleksandr.mikhalitsyn@canonical.com> <ZH9/Drgo+sDYTGIG@google.com>
In-Reply-To: <ZH9/Drgo+sDYTGIG@google.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Tue, 6 Jun 2023 20:52:58 +0200
Message-ID: <CAEivzxeOYX+W4oBDdbOB7b2bRKFLf7YxFHzpR_8HFu2jN7puiA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] KVM: SVM: enhance info printk's in SEV init
To:     Sean Christopherson <seanjc@google.com>
Cc:     pbonzini@redhat.com,
        =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 6, 2023 at 8:46=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Mon, May 22, 2023, Alexander Mikhalitsyn wrote:
> > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > index cc832a8d1bca..fff63d1f2a34 100644
> > --- a/arch/x86/kvm/svm/sev.c
> > +++ b/arch/x86/kvm/svm/sev.c
> > @@ -2224,7 +2224,6 @@ void __init sev_hardware_setup(void)
> >               goto out;
> >       }
> >
> > -     pr_info("SEV supported: %u ASIDs\n", sev_asid_count);
> >       sev_supported =3D true;
> >
> >       /* SEV-ES support requested? */
> > @@ -2252,10 +2251,16 @@ void __init sev_hardware_setup(void)
> >       if (misc_cg_set_capacity(MISC_CG_RES_SEV_ES, sev_es_asid_count))
> >               goto out;
> >
> > -     pr_info("SEV-ES supported: %u ASIDs\n", sev_es_asid_count);
> >       sev_es_supported =3D true;
> >
> >  out:
> > +     if (boot_cpu_has(X86_FEATURE_SEV))
> > +             pr_info("SEV %s (ASIDs %u - %u)\n",
> > +                     sev_supported ? "enabled" : "disabled", min_sev_a=
sid, max_sev_asid);
> > +     if (boot_cpu_has(X86_FEATURE_SEV_ES))
> > +             pr_info("SEV-ES %s (ASIDs %u - %u)\n",
> > +                     sev_es_supported ? "enabled" : "disabled", 1, min=
_sev_asid - 1);
>
> The min should print '0' if min_sev_asid<=3D1, otherwise the output will =
be
>
>         SEV-ES disabled (ASIDs 1 - 0)
>
> which is confusing.  That would also align with what gets printed out for=
 SEV
> when it's not supported at all (min=3D=3Dmax=3D0).
>
> No need for v3, I'll fixup when applying.

Got it. Ok!

Thanks again for looking into that.

Kind regards,
Alex
