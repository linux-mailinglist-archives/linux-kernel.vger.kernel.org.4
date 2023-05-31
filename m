Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245F7718935
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 20:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjEaSRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 14:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEaSRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 14:17:07 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E99126
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 11:17:06 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1a15ce37b39so67533fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 11:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685557026; x=1688149026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKE7gLneboHzBYpBQs2sbluEvJxYw167pBbu10odVYc=;
        b=WjgN/rQ6A6sy6x1UGKx0hZUiHK/3aru6qw39NAaT7SV65yJHIjt1fXFfINdMz3mftd
         E/Yoxh5e7Wgu3nPlRvoONaHNk6EusOa4m2eJsQRkct/wBtqwjMeunwyesJB7clFCTGHj
         YedMkxyg/Knxb/6S3I04JD9Y9RH7xAbJDIabn/iNLahoES7UKHhV0/SNPHOgWbmzIuA6
         WcJ/eVeNPltZjtt+0SITiVCOvAiWODUJdDZ9fUlXIzpg9aBp1Kd7+HLe1RNZKpWbXFmz
         uC1ssYRLUn7kfdI2SsSE7kyv4e6huTnGCnfYfe6Mn9m2/LbPaVCENEdZSW0EoM9w12Fk
         LCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685557026; x=1688149026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IKE7gLneboHzBYpBQs2sbluEvJxYw167pBbu10odVYc=;
        b=KZQjTLgzFSEjBA83GWO++n3u5rbok6ZQC6z0hHmokMeERnOVL3AoY0c9p4G8uDyTO8
         FQFtFWozEbwWp1NrwBr+mhathtOgZR6GS0aYqTLfdgxYcB6+TzbsKM4E0eanQk7DrPVU
         P31aeg8eonBw0N69AhKh4wQuGeVbXan6pn2uqKxZoBh0lgh73A7kLUnL2akD3Z2Ksjhl
         miMzVyJfryQtbyjVmLDSRXTBxxqS6wx9yc4hhczSNXEE3EveLuzwhBe3elSCc7HRlcmC
         VOyY/776jq+wi8Qifm2X0yts2lKCwov113v3weZvKfniqJ6HkkvKNHePHaN5OVgIiItz
         ksCQ==
X-Gm-Message-State: AC+VfDwpO/DHlAUlHxTrj2q1lsptBUtYCv0uAPNAvRTEKHitmM2p6ySJ
        zFj7jCC5ZOPM1uDJ4N5XAsDIA9KPG+2lbGHxauc=
X-Google-Smtp-Source: ACHHUZ6cLe1ZQVM8glQY1J5ntv8EYVB9R8yV7noymkqrytZ5v9UmE1VzoQp4Yp73YfIKYBX8LGitTg1kRp59ixYa7RQ=
X-Received: by 2002:a05:6870:e19:b0:199:a7f5:61fa with SMTP id
 mp25-20020a0568700e1900b00199a7f561famr3510327oab.58.1685557025625; Wed, 31
 May 2023 11:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230330152040.1838353-1-trix@redhat.com> <6dac0c4b-a792-849b-97be-31ad3a527e7b@amd.com>
 <CY8PR12MB743581364ACB8E28AB149A48858E9@CY8PR12MB7435.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB743581364ACB8E28AB149A48858E9@CY8PR12MB7435.namprd12.prod.outlook.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 31 May 2023 14:16:54 -0400
Message-ID: <CADnq5_NP=bGpe6cih7pnYauNWccLzetzZxvg2zAiaWrJRJQG9w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: remove unused sq_int_priv variable
To:     "Kim, Jonathan" <Jonathan.Kim@amd.com>
Cc:     "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Tom Rix <trix@redhat.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 12:04=E2=80=AFPM Kim, Jonathan <Jonathan.Kim@amd.co=
m> wrote:
>
> [Public]
>
> Hi Felix,
>
> That is correct.  The debugger will need sq_int_priv to work.

I'll just apply this for now.  We can squash the revert into the
debugger changes once those land.

Alex

>
> Thanks,
>
> Jon
>
> > -----Original Message-----
> > From: Kuehling, Felix <Felix.Kuehling@amd.com>
> > Sent: Thursday, March 30, 2023 11:39 AM
> > To: Tom Rix <trix@redhat.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>;
> > airlied@gmail.com; daniel@ffwll.ch; nathan@kernel.org;
> > ndesaulniers@google.com; Kim, Jonathan <Jonathan.Kim@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; lin=
ux-
> > kernel@vger.kernel.org; llvm@lists.linux.dev
> > Subject: Re: [PATCH] drm/amdkfd: remove unused sq_int_priv variable
> >
> > Am 2023-03-30 um 11:20 schrieb Tom Rix:
> > > clang with W=3D1 reports
> > > drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_int_process_v11.c:282:38:
> > error: variable
> > >    'sq_int_priv' set but not used [-Werror,-Wunused-but-set-variable]
> > >          uint8_t sq_int_enc, sq_int_errtype, sq_int_priv;
> > >                                              ^
> > > This variable is not used so remove it.
> >
> > Hi Jon,
> >
> > I think your debugger patches are going to start using this. Can you
> > comment?
> >
> > I'd prefer not to apply this patch now, as Jon's patches are expected t=
o
> > land soon, once Alex is done upstreaming GFX 9.4.3 support.
> >
> > Regards,
> >    Felix
> >
> >
> > >
> > > Signed-off-by: Tom Rix <trix@redhat.com>
> > > ---
> > >   drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c | 9 +--------
> > >   1 file changed, 1 insertion(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> > > index 0d53f6067422..bbd646c0dee7 100644
> > > --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> > > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> > > @@ -279,7 +279,7 @@ static void event_interrupt_wq_v11(struct kfd_dev
> > *dev,
> > >   {
> > >     uint16_t source_id, client_id, ring_id, pasid, vmid;
> > >     uint32_t context_id0, context_id1;
> > > -   uint8_t sq_int_enc, sq_int_errtype, sq_int_priv;
> > > +   uint8_t sq_int_enc, sq_int_errtype;
> > >     struct kfd_vm_fault_info info =3D {0};
> > >     struct kfd_hsa_memory_exception_data exception_data;
> > >
> > > @@ -348,13 +348,6 @@ static void event_interrupt_wq_v11(struct kfd_de=
v
> > *dev,
> > >                             break;
> > >                     case SQ_INTERRUPT_WORD_ENCODING_INST:
> > >                             print_sq_intr_info_inst(context_id0,
> > context_id1);
> > > -                           sq_int_priv =3D REG_GET_FIELD(context_id0=
,
> > > -
> >       SQ_INTERRUPT_WORD_WAVE_CTXID0, PRIV);
> > > -                           /*if (sq_int_priv &&
> > (kfd_set_dbg_ev_from_interrupt(dev, pasid,
> > > -
> >       KFD_CTXID0_DOORBELL_ID(context_id0),
> > > -
> >       KFD_CTXID0_TRAP_CODE(context_id0),
> > > -                                           NULL, 0)))
> > > -                                   return;*/
> > >                             break;
> > >                     case SQ_INTERRUPT_WORD_ENCODING_ERROR:
> > >                             print_sq_intr_info_error(context_id0,
> > context_id1);
