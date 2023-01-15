Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A6B66B3F0
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 21:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjAOUs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 15:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjAOUsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 15:48:55 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A280413512;
        Sun, 15 Jan 2023 12:48:53 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id d10so18346277pgm.13;
        Sun, 15 Jan 2023 12:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MIkd2tMIqbl7DAxJsCwkxSiR7cv8R+Xwzf9xXdLwdvw=;
        b=ehnqfS3nWLQtL0guJ0ycBgulw4xjhbNma55ULp/G8DJuYbtDRgzRaFPf3kqHaOX6Bs
         WzxOSEULv9A2HRlHksKOJCs7nqOQXk/Xa+fjrWqGGlKsveeBbSriQxj7XuqwkJHgpTsC
         RnQuCgwSfXyrekYgh9SfT5v+WtnpMySyx/lvLEvnJglb8l+Z8YOjng51pySwnwSHy6ke
         TuLRTIwGObtWeEu4QraCIjGbv2E3U0u/BM4ZgWlfyLasLEmf9em+6ABe5q+cvvArTm1p
         HiRIOUReY5n+ODvjmfyK2C9Kp69ysZK2g0Z65oRMR3P9cX94rsXLNZtL5eOEyis1/+nr
         ExCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MIkd2tMIqbl7DAxJsCwkxSiR7cv8R+Xwzf9xXdLwdvw=;
        b=OcBwzCCSya+r8AlEuYIEw5AD+vCeHCWtFpDeOHXLG8Zn9evlUU4o4RqEJinDWdEy4e
         PCcJO1TymJaKEVicw6tSStTZ4M5aKWC9dZToa6DrttBzaJ3vK1cMi+CTGlXAGZljpEqE
         41G7aM0Qu7BLrGJ8TEeRlavVmSfRFB0AUEl6I9Y/95GYNK/f8sJ/09o8NubXV8nQCaUY
         zA/xcwNSI/6jXCisihwzrwgANft+Nyev2OSLjq2Zw5b11iBpkrnWd/v412bKCOEVMxHX
         OzuxoJIDMbRgHvxicnpzr2NIkZm6X8uHkSGY7Ugu7oH8CGfSBE5WR/AECmbCdJ62xsKh
         z7WA==
X-Gm-Message-State: AFqh2koX+yy8zkN3gTF4+PG0P3PPEUr7R68RQdDfv4Mim38Zsan8QFsd
        JDUVs2DleIAOJMEZESWP09y+UnPPm/z5ozNpGdM=
X-Google-Smtp-Source: AMrXdXvWyvpXV5dLUF+hc/n/3eVOPJVL9z3kWOSuXuFG8siScyfsnWEajTwnwIP8AvxMoFyyyiRYT2lICAflIwow2Ns=
X-Received: by 2002:aa7:8157:0:b0:583:3c8d:266a with SMTP id
 d23-20020aa78157000000b005833c8d266amr3155570pfn.72.1673815733109; Sun, 15
 Jan 2023 12:48:53 -0800 (PST)
MIME-Version: 1.0
References: <20230115103217.9232-1-pierluigi.p@variscite.com> <CAOMZO5CdG=Tx98DVYo9QZFM7Y65b0KGLNc=XskYDuRqORBiLSg@mail.gmail.com>
In-Reply-To: <CAOMZO5CdG=Tx98DVYo9QZFM7Y65b0KGLNc=XskYDuRqORBiLSg@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 15 Jan 2023 17:48:41 -0300
Message-ID: <CAOMZO5BLoCibdbmBV5Sysfc7seCnYu7Mvu+Yar-YUvDrjJuNCA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mm: Fix pad control for UART1_DTE_RX
To:     Pierluigi Passaro <pierluigi.passaro@gmail.com>
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

Hi Pierluigi,

On Sun, Jan 15, 2023 at 9:27 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Pierluigi,
>
> Thanks for the patch.
>
> On Sun, Jan 15, 2023 at 7:32 AM Pierluigi Passaro
> <pierluigi.passaro@gmail.com> wrote:
> >
> > According section
> >     8.2.5.313 Select Input Register (IOMUXC_UART1_RXD_SELECT_INPUT)
> > of
> >     i.MX 8M Mini Applications Processor Reference Manual, Rev. 3, 11/2020
> > the required setting for this specific pin configuration is "1"
>
> Fixes: c1c9d41319c3 ("dt-bindings: imx: Add pinctrl binding doc for imx8mm")
>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

./scripts/checkpatch.pl shows the following problem with your patch:

WARNING: From:/Signed-off-by: email address mismatch: 'From: Pierluigi
Passaro <pierluigi.passaro@gmail.com>' != 'Signed-off-by: Pierluigi
Passaro <pierluigi.p@variscite.com>'

Please adjust this, add the Fixes tag and send a v2.

Thanks
