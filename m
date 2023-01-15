Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6641166B3FC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 21:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjAOUy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 15:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjAOUyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 15:54:55 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF08A13514;
        Sun, 15 Jan 2023 12:54:53 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id j9so18542749qvt.0;
        Sun, 15 Jan 2023 12:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GNMkbSbb9ICxrzUUU3C9l/GMwdexOFTK//x14iJdWmM=;
        b=qp5Z8EFieIq7/J/dh/J43zUugiBfVNeBCe1pq+REJgRFMNbJC1nfxm9yOhTH5ETn8y
         WHeCS6mEx5uu3EVINPVXhtPebizrzsDWnTjiB63Dfc/xGL/mqNkDN5/cH0e6GdWupLlE
         4wb9pC+Sk2kJGsE1lruA2Wt8nzj9Bm0GdppxtcpuNklaulu4fKG2PZdMb3EY9gMm6fnE
         K5GbbM+7PB8+Ke/VJcDWRl4+vJ8I1ZGduhhT1gi8zVRe+EIYLpfyb4Gw6+uvTqJ97e87
         UKFtW94+X2xJVm/EavQIbKnreZtcrnFL+SRqjMr/+ptzMLJKdxi1BSMYZsKXesx7ZA4j
         pFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GNMkbSbb9ICxrzUUU3C9l/GMwdexOFTK//x14iJdWmM=;
        b=PmTU1ANqvw28dmGm8xNDi9ET4Uh2GJl7LAjbazLyR9aWt5BZekbZUofioScMcZRDcl
         IkiF7OfYRrXoGX09UVCgA5wKDkXLkFpRT1FViWpdtYY5I6xMHcNNeYQojLyp7Rl8azTn
         8VH0SkM9z4ihh+lDGBDJouWz6pENzvl3YOKgG6BWpRX/Um/RxVfBP6RbX7JMZrv6Stxy
         kyMs18xkujptu/HRCdn6DAaCrvC3LUryeVhYtYD3qCAYvK0UWFKRWgcYEU5GeABOkESx
         1vatvz8ODKMPsq1wOoNKEN5QQ4PI4OOSFNE8r0MxCO4h5Eg2JwGxcIheccHceErDo7+x
         wdPw==
X-Gm-Message-State: AFqh2ko57joX4qaIfX7HMlxF5J1fPhWkOv1OFtEoNzODIBT685P+e3WL
        +2KKQ7XCtUjBpRZ8mC3xpNHltPeM/f93d4NIB0sIm71662k=
X-Google-Smtp-Source: AMrXdXvkGZI0k1pnngxktYC4R61jH0zIyHSlCBGbhGKzn7iNmZwaicp0p6IGPJ679OgH00ExhW7b4N1Zd+Cp2KwB/b4=
X-Received: by 2002:a05:6214:2c17:b0:4c7:6dbe:807e with SMTP id
 lc23-20020a0562142c1700b004c76dbe807emr6574056qvb.67.1673816093000; Sun, 15
 Jan 2023 12:54:53 -0800 (PST)
MIME-Version: 1.0
References: <20230115103217.9232-1-pierluigi.p@variscite.com>
 <CAOMZO5CdG=Tx98DVYo9QZFM7Y65b0KGLNc=XskYDuRqORBiLSg@mail.gmail.com> <CAOMZO5BLoCibdbmBV5Sysfc7seCnYu7Mvu+Yar-YUvDrjJuNCA@mail.gmail.com>
In-Reply-To: <CAOMZO5BLoCibdbmBV5Sysfc7seCnYu7Mvu+Yar-YUvDrjJuNCA@mail.gmail.com>
From:   Pierluigi Passaro <pierluigi.passaro@gmail.com>
Date:   Sun, 15 Jan 2023 21:54:42 +0100
Message-ID: <CAJ=UCjVX212EdAoCe62BxA9T6CEs-jXPwfXMN_gjd5=Z-8w3zA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mm: Fix pad control for UART1_DTE_RX
To:     Fabio Estevam <festevam@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-imx@nxp.com, pierluigi.p@variscite.com, marex@denx.de,
        peng.fan@nxp.com, marcel.ziswiler@toradex.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, eran.m@variscite.com,
        nate.d@variscite.com
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

On Sun, Jan 15, 2023 at 9:48 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Pierluigi,
>
> On Sun, Jan 15, 2023 at 9:27 AM Fabio Estevam <festevam@gmail.com> wrote:
> >
> > Hi Pierluigi,
> >
> > Thanks for the patch.
> >
> > On Sun, Jan 15, 2023 at 7:32 AM Pierluigi Passaro
> > <pierluigi.passaro@gmail.com> wrote:
> > >
> > > According section
> > >     8.2.5.313 Select Input Register (IOMUXC_UART1_RXD_SELECT_INPUT)
> > > of
> > >     i.MX 8M Mini Applications Processor Reference Manual, Rev. 3, 11/2020
> > > the required setting for this specific pin configuration is "1"
> >
> > Fixes: c1c9d41319c3 ("dt-bindings: imx: Add pinctrl binding doc for imx8mm")
> >
> > Reviewed-by: Fabio Estevam <festevam@gmail.com>
>
> ./scripts/checkpatch.pl shows the following problem with your patch:
>
> WARNING: From:/Signed-off-by: email address mismatch: 'From: Pierluigi
> Passaro <pierluigi.passaro@gmail.com>' != 'Signed-off-by: Pierluigi
> Passaro <pierluigi.p@variscite.com>'
>
> Please adjust this, add the Fixes tag and send a v2.
>
I have a temporary SMTP configuration problem with my company account.
As soon as it will be fixed, the patch will have no changes, will only change
the SMTP mail server: is this warning so critical ?
>
> Thanks
