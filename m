Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612587114E7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242166AbjEYSlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242590AbjEYSkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:40:49 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9067210D2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 11:38:24 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-510d6e1f1abso5362654a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 11:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685039753; x=1687631753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LfxAZR8t52u4AO1SI5kqvS9LLBpQSJuHQCFUX9OzGQ=;
        b=g9JfbEY9bxh9EFIPrAmrY+rOfrj+WxxnuJ/cu8Dy8jgAuxdkF7fJ2GQ1kUODnVFDDz
         +hBd/VU0QaeUH2K+JB3vk6q2kH+7eqi54cjsOTvNUgE5r+nXS3C6PV2JrI6tjglNMGAP
         h/52M9XN3BDzkpN0nx83F6MNLOM075WaOwoUQGDGM7nsbMETbyvN+F9OJ45JlObjkAoB
         VlsoaCqwUJr1ckApxtYKGoKag0/TgNw/iB25yH2nu1Y7nHljvljytaCKr5NSJ0pMBcGT
         QlO0NXoj8ryYtS/Hk5r5LLvG0XWLQeHITLweEidUZmOz49K4Ax6Fy5RV+mBaYxZzNg7S
         Y7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685039753; x=1687631753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LfxAZR8t52u4AO1SI5kqvS9LLBpQSJuHQCFUX9OzGQ=;
        b=ahMPVpA9DmNl377appzwywtLDhwbXsDxk2tcYosB/MgAYgWOBZr+UBdd/MiWOz1TWQ
         8LWybNt0XKLP2eDuw5cUZ5Mo034eBesoePSHiWbKU5n9IBrt+L/oCyxURuqpavfjyirY
         g9KmGu7xndoXTOp7zTF0uaOsGVl17UZwoP+ub/T3wzj+hMIkMbYxu1BRtIs5ZGdw05as
         9AnuIvoH+/+l+Tvo9eZNfe+rw/zM5Gzdpu2eztlZhUjwA9EY+CfsuE3pfa1DOEXOwFTY
         guhgTsSF5TLoGXw1ze/lEMxBoviA6uGRngYJZUPGkdh+7mJ7r66Ooo5agjzQEVv9y7p5
         BRmw==
X-Gm-Message-State: AC+VfDzlDMUEqeuQSvEGUO6KAf/P5QgGaYzryd9SvJfVEaTIYemJ+gZh
        UD2qOsEAN3cW7VyUEkZJhKCiOt2UX0Gxv+h24ZM=
X-Google-Smtp-Source: ACHHUZ6HhImvycIW5y9vQ9Fb6/lTe4cNBTqpqgaXHCHK9T60sVxAPi6KnVa8R196FbkpqvqTomfV6C0HgBOSM2p6AwU=
X-Received: by 2002:a17:906:6a0c:b0:96f:3e35:748a with SMTP id
 qw12-20020a1709066a0c00b0096f3e35748amr3072640ejc.6.1685039753202; Thu, 25
 May 2023 11:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230525122837.649627-1-daniel.baluta@oss.nxp.com> <69c2b7cd-f211-47ef-b42a-609ee792de11@sirena.org.uk>
In-Reply-To: <69c2b7cd-f211-47ef-b42a-609ee792de11@sirena.org.uk>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 25 May 2023 21:35:40 +0300
Message-ID: <CAEnQRZAseAmOHLBsBQuW+SqEFbT-pbrjpUiPhSuv8Ww2VoJf_w@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: SOF: imx: Add OF machine descriptors for i.MX platforms
To:     Mark Brown <broonie@kernel.org>
Cc:     Daniel Baluta <daniel.baluta@oss.nxp.com>,
        alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
        lgirdwood@gmail.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 8:07=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Thu, May 25, 2023 at 03:28:37PM +0300, Daniel Baluta wrote:
>
> > +static struct snd_sof_of_mach sof_imx8_machs[] =3D {
> > +     {
> > +             .compatible =3D "fsl,imx8qxp",
> > +             .drv_name =3D "asoc-simple-card",
> > +             .sof_tplg_filename =3D "sof-imx8.tplg",
> > +     },
> > +     {
> > +             .compatible =3D "fsl,imx8qm",
> > +             .drv_name =3D "asoc-simple-card",
> > +             .sof_tplg_filename =3D "sof-imx8.tplg",
> > +     },
> > +     {}
>
> It seems a bit sad to be adding simple-card rather than audio-graph-card
> at this point - is there some great reason for this?

This is what we used so far and it works pretty well for us.

Is there a plan to deprecate simple-card? And switch to audio-graph-card?

We could have a look at this if this is the correct direction.
