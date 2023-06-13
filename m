Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D62372DBD9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240460AbjFMIAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241173AbjFMH76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:59:58 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7363C39
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:58:57 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-43b4b5378ecso300642137.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686643135; x=1689235135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsJLNzamcvflvt39bJ653iKfbKKP5ytmbnffadMCPyM=;
        b=NzCmxWBnfmLYJE9eX8SGkh9EhG7MM+9AO4XxEFNdYE36a5jCujth0fxlxzD/WRlvI8
         wwHufGE06Z+3m94N+4rDADqMOC4ANpUJorLdPwiUD00X2QXZznGT46ZEvMM0nF5r7Hri
         9GXJltOAClw2tO8tc9BIcNcAmC/T/tpq50YHo40fVChd+g0FeBMUbytkvo7nId5TBP0R
         1L0PMHqcFc6yCQ9/WNDJ5GubKrmAIjPco7+TvVkVgtJNRwxw658g7/AUVJ8UH0JCOH2P
         tjKwFbEn3WJEakotGAE6Gq3ferV6U8Sae8+CLPLCZsmps1TPLgesfq6pbt4z12KWyPjJ
         ekjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686643135; x=1689235135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UsJLNzamcvflvt39bJ653iKfbKKP5ytmbnffadMCPyM=;
        b=FonJDbJP+6GBuCzX/oWzCzDXZVE2mMjz7NlGqvgyePD7D3poGdmIhMNDOYXDtkNiFD
         5YiLtPc0xHlHJn6qFhOD6RsLQdm9X+rICMufJDIYEOun4LYo6jK3M2gZCniSEOf6l8/1
         GsP4vTtGoM6ihAxhb/TrmK+UH/CsnF9hSraDAyVwnUcjXeseB3SJo4FAwaRBG7s2voBQ
         +d+QpGnHN6nGFHiSxySUzgIHjGSxGpQa2QBkdwfYwkdBt4LK4N9h4nJz/SZzkqJgIoS8
         PKAKer7xrqUiVczNfE2xIToVWBT9M6XAn20cn7TeNFBf5wOWLom0F8Y19ORruufd5lqU
         sw0Q==
X-Gm-Message-State: AC+VfDxjgiIvNa7sUQeLZg8UXIWYx31/SNylZXXpfwCMEZdQMdlDE1kt
        X0bscYgQEuDGP2mr97ORCuqQTX3Zv4BIRmD51PObwQ==
X-Google-Smtp-Source: ACHHUZ6UD0q4lBsFYRt1iBzo8nMQl6CBXd1e25IrTyG7lfVFArPC+BBaQLENtHQYb5mOM3DJ18qcoESm5mZWq4y4/aI=
X-Received: by 2002:a67:f610:0:b0:43b:398c:b251 with SMTP id
 k16-20020a67f610000000b0043b398cb251mr6161345vso.5.1686643135653; Tue, 13 Jun
 2023 00:58:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230612092355.87937-1-brgl@bgdev.pl> <20230612092355.87937-14-brgl@bgdev.pl>
 <20230612204042.litbbv23zdb3u5k7@halaney-x13s>
In-Reply-To: <20230612204042.litbbv23zdb3u5k7@halaney-x13s>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 13 Jun 2023 09:58:44 +0200
Message-ID: <CAMRc=MeFnbcpjxNb537t0nb8Gd4ZsGVWZn2j+yHusWjmQQge4w@mail.gmail.com>
Subject: Re: [PATCH 13/26] net: stmmac: dwmac-qcom-ethqos: make the rgmii
 clock optional
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 10:40=E2=80=AFPM Andrew Halaney <ahalaney@redhat.co=
m> wrote:
>
> On Mon, Jun 12, 2023 at 11:23:42AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > On sa8775p there's no RGMII clock so make it optional in the driver.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/=
drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> > index 3438b6229351..252dca400071 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> > @@ -663,7 +663,7 @@ static int qcom_ethqos_probe(struct platform_device=
 *pdev)
> >       ethqos->rgmii_config_loopback_en =3D data->rgmii_config_loopback_=
en;
> >       ethqos->has_emac3 =3D data->has_emac3;
> >
> > -     ethqos->rgmii_clk =3D devm_clk_get(dev, "rgmii");
> > +     ethqos->rgmii_clk =3D devm_clk_get_optional(dev, "rgmii");
>
> This makes it optional for older platforms too, but as far as I know on
> those platforms it is mandatory.
>
> This can be enforced in dt-binding checks, but should we also enforce
> that in the driver still? Honestly I feel like yes, but there's probably
> some precedent maintainers follow on this front that I don't know of.
>

While my gut feeling is that enforcing the clock list on the DT
binding lever is enough, we can also do a different thing: rename the
clock from rgmii_clk to link_clk or something similar and just
determine the name based on the HW variant ("rgmii" or "phyaux"). Or
even get the clock by its index? this way we could fold the next patch
in the series into this one and simplify the code.

Bart

>
> >       if (IS_ERR(ethqos->rgmii_clk)) {
> >               ret =3D PTR_ERR(ethqos->rgmii_clk);
> >               goto out_config_dt;
> > --
> > 2.39.2
> >
>
