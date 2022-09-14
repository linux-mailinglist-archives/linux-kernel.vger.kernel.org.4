Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936F15B8FBE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 22:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiINUtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 16:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiINUtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 16:49:18 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34E06C752
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 13:49:15 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id a9so8660771ilh.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 13:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=srvlwn1s0DWqayHeswIlpcLOKVgilS3dmjKYuVsVAWo=;
        b=m5GxyZv5Wj0wXSYhc62y3JzNwwz96gkwRHX5vgmaWsaoQmdkxiIa7vC8EHwTKDVMs2
         cVvlcRkmSpjwP2i3GHU/w7PgftSXnDfQQh2gQwlM//QjOec2finS5e+3MaChJkwoW3cB
         +paEYBY4ptrdjr8JrqMuT/ZUivoSrudgE2nu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=srvlwn1s0DWqayHeswIlpcLOKVgilS3dmjKYuVsVAWo=;
        b=ySvEIYgmOUsivT5aRthjCuPFAE28xU34l+MAd7TfKq0aE+BT/CFfpKvxfHoKTPVKVZ
         U6ahqQCAodcLglaywkr3TU5jCf1kJ85iS5p0Hfgb6b2O3LOO/f2b6SyxJVqXR+ny7ceo
         zhmJ3NBKSP/4pvbGkt8fSfCB8YJk6OkpL8ez96i6uXLm1rcr90mgzq5gp1EQtRCrMhoy
         lRqqLQYIzzKD0oYQloJFjrDXSqJqlejOI5ck3HuHwxSFyJeJCwuh0+HijVBYxD67q3Gr
         zLQf63Z/hLX5bXn2HI8g4Gc7r08edmrej+vtq/W/aTYK+u7HCQacQGcjS9kWAi21+3Vb
         1SdQ==
X-Gm-Message-State: ACgBeo2QJKKdNGjzsGD1f7ZIVOoAJEeoGRKqat0pM0gb8yYH9dFjaqMl
        NX/FK/aD7ZRzAzpfE2NOQ08uaA==
X-Google-Smtp-Source: AA6agR7rclet6G5TtC0LrJQZ8gZPU54JQT6EpGmIzS1l+uKyUgF+LS14bwOKS/n7nDhdNdhMy1jC/A==
X-Received: by 2002:a05:6e02:180f:b0:2f3:4a2f:7907 with SMTP id a15-20020a056e02180f00b002f34a2f7907mr14348320ilv.141.1663188554932;
        Wed, 14 Sep 2022 13:49:14 -0700 (PDT)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id g6-20020a92c7c6000000b002eae6cf8898sm6941522ilk.30.2022.09.14.13.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 13:49:14 -0700 (PDT)
Date:   Wed, 14 Sep 2022 20:49:12 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v24 1/2] arm64: dts: qcom: sc7180-trogdor: Add nodes for
 onboard USB hub
Message-ID: <YyI+SEnBthZ5l3OC@google.com>
References: <20220722093238.v24.1.I7a1a6448d50bdd38e6082204a9818c59cc7a9bfd@changeid>
 <CAD=FV=WkiNZQ0G9MivhA2TwG09wkyPX2AD5T9cMBJeSKWhddvA@mail.gmail.com>
 <CAD=FV=ULGGf2yVG8iULOUzD5XJL7nS+hgis6csrP4f0FKNBn5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=ULGGf2yVG8iULOUzD5XJL7nS+hgis6csrP4f0FKNBn5Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 03:02:23PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Thu, Aug 18, 2022 at 2:31 PM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Fri, Jul 22, 2022 at 9:32 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> > >
> > > Add nodes for the onboard USB hub on trogdor devices. Remove the
> > > 'always-on' property from the hub regulator, since the regulator
> > > is now managed by the onboard_usb_hub driver.
> > >
> > > For anyone using trogdor-based devices on Linux, it should be
> > > noted that this requires "CONFIG_USB_ONBOARD_HUB=y".
> > >
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> > > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > > This series depends on 3a6bf4a08142 ("usb: core: hub: Create platform
> > > devices for onboard hubs in hub_probe()") which landed in -next [1].
> > >
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?h=usb-next&id=3a6bf4a08142826698121bef16b244dcf50a6431
> > >
> > > Changes in v24:
> > > - renamed 'companion-hub' to 'peer-hub' according to the change
> > >   in the binding
> > >
> > > Changes in v23:
> > > - added note about enabling CONFIG_USB_ONBOARD_HUB to the commit
> > >   message
> > >
> > > Changes in v22:
> > > - none
> > >
> > > Changes in v21:
> > > - patch dropped from onboard_usb_hub series
> > >
> > > Changes in v20:
> > > - renamed hub labels to 'usb_hub_2/3_x'
> > > - added comment for 'regulator-boot-on' of 'pp3300_hub'
> > > - added 'Reviewed-by' tags from Stephen and Doug
> > >
> > > Changes in v19:
> > > - none
> > >
> > > Changes in v18:
> > > - also adjust config for pompom rev1
> > >
> > > Changes in v17:
> > > - none
> > >
> > > Changes in v16:
> > > - none
> > >
> > > Changes in v15:
> > > - none
> > >
> > > Changes in v14:
> > > - none
> > >
> > > Changes in v13:
> > > - none
> > >
> > > Changes in v12:
> > > - none
> > >
> > > Changes in v11:
> > > - rebased on qcom/arm64-for-5.14 (with the rest of the series)
> > >
> > > Changes in v10:
> > > - keep 'regulator-boot-on' property
> > > - updated commit message
> > >
> > > Changes in v9:
> > > - none
> > >
> > > Changes in v8:
> > > - none
> > >
> > > Changes in v7:
> > > - rebased on qcom/arm64-for-5.13 (with the rest of the series)
> > >
> > > Changes in v6:
> > > - added 'companion-hub' entry to both USB devices
> > > - added 'vdd-supply' also to hub@2
> > >
> > > Changes in v5:
> > > - patch added to the series
> > >
> > >  .../boot/dts/qcom/sc7180-trogdor-lazor-r0.dts | 19 ++++++++----------
> > >  .../boot/dts/qcom/sc7180-trogdor-lazor-r1.dts | 12 +++++------
> > >  .../dts/qcom/sc7180-trogdor-pompom-r1.dts     | 11 ++++------
> > >  .../arm64/boot/dts/qcom/sc7180-trogdor-r1.dts | 19 ++++++++----------
> > >  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  | 20 ++++++++++++++++++-
> > >  5 files changed, 44 insertions(+), 37 deletions(-)
> >
> > The driver changes have landed and stuck. They're in Linus's tree, so
> > I think we're now ready to land these two patches! Hooray!
> >
> > FWIW: I've continued my experiment of landing changes that I'm keeping
> > track of in a github tree:
> >
> > https://github.com/dianders/kernel-staging/commits/qcom/arm64-staging
> 
> I believe this series continues to be ready to land. Perhaps now would
> be a good time for it? ;-)

Ping, can these be landed?
