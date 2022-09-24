Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCDE5E8BCE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 13:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbiIXLig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 07:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiIXLie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 07:38:34 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF07D10B23F;
        Sat, 24 Sep 2022 04:38:32 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id c30so2128908edn.2;
        Sat, 24 Sep 2022 04:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=dyM/rt0gKNSVbo2LRmeJCOAYDEu/aCHyvBr+3Af8zq8=;
        b=fmAeP3hPmDf+RNnACiFP0vinV3rvcS+CuIuamPXvHu+P0MgDyl46tIxHNM44QYE13l
         aHDrv1G+8cK8o62yQb2IiG1mcuQ3FBda9rDKziRGcBoUY6/aLDGDRnfytIYFi4RgmVwU
         qUvjqoGwd9KtFIsnCtpvYqSmu/WKgzkTL7yiqILov98cmzYpTcgQTvtOgwc2WFwN9yj1
         HeORF7f6fTrOALdzZw/V4gsbyQHcr7FaF/dgwTC75wbPIHSZ73xFSK6UYuHWNIb1JXwY
         uYJcOME+Sm5WKDtFKfAFcm4yXZKX3Xn/lrbP1MhxY7qOoLXYtom21l1epJXWDQ3lXe0Q
         C7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=dyM/rt0gKNSVbo2LRmeJCOAYDEu/aCHyvBr+3Af8zq8=;
        b=rd1WL8JuBf8CxtEumpdidRA17iecQkSQ4axkqsmFqLjrtHo8Bh50zZn7D4MwQH8cwy
         oJr698YHMgx6S3ZjD4Osv6hcXoo3Gro689gS1Oc+GFZzMHKaEFfE3TTjT+fXBq5w7VXN
         CZRWkyeh2sLPxchogA9rLmOx88MUpNBHXzu65ZVgu9wsMczvBgbR6x3yLWZ5kHnxxz6h
         IWyyJkVYXFpxFY8b7GJ6iyAqYcUSu+8pUSIdlOzsImJ399J+yW40xdHbjOpGeZ+4n0nS
         ckogahrsmRjjSMiknN8IUBnTdf0Bgex69HzGkgSc5gpuzqPJvx3CT1QlxMS+qN2fdZGN
         Y4Wg==
X-Gm-Message-State: ACrzQf1z1dPypoBA/cSeLJfkioj6AEjGGbg+6HLsQNlTgysTFEWD/aZE
        tOeGD4Zzt5Fa/A6zewap2mKRh6CA9TYsMVg4MhU=
X-Google-Smtp-Source: AMsMyM6npIX132f34bc7kQx5JR4oEJq+EDLjQufM/wqFTh6f/M7O179otOQTl3hUY00Wt62O1jTuICK0Jn692CCz7hY=
X-Received: by 2002:a05:6402:350b:b0:452:2b68:90db with SMTP id
 b11-20020a056402350b00b004522b6890dbmr12971523edd.255.1664019511404; Sat, 24
 Sep 2022 04:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220905230406.30801-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220905230406.30801-5-prabhakar.mahadev-lad.rj@bp.renesas.com> <Yy4TtzPtSN9qiiQS@paasikivi.fi.intel.com>
In-Reply-To: <Yy4TtzPtSN9qiiQS@paasikivi.fi.intel.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sat, 24 Sep 2022 12:38:03 +0100
Message-ID: <CA+V-a8sNVJe5o5taQrEzLis0KbdihVv+JzSHU26FUfD=ctPhhg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] media: platform: Add Renesas RZ/G2L CRU driver
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>
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

On Fri, Sep 23, 2022 at 9:14 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Prabhakar,
>
> On Tue, Sep 06, 2022 at 12:04:06AM +0100, Lad Prabhakar wrote:
> ...
>
> > +#define to_buf_list(vb2_buffer) (&container_of(vb2_buffer, \
> > +                                             struct rzg2l_cru_buffer, \
> > +                                             vb)->list)
>
> #define to_buf_list(vb2_buffer) \
>         (&container_of(vb2_buffer, struct rzg2l_cru_buffer, vb)->list)
>
OK.

>
> ...
>
> > +static int rzg2l_cru_open(struct file *file)
> > +{
> > +     struct rzg2l_cru_dev *cru = video_drvdata(file);
> > +     int ret;
> > +
> > +     ret = clk_prepare_enable(cru->pclk);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = clk_prepare_enable(cru->vclk);
> > +     if (ret)
> > +             goto disable_pclk;
> > +
> > +     ret = clk_prepare_enable(cru->aclk);
> > +     if (ret)
> > +             goto disable_vclk;
> > +
> > +     ret = mutex_lock_interruptible(&cru->lock);
> > +     if (ret)
> > +             goto disable_aclk;
> > +
> > +     file->private_data = cru;
> > +     ret = v4l2_fh_open(file);
> > +     if (ret)
> > +             goto err_unlock;
> > +
> > +     ret = v4l2_pipeline_pm_get(&cru->vdev.entity);
>
> Please use runtime PM instead in sensor drivers, we're trying to get rid of
> this function.
>
OK.

> It'd be nice to have it in this one as well.
>
I'll will switch to runtime PM.

> > +     if (ret < 0)
> > +             goto err_open;
> > +
> > +     mutex_unlock(&cru->lock);
> > +
> > +     return 0;
> > +err_open:
> > +     v4l2_fh_release(file);
> > +err_unlock:
> > +     mutex_unlock(&cru->lock);
> > +disable_aclk:
> > +     clk_disable_unprepare(cru->aclk);
> > +disable_vclk:
> > +     clk_disable_unprepare(cru->vclk);
> > +disable_pclk:
> > +     clk_disable_unprepare(cru->pclk);
> > +
> > +     return ret;
> > +}
>
> ...
>
> > +void rzg2l_cru_v4l2_unregister(struct rzg2l_cru_dev *cru)
> > +{
> > +     if (!video_is_registered(&cru->vdev))
> > +             return;
> > +
> > +     v4l2_info(&cru->v4l2_dev, "Removed %s\n",
> > +               video_device_node_name(&cru->vdev));
>
> I'd just leave this out. Same for the similar message on registration.
>
OK, I'll drop both the messages.

Cheers,
Prabhakar
