Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692C16C1440
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjCTOBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjCTOBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:01:13 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC4D49EB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 07:01:10 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id q2so3684229qki.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 07:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679320870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSxZs4rFtzdPbCAaEvJdzWP0wVixUsku4WNBJJi7xbY=;
        b=OmtbWngGjdGdpsE7TFKf7PJ7ZCDCjPXQcmY7bsZhucJwxEmbIOdJz4GS/MmJVkc/93
         243zQZeuOJxM1PtHUZpHPNfkUNjAvozHaSuQ1HrfKGDDv/vXbXEYUZM5+PXBaFdFbwuu
         nJ2wJRdQGK/BjlL3hVG/RD3l/lLXSQUEDXY43TtXlKSwz4bmlTfeQ6QoFJFqBrzVzy7K
         0D8eU3RXZbIlzNlewQuyTHPlfDe44dvT84MLOzJrrecun7GbEeDYeXkJtJ/F/71LvRac
         1vGlLQpAnnG7tmaWP4mwohY/psDAnQ70DcPqG8zgUy3NmfUQ5tA1We+3fTNGrvM/h+fG
         0GOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679320870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LSxZs4rFtzdPbCAaEvJdzWP0wVixUsku4WNBJJi7xbY=;
        b=C+jyZmWs5BNL+hmiXX+v1WefZDvwBr7EX6Tnislj44AsGdwKthQwBD+22YVl+TF/d+
         D9QrQ6yMgjvSUzEHf+A0RItc8E0fq9lJve9nTf1jE5rx71kC3c4A/Fo6MQU/L0NlUJ3Q
         PdB8ygc0Av3IYFEyd/uKS10U6gImjqlbHTpQnLu08nCfxJ9AqsEub0xVX3Wh2ei7L/sg
         LxbatWrgexWXl9deSrs9qmBo3YZm5BgVkU4Jy+YZ6d0FRoZTiZbkPiWHb3nn9Ufr9Xby
         SVOv5NJ6L/Cw0VSpby+2D0dsKVkbN76kUpCmDeKj4j6EM3WyhVX8xJx2nIk+NGp+4Zb6
         Q76Q==
X-Gm-Message-State: AO0yUKW+7FM8/MNAbfCDa2V/RzBP2aDPtYYZxzri0R47gLIegM851EVx
        Lds31vNgXJROfUiwIHKPaAXrxFYHJkhWsUZiG+Y=
X-Google-Smtp-Source: AK7set8DGuuDG1joPhpNkmZhbvi7bMRwRqYSolhEFXfOB1coZY+YivxLyCKKKSpZ3fc1b7KMk1Y+YLQGHwhUrzsseCE=
X-Received: by 2002:a37:bd7:0:b0:746:8d0e:2053 with SMTP id
 206-20020a370bd7000000b007468d0e2053mr361762qkl.7.1679320869867; Mon, 20 Mar
 2023 07:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230319234710.1749455-1-cphealy@gmail.com> <CAOMZO5Cfc2cYEYvZxm4v1teCgZJjbY08_gWWDxmp4YDCmbewhw@mail.gmail.com>
In-Reply-To: <CAOMZO5Cfc2cYEYvZxm4v1teCgZJjbY08_gWWDxmp4YDCmbewhw@mail.gmail.com>
From:   Chris Healy <cphealy@gmail.com>
Date:   Mon, 20 Mar 2023 07:00:58 -0700
Message-ID: <CAFXsbZpHOx6D_tQJ09u2gNd1a_nQLaf32F2y=gSTTwqtnHyhTQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] ARM: imx_v6_v7_defconfig: Enable SMSC Ethernet PHY
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux@armlinux.org.uk, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, linux-imx@nxp.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch, Chris Healy <healych@amazon.com>
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

On Sun, Mar 19, 2023 at 8:07=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Chris,
>
> On Sun, Mar 19, 2023 at 8:47=E2=80=AFPM Chris Healy <cphealy@gmail.com> w=
rote:
> >
> > From: Chris Healy <healych@amazon.com>
> >
> > The imx53 base imx53qsb uses an SMSC Ethernet PHY.  Enable it's driver.
> >
> > Signed-off-by: Chris Healy <healych@amazon.com>
> > ---
> >  arch/arm/configs/imx_v6_v7_defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/im=
x_v6_v7_defconfig
> > index 6dc6fed12af8..a12d45e99782 100644
> > --- a/arch/arm/configs/imx_v6_v7_defconfig
> > +++ b/arch/arm/configs/imx_v6_v7_defconfig
> > @@ -135,6 +135,7 @@ CONFIG_SMSC911X=3Dy
> >  # CONFIG_NET_VENDOR_STMICRO is not set
> >  CONFIG_MICREL_PHY=3Dy
> >  CONFIG_AT803X_PHY=3Dy
> > +CONFIG_SMSC_PHY=3Dy
>
> Running 'make imx_v6_v7_defconfig' causes CONFIG_SMSC_PHY=3Dy to be
> selected by default
> because USB_NET_SMSC95XX is already enabled.
>
> It seems that we don't need to explicitly select CONFIG_SMSC_PHY=3Dy as
> done in this patch.

I see what you are saying.  I agree this patch is no longer necessary.  Tnx=
.
