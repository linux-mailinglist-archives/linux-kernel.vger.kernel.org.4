Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED20960E557
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 18:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbiJZQOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 12:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbiJZQOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 12:14:04 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0B3CE99F;
        Wed, 26 Oct 2022 09:14:03 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 68E30580391;
        Wed, 26 Oct 2022 12:14:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 26 Oct 2022 12:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1666800842; x=
        1666808042; bh=vl4HoCVHol4hKpd3C0NRQB0WtcoXr8XO2mxUe95jG5k=; b=k
        HuPJk+Z+MVjBFThX2bL31VSIB3rNDDJhE/pYNzaKPpPDS9b8Cv+tjApM5le7weJp
        /8rkYXMXQ/CHScPvqf9QYNqV8wKSWDp+5lIuimE3hW9f3MwHl1B1jz3q50qMiVJd
        Z1+YmO2Kq5HybJBW7HQS/5ebgJ7DpEH0gbeNFo9PrC5L82Qj9q3G8M8eTgmcBH3/
        OEZKNU0WDFIzZ/9qDHHTrHLDweUcQ8Q/ekM9KxISyDg7zHy9Aky6mrH9wBa1intS
        f4AgU750rpT1ZBMVLgC2CbkR9SEtdTspePcFYF2yfIhVtyFhcAwCI9Rkdo/NG1Gt
        zRhfzPMYLMi+qtZIUnFTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1666800842; x=
        1666808042; bh=vl4HoCVHol4hKpd3C0NRQB0WtcoXr8XO2mxUe95jG5k=; b=a
        Yz0u0LfjWEAx+IauSzyx6J6Jx0+Ste7fQG986DfcUpa/U0AVvmwmN4OpuEM9b+wl
        SNSGY58UpHxMtbWFd8dP5qHLuSzqFXiuJ/YO5YI7VAlTQzGogF12ouVe6tcwtE/1
        AR2I+24KZm/R8+neC2Nu9oBUq1DdzUzSPZ9WU2iDSpjcQXiZmRnoz7frCR0GlAR/
        yuUQkmXgv72zOoScIgQvnXbjQmrj04hFwnFWTlyCwpcOXB1JOlQxZKOBNtZoo5FS
        eecnSfT51jxlg3umLwiBzGmu+JlLOcP5VNDh8nWm0XxpDZM1944R3Yh1/t6xvAAw
        VYyWSbiioqoBjJEbep9RQ==
X-ME-Sender: <xms:ylxZY76wbOw6LPoafFdmAi1D4qNUZ7fHylFPIncWIF_bz2hJwLqeHg>
    <xme:ylxZYw4RMEx7JEd3L98fJTC6r16PJHfIojRbjxwB7GXm9XMnvPItRfvbjvIernaol
    zecaHunUfouYQ5H5fY>
X-ME-Received: <xmr:ylxZYycvEnQHxINgxB2NMsMMxwidJ4oyuuyXFJSMSxDVYv4kvc6u2oI-ckOqINqB7B9EsvUvtaBeTCLd2eWIluC9JwG3amZNzCj3Bd0lsjt5VQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtddvgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhfffvvefukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomhepmhgrgihi
    mhgvsegtvghrnhhordhtvggthhenucggtffrrghtthgvrhhnpedvtefggeffuefhkedufe
    ffgffhgfehheetheeghfffkeduhfegffeukeelvdejgfenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtg
    hh
X-ME-Proxy: <xmx:ylxZY8KJ8lDG0xoRDbi2GZFj37IGlLOWVHe-inCtSb7_Z0OgcgSRXw>
    <xmx:ylxZY_K3JNY1kNEblIQpL0844ZBIRCWbbjezaB8yMmX3CccYnYYRSg>
    <xmx:ylxZY1xa5BqHrqU63O33u8FxrLuKqFUaYQW7DvorUOPG47KurxI7Wg>
    <xmx:ylxZY-iNus2sFSmqe0Ag17HMnGIb4egq_-vyrY2myOIPspbfq7h9UQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Oct 2022 12:14:01 -0400 (EDT)
From:   maxime@cerno.tech
Date:   Wed, 26 Oct 2022 18:14:00 +0200
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Dom Cobley <popcornmix@gmail.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v4 5/7] drm/vc4: hdmi: Rework hdmi_enable_4kp60 detection
 code
Message-ID: <20221026161400.ppg6a5ckycpdkhmn@houat>
References: <20220815-rpi-fix-4k-60-v4-0-a1b40526df3e@cerno.tech>
 <20220815-rpi-fix-4k-60-v4-5-a1b40526df3e@cerno.tech>
 <CAPY8ntBUJRKOkw4VxWL97zj13+DLtMG6rBgGCrvA+HHaAZ7Zvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAPY8ntBUJRKOkw4VxWL97zj13+DLtMG6rBgGCrvA+HHaAZ7Zvg@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Wed, Oct 26, 2022 at 05:00:25PM +0100, Dave Stevenson wrote:
> > +
> > +               node =3D rpi_firmware_find_node();
> > +               if (!node)
> > +                       return -EINVAL;
> > +
> > +               firmware =3D rpi_firmware_get(node);
> > +               of_node_put(node);
> > +               if (!firmware)
> > +                       return -EPROBE_DEFER;
> > +
> >                 hvs->core_clk =3D devm_clk_get(&pdev->dev, NULL);
> >                 if (IS_ERR(hvs->core_clk)) {
> >                         dev_err(&pdev->dev, "Couldn't get core clock\n"=
);
> >                         return PTR_ERR(hvs->core_clk);
> >                 }
> >
> > +               max_rate =3D rpi_firmware_clk_get_max_rate(firmware,
> > +                                                        RPI_FIRMWARE_C=
ORE_CLK_ID);
> > +               rpi_firmware_put(firmware);
> > +               if (max_rate >=3D 550000000)
> > +                       hvs->vc5_hdmi_enable_scrambling =3D true;
> > +
> > +               hvs->max_core_rate =3D max_rate;
>=20
> I was going to query the reason for storing this value, but it's used
> when we get to patch 7/7.
> I won't quibble about having it as an unused value for 2 patches.

Yeah, it felt natural to do it in that patch, even though it's indeed
only useful in a couple of patches.

Maxime
