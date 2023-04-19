Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FBE6E7797
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 12:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjDSKmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 06:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjDSKmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 06:42:03 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EBC106;
        Wed, 19 Apr 2023 03:42:02 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63b5c830d5eso2511450b3a.2;
        Wed, 19 Apr 2023 03:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681900922; x=1684492922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MdNpSS+OOI19jq0uYTZJnCcJQUPASUIXiKZhUZv1Dk=;
        b=qPRkEGyJsDCSaZp4ogPYKDiohjMXJ0vzEVw3ywT3uU/GKNXrfLhJZ6WO/RujYYRmnF
         PIWdYM8XUTae0Uwqo7K/BsM/m71gYS2qAaYZAovPC1ozzLxvbFBxNBj2itCjIfsdCZJz
         oYXRbDEc4jvuxTsiYF9N+36SWDKzN6YFkfpmByLMKoupMARS4SESLcF10sB+s5JNHtH+
         eU6mOiWuF6DAzFXziTij97EURj0NDOKUoNwtwn7c6F8otf7HQY66n+v+ABnb1PuUo9vp
         1st/sxXJ8d2dMZe0h1UZDcj5KiM9BY58WSMtHv03DVWR0PY6UdrnmgJzZ4HyJLaQfrvf
         4SnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681900922; x=1684492922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MdNpSS+OOI19jq0uYTZJnCcJQUPASUIXiKZhUZv1Dk=;
        b=a9+oF9oZ90DwII8B5NcDhmPWznPe+EAnOYGEN5NxZq1aRtt+y9Zm3iMaofA26qofK5
         uF/rgXTVpSvBRvjSWRByYG9Yxgv4k/UvcAIzvEyQSGIVAkcvmkqkpR+vbqOgsIKN3HX/
         ge8VYf5SDjRxEw91qBslF73oLKOQId8K1N6VHD+UyzPKpXuc2WTtJhly+JWjnpPhNrvM
         ZAo01O86ro+xdnH2/H3M9kRc1ACgijIJkvNTNjeblfyh6X2iyVE2njUoB+E+D+q5vHIw
         nWXc5zs4hkNAQ8Wa0AN9q22yw4Y1tyF/CCZrKb9RJZGELpx17tytTwKY8b0YXSsqNe0B
         Mtdg==
X-Gm-Message-State: AAQBX9eHIEteHoUtHJIdnBWLJVI8PBpR5rCfeWOzNXx+ae6FTyEw7+8d
        nm5nfvxU5GiI+HkFeMZxF5O4yYAFaqnEPlHUtGo=
X-Google-Smtp-Source: AKy350YK8qcAcZopioCgqzrCcc04oP+3g3LHqjy7As6Hr0znMSBB+LYIyMZez9fjGSi2RP7eMP/QK1WXZ/RF5wuQ8GQ=
X-Received: by 2002:a17:90a:9802:b0:247:160d:3a8e with SMTP id
 z2-20020a17090a980200b00247160d3a8emr2278200pjo.22.1681900921522; Wed, 19 Apr
 2023 03:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230415104104.5537-1-aford173@gmail.com> <20230415104104.5537-3-aford173@gmail.com>
 <7eed74e8-9f67-a410-3cec-f61a6db85238@denx.de> <CAHCN7xKw26TQ=t75TEDbEkA0mb9rnEwNW=7ei1=WFBZjiJMf=g@mail.gmail.com>
 <56085a0f-02f7-6f45-f351-1f9ee612b748@denx.de> <426e901f14254cfcff87ba1747534f9b856ef738.camel@pengutronix.de>
In-Reply-To: <426e901f14254cfcff87ba1747534f9b856ef738.camel@pengutronix.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 19 Apr 2023 05:41:49 -0500
Message-ID: <CAHCN7xLL+VBYfL_si07zhdLgV431H7XSxf6U_50mtAH-BZL=SA@mail.gmail.com>
Subject: Re: [PATCH 3/6] drm: bridge: samsung-dsim: Fetch pll-clock-frequency automatically
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Marek Vasut <marex@denx.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        aford@beaconembedded.com, dri-devel@lists.freedesktop.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        m.szyprowski@samsung.com, Robert Foss <rfoss@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 3:47=E2=80=AFAM Lucas Stach <l.stach@pengutronix.de=
> wrote:
>
> Am Dienstag, dem 18.04.2023 um 10:30 +0200 schrieb Marek Vasut:
> > On 4/18/23 04:29, Adam Ford wrote:
> > > On Sun, Apr 16, 2023 at 5:08=E2=80=AFPM Marek Vasut <marex@denx.de> w=
rote:
> > > >
> > > > On 4/15/23 12:41, Adam Ford wrote:
> > > > > Fetch the clock rate of "sclk_mipi" (or "pll_clk") instead of
> > > > > having an entry in the device tree for samsung,pll-clock-frequenc=
y.
> > > > >
> > > > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > > > ---
> > > > >    drivers/gpu/drm/bridge/samsung-dsim.c | 12 ++++++------
> > > > >    1 file changed, 6 insertions(+), 6 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/=
drm/bridge/samsung-dsim.c
> > > > > index 9fec32b44e05..73f0c3fbbdf5 100644
> > > > > --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> > > > > +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> > > > > @@ -1744,11 +1744,6 @@ static int samsung_dsim_parse_dt(struct sa=
msung_dsim *dsi)
> > > > >        struct device_node *node =3D dev->of_node;
> > > > >        int ret;
> > > > >
> > > > > -     ret =3D samsung_dsim_of_read_u32(node, "samsung,pll-clock-f=
requency",
> > > > > -                                    &dsi->pll_clk_rate);
> > > > > -     if (ret < 0)
> > > > > -             return ret;
> > > > > -
> > > > >        ret =3D samsung_dsim_of_read_u32(node, "samsung,burst-cloc=
k-frequency",
> > > > >                                       &dsi->burst_clk_rate);
> > > > >        if (ret < 0)
> > > >
> > > > Does this break compatibility with old samsung DTs ?
> > >
> > > My goal here was to declutter the device tree stuff and fetch data
> > > automatically if possible. What if I changed this to make them
> > > optional?  If they exist, we can use them, if they don't exist, we
> > > could read the clock rate.  Would that be acceptable?
> >
> > If you do not see any potential problem with ignoring the DT property
> > altogether, that would be better of course, but I think you cannot do
> > that with old DTs, so you should retain backward compatibility fallback=
,
> > yes. What do you think ?
>
> I'm very much in favor of this patch, but I also think we shouldn't
> risk breaking Samsung devices, where we don't now 100% that the input
> clock rate provided by the clock driver is correct.
>
> So I think the right approach is to use "samsung,pll-clock-frequency"
> when present in DT and get it from the clock provider otherwise. Then
> just remove the property from the DTs where we can validate that the
> input clock rate is correct, i.e. all i.MX8M*.

I'll update this accordingly when I do a V2 of this series.

adam
>
> Regards,
> Lucas
