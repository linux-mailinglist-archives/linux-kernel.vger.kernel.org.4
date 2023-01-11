Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D801665877
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238303AbjAKKCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235989AbjAKKB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:01:57 -0500
Received: from egress-ip33a.ess.de.barracuda.com (egress-ip33a.ess.de.barracuda.com [18.185.115.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B902DECE
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:58:39 -0800 (PST)
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200]) by mx-outbound9-241.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 11 Jan 2023 09:58:35 +0000
Received: by mail-lj1-f200.google.com with SMTP id l11-20020a2e99cb000000b0027fbbafe46fso3746406ljj.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+NDmNbFwjo9DxMWr9KM3RKDdc7/RIp0UCXNPTu6MxA=;
        b=VlOJxEjrjd+VrQXJF6dP3QOBELPyvzrhRIc7t7KdSQp+j9RupVVVCYCNvRx4+ZKgeb
         ql5Q/vYxqD39/7mRf5D/l4Vw8MeK/rfq+3ubX9EJWsSCiLW/VTtTaHTA9xVHzV4jQp/p
         gpBATLZFlgKMT5mtSUOTXETbKZJC/8XAj/deM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+NDmNbFwjo9DxMWr9KM3RKDdc7/RIp0UCXNPTu6MxA=;
        b=x9+E/jwmpCoJy3VSMzfz9GrquFl643K+lQEYOfup37fWJQIzoMytVmzLWzZJaMNd/3
         igawdvIxuOER92MOx63DKMsAWheO63QvfQNChLXGxvGwzh7NdE/AjYXrytOMDtDp99xA
         bfAovMrzBbHOqARysHFUrbhl3ywk9VEqvUCGLHLDirO99j+7IZV1WQetxfUd+rLA0s0w
         z1CBMq3hPKgLIPnFHDkyQRC+lf60pjEp5uHgCMAlEClKfaIjJLZlWipXIc/VE/5JlGPN
         sQYvI6m1FB1XTXM7GCnCSlbW11TrjKFc8SU+P0XZwBAQ/6C07BbgmJ4WsqraOLgOL/Y2
         Mjng==
X-Gm-Message-State: AFqh2kqfh4UHQV++7BK28Vh8X7en0Kp5NNxwWo1jry+d42sBUoREj0vd
        ppqQIklZAFkaOcsjms234U5v1BO91aAilhBP+i4yzCgk8b1Y0tDEGyPyymPJ7GsP31GW8Qnf4Rl
        /FvOQ430CWWhRuATqGsbelu9nE/TzNMKFcdRJVjrKouLtnZ4ll7Av9oAd2/13G7trn6tvT2ACSQ
        rD
X-Received: by 2002:a05:651c:210c:b0:286:6e49:190f with SMTP id a12-20020a05651c210c00b002866e49190fmr717447ljq.40.1673431115258;
        Wed, 11 Jan 2023 01:58:35 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsufEAoTnnzxY8wmHx63idXKB1GFlobCduIWhEry1RFVfcwllpiNPdlE9GyZtuOaND3yRD93DBm8KZoD8RtA18=
X-Received: by 2002:a05:651c:210c:b0:286:6e49:190f with SMTP id
 a12-20020a05651c210c00b002866e49190fmr717441ljq.40.1673431114978; Wed, 11 Jan
 2023 01:58:34 -0800 (PST)
MIME-Version: 1.0
References: <20230106071714.30562-1-sinthu.raja@ti.com> <20230106071714.30562-3-sinthu.raja@ti.com>
 <cf854af6-fbbc-6e5c-f773-c4a868d85278@kernel.org>
In-Reply-To: <cf854af6-fbbc-6e5c-f773-c4a868d85278@kernel.org>
From:   Sinthu Raja M <sinthu.raja@mistralsolutions.com>
Date:   Wed, 11 Jan 2023 15:28:23 +0530
Message-ID: <CAEd-yTTDrTs_dpb_VqhyZjbTWDcXvZwKqhoP=sU_921PjuLpGQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] phy: ti: j721e-wiz: Add support to enable LN23
 Type-C swap
To:     Roger Quadros <rogerq@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sinthu Raja <sinthu.raja@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BESS-ID: 1673431115-302545-5392-2780-1
X-BESS-VER: 2019.1_20221214.2106
X-BESS-Apparent-Source-IP: 209.85.208.200
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.245392 [from 
        cloudscan9-143.eu-central-1a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_SC0_SA085b, BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 3:24 PM Roger Quadros <rogerq@kernel.org> wrote:
>
> Hi Sinthu,
>
> On 06/01/2023 09:17, Sinthu Raja wrote:
> > From: Sinthu Raja <sinthu.raja@ti.com>
> >
> > The WIZ acts as a wrapper for SerDes and has Lanes 0 and 2 reserved
> > for USB for type-C lane swap if Lane 1 and Lane 3 are linked to the
> > USB PHY that is integrated into the SerDes IP. The WIZ control register
> > has to be configured to support this lane swap feature.
> >
> > The support for swapping lanes 2 and 3 is missing and therefore
> > add support to configure the control register to swap between
> > lanes 2 and 3 if PHY type is USB.
> >
> > Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
> > ---
> >
> > Changes in V2:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Address review comments:
> > - Update commit description.
> > - Rename enum variable name from wiz_lane_typec_swap_mode to wiz_typec_=
master_lane.
> > - Rename enumerators name specific to list of master lanes used for lan=
e swapping.
> > - Add inline comments.
> >
> > V1: https://linkprotect.cudasvc.com/url?a=3Dhttps%3a%2f%2flore.kernel.o=
rg%2flkml%2f20221213124854.3779-2-sinthu.raja%40ti.com%2fT%2f%23m5e2d1a15d6=
47f5df9dd28ed2dedc4b0812d6466f&c=3DE,1,Y-aGHFF9W5xMNeMlJ71LqKOZsmcrFFVOKtXq=
77GFhXQctctl3hRfr-TLmdAnjdaeSzzP0z8DPPPmxLORLMeyROZypsrLBJDsa2LdQkLThbo_gfu=
7bN9Uj_qC&typo=3D1
> >
> >  drivers/phy/ti/phy-j721e-wiz.c | 33 ++++++++++++++++++++++++++++++---
> >  1 file changed, 30 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-=
wiz.c
> > index 571f0ca18874..815e8124b94a 100644
> > --- a/drivers/phy/ti/phy-j721e-wiz.c
> > +++ b/drivers/phy/ti/phy-j721e-wiz.c
> > @@ -58,6 +58,14 @@ enum wiz_lane_standard_mode {
> >       LANE_MODE_GEN4,
> >  };
> >
> > +/*
> > + * List of master lanes used for lane swapping
> > + */
> > +enum wiz_typec_master_lane {
> > +     LANE0 =3D 0,
> > +     LANE2 =3D 2,
> > +};
> > +
> >  enum wiz_refclk_mux_sel {
> >       PLL0_REFCLK,
> >       PLL1_REFCLK,
> > @@ -194,6 +202,9 @@ static const struct reg_field p_mac_div_sel1[WIZ_MA=
X_LANES] =3D {
> >  static const struct reg_field typec_ln10_swap =3D
> >                                       REG_FIELD(WIZ_SERDES_TYPEC, 30, 3=
0);
> >
> > +static const struct reg_field typec_ln23_swap =3D
> > +                                     REG_FIELD(WIZ_SERDES_TYPEC, 31, 3=
1);
> > +
> >  struct wiz_clk_mux {
> >       struct clk_hw           hw;
> >       struct regmap_field     *field;
> > @@ -367,6 +378,7 @@ struct wiz {
> >       struct regmap_field     *mux_sel_field[WIZ_MUX_NUM_CLOCKS];
> >       struct regmap_field     *div_sel_field[WIZ_DIV_NUM_CLOCKS_16G];
> >       struct regmap_field     *typec_ln10_swap;
> > +     struct regmap_field     *typec_ln23_swap;
> >       struct regmap_field     *sup_legacy_clk_override;
> >
> >       struct device           *dev;
> > @@ -676,6 +688,13 @@ static int wiz_regfield_init(struct wiz *wiz)
> >               return PTR_ERR(wiz->typec_ln10_swap);
> >       }
> >
> > +     wiz->typec_ln23_swap =3D devm_regmap_field_alloc(dev, regmap,
> > +                                                    typec_ln23_swap);
> > +     if (IS_ERR(wiz->typec_ln23_swap)) {
> > +             dev_err(dev, "LN23_SWAP reg field init failed\n");
> > +             return PTR_ERR(wiz->typec_ln23_swap);
> > +     }
> > +
> >       wiz->phy_en_refclk =3D devm_regmap_field_alloc(dev, regmap, phy_e=
n_refclk);
> >       if (IS_ERR(wiz->phy_en_refclk)) {
> >               dev_err(dev, "PHY_EN_REFCLK reg field init failed\n");
> > @@ -1254,9 +1273,17 @@ static int wiz_phy_reset_deassert(struct reset_c=
ontroller_dev *rcdev,
> >                       int i;
> >
>
> Don't you have to update the below comment you added in patch 1 to mentio=
n about LN23 as well?

Thanks for the review, Roger.
Yes, I have to. My bad. I will send out another version updating this comme=
nt.
>
>
> +                       /* if no typec-dir gpio was specified and PHY typ=
e is
> +                        * USB3 with master lane number is '0', set LN10 =
SWAP
> +                        * bit to '1'
> +                        */
>
>
> >                       for (i =3D 0; i < num_lanes; i++) {
> > -                             if ((wiz->lane_phy_type[i] =3D=3D PHY_TYP=
E_USB3)
> > -                                             && wiz->master_lane_num[i=
] =3D=3D 0) {
> > -                                     regmap_field_write(wiz->typec_ln1=
0_swap, 1);
> > +                             if (wiz->lane_phy_type[i] =3D=3D PHY_TYPE=
_USB3) {
> > +                                     switch (wiz->master_lane_num[i]) =
{
> > +                                     case LANE0:
> > +                                             regmap_field_write(wiz->t=
ypec_ln10_swap, 1);
> > +                                             break;
> > +                                     case LANE2:
> > +                                             regmap_field_write(wiz->t=
ypec_ln23_swap, 1);
> > +                                             break;
> > +                                     default:
> > +                                             break;
> > +                                     }
> >                               }
> >                       }
> >               }
>
> Otherwise looks good.
>
> cheers,
> -roger
>


--=20
With Regards
Sinthu Raja
