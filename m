Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEE169F11B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjBVJQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjBVJQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:16:36 -0500
X-Greylist: delayed 109 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Feb 2023 01:16:35 PST
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CF4367E6;
        Wed, 22 Feb 2023 01:16:34 -0800 (PST)
Received: from hillosipuli.retiisi.eu (dkzbhx1tyyyyyyyyyyyyt-3.rev.dnainternet.fi [IPv6:2001:14ba:4502:69d6::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 0D8E91B001D8;
        Wed, 22 Feb 2023 11:16:33 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1677057393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1gLABmEErG0c/dQ1eaD1AMy9nmYziBDR1skxStDMMes=;
        b=JQ4xVmHsdot0+DDWsNIxqf3v54crYgImT4uS14vSeyg2rKQBf/UA5vkM2vtqnDZR3G2pxD
        l2REqI7svnlKTuR0Q+BrUqx22RqFGVkRopEW8QDnkyGiQYVmv7Pny0IVykvg4aFuEdtSDB
        JIGFlO1sugfNjVMusvMJ0vu6J6gqzrOnE4kvtooFS9/kizafVnKco0GzQGY+q7PmM9PrPh
        jPW2Rwodasvdyg280ihO5tEU1nC2DT0BIsjbE7waXSFutopOvXEx7l+uxzV0zNWZs+PrFH
        une3B5pBYLTTBVdhm5o7H/zwv/0W5Y+xHn5/ntZlaYftDemMvUTe5eyKkkc5fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1677057393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1gLABmEErG0c/dQ1eaD1AMy9nmYziBDR1skxStDMMes=;
        b=czooaXG1dXhYirXUP2sAH0/CGmtJ7mGk6xWDTxIM1s8PP8odkSdy6JxCfXBO1MYhzf2e8O
        VprJ5jLitF0DzT+anVchW2lYHrg0VA3ZATWyRIH5R9QrFjiaVJkK+VHScb2S0L2Ulo4s9f
        wwRw12DIAAvYj8Be3Xi3wGe60czH0417SWik8Aj25kddrRFwdnKScUf71j7Kkwmm055734
        HSwGCtudvIGwpFODDVk6u9Wg2UIe3q2o15z96q9gXbTBXDiWgA259/4h+jaIL+vX4WaUZL
        af1kI+ARWoxop4CH4D9yR7mLHUJZLuwyBreZKyxaMb9domIXZsuvJETTCVB3SA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1677057393; a=rsa-sha256;
        cv=none;
        b=ifQMFZDkD6GePV7K/znuMmm8o2B/pTb9KQEqGVUaxsPrqg1zldo542Z4NOF4Pun1x661nO
        FdCDgTErPp9xfqjKn6lS2c1/cK/qHVraMsdKftRvlSIEzQcNECzyX9LCNX4tOClwS9Jheg
        c3TgXNTQO2Ixp/toq7bhdlAFbm6DtKI12lwfhlq82gt6Czf4f4E77nRgSvADzw3KiTeg9b
        jeuNBsnsUuDKdu6gjno4+fbI8aRQi+a2s6/N9o5NeWmtKp/iJCs6zABJkV/c1c7RYK9cMU
        R/zGuF7ju2ozAGVcZ7667n2XP+zB85pvC0SDq4xZxtlp+iyd0DKs9YPn7ru9pg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 8FBE3634C91;
        Wed, 22 Feb 2023 11:16:20 +0200 (EET)
Date:   Wed, 22 Feb 2023 11:16:20 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Shravan.Chippa@microchip.com
Cc:     paul.j.murphy@intel.com, daniele.alessandrelli@intel.com,
        mchehab@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        kernel@pengutronix.de, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND v10 5/5] media: i2c: imx334: update pixel and link
 frequency
Message-ID: <Y/XdZC7Yc8TjPvj4@valkosipuli.retiisi.eu>
References: <20230121033713.3535351-1-shravan.chippa@microchip.com>
 <20230121033713.3535351-6-shravan.chippa@microchip.com>
 <Y88SG5ndXjQ9AjZg@valkosipuli.retiisi.eu>
 <PH0PR11MB56119C93EB4A19FEFC03778F81C99@PH0PR11MB5611.namprd11.prod.outlook.com>
 <Y9D5eG8PP/qYPk40@valkosipuli.retiisi.eu>
 <PH0PR11MB5611880BB2141A73B2D67D7181CC9@PH0PR11MB5611.namprd11.prod.outlook.com>
 <PH0PR11MB561174CA61F9C858577F726781DA9@PH0PR11MB5611.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB561174CA61F9C858577F726781DA9@PH0PR11MB5611.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shravan,

On Mon, Feb 06, 2023 at 04:43:42AM +0000, Shravan.Chippa@microchip.com wrote:
> Hi Sakari,
> 
> 
> > -----Original Message-----
> > From: shravan Chippa - I35088
> > Sent: 27 January 2023 05:40 AM
> > To: Sakari Ailus <sakari.ailus@iki.fi>
> > Cc: paul.j.murphy@intel.com; daniele.alessandrelli@intel.com;
> > mchehab@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > shawnguo@kernel.org; s.hauer@pengutronix.de; festevam@gmail.com;
> > kernel@pengutronix.de; linux-imx@nxp.com; linux-media@vger.kernel.org;
> > linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org
> > Subject: RE: [PATCH RESEND v10 5/5] media: i2c: imx334: update pixel and
> > link frequency
> > 
> > Hi Sakari,
> > 
> > > -----Original Message-----
> > > From: Sakari Ailus <sakari.ailus@iki.fi>
> > > Sent: 25 January 2023 03:12 PM
> > > To: shravan Chippa - I35088 <Shravan.Chippa@microchip.com>
> > > Cc: paul.j.murphy@intel.com; daniele.alessandrelli@intel.com;
> > > mchehab@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > > shawnguo@kernel.org; s.hauer@pengutronix.de; festevam@gmail.com;
> > > kernel@pengutronix.de; linux-imx@nxp.com; linux-
> > media@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> > > kernel@lists.infradead.org
> > > Subject: Re: [PATCH RESEND v10 5/5] media: i2c: imx334: update pixel
> > > and link frequency
> > >
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you know
> > > the content is safe
> > >
> > > Hi Shravan,
> > >
> > > On Tue, Jan 24, 2023 at 05:34:02AM +0000, Shravan.Chippa@microchip.com
> > > wrote:
> > > > Hi Sakari,
> > > >
> > > > > -----Original Message-----
> > > > > From: Sakari Ailus <sakari.ailus@iki.fi>
> > > > > Sent: 24 January 2023 04:33 AM
> > > > > To: shravan Chippa - I35088 <Shravan.Chippa@microchip.com>
> > > > > Cc: paul.j.murphy@intel.com; daniele.alessandrelli@intel.com;
> > > > > mchehab@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > > > > shawnguo@kernel.org; s.hauer@pengutronix.de;
> > festevam@gmail.com;
> > > > > kernel@pengutronix.de; linux-imx@nxp.com;
> > > > > linux-media@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > > devicetree@vger.kernel.org; linux-arm- kernel@lists.infradead.org
> > > > > Subject: Re: [PATCH RESEND v10 5/5] media: i2c: imx334: update
> > > > > pixel and link frequency
> > > > >
> > > > > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > > > > know the content is safe
> > > > >
> > > > > Hi Shravan,
> > > > >
> > > > > On Sat, Jan 21, 2023 at 09:07:13AM +0530, shravan kumar wrote:
> > > > > > From: Shravan Chippa <shravan.chippa@microchip.com>
> > > > > >
> > > > > > Update pixel_rate and link frequency for 1920x1080@30 while
> > > > > > changing mode.
> > > > > >
> > > > > > Add dummy ctrl cases for pixel_rate and link frequency to avoid
> > > > > > error while changing the modes dynamically.
> > > > > >
> > > > > > Add support to handle multiple link frequencies.
> > > > > >
> > > > > > Suggested-by: Sakari Ailus <sakari.ailus@iki.fi>
> > > > > > Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> > > > > > ---
> > > > > >  drivers/media/i2c/imx334.c | 41
> > > > > > ++++++++++++++++++++++++++++----------
> > > > > >  1 file changed, 30 insertions(+), 11 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/media/i2c/imx334.c
> > > > > > b/drivers/media/i2c/imx334.c index 309c706114d2..62b104eaa437
> > > > > > 100644
> > > > > > --- a/drivers/media/i2c/imx334.c
> > > > > > +++ b/drivers/media/i2c/imx334.c
> > > > > > @@ -49,7 +49,8 @@
> > > > > >  #define IMX334_INCLK_RATE    24000000
> > > > > >
> > > > > >  /* CSI2 HW configuration */
> > > > > > -#define IMX334_LINK_FREQ     891000000
> > > > > > +#define IMX334_LINK_FREQ_891M        891000000
> > > > > > +#define IMX334_LINK_FREQ_445M        445500000
> > > > > >  #define IMX334_NUM_DATA_LANES        4
> > > > > >
> > > > > >  #define IMX334_REG_MIN               0x00
> > > > > > @@ -139,12 +140,14 @@ struct imx334 {
> > > > > >       u32 vblank;
> > > > > >       const struct imx334_mode *cur_mode;
> > > > > >       struct mutex mutex;
> > > > > > +     unsigned long menu_skip_mask;
> > > > > >       u32 cur_code;
> > > > > >       bool streaming;
> > > > > >  };
> > > > > >
> > > > > >  static const s64 link_freq[] = {
> > > > > > -     IMX334_LINK_FREQ,
> > > > > > +     IMX334_LINK_FREQ_891M,
> > > > > > +     IMX334_LINK_FREQ_445M,
> > > > > >  };
> > > > > >
> > > > > >  /* Sensor mode registers for 1920x1080@30fps */ @@ -468,7
> > > > > > +471,7 @@ static const struct imx334_mode supported_modes[] = {
> > > > > >               .vblank_min = 45,
> > > > > >               .vblank_max = 132840,
> > > > > >               .pclk = 297000000,
> > > > > > -             .link_freq_idx = 0,
> > > > > > +             .link_freq_idx = 1,
> > > > > >               .reg_list = {
> > > > > >                       .num_of_regs = ARRAY_SIZE(mode_1920x1080_regs),
> > > > > >                       .regs = mode_1920x1080_regs, @@ -598,6
> > > > > > +601,11 @@ static int imx334_update_controls(struct imx334
> > > > > > +*imx334,
> > > > > >       if (ret)
> > > > > >               return ret;
> > > > > >
> > > > > > +     ret = __v4l2_ctrl_modify_range(imx334->pclk_ctrl, mode->pclk,
> > > > > > +                                    mode->pclk, 1, mode->pclk);
> > > > > > +     if (ret)
> > > > > > +             return ret;
> > > > > > +
> > > > > >       ret = __v4l2_ctrl_modify_range(imx334->hblank_ctrl, mode-
> > >hblank,
> > > > > >                                      mode->hblank, 1, mode->hblank);
> > > > > >       if (ret)
> > > > > > @@ -698,6 +706,8 @@ static int imx334_set_ctrl(struct v4l2_ctrl *ctrl)
> > > > > >               pm_runtime_put(imx334->dev);
> > > > > >
> > > > > >               break;
> > > > > > +     case V4L2_CID_PIXEL_RATE:
> > > > > > +     case V4L2_CID_LINK_FREQ:
> > > > > >       case V4L2_CID_HBLANK:
> > > > > >               ret = 0;
> > > > > >               break;
> > > > > > @@ -1047,7 +1057,7 @@ static int imx334_parse_hw_config(struct
> > > > > > imx334
> > > > > *imx334)
> > > > > >       struct fwnode_handle *ep;
> > > > > >       unsigned long rate;
> > > > > >       int ret;
> > > > > > -     int i;
> > > > > > +     int i, j;
> > > > >
> > > > > unsigned int would be nicer.
> > > > I will change.
> > > > >
> > > > > >
> > > > > >       if (!fwnode)
> > > > > >               return -ENXIO;
> > > > > > @@ -1097,11 +1107,20 @@ static int imx334_parse_hw_config(struct
> > > > > > imx334
> > > > > *imx334)
> > > > > >               goto done_endpoint_free;
> > > > > >       }
> > > > > >
> > > > > > -     for (i = 0; i < bus_cfg.nr_of_link_frequencies; i++)
> > > > > > -             if (bus_cfg.link_frequencies[i] == IMX334_LINK_FREQ)
> > > > > > +     for (i = 0; i < bus_cfg.nr_of_link_frequencies; i++) {
> > > > > > +             for (j = 0; j < ARRAY_SIZE(link_freq); j++) {
> > > > > > +                     if (bus_cfg.link_frequencies[i] == link_freq[j]) {
> > > > > > +                             set_bit(j,
> > > > > > + &imx334->menu_skip_mask);
> > > > >
> > > > > Is there a guarantee that you'll only be using the modes with the
> > > > > listed frequencies? I don't see one but I might have missed it.
> > > >
> > > > If I understand it correctly, the question here is, the listed
> > > > freqeunceis and modes are one to one mapped? Then yes.
> > >
> > > I don't see this being checked in imx334_set_pad_format(), for instance.
> > >
> > > If a frequency isn't in DT, the driver isn't supposed to be using it either.
> > 
> > Yes, there is no check.
> > 
> > But, if a frequency is not in DT, the driver will not add in menu items.
> > So, the function imx334_set_pad_format() -> imx334_update_controls()
> > fails, if we set the frequencies which are not there in the DT or menu items.
> > 
> 
> Are you ok with the above explanation or any changes you are expecting?
> Please do let me know if there are any changes needed.
> I am planning to send the next version.

There doesn't seem to be anything that would prevent selecting a format
with a wrong link frequency in these patches. Could you address that, or
point me to where this is done? The control can't be changed by the user,
but that's not enough.

-- 
Kind regards,

Sakari Ailus
