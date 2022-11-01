Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C75F6154BD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiKAWJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiKAWJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:09:29 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B623DEA1;
        Tue,  1 Nov 2022 15:09:28 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-13b103a3e5dso18397182fac.2;
        Tue, 01 Nov 2022 15:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IvStYSLqkWuMUwFL9pdUVrHNd8JNHDxjRFTnT52p7/c=;
        b=PjvZ7puHv+7V90LzJQPQaPyKXQrTIqJUZZLssvIWtIBipGVdOG7/MaPwIHfeqHkeRc
         KHfuwDz+A2r+ABa15478ookJDiRBnfALN+BuePEMc1Ex9su7/7WguQAoXAyKOoth/KbL
         APgp4aFD8yu67uTpxSeuKZ6enrP+NBtx2+bYLyhXMybpnESlwt+QGTlEU4I7hgCbigB7
         lCO+XBCRvgI+8VzchZ6ogM5qEv3tHKcWSVqccF9ZyFI0D3vxyZ2TfD0Lq4DxsCSV+srw
         r7CB4DXBoiAMa4GAGkpEFLsto+kdfO1YeZGuNZK7w6e7V5ImNz0A3M/L4PvxVwRN1ONF
         Hz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IvStYSLqkWuMUwFL9pdUVrHNd8JNHDxjRFTnT52p7/c=;
        b=bgI+xJjv38v5SyWKqCgQebfAHdPzslFpZQcU7MGfaw1APdoTDX89BtYGxgVRjGmDEo
         z/+xYVQeUvnm78h6UyPKiZlo+FJuMzdwZWBK13bPDXBz5l3C8BOIPrR82PPmBcFVjDDa
         Ld7BftpfMDRlzqN6Ji9JWKmEXMuWFiMpyt9vmgZKLguCDhqkTg/oUQYTEhsJ5+3/SXBD
         DkEC0efpKOVcmf3WhODb4ZU/1PilnUg2Zsf80EJNvR+SnKPlqDPccuuEhbHc3t8qB7Fk
         MpI0TaUo2lModjTYvM02yAAPMuF7mETFaxgWJ1C4+9wVn3JIwHGF40mY2r6mL+CNqUfS
         B18w==
X-Gm-Message-State: ACrzQf3tCFEJEplfmTGv5/uSWlgqbMP0WRtqXfmHImTRAtg38gxUM5PN
        tj7K3DPOYQ4eZNtlAh4lFqwDzrFUBJ+ayJA3u4c=
X-Google-Smtp-Source: AMsMyM4lBZWMq6jgAvuEXIf45JlEUKQ3kVJp+Onr3xJO3280AGlJn/rv7oo3l1LLZxCdTzBoIr6dRE7i40Zdyylq7M0=
X-Received: by 2002:a05:6870:a7a4:b0:136:7c39:979e with SMTP id
 x36-20020a056870a7a400b001367c39979emr12655316oao.96.1667340567570; Tue, 01
 Nov 2022 15:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <Y1trhRE3nK5iAY6q@mail.google.com> <Y1yetX1CHsr+fibp@mail.google.com>
 <CADnq5_Mod90O=tN26+Yi74WPYxpVtss+LG_+_HZyFv2EtzR+MA@mail.gmail.com> <202211011443.7BDB243D8D@keescook>
In-Reply-To: <202211011443.7BDB243D8D@keescook>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 1 Nov 2022 18:09:16 -0400
Message-ID: <CADnq5_Ou9HnZjQx5WaAZW+iu24g_eS2hh25xhExeQjdMOXYfCQ@mail.gmail.com>
Subject: Re: [PATCH v2] [next] drm/radeon: Replace one-element array with
 flexible-array member
To:     Kees Cook <keescook@chromium.org>
Cc:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 1, 2022 at 5:54 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Nov 01, 2022 at 10:42:14AM -0400, Alex Deucher wrote:
> > On Fri, Oct 28, 2022 at 11:32 PM Paulo Miguel Almeida
> > <paulo.miguel.almeida.rodenas@gmail.com> wrote:
> > >
> > > One-element arrays are deprecated, and we are replacing them with
> > > flexible array members instead. So, replace one-element array with
> > > flexible-array member in struct _ATOM_FAKE_EDID_PATCH_RECORD and
> > > refactor the rest of the code accordingly.
> > >
> > > It's worth mentioning that doing a build before/after this patch results
> > > in no binary output differences.
> > >
> > > This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> > > routines on memcpy() and help us make progress towards globally
> > > enabling -fstrict-flex-arrays=3 [1].
> >
> > This seems like a worthy goal, and I'm not opposed to the patch per
> > se, but it seems a bit at odds with what this header represents.
> > atombios.h represents the memory layout of the data stored in the ROM
> > on the GPU.  This changes the memory layout of that ROM.  We can work
>
> It doesn't though. Or maybe I'm misunderstanding what you mean.
>
> > around that in the driver code, but if someone were to take this
> > header to try and write some standalone tool or use it for something
> > else in the kernel, it would not reflect reality.
>
> Does the ROM always only have a single byte there? This seems unlikely
> given the member "ucFakeEDIDLength" (and the code below).

I'm not sure.  I'm mostly concerned about this:
                                        record +=
fake_edid_record->ucFakeEDIDLength ?

fake_edid_record->ucFakeEDIDLength + 2 :

sizeof(ATOM_FAKE_EDID_PATCH_RECORD);

Presumably the record should only exist if ucFakeEDIDLength is non 0,
but I don't know if there are some OEMs out there that just included
an empty record for some reason.  Maybe the code is wrong today and
there are some OEMs that include it and the array is already size 0.
In that case, Paulo's original patches are probably more correct.

Alex

>
> The problem on the kernel side is that the code just before the patch
> context in drivers/gpu/drm/amd/amdgpu/atombios_encoders.c will become
> a problem soon:
>
>         if (fake_edid_record->ucFakeEDIDLength) {
>                 struct edid *edid;
>                 int edid_size =
>                         max((int)EDID_LENGTH, (int)fake_edid_record->ucFakeEDIDLength);
>                 edid = kmalloc(edid_size, GFP_KERNEL);
>                 if (edid) {
>                         memcpy((u8 *)edid, (u8 *)&fake_edid_record->ucFakeEDIDString[0],
>                                fake_edid_record->ucFakeEDIDLength);
>
>                         if (drm_edid_is_valid(edid)) {
>         ...
>
> the memcpy() from "fake_edid_record->ucFakeEDIDString" will eventually
> start to WARN, since the size of that field will be seen as a single byte
> under -fstrict-flex-arrays. At this moment, no, there's neither source
> bounds checking nor -fstrict-flex-arrays, but we're trying to clean up
> everything we can find now so that we don't have to do this all again
> later. :)
>
> -Kees
>
> P.S. Also this could be shorter with fewer casts:
>
>                 struct edid *edid;
>                 u8 edid_size =
>                         max_t(u8, EDID_LENGTH, fake_edid_record->ucFakeEDIDLength);
>                 edid = kmemdup(fake_edid_record->ucFakeEDIDString, edid_size, GFP_KERNEL);
>                 if (edid) {
>                         if (drm_edid_is_valid(edid)) {
>                                 adev->mode_info.bios_hardcoded_edid = edid;
>         ...
>
> --
> Kees Cook
