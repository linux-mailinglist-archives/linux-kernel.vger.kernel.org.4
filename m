Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC5A6921DA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbjBJPTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbjBJPTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:19:04 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971C17535C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:18:59 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 7so3931801pga.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1676042339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZJPND2s+zQTcPg0lTRjGcQ6VAXJSBe+ETxukqXx6TY=;
        b=GLwRV7JINjFYIBK9wuwB1hc8Kov9Yd0NsyeednjqlZ2UWz4RvxDL+u9g1yvu1x7F48
         Dmu3hQ5gsj1doi2QDE89d92lI0O4h21YzjH55lbPzuF73Bfc3e1Fh45iLp6Ho6oBtd5S
         AXR1WVstTrnWSsa3FK5WMO6vfZIWog2Rscdbr0kI8J5CqlTd7PZDLpQxjL5XADaH5jhb
         8nLI6qsffcMXhLdCXNB0DujC7UfWqJCbAz4mRaCHT/f79LIFQPo3dnBNCgZb0Os9HrtX
         NVrU6pxJMwv0e8FOR6H7JdK3RtB1vM2shDelPBbLqvD8SCFZsNIOCWunr1xJ7HWviOIn
         xXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676042339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZJPND2s+zQTcPg0lTRjGcQ6VAXJSBe+ETxukqXx6TY=;
        b=2tiRd/JbRZJXDQuY7qaOdIhEInIYZj2npPmvHGCoEP4u9m16+ryAHzAdqrSipGdWpa
         jlc3bqSPdVuT/h+O9ZbIbpj2Gl3RmylIRYSs81LEk9cegW8hwREGnvDSllpuFhm3cUir
         Hn5pOZcDsckeo448MTDz1FOjxuPMS3c9eYSFqvnkloPSahuFz65q23JzOS1xH4zYOKK9
         NTlsyxDxCt/tbPDBvYjgd8OohH4robrje24SSDkDgclB5DrLARwSTxpIg7HoPfEfhJvc
         pyHQnia8x3aIgrTa1Er20oX65IpMhm3eEs6SI33wo1rM6EnljLUVdje6YDs23BPPxzXW
         JnZg==
X-Gm-Message-State: AO0yUKVCP75HdG/zJACbeZfVg7X9L2c6vSEBvHgyDlzvhFa6f3bP1yrD
        eWLIR8YJQeuXikkTNBx6qTnQFmVhEh8vhJuN/M88Kg==
X-Google-Smtp-Source: AK7set/0kOMUQDxFWMfAfr5O5VlT67Hlh3gmf7QVZEcin3wKEVNgleV6xMqGCZwpG4zHOmc5o2TOk7skFNIJI9Mbb0s=
X-Received: by 2002:aa7:9d9e:0:b0:5a8:5351:81d0 with SMTP id
 f30-20020aa79d9e000000b005a8535181d0mr1280424pfq.42.1676042338996; Fri, 10
 Feb 2023 07:18:58 -0800 (PST)
MIME-Version: 1.0
References: <20230130105423.1338554-1-mk@semmihalf.com> <20230130135418.1604455-1-mk@semmihalf.com>
 <CAJMMOfNJV+eOqTgUoLLWKQe2MJ=6fXL3aaP6d=YrSBQvfhOXiA@mail.gmail.com>
 <DM8PR02MB8169B2AC8918F8E31628F61AF3DB9@DM8PR02MB8169.namprd02.prod.outlook.com>
 <CAJMMOfN-6fgN0VohA5ViwVXmNWtA13ycfZFoO4ys9_CLes0feA@mail.gmail.com>
In-Reply-To: <CAJMMOfN-6fgN0VohA5ViwVXmNWtA13ycfZFoO4ys9_CLes0feA@mail.gmail.com>
From:   =?UTF-8?Q?Micha=C5=82_Krawczyk?= <mk@semihalf.com>
Date:   Fri, 10 Feb 2023 16:18:47 +0100
Message-ID: <CAJMMOfM41dfqx0NoiHGE=8X5hoRHo1=qPEp4KXLP1kygestEJQ@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm wondering if there are any more comments for this patch? I would
be happy to clarify anything that's unclear or improve the code if
needed.

I know it's pretty late, but it would be really great if this fix
could land before v6.2 is released, so I'd appreciate your help and
review.

Thank you,
Micha=C5=82

wt., 7 lut 2023 o 12:15 Micha=C5=82 Krawczyk <mk@semihalf.com> napisa=C5=82=
(a):
>
> wt., 7 lut 2023 o 10:54 Vikash Garodia <vgarodia@qti.qualcomm.com> napisa=
=C5=82(a):
> > I have reviewed the patch, and the drain sequence handling looks good t=
o me.
> > Could you share some details on the test client which you are using to =
catch this issue ?
>
> Hi Vikash,
>
> Thank you for looking at the code!
>
> I've been testing it using the Chromium implementation of the V4L2
> codec [1]. Meanwhile, we were running a test suite which changes the
> encryption method in the middle of the video decoding. This triggers
> the flush behavior and the Chromium sends the stop/start cmd to the
> V4L2 kernel component, and the test expects the video to continue the
> playback normally. Unfortunately, it was causing a stall of the video
> at the same time.
>
> [1] https://source.chromium.org/chromium/chromium/src/+/main:media/gpu/v4=
l2/
>
> >
> > > Thank you,
> > > Micha=C5=82
> >
> > Thanks,
> > Vikash
