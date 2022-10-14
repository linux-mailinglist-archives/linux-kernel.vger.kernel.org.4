Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5672D5FF56E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 23:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiJNVbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 17:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiJNVbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 17:31:16 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5221CAB822;
        Fri, 14 Oct 2022 14:31:15 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id r17so13107780eja.7;
        Fri, 14 Oct 2022 14:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z+BO5ARgJRLmRigfMjGI5zoIA+hl59J0KLA++gO1fC0=;
        b=gPbhp80Ve/jwYVxgvSsydmCG+8SwXSx4qRq5Lz/6z8Nl3WEnv2k5piDdU/BDQU2MY7
         ct5CbXefz3SP8cfwbVtjva6mL6qYbKJNHCIeD726lr3elSiitFXegedklpZWNM6NcAyp
         vMgBoHKzfTr9vC/+mi2FOxWr4ZyEo6bRivO0maYI61MqO21dZY/TQdXbjoGKk0qAjVih
         HYgPdQzlsacjITzBP9m/tMybqMXv1vgOtuheGrBLuGBFPKlgnELnJed1zL3WNCD/6AyA
         zM3MNsNq4cB8T3gauHBh13IXrRZqOeTQwhBV/wNPBvKEGZvMCQ6NXDn86UpCLidDewRs
         D8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z+BO5ARgJRLmRigfMjGI5zoIA+hl59J0KLA++gO1fC0=;
        b=2LM0jQloLXjl7RWKgLsjCsiT/I2EWjgL2QM01sO1+Q5+mc8M5Dku5WTjkLNqZIx6lB
         eXRwIdr0sx0TD6C0FOlf0AFBGXEdYrhOmDp1kJteC5xDK0JopE0az6jywCQTdkvmewhB
         zWCLT9Xx9OsP7/hkWmsRgmmfR9kH/yfWMox5JSbdHw6zMcbZN84fCOa+Z1sY7Wz3BHhJ
         VcJdanmbprhwbbaVHaiIOAnLNtt3M6K+FjRxcwcQ5xulNT6QDnxADgdHsEIbQtqYW/dU
         IxxU/8MaZDHtZrv60ZYC8/Pb/NP0dMCbC80QuifaAxbcZkrAa/Wr/L5xMIFfUosNwTun
         gfRA==
X-Gm-Message-State: ACrzQf0dmBP3HzVhLHG6Fs6d3Wybzvqecrxkw9dhUt6hibXAW1ePvmbR
        LywSG1geKldCk/tk4ExmQyvdmvvVc6PomDXQTZA=
X-Google-Smtp-Source: AMsMyM5qn8sK32ciJuhU0cyHzs2wIt+ntGhOdPpXzTFUTyBGrvPg2Nyu7ThZ4G/WQbmQTH3bWvpE2qUPQbA7k0qUK6E=
X-Received: by 2002:a17:906:9bd8:b0:78d:85f9:36ae with SMTP id
 de24-20020a1709069bd800b0078d85f936aemr4980802ejc.342.1665783073945; Fri, 14
 Oct 2022 14:31:13 -0700 (PDT)
MIME-Version: 1.0
References: <20221014183459.181567-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221014183459.181567-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <Y0m180wwV9CiNNTf@paasikivi.fi.intel.com>
In-Reply-To: <Y0m180wwV9CiNNTf@paasikivi.fi.intel.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 14 Oct 2022 22:30:46 +0100
Message-ID: <CA+V-a8uSnyT=qHhQwNXx-gJOcm_xV_JP=PAPLqWiYvOYAsxfKA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] media: i2c: ov5645: Use runtime PM
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Sakari,

Thank you for the review.

On Fri, Oct 14, 2022 at 8:18 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Prabhakar,
>
> On Fri, Oct 14, 2022 at 07:34:56PM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Switch to using runtime PM for power management.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1->v2
> > * Moved pm_runtime_*_autosuspend() calls after registering the subdev.
> > ---
<snip>
> > @@ -795,7 +773,7 @@ static int ov5645_s_ctrl(struct v4l2_ctrl *ctrl)
> >       int ret;
> >
> >       mutex_lock(&ov5645->power_lock);
> > -     if (!ov5645->power_count) {
> > +     if (!pm_runtime_get_if_in_use(ov5645->dev)) {
> >               mutex_unlock(&ov5645->power_lock);
> >               return 0;
> >       }
> > @@ -827,6 +805,7 @@ static int ov5645_s_ctrl(struct v4l2_ctrl *ctrl)
> >               break;
> >       }
> >
> > +     pm_runtime_put_autosuspend(ov5645->dev);
>
> I think you'll need pm_runtime_mark_last_busy() before this. I missed this
> on the last round. Maybe in probe() too. Feel free to resend just this
> patch.
>
Agreed, I'll respin this patch fixing the above.

Cheers,
Prabhakar
