Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5B360FD20
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 18:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbiJ0Qcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 12:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235710AbiJ0Qcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 12:32:35 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E342A2329;
        Thu, 27 Oct 2022 09:32:35 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id sc25so6167806ejc.12;
        Thu, 27 Oct 2022 09:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w2sKi/FidnzYYF/kqFgrvTbVLAOpdPoKmkW/OsJ1VX8=;
        b=gtPuHpSebI19NwQMNWbQe8LxqWpp6NFl/9GH5Bm46HkvTKTCbtk21yXDGOvu80s8lr
         6u5Zu683zpxmECsFY9YQ+iU3o5+enrd64/R5BjWOkc5aDNLm0+vIGMskyIjovXFYB/w8
         IAinKBt+BuZiSsCOcYo7tmmlyn6RCHg7J1zP4U6foSWGFZl+hwQ62w6CCVT0ZP7ZrHmD
         Q3t3LsriE9hPM/9BY/c05qnlJUWYmSUpCPZTLbRO7QwnfaFc8C+ZSoOrbQxtN5+2MrfV
         t/viBOCzXW3m6zjv/hjxE7Bj6T1e3kI1/uBof3wT5+mpYTVrWVFs6PRQJKJorNBTdliC
         jYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w2sKi/FidnzYYF/kqFgrvTbVLAOpdPoKmkW/OsJ1VX8=;
        b=SM9S3XYvfd09kMexyoLlGTaagWSOwsFhyCwAW+5p8xQaWakczllno0ERxnzX9ztibb
         MqYfosrXmqo6pNfEd/Bwmg5TSVweChvWVB+HMUN7pSIH/6h5i/5iWeMoXCDOKlXjvAeT
         75OvV5e4aKmoldm1/MTFBx1LrUiqGIdpoKoqMxxK3+WxiUZnjB1ZikvUBILhE56Dm6+M
         2mTvmIuMHuhs3HDnBs/CTixCVccI8OPSeG1kkl+GjHCc2A9h13sGwKkvEwPrfnjH4ffG
         DGGY/RpEFDZ7N+665DXycpYWhJRA5yrXkImFLt//C+Tm0ivcDS61raqB4qh0/qZca/dL
         XQIw==
X-Gm-Message-State: ACrzQf2IqSA+4CRj9co6KDXUv83gFNWHuljJgA0oB53wx/QrNpMmPeJf
        v0P+nVAaraOqOn3PtXgzA7yX0iW52eqplEQlG+I=
X-Google-Smtp-Source: AMsMyM4V+7IoJvMBh0mBGyLz2zWjBHflEVIcET8cYEbJ4bG9f9Kpd2oWTwRMkvQx+yEO5EVKgPey5PCUtEQewG3PWaU=
X-Received: by 2002:a17:907:b1c:b0:797:983a:7d97 with SMTP id
 h28-20020a1709070b1c00b00797983a7d97mr35628022ejl.267.1666888353496; Thu, 27
 Oct 2022 09:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20221014183459.181567-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221014183459.181567-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y1pphVPw0J97AmW4@paasikivi.fi.intel.com> <CA+V-a8szaPjwumrBgOT9gzMKBjY7hk0zfP8RgzUUDfY+BAsogA@mail.gmail.com>
 <Y1p91+XxPCB9NWwh@paasikivi.fi.intel.com>
In-Reply-To: <Y1p91+XxPCB9NWwh@paasikivi.fi.intel.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 27 Oct 2022 17:32:07 +0100
Message-ID: <CA+V-a8uhYymEVg7jdLVGNLsVD3=O1mk-_NVERu00W+gsv-7QXg@mail.gmail.com>
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

On Thu, Oct 27, 2022 at 1:47 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Prabhakar,
>
> On Thu, Oct 27, 2022 at 01:01:52PM +0100, Lad, Prabhakar wrote:
> > Hi Sakari,
> >
> > On Thu, Oct 27, 2022 at 12:20 PM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Hi Prabhakar,
> > >
> > > One more comment.
> > >
> > > On Fri, Oct 14, 2022 at 07:34:56PM +0100, Prabhakar wrote:
> > > > @@ -1209,12 +1190,16 @@ static int ov5645_probe(struct i2c_client *client)
> > > >
> > > >       dev_info(dev, "OV5645 detected at address 0x%02x\n", client->addr);
> > > >
> > > > +     pm_runtime_set_active(dev);
> > > > +     pm_runtime_get_noresume(dev);
> > > > +     pm_runtime_enable(dev);
> > >
> > > You won't gain anything by eanbling runtime PM here. Just move it to the
> > > end of the function before the rest of the calls. Error handling becomes
> > > more simple.
> > >
> > If I move the above calls below I get the below warning:
> >
> > [    2.633386] ov5645 0-003c: Runtime PM usage count underflow!
> >
> > This is because of the last patch which moves ov5645_entity_init_cfg()
> > before registering the subdev. ov5645_entity_init_cfg() calls s_ctrl
> > due to which we are seeing the above message. Please let me know how
> > to proceed on this.
>
> Ah. Yes, this is a problem with the usage pattern of
> pm_runtime_get_if_in_use(). But please don't change that.
>
> You can still move enabling runtime PM later in the function.
>
Agreed, the final version looks like below:

    pm_runtime_set_active(dev);
    pm_runtime_get_noresume(dev);

    ov5645_entity_init_cfg(&ov5645->sd, NULL);

    ret = v4l2_async_register_subdev(&ov5645->sd);
    if (ret < 0) {
        dev_err(dev, "could not register v4l2 device\n");
        goto err_pm_runtime;
    }

    pm_runtime_set_autosuspend_delay(dev, 1000);
    pm_runtime_use_autosuspend(dev);
    pm_runtime_enable(dev);


Cheers,
Prabhakar
