Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B2360E725
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 20:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbiJZS1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 14:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbiJZS07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 14:26:59 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAE482D2B;
        Wed, 26 Oct 2022 11:26:58 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id i21so21917737edj.10;
        Wed, 26 Oct 2022 11:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t6vJDW3tWb5ACOdSohfrX6/ZlY8c1ETchJHmlCQfqJg=;
        b=mfdQHeqFLvG4EvMGmF+03bmVQd85/xlfIr6cKm9gFtiUGprtmcUiZeqU3Od1wOkuRw
         PhLdEN3RyVYl2oTHi7XH1jEkBABJnesNTlbmAOZfwbIBwwvO05wNW4DSdhi9kDcWR6fW
         SjQha77hmybz7o6oZuxLUabiFCRuGpsW+tLJ7VbnRaPUt8BHr7db9imof0HsUDsVIOYg
         z1egrRbBCoKaf9XllFg/77Duse5aa+hlGeUS1CC28a9CcEPcRd5QfQGa/6UZcJKuZvly
         Rgm5MLkfUdMViALP97tdvy1Asd2KQECZJzQWgGLGftpsHfHpG4LsXs8OG4nR950ZOezf
         74SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t6vJDW3tWb5ACOdSohfrX6/ZlY8c1ETchJHmlCQfqJg=;
        b=fZtU7em1Qflz5aupYdxLVVldaTkE082QH9q9rTY5qEDbWMxrlTDtB3aGD+7wkvVGAG
         StJZbvjYCn/BOzsMNq8Ii9v4+DKf6eEMiv6jC0EJ8tLheZevis5PwiOhjygzREKs0Qx4
         8aIkCRT3lLlVB06yCi4sCmX6m+eCjDc/nwQqnw35XgSU/4QoJ0SqL5t12DItAnDnfZfQ
         4xhF7ZvVs8e2SQcUA6+wkXrb4xQsWrDIDlouFbqU1zZVMDcZSTQ7HgOzw/076jDLjgEC
         lmI3RtLxVfMff15S7Cg5L6pptcy1DzX8WulA0GfEcbyUU+vmLYFc3Fk85xm23K9gh0lW
         j44g==
X-Gm-Message-State: ACrzQf3+TqtIkGTwzDl6kguEexBMIC0nVrysk5Fz61c1qEBjgWMMBc2W
        d63N2xEcy+ixQcNJ3MajbsQF2g6lLbcPnZbrGYo=
X-Google-Smtp-Source: AMsMyM5H36B31dnAuAKEoO2jKeWDGvA8Paz2NZ3mgXcz/BdjOfm2PpuNIO3++jh2TObcJkvmbTzV7e5ZzL70C0juzv8=
X-Received: by 2002:a05:6402:26cf:b0:45d:48d7:928e with SMTP id
 x15-20020a05640226cf00b0045d48d7928emr40737493edd.275.1666808816957; Wed, 26
 Oct 2022 11:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <20221026130658.45601-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221026130658.45601-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221026171721.4nfvhamguwnrw6zf@pengutronix.de> <CA+V-a8urKEjEKP0n9mki8xx1B9JLOMTYM4F1aXC3h_5Ne0+tCw@mail.gmail.com>
 <20221026173519.bm22im7uov6b4nnp@pengutronix.de>
In-Reply-To: <20221026173519.bm22im7uov6b4nnp@pengutronix.de>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 26 Oct 2022 19:26:30 +0100
Message-ID: <CA+V-a8sehSzH-xe_Xm-YC97+CbjLROLrTauEKv-wWNTjGAmxKw@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] media: i2c: ov5645: Don't return early on failures
 for s_stream(0)
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>, devicetree@vger.kernel.org,
        Jacopo Mondi <jacopo@jmondi.org>, linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
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

Hi Marco,

On Wed, Oct 26, 2022 at 6:35 PM Marco Felsch <m.felsch@pengutronix.de> wrote:
>
> On 22-10-26, Lad, Prabhakar wrote:
> > Hi Marco,
> >
> > Thank you for the review.
> >
> > On Wed, Oct 26, 2022 at 6:17 PM Marco Felsch <m.felsch@pengutronix.de> wrote:
> > >
> > > Hi Prabhakar,
> > >
> > > thanks for the patch, please see below my comments.
> > >
> > > On 22-10-26, Prabhakar wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Make sure we dont stop the code flow in case of errors while stopping
> > > > the stream and return the error code of the first error case if any.
> > > >
> > > > v4l2-core takes care of warning the user so no need to add a warning
> > > > message in the driver.
> > > >
> > > > Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > ---
> > > > v2->v3
> > > > * Now propagating the first error code in case of failure.
> > > >
> > > > v1->v2
> > > > * New patch
> > > > ---
> > > >  drivers/media/i2c/ov5645.c | 11 ++++++++---
> > > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
> > > > index eea3067ddc8b..5702a55607fc 100644
> > > > --- a/drivers/media/i2c/ov5645.c
> > > > +++ b/drivers/media/i2c/ov5645.c
> > > > @@ -996,17 +996,22 @@ static int ov5645_s_stream(struct v4l2_subdev *subdev, int enable)
> > > >               if (ret < 0)
> > > >                       goto err_rpm_put;
> > > >       } else {
> > > > +             int stream_off_ret = 0;
> > > > +
> > > >               ret = ov5645_write_reg(ov5645, OV5645_IO_MIPI_CTRL00, 0x40);
> > >
> > > If this write failed..
> > >
> > > >               if (ret < 0)
> > > > -                     return ret;
> > > > +                     stream_off_ret = ret;
> > > >
> > > >               ret = ov5645_write_reg(ov5645, OV5645_SYSTEM_CTRL0,
> > > >                                      OV5645_SYSTEM_CTRL0_STOP);
> > >
> > > why should this write be successful?
> > >
> > Indeed that will fail unless I have a lucky day ;-)
> >
> > But it seemed to be an overkill for adding an additional check to see
> > if the previous write succeeded. Do you think this will create an
> > issue?
>
> Why not just say?
>
>         ret = ov5645_write_reg();
>         if (ret < 0)
>                 goto out;
>
>         ...
>
>         out:
>
>         dev_pm_xxx();
>
>         return ret;
>
Thanks for the suggestion, I will rework this in the next version.

Cheers,
Prabhakar
