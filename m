Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC8A624C52
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 22:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiKJVBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 16:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiKJVBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 16:01:38 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E337CBF43
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:01:37 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-13b103a3e5dso3529282fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uSbodY8FqZ0Ciim/vAb77VV4F9ElrHL2UVuKiq5ungA=;
        b=YMGD8nMS55gvLSoZ8tKrtFoOZ/Ve6TrHy42MgIRNg7/fmubAxDJH5DG0RW10SxvOeP
         DjTT4GnaBPcWIi5FHosoNTKOgkLUY73yZvvLd9GalbDMFolHEKGR8P2hdFUvIFmPB/SO
         BrV90aXQ1eoZkI6c1yhjIGCApzY+hu3tS/DTZEU/Fg2s7BMNOWpnAvF4Cuip1vbjLDDi
         Wi0Cf6JFPCLTbtm34QorcHgGhquebmcOqtlB6bTQLk4Mr7H+4Eba3Bf+AHWKYeyJTbOW
         TJMserRFDaCMIXo5v2+5i1CgxrdLo/ul7beHcB3VpcJHaJjJRJj3Y82oz8ECPN2Z55/w
         fCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uSbodY8FqZ0Ciim/vAb77VV4F9ElrHL2UVuKiq5ungA=;
        b=RfFdCKHgh1+wX9nQM5Aoilns6QgVqcVn1HDWu7EV6nX3ngfrYIC8tBLqrBWtmgLHg9
         lO92EHSCdENEXny8G0cGQ3UDl7hiTaXmJvgBiCe03pvcWNIXo5++EKKcBKpnWXpcFXxf
         ASIuOF0Ux07RS+JjTzwBCM/wVMm0pTRD2lGzGpvmjbJsRaR6T5lt0bOa2m3CVrTAJV9y
         1G413aDRTb3iypBX1BH0Sc95TfRbuZF+pmT5/qVLdmbSsFksVSwyqPVPe1L97NOBXGBr
         MeWj+V2a04VQ4tBXEmce97cyaHSxqiTxt8ZNTrw0O4zPA6z4E3tFQwuNGNs4S5ujqXbN
         FAWg==
X-Gm-Message-State: ACrzQf12pB3fBPdAtxgoJzv2skBGLbAzvNeqVHLqOwkTMx+SAymWCiM0
        p2NPbUkk4FiwavydGS2S0VKW832Garhit2ezGnOdqg==
X-Google-Smtp-Source: AMsMyM5Lbc1uK8AP5uOpZgGwnsT6w5cfTgiZG9wE2H4u+6rVvgryo+vd5IZC988GgRuXQXR3iL+1Gj8CZ3j8fJF1g8o=
X-Received: by 2002:a05:6870:ab84:b0:13c:7d1c:5108 with SMTP id
 gs4-20020a056870ab8400b0013c7d1c5108mr2177638oab.282.1668114096980; Thu, 10
 Nov 2022 13:01:36 -0800 (PST)
MIME-Version: 1.0
References: <mhng-9e6b4607-6bea-411c-b843-916c1e0798ee@palmerdabbelt-glaptop> <182c1d4e-a117-79d6-4dd1-8e3c8a447b4a@ghiti.fr>
In-Reply-To: <182c1d4e-a117-79d6-4dd1-8e3c8a447b4a@ghiti.fr>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 10 Nov 2022 13:01:26 -0800
Message-ID: <CACT4Y+YYAfTafFk7DE0B=qQFgkPXS7492AhBdY_CP1WdB8CGfA@mail.gmail.com>
Subject: Re: [PATCH] riscv: Bump COMMAND_LINE_SIZE value to 1024
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, macro@orcam.me.uk,
        david.abdurachmanov@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-api@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

On Mon, 21 Jun 2021 at 00:11, Alex Ghiti <alex@ghiti.fr> wrote:
>
> Hi Palmer,
>
> Le 23/04/2021 =C3=A0 04:57, Palmer Dabbelt a =C3=A9crit :
> > On Fri, 02 Apr 2021 11:33:30 PDT (-0700), macro@orcam.me.uk wrote:
> >> On Fri, 2 Apr 2021, David Abdurachmanov wrote:
> >>
> >>> > > >  This macro is exported as a part of the user API so it must
> >>> not depend on
> >>> > > > Kconfig.  Also changing it (rather than say adding
> >>> COMMAND_LINE_SIZE_V2 or
> >>> > > > switching to an entirely new data object that has its dimension
> >>> set in a
> >>> > > > different way) requires careful evaluation as external binaries
> >>> have and
> >>> > > > will have the value it expands to compiled in, so it's a part
> >>> of the ABI
> >>> > > > too.
> >>> > >
> >>> > > Thanks, I didn't realize this was part of the user BI.  In that
> >>> case we
> >>> > > really can't chage it, so we'll have to sort out some other way
> >>> do fix
> >>> > > whatever is going on.
> >>> > >
> >>> > > I've dropped this from fixes.
> >>> >
> >>> > Does increasing COMMAND_LINE_SIZE break user-space binaries? I woul=
d
> >>> > expect it to work the same way as adding new enum values, or adding
> >>> > fields at the end of versioned structs, etc.
> >>> > I would assume the old bootloaders/etc will only support up to the
> >>> > old, smaller max command line size, while the kernel will support
> >>> > larger command line size, which is fine.
> >>> > However, if something copies /proc/cmdline into a fixed-size buffer
> >>> > and expects that to work, that will break... that's quite unfortuna=
te
> >>> > user-space code... is it what we afraid of?
> >>> >
> >>> > Alternatively, could expose the same COMMAND_LINE_SIZE, but interna=
lly
> >>> > support a larger command line?
> >>>
> >>> Looking at kernel commit history I see PowerPC switched from 512 to
> >>> 2048, and I don't see complaints about the ABI on the mailing list.
> >>>
> >>> If COMMAND_LINE_SIZE is used by user space applications and we
> >>> increase it there shouldn't be problems. I would expect things to
> >>> work, but just get truncated boot args? That is the application will
> >>> continue only to look at the initial 512 chars.
> >>
> >>  The macro is in an include/uapi header, so it's exported to the userl=
and
> >> and a part of the user API.  I don't know what the consequences are fo=
r
> >> the RISC-V port specifically, but it has raised my attention, and I th=
ink
> >> it has to be investigated.
> >>
> >>  Perhaps it's OK to change it after all, but you'd have to go through
> >> known/potential users of this macro.  I guess there shouldn't be that
> >> many
> >> of them.
> >>
> >>  In any case it cannot depend on Kconfig, because the userland won't h=
ave
> >> access to the configuration, and then presumably wants to handle any a=
nd
> >> all.
> >
> > It kind of feels to me like COMMAND_LINE_SIZE shouldn't have been part
> > of the UABI to begin with.  I sent a patch to remove it from the
> > asm-generic UABI, let's see if anyone knows of a reason it should be UA=
BI:
> >
> > https://lore.kernel.org/linux-arch/20210423025545.313965-1-palmer@dabbe=
lt.com/T/#u
>
> Arnd seemed to agree with you about removing COMMAND_LINE_SIZE from the
> UABI, any progress on your side?

Was this ever merged? Don't see this even in linux-next.
