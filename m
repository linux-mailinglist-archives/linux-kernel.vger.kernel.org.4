Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A5B60E67B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 19:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbiJZRaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 13:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbiJZR3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 13:29:47 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DFA32EF8;
        Wed, 26 Oct 2022 10:29:38 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y69so23714957ede.5;
        Wed, 26 Oct 2022 10:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7AA9h8SmdIJH6hpfSaQ1dsYeLBKSIK0Dj9U7LImgfDg=;
        b=GEAxVKOtuirXdsRDTvEMEotHUyxwYr1Iu9/ZqJKdAmUoqPCxTnr3Zq/2aRaKDkqrIA
         INabHPdOdnZc2DB+ZC9YB2RKlCd8qATeZjqxC16bRjR4ShmWummnyJ/6Fv35YUY4cCwu
         vjYx7HLi5qwgoag6GUicDNb+mP/g948GWBO9g7IB3TwQzAgz8PnT6HFwjSibiwgLDU1f
         +kNvO6+Bnl0mkylu2ydieM5IZ5YoiT9g2U0BP78Fo3zkYVOTohSUHuROG1g2Dy3glMRu
         PvX/X08H2vwdmPRZ+fwYDCS5oMJoR8ChM9poMOMQruGDudHIso0aMGRjek9+Bs899yAH
         jwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7AA9h8SmdIJH6hpfSaQ1dsYeLBKSIK0Dj9U7LImgfDg=;
        b=0d0krf8T67uKTf+sK0c9OOJooL9mLb9pEBsvhdc9vmSdds7FPrZX/rYmxKPnGKWJdH
         CFEceu7Nv6F11B1S8ugIzFYCbhUsqUPknUyrt4dPnUEtMsBax2ibOVj2FZ064YueCDU9
         oneIh7V8TCGe4pslIJy8NLAHA1dF2Td4Z6deqBtK4+lufB2P1bhqPSwUW4c1WbGR/7MP
         gvEun8e/ofRvC0pekOiLTWY5kNlaUhWuYMUC4A9gj90nB++shnfuyWXB6LgDTTHBAQCl
         JF4XLtpxItI1O4n4CEqS2k+Gj5sXSNM2pSxh3BGg8rbOiOW0vShT5w9HgAOW5QUILpyZ
         kR8A==
X-Gm-Message-State: ACrzQf0IkfqEhc8czXlO1cawV75nCbCaXeaB4Lmr0h7Y5JUyDQtzbK+7
        E0PmFjPXrtzIXHDyNQp5eIRwK9fDhW01gOBOHsQ=
X-Google-Smtp-Source: AMsMyM4sHeGBjgie6YkH1gVHxtNyumuvzPz/rT9VWOzyzxvJEZU1tSV8A+2mn0zsFx4kB3dIVkpNlykixMy810f0lYI=
X-Received: by 2002:a05:6402:2552:b0:45d:ecf:b23 with SMTP id
 l18-20020a056402255200b0045d0ecf0b23mr42421584edb.255.1666805376698; Wed, 26
 Oct 2022 10:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20221004234343.54777-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221004234343.54777-5-prabhakar.mahadev-lad.rj@bp.renesas.com> <Y1hkG6NVFS08WTIg@paasikivi.fi.intel.com>
In-Reply-To: <Y1hkG6NVFS08WTIg@paasikivi.fi.intel.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 26 Oct 2022 18:29:10 +0100
Message-ID: <CA+V-a8vdcG51mHBV4C8nC7Ad9YWEfKD=jiy5KXVgSWVR_UvNfQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] media: platform: Add Renesas RZ/G2L CRU driver
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
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

On Tue, Oct 25, 2022 at 11:33 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Prabhakar,
>
> A few comments below... apologies for not reviewing this earlier. Looks
> good in general but there are a few points that need some attention.
>
> On Wed, Oct 05, 2022 at 12:43:43AM +0100, Prabhakar wrote:
> ...
> > +static int rzg2l_cru_ip_pre_streamon(struct v4l2_subdev *sd, u32 flags)
> > +{
> > +     struct rzg2l_cru_dev *cru;
> > +     int ret;
> > +
> > +     cru = v4l2_get_subdevdata(sd);
> > +
> > +     if (!cru->is_csi)
> > +             return -EINVAL;
> > +
> > +     ret = v4l2_subdev_call(cru->ip.remote, video, pre_streamon, 0);
>
> If you're calling pre_streamon successfully, you'll have to have an
> equivalent number of post_streamoff calls.
>
Agreed, I will implement the post_streamoff()

> ...
>
> > +static int rzg2l_cru_set_stream(struct rzg2l_cru_dev *cru, int on)
> > +{
> > +     struct media_pipeline *pipe;
> > +     struct v4l2_subdev *sd;
> > +     struct media_pad *pad;
> > +     unsigned long flags;
> > +     int ret;
> > +
> > +     pad = media_pad_remote_pad_first(&cru->pad);
> > +     if (!pad)
> > +             return -EPIPE;
> > +
> > +     sd = media_entity_to_v4l2_subdev(pad->entity);
> > +
> > +     if (!on) {
> > +             media_pipeline_stop(&cru->vdev.entity);
> > +             return v4l2_subdev_call(sd, video, s_stream, 0);
>
> Ditto.
>
OK.

> > +     }
> > +
> > +     ret = rzg2l_cru_mc_validate_format(cru, sd, pad);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = v4l2_subdev_call(sd, video, pre_streamon, 0);
> > +     if (ret == -ENOIOCTLCMD)
> > +             ret = 0;
> > +     if (ret)
> > +             return ret;
>
> For all cases below where streaming on doesn't succeed, you'll have to have
> a call of post_streamoff.
>
Agreed, I missed that I will call post_streamoff in the error paths.

> > +
> > +     spin_lock_irqsave(&cru->qlock, flags);
> > +
> > +     /* Select a video input */
> > +     if (cru->is_csi)
> > +             rzg2l_cru_write(cru, CRUnCTRL, CRUnCTRL_VINSEL(0));
> > +
> > +     /* Cancel the software reset for image processing block */
> > +     rzg2l_cru_write(cru, CRUnRST, CRUnRST_VRESETN);
> > +
> > +     /* Disable and clear the interrupt before using */
> > +     rzg2l_cru_write(cru, CRUnIE, 0);
> > +     rzg2l_cru_write(cru, CRUnINTS, 0x001f000f);
> > +
> > +     /* Initialize the AXI master */
> > +     rzg2l_cru_initialize_axi(cru);
> > +
> > +     /* Initialize image convert */
> > +     ret = rzg2l_cru_initialize_image_conv(cru);
> > +     if (ret) {
> > +             spin_unlock_irqrestore(&cru->qlock, flags);
> > +             return ret;
> > +     }
> > +
> > +     /* Enable interrupt */
> > +     rzg2l_cru_write(cru, CRUnIE, CRUnIE_EFE);
> > +
> > +     /* Enable image processing reception */
> > +     rzg2l_cru_write(cru, ICnEN, ICnEN_ICEN);
> > +
> > +     spin_unlock_irqrestore(&cru->qlock, flags);
> > +
> > +     pipe = sd->entity.pipe ? sd->entity.pipe : &cru->vdev.pipe;
> > +     ret = media_pipeline_start(&cru->vdev.entity, pipe);
> > +     if (ret)
> > +             return ret;
> > +
> > +     clk_disable_unprepare(cru->vclk);
> > +
> > +     ret = v4l2_subdev_call(sd, video, s_stream, 1);
> > +     if (ret == -ENOIOCTLCMD)
> > +             ret = 0;
> > +     if (ret) {
> > +             /* enable back vclk so that release() disables it */
> > +             clk_prepare_enable(cru->vclk);
> > +             media_pipeline_stop(&cru->vdev.entity);
> > +             return ret;
> > +     }
> > +
> > +     ret = clk_prepare_enable(cru->vclk);
>
> What will happen if enabling vclk will fail here? (Or above?)
>
Hmm, I will have to undo the stuff here. I will fix that in the next
version and for the above failure I'll add a warning message as
s_stream(1) itself has failed.

Cheers
Prabhakar
