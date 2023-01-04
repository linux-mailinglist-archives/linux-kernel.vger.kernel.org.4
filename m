Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9ADC65CDD7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 08:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbjADHry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 02:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjADHrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 02:47:49 -0500
Received: from egress-ip4a.ess.de.barracuda.com (egress-ip4a.ess.de.barracuda.com [18.184.203.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364DE167CF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 23:47:48 -0800 (PST)
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198]) by mx-outbound46-4.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 04 Jan 2023 07:47:46 +0000
Received: by mail-lj1-f198.google.com with SMTP id bn17-20020a05651c179100b0027905fa8e48so7698921ljb.15
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 23:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D9f5z3cCFhs4FR8+gGLSNtq0xtNbjblXeZzCadPdRGE=;
        b=O6d2M1Vej/BwZLu4EoGLh5uM7yv0nu6iP0TkVbc3k7WGicrfyEfKuHmSdPUv0bUcUd
         oojLPhabL2JIoviRqHTudV0sDgdh9LehmAKWbFMRLoVLzlUrFhq+UVvr2Nr3itsInn0j
         fJ/6JBCHqi6sVeveJG6TMbN+vzYYCCkPszDWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D9f5z3cCFhs4FR8+gGLSNtq0xtNbjblXeZzCadPdRGE=;
        b=gUrRT3+cjOOcVhdK/Wx+11cneZs1iuXqH3F/JsGMnXecC8yYjMmO+MVDQlCk+xx6ga
         8ypDpquz5ueUzSxbMwbCJRmHGQjZyiOW2dO2Hd8F4wzvC92oThHIRO6ELkBbGWh6dNSr
         D9wCibDmGKeylluPPhf0FcQM0D+heznFKxKeFWCmlFcPaDoswGepvJt9JtmG58f12hw7
         9ZYsTGpoqJhIKZ7iQcSPRJ1g6sxNyzu2LpB+Wu5k7iTzphoNi2QwhmWFXFp/K59EUeZ3
         Csftt/7PTXdDwWKqofv2MuIfiQsSZlMGuorm9zTHJpl4x42xIT1sM5c5ZJ3WqCDZ0oa/
         /HcQ==
X-Gm-Message-State: AFqh2koAPSX6rbbwOttNo/48vOuneoCyORJbZ8OhGAxISPL7PzjwnGng
        TLvo/F7Sitxu2IqATg5te/pQ2uu1u4wm9X+AcAnX/lnDWnW+lRJFcFJ9iJRx/lvLbmHn3/k29k+
        t4D9l7YB0k/tZgxmuCc9qQ+p6PG7/xwC+B7rVoXnH71OE7MRncbGPT6CQnjLkHZmadT/e8BruFP
        i4
X-Received: by 2002:ac2:5de3:0:b0:4b4:a536:f866 with SMTP id z3-20020ac25de3000000b004b4a536f866mr1787908lfq.262.1672818464887;
        Tue, 03 Jan 2023 23:47:44 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvcwoBZoAjr1B1FS1N0PlG/MN9fvsCDXnPzOywCadO0g5UuE7gHb7YLH7P42zk3VwKiejVRKyn1giV2dty0xqY=
X-Received: by 2002:ac2:5de3:0:b0:4b4:a536:f866 with SMTP id
 z3-20020ac25de3000000b004b4a536f866mr1787900lfq.262.1672818464592; Tue, 03
 Jan 2023 23:47:44 -0800 (PST)
MIME-Version: 1.0
References: <20221213124854.3779-1-sinthu.raja@ti.com> <20221213124854.3779-2-sinthu.raja@ti.com>
 <b4f725b1-3ed6-51fd-4973-92e28987f488@kernel.org>
In-Reply-To: <b4f725b1-3ed6-51fd-4973-92e28987f488@kernel.org>
From:   Sinthu Raja M <sinthu.raja@mistralsolutions.com>
Date:   Wed, 4 Jan 2023 13:17:32 +0530
Message-ID: <CAEd-yTQEUcXYP1hJkUHyvd95-tyDMRETDNHBf07-_zbQu7UAJw@mail.gmail.com>
Subject: Re: [PATCH 1/2] phy: ti: j721e-wiz: Manage TypeC lane swap if
 typec-gpio-dir not specified
To:     Roger Quadros <rogerq@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sinthu Raja <sinthu.raja@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-BESS-ID: 1672818465-311780-5566-1560-1
X-BESS-VER: 2019.1_20221214.2106
X-BESS-Apparent-Source-IP: 209.85.208.198
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.245240 [from 
        cloudscan10-254.eu-central-1a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

On Wed, Dec 14, 2022 at 3:12 PM Roger Quadros <rogerq@kernel.org> wrote:
>
> Hi,
>
> Some more comments below.
>
> On 13/12/2022 14:48, Sinthu Raja wrote:
> > It's possible that the Type-C plug orientation on the DIR line will be
> > implemented through hardware design. In that situation, there won't be
> > an external GPIO line available, but the driver still needs to address
> > this since the DT won't use the typec-gpio-dir property.
> >
> > Add code to handle LN10 Type-C swap if typec-gpio-dir property is not
> > specified in DT.
> >
> > Remove typec-gpio-dir check to use minimum debounce from Type-C spec if
> > it is not provided in DT
> >
> > Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
> > ---
> >  drivers/phy/ti/phy-j721e-wiz.c | 65 +++++++++++++++++++++-------------
> >  1 file changed, 40 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
> > index 141b51af4427..b17eec632d49 100644
> > --- a/drivers/phy/ti/phy-j721e-wiz.c
> > +++ b/drivers/phy/ti/phy-j721e-wiz.c
> > @@ -375,6 +375,7 @@ struct wiz {
> >       struct gpio_desc        *gpio_typec_dir;
> >       int                     typec_dir_delay;
> >       u32 lane_phy_type[WIZ_MAX_LANES];
> > +     u32 lane_phy_reg[WIZ_MAX_LANES];
>
> This name looks misleading. I'll discuss about it where you are setting it.
Will change the name to master_lane_num[];
>
> >       struct clk              *input_clks[WIZ_MAX_INPUT_CLOCKS];
> >       struct clk              *output_clks[WIZ_MAX_OUTPUT_CLOCKS];
> >       struct clk_onecell_data clk_data;
> > @@ -1231,14 +1232,28 @@ static int wiz_phy_reset_deassert(struct reset_controller_dev *rcdev,
> >       int ret;
> >
> >       /* if typec-dir gpio was specified, set LN10 SWAP bit based on that */
> > -     if (id == 0 && wiz->gpio_typec_dir) {
> > -             if (wiz->typec_dir_delay)
> > -                     msleep_interruptible(wiz->typec_dir_delay);
> > -
> > -             if (gpiod_get_value_cansleep(wiz->gpio_typec_dir))
> > -                     regmap_field_write(wiz->typec_ln10_swap, 1);
> > -             else
> > -                     regmap_field_write(wiz->typec_ln10_swap, 0);
> > +     if (id == 0 && wiz->typec_dir_delay) {
> > +             msleep_interruptible(wiz->typec_dir_delay);
> > +
> > +             if (wiz->gpio_typec_dir) {
> > +                     if (gpiod_get_value_cansleep(wiz->gpio_typec_dir))
> > +                             regmap_field_write(wiz->typec_ln10_swap, 1);
> > +                     else
> > +                             regmap_field_write(wiz->typec_ln10_swap, 0);
> > +             } else {
> > +                     /* if no typec-dir gpio was specified, and USB lines
> > +                      * are connected to Lane 0 then set LN10 SWAP bit to 1.
> > +                      */
>
> Why should lanes 1 and 0 be swapped if USB is connected to lane 0?
My Bad! I should have been more precise in mentioning the USB3 Type C.
Lanes 0 and 2 are reserved for USB3 for type-C connector lane swap.
>
> > +                     u32 num_lanes = wiz->num_lanes;
> > +                     int i;
> > +
> > +                     for (i = 0; i < num_lanes; i++) {
> > +                             if ((wiz->lane_phy_type[i] == PHY_TYPE_USB3) \
> > +                                             && wiz->lane_phy_reg[i] == 0) {
> > +                                     regmap_field_write(wiz->typec_ln10_swap, 1);
> > +                             }
> > +                     }
>
> I really don't understand what you are doing here.
> It definitely doesn't match your comment.
> As an example. If num_lanes = 2 then wiz->lane_phy_reg[1] is being used without being
> really initialized (see later). Just because of kzalloc, it would of course be 0.
This register is used to configure the external lanes selections that
need to be swapped for SerDes type C. The initialization of the lanes
is done separately. This bit is set to configure that all control for
lane 0 will apply to lane 1 and vice versa.  Will update the commit
description.
>
> > +             }
> >       }
> >
> >       if (id == 0) {
> > @@ -1370,8 +1385,10 @@ static int wiz_get_lane_phy_types(struct device *dev, struct wiz *wiz)
> >               dev_dbg(dev, "%s: Lanes %u-%u have phy-type %u\n", __func__,
> >                       reg, reg + num_lanes - 1, phy_type);
> >
> > -             for (i = reg; i < reg + num_lanes; i++)
> > +             for (i = reg; i < reg + num_lanes; i++) {
> > +                     wiz->lane_phy_reg[i] = reg;
>
> As per DT binding
>       reg:
>         description:
>           The master lane number. This is the lowest numbered lane in the lane group.
>
> So you are in fact storing the Master lane number of every Link (or lane group).
> A link may have 1 or more lanes in it.
>
> Also notice that if num_lanes has been 2 then wiz->lane_phy_reg[1] is not initialized.
Irrespective of the number of lanes that are connected to the link, if
the master lane is '0' or '2'  and the PHY type is USB3, then this bit
needs to be set in the SerDes WIZ control register (according to the
design).
>
> >                       wiz->lane_phy_type[i] = phy_type;
> > +             }
> >       }
> >
> >       return 0;
> > @@ -1464,24 +1481,22 @@ static int wiz_probe(struct platform_device *pdev)
> >               goto err_addr_to_resource;
> >       }
> >
> > -     if (wiz->gpio_typec_dir) {
> > -             ret = of_property_read_u32(node, "typec-dir-debounce-ms",
> > -                                        &wiz->typec_dir_delay);
> > -             if (ret && ret != -EINVAL) {
> > -                     dev_err(dev, "Invalid typec-dir-debounce property\n");
> > -                     goto err_addr_to_resource;
> > -             }
> > +     ret = of_property_read_u32(node, "typec-dir-debounce-ms",
> > +                                &wiz->typec_dir_delay);
> > +     if (ret && ret != -EINVAL) {
> > +             dev_err(dev, "Invalid typec-dir-debounce property\n");
> > +             goto err_addr_to_resource;
> > +     }
> >
> > -             /* use min. debounce from Type-C spec if not provided in DT  */
> > -             if (ret == -EINVAL)
> > -                     wiz->typec_dir_delay = WIZ_TYPEC_DIR_DEBOUNCE_MIN;
> > +     /* use min. debounce from Type-C spec if not provided in DT  */
> > +     if (ret == -EINVAL)
> > +             wiz->typec_dir_delay = WIZ_TYPEC_DIR_DEBOUNCE_MIN;
> >
> > -             if (wiz->typec_dir_delay < WIZ_TYPEC_DIR_DEBOUNCE_MIN ||
> > -                 wiz->typec_dir_delay > WIZ_TYPEC_DIR_DEBOUNCE_MAX) {
> > -                     ret = -EINVAL;
> > -                     dev_err(dev, "Invalid typec-dir-debounce property\n");
> > -                     goto err_addr_to_resource;
> > -             }
> > +     if (wiz->typec_dir_delay < WIZ_TYPEC_DIR_DEBOUNCE_MIN ||
> > +         wiz->typec_dir_delay > WIZ_TYPEC_DIR_DEBOUNCE_MAX) {
> > +             ret = -EINVAL;
> > +             dev_err(dev, "Invalid typec-dir-debounce property\n");
> > +             goto err_addr_to_resource;
> >       }
> >
> >       ret = wiz_get_lane_phy_types(dev, wiz);
>
> cheers,
> -roger



-- 
With Regards
Sinthu Raja
