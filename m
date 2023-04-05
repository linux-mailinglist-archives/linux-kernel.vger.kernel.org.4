Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6286D784C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 11:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237666AbjDEJaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 05:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237497AbjDEJ3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 05:29:55 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57246186
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 02:29:25 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id l7so33319740pjg.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 02:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1680686963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CB65A8SjX16vPcN6BQCB8Vc5858YsTyuoCI6+70iQws=;
        b=HBDDhFVGtA0Aicl5sg/jfaWecYsYcMbRsHAxUQ2Cz8tDDBS4flOhkmOv0qCU1NcomF
         El0EcpRU94382WLwHA8YVlbhXolyMRSoVL9oJ32ZZpEwGxoET+5mPux51YWbx7xaOTPl
         BSuRofVFClX+/dZlhUu46hxiNjkB20ZbQbEqgSmtPAuTNlAkk2R569QAAmyVVn+nTdPA
         HZA/JCNY+sdBiG0F8szDCfvEIvPN8EP5/B7tHSkk32RlOkUMzRSAgFUcT8Htj4t9jtW/
         3jUl0TV7gZoKacFm3p4I3yZJq+tSdBWFv9cTQDL8AbdSlqa26/m9YN8sC+QAbIicxKFM
         eBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680686963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CB65A8SjX16vPcN6BQCB8Vc5858YsTyuoCI6+70iQws=;
        b=Ur4ycbnkSNcAHM8a9iOlSRowtLzw5COJgKA2s6Z06nSwiFmoQJlY9yujyHyu8fNDmw
         KIntHiWbG5/IzC1N+ONz817Zl96VEmlQjZMOogE74O5zcbrR9pNt0asw76vrt3DgSXnL
         uogXaZZTSZZC5BWb0oekXGJQLLbgZgGo8eMV1vVRPuEeL5cIhxL/eWweu8oVYn8tB166
         OWoEDVrXv+xfPGo80qCqZTmAD4VUlqZha1GEap7UzEBt7lBCjq8cWWZ2jAWVc+P7czwY
         WZjigsChpcYGGO4WCayRcdmVH4d6V0vxoAbKJhXIbKS7jOJtfE8yHUnCinoRyC5Adlzx
         CRIg==
X-Gm-Message-State: AAQBX9dcqQWc1MY/ERRqrtU5fRhWzTlM4CyXfsBQO4b0ph707ZkBgN2m
        9DwO+eo0m8limSRbJ83GUJmGy+JVMUkpVqbkKfdnuQ==
X-Google-Smtp-Source: AKy350a2aSuU+GT0mHqC7la+7TGRYdNgcToP4W9UShQRP3Mdjvc5GASCj61EyN7Q2oziPCR/E4LVbxYFgh0izappgYo=
X-Received: by 2002:a17:90a:d598:b0:230:b842:143e with SMTP id
 v24-20020a17090ad59800b00230b842143emr2009042pju.6.1680686962913; Wed, 05 Apr
 2023 02:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230130105423.1338554-1-mk@semmihalf.com> <20230130135418.1604455-1-mk@semmihalf.com>
 <CAJMMOfNJV+eOqTgUoLLWKQe2MJ=6fXL3aaP6d=YrSBQvfhOXiA@mail.gmail.com>
 <DM8PR02MB8169B2AC8918F8E31628F61AF3DB9@DM8PR02MB8169.namprd02.prod.outlook.com>
 <CAJMMOfN-6fgN0VohA5ViwVXmNWtA13ycfZFoO4ys9_CLes0feA@mail.gmail.com>
 <CAJMMOfM41dfqx0NoiHGE=8X5hoRHo1=qPEp4KXLP1kygestEJQ@mail.gmail.com> <CAJMMOfN6tUzGZOkP6ZXbKCr-vszqf3nnRM-dhXfpOUSiHr2EHA@mail.gmail.com>
In-Reply-To: <CAJMMOfN6tUzGZOkP6ZXbKCr-vszqf3nnRM-dhXfpOUSiHr2EHA@mail.gmail.com>
From:   =?UTF-8?Q?Micha=C5=82_Krawczyk?= <mk@semihalf.com>
Date:   Wed, 5 Apr 2023 11:29:12 +0200
Message-ID: <CAJMMOfNzkp9wFfwmov3T8f3KheY4hzu+4AnwXf7iLjKRQQbDzA@mail.gmail.com>
Subject: Re: [PATCH v2] media: venus: dec: Fix handling of the start cmd
To:     Vikash Garodia <vgarodia@qti.qualcomm.com>
Cc:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        "Vikash Garodia (QUIC)" <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mw@semihalf.com" <mw@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

just a kindly reminder about the patch.

Thanks,
Micha=C5=82

pt., 10 mar 2023 o 16:05 Micha=C5=82 Krawczyk <mk@semihalf.com> napisa=C5=
=82(a):
>
> Hi,
>
> Any update on this patch? It would be great if we could make some
> progress there (and, hopefully, finally merge it :))
>
> Thanks,
> Micha=C5=82
>
> pt., 10 lut 2023 o 16:18 Micha=C5=82 Krawczyk <mk@semihalf.com> napisa=C5=
=82(a):
> >
> > Hi,
> >
> > I'm wondering if there are any more comments for this patch? I would
> > be happy to clarify anything that's unclear or improve the code if
> > needed.
> >
> > I know it's pretty late, but it would be really great if this fix
> > could land before v6.2 is released, so I'd appreciate your help and
> > review.
> >
> > Thank you,
> > Micha=C5=82
> >
> > wt., 7 lut 2023 o 12:15 Micha=C5=82 Krawczyk <mk@semihalf.com> napisa=
=C5=82(a):
> > >
> > > wt., 7 lut 2023 o 10:54 Vikash Garodia <vgarodia@qti.qualcomm.com> na=
pisa=C5=82(a):
> > > > I have reviewed the patch, and the drain sequence handling looks go=
od to me.
> > > > Could you share some details on the test client which you are using=
 to catch this issue ?
> > >
> > > Hi Vikash,
> > >
> > > Thank you for looking at the code!
> > >
> > > I've been testing it using the Chromium implementation of the V4L2
> > > codec [1]. Meanwhile, we were running a test suite which changes the
> > > encryption method in the middle of the video decoding. This triggers
> > > the flush behavior and the Chromium sends the stop/start cmd to the
> > > V4L2 kernel component, and the test expects the video to continue the
> > > playback normally. Unfortunately, it was causing a stall of the video
> > > at the same time.
> > >
> > > [1] https://source.chromium.org/chromium/chromium/src/+/main:media/gp=
u/v4l2/
> > >
> > > >
> > > > > Thank you,
> > > > > Micha=C5=82
> > > >
> > > > Thanks,
> > > > Vikash
