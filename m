Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4586B3C67
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 11:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjCJKgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 05:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjCJKf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 05:35:57 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA0776067;
        Fri, 10 Mar 2023 02:35:24 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id s11so18579004edy.8;
        Fri, 10 Mar 2023 02:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678444448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJwG2CiQ/K++yhEMzDfBPC3J6efxbJJMs0y+94/eJZ4=;
        b=kHXx7S3vhx9fI9CU2b3dkuqH7usWzHolXJa3qQ6XSLKLZEDTurxnIgDg041DCqN+d1
         Hb/hrq4JgGRLyzfcJVeTRK7g+IMnandzPox1P+u3kMAkq51fOR3mhx6KGMsyuqtAzF9s
         lNDgdJSM8Y0KxInGV5Jb43WFR4RoYQgN8XurHvrgEVipKT5O7QinzcoJw+dzfRPNHdas
         OaD9iqprX7YIpZMYmXR3m0spMia2DW1I8qX8zvvn8esmRdhhBz53VjBOSATFRgr8PkXi
         M4EhUfj1WK6YVcM2ohYRK5g7kJAE23ER3ZnqbD+vz3K57ehBcb7XA7Sk1rOS76IfisE+
         AuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678444448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJwG2CiQ/K++yhEMzDfBPC3J6efxbJJMs0y+94/eJZ4=;
        b=78BJIjpR9MFvQyxqEUCnrVhMabFoNFktfCKl4VLPLVRXAk6LWSFlTgNzEV9YDZgHML
         U7v7EBV08SQtRVYO7VGtMMBhCmworhv/3yEVAD+tYY3fVmwBk0lKLE9yGM+QlmkV3SYD
         s7trQF3Sdhk00KqeRrDYMxQdHnGjAWgDRNKXvJp2wnTYyR+s74gnHkbH9QaH1GjLxFbA
         8NTE/aFsrn29xDkOvfmIh7FAPtGh6J0sFttdwXqhYP+6imketbYeLopHWPSxGTtTh/Lx
         CtWiXM6yFkdt//I9JBPLbzSWs8UY86UsSS6rSWLl2Mj3MH6DYnlJvFBbiZ0gR6hNKF1h
         uZxg==
X-Gm-Message-State: AO0yUKXQniMM+xzt5OI9gA2ZhjgzaIsw3ahnBrRCXLxJ3I5spNaKja97
        qo2Erjq6Ly6xDkFIFGeQ9Vbpx9FWEIcKCKsUtgI=
X-Google-Smtp-Source: AK7set+9plAVZiLvbdivPMu0PCQT9w4blh4eMxoeF5vw1OScTWQjQ3Ny0OytY2JQerP8zncC9PMdAnX2hDuYfFQMJQg=
X-Received: by 2002:a17:906:a1c5:b0:8f0:147b:be2 with SMTP id
 bx5-20020a170906a1c500b008f0147b0be2mr11938349ejb.4.1678444447856; Fri, 10
 Mar 2023 02:34:07 -0800 (PST)
MIME-Version: 1.0
References: <20230310101715.69209-1-slark_xiao@163.com> <20230310103126.GA6838@thinkpad>
In-Reply-To: <20230310103126.GA6838@thinkpad>
From:   Fabio Porcedda <fabio.porcedda@gmail.com>
Date:   Fri, 10 Mar 2023 11:33:56 +0100
Message-ID: <CAHkwnC_S_qPOfkoJ-uZ7GNW4J26AXik=33f2=uMfw72yFOFXLg@mail.gmail.com>
Subject: Re: [PATCH] bus: mhi: host: pci_generic: Revert "Add a secondary AT
 port to Telit FN990"
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Slark Xiao <slark_xiao@163.com>, loic.poulain@linaro.org,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il giorno ven 10 mar 2023 alle ore 11:31 Manivannan Sadhasivam
<mani@kernel.org> ha scritto:
>
> On Fri, Mar 10, 2023 at 06:17:15PM +0800, Slark Xiao wrote:
> > This reverts commit 2d5253a096c6057bbf7caa5520856dcdf7eca8bb.
> > There are 2 commits with commit message "Add a secondary AT
> > port to Telit FN990". But the last one 2d5253a096 was added
>
> Btw, we usually refer the commit SHA by 12 digits. Like, 2d5253a096c6.
> I can fix it up while applying.
>
> > on Foxconn devices. Actually the second AT port of Foxconn
> > devices doesn't work in PCIe mode. And the commit message
> > mismatch with the changes. So we need to remove it.
> >
>
> Sigh... the subject itself was wrong :( thanks for catching.
>
> > Signed-off-by: Slark Xiao <slark_xiao@163.com>
>
> For future Foxconn patches, please help with the review to catch issues l=
ike
> this. Unfortunately, I do not own any Foxconn modems :/
>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Reviewed-by: Fabio Porcedda <fabio.porcedda@gmail.com>

Just to clarify, the original patch change just the Telit FN990:
https://lore.kernel.org/netdev/CAMZdPi8gGrbkKnDR+WLadF92shJbwH-ksQY+dbpgfZ2=
1iAp9ug@mail.gmail.com/

The problem is caused by the fact that it was merged two times and the
second time was merged wrongly.
The correct one is commit 479aa3b0ec2e000ac99dd0661936d9685d6cac64 and
the wrong one is 2d5253a096c6057bbf7caa5520856dcdf7eca8bb.

BR
Fabio

> Thanks,
> Mani
>
> > ---
> >  drivers/bus/mhi/host/pci_generic.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/=
pci_generic.c
> > index 6e13c43a84d1..91d02f84ba21 100644
> > --- a/drivers/bus/mhi/host/pci_generic.c
> > +++ b/drivers/bus/mhi/host/pci_generic.c
> > @@ -343,8 +343,6 @@ static const struct mhi_channel_config mhi_foxconn_=
sdx55_channels[] =3D {
> >       MHI_CHANNEL_CONFIG_DL(13, "MBIM", 32, 0),
> >       MHI_CHANNEL_CONFIG_UL(32, "DUN", 32, 0),
> >       MHI_CHANNEL_CONFIG_DL(33, "DUN", 32, 0),
> > -     MHI_CHANNEL_CONFIG_UL(92, "DUN2", 32, 1),
> > -     MHI_CHANNEL_CONFIG_DL(93, "DUN2", 32, 1),
> >       MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0_MBIM", 128, 2),
> >       MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0_MBIM", 128, 3),
> >  };
> > --
> > 2.34.1
> >
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D



--=20
Fabio Porcedda
