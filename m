Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE1B5F689F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 15:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiJFN4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 09:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiJFN4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 09:56:48 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C4DAC3BB;
        Thu,  6 Oct 2022 06:56:45 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id d22-20020a4a5216000000b0047f740d5847so1424897oob.13;
        Thu, 06 Oct 2022 06:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/tGLue9QFBddVGPG1fUu/Vm6K4t9pa+6ym9D6yr+ZRI=;
        b=CJxfJ6xRFvFe0xRGHXb7hO+RqzLhVdFEA3eJcGFTiAeLFAGNotEztpUo78DXDaglEU
         iTwHL2Vj4qZZhRBZ/4fip4PYYNzGxdn5MF5FXTJ2zoOwF2DT4G4xiAYC8d+gGWMwnff5
         0+FV+xCihxnquE3kJZbBcPZLSWgxyPxHg1DoSRDWo/L2JCexXjSpeJ5SmBr0M1h0wC8z
         SoIhDyv6A7R45rCVGfOYcN3fcNHqaSuEeb7C8ALy30+aVVNwgjiqkLQhDJTaPZw0Nmaj
         cqJyZ1cRljeRrAy7ayEZNV/GZ2OW/wJ7WmwSuvtY7D1wj8BgSwqc2pC/+6vzJGKaHV1s
         YprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/tGLue9QFBddVGPG1fUu/Vm6K4t9pa+6ym9D6yr+ZRI=;
        b=pq5KXlR8JOjMMLCzNLlnXp6BKyePMlSEdMvRoXfERWUzKSY/D5D2VtpjaTKvnpq8pT
         9KYmFUW/U2io77SCT/wFR2gBlUfMGHnSKV1a3VF39yUtEFZLRdLBkkS3wKXcczATAL/A
         EJGUUqr/S7bKBj+hHPSh6gMUfpsGkEj25k1+lqKNGHlMGXlnjziOC8kA4vWI3beK3LBo
         Z0JdZaeP4hNjB5IkRe7J0949wPzVcBtwOxu3qry0to+nEfbLkTYGgbEJYPkaxKSB+vK7
         L8dZLc07V/5C1OcfviImhiL6lC+hBV3v7Xt37QDcfpGrzIdLQ9hOje8qoAna97pnAtJ7
         TQvQ==
X-Gm-Message-State: ACrzQf2kwldLtZy0k+aaAE37mVip85Gz0ItWOiqFF4wHLxtDditoCbNo
        dKmifKETSuoo4N6QDQMK+L5ZX6QW+xHr0Mix7sE=
X-Google-Smtp-Source: AMsMyM7JEhRZLznaTVpUQ/ANn7XeGLOBPX/p97js8u3mIR8qd0bxqegHsBBzxRIQ4nttfAXKtUHNfSMd4v28DjD5t5U=
X-Received: by 2002:a9d:6215:0:b0:660:f41e:513a with SMTP id
 g21-20020a9d6215000000b00660f41e513amr1490380otj.123.1665064603933; Thu, 06
 Oct 2022 06:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220930105434.111407-1-broonie@kernel.org> <20221004132047.435d42db@canb.auug.org.au>
 <CAMwc25oshRcJBoCT70B+b42bh5sPqgyoHuBx6K6ZLrwBMHnJzw@mail.gmail.com>
 <20221004140558.64f59f2c@canb.auug.org.au> <YzwbW4YQwQPsRPYw@sirena.org.uk>
 <CADnq5_PbPQPui1tOdUMB+OYbz6UBMKCgtwvE95oA+SfcN0RzNg@mail.gmail.com>
 <09cd11c5-2a15-3653-957c-88c751fa9029@amd.com> <20221006092810.0c3a2238@canb.auug.org.au>
 <20221006191245.11bb0e2c@canb.auug.org.au>
In-Reply-To: <20221006191245.11bb0e2c@canb.auug.org.au>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 6 Oct 2022 09:56:32 -0400
Message-ID: <CADnq5_N1cZiG39KzUzdHCtLRRCipMMNXjaNuAvoQs8=VTjtGCA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the drm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Airlie <airlied@redhat.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
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

This looks good to me.  Care to add you s-o-b?

Alex

On Thu, Oct 6, 2022 at 4:12 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> On Thu, 6 Oct 2022 09:28:10 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > I have applied the following hack for today:
> >
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Thu, 6 Oct 2022 09:14:26 +1100
> > Subject: [PATCH] fix up for drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> >
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> > index ae13887756bf..a5da787b7876 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> > @@ -520,9 +520,9 @@ bool dc_stream_remove_writeback(struct dc *dc,
> >       }
> >
> >       /* remove writeback info for disabled writeback pipes from stream */
> > -     for (i = 0, j = 0; i < stream->num_wb_info && j < MAX_DWB_PIPES; i++) {
> > +     for (i = 0, j = 0; i < stream->num_wb_info && i < MAX_DWB_PIPES; i++) {
> >               if (stream->writeback_info[i].wb_enabled) {
> > -                     if (i != j)
> > +                     if ((j >= 0) && (j < i))
> >                               /* trim the array */
> >                               stream->writeback_info[j] = stream->writeback_info[i];
> >                       j++;
>
> This works as well, and (in my opinion) is better:
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> index ae13887756bf..fb6222d4c430 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> @@ -499,7 +499,7 @@ bool dc_stream_remove_writeback(struct dc *dc,
>                 struct dc_stream_state *stream,
>                 uint32_t dwb_pipe_inst)
>  {
> -       int i = 0, j = 0;
> +       unsigned int i, j;
>         if (stream == NULL) {
>                 dm_error("DC: dc_stream is NULL!\n");
>                 return false;
> @@ -520,9 +520,9 @@ bool dc_stream_remove_writeback(struct dc *dc,
>         }
>
>         /* remove writeback info for disabled writeback pipes from stream */
> -       for (i = 0, j = 0; i < stream->num_wb_info && j < MAX_DWB_PIPES; i++) {
> +       for (i = 0, j = 0; i < stream->num_wb_info; i++) {
>                 if (stream->writeback_info[i].wb_enabled) {
> -                       if (i != j)
> +                       if (j < i)
>                                 /* trim the array */
>                                 stream->writeback_info[j] = stream->writeback_info[i];
>                         j++;
>
> --
> Cheers,
> Stephen Rothwell
