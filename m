Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D5974CB25
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 06:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjGJESP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 00:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjGJESL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 00:18:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE03E7;
        Sun,  9 Jul 2023 21:18:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A84C60DC5;
        Mon, 10 Jul 2023 04:18:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA883C433C7;
        Mon, 10 Jul 2023 04:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688962689;
        bh=icelyTv0me7PhCdYXmZ6RGwhJh8wbgcHWtBnbl35BNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZjgPRFKD9qaKDg9g43bXHtw9j+7d++U/AAkBS++AxOyDWfkwU30+rrofrn6egW+gM
         23o4p9bhMo0olgeo4aFWMAoiq34u8oGSh9Vyy6dHthVy76HgG92YN8D+W00OXz3Yvx
         rNXak9HkgCcVHaX9k/VOlZN5ST08+Ko/ZdeL4PFsF8tIUV7lb0ZIZSdHVPmWZ/lOTo
         IjizoqA7I2HbGkorc30YMfXBJACxQ3KpJhieKLOY5MtWKL6PZVw2a4GNLAduj4Pw01
         dZ9vixwKFW+IQesOfIpwzUGOypxnFWIBEPR9VZpq8jpaJvhuieoahVZM6bcqh5jSmy
         54JF7kJy1oBtg==
Date:   Sun, 9 Jul 2023 21:21:45 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] arm64: dts: qcom: sdm845-mtp: add chassis-type
 property
Message-ID: <pfoaaercog5pgmz3ytuieclzmluw3dn7ir5kn7rmsvdnevpjx5@bd7kwdiofg4w>
References: <20230622-topic-sm8x50-upstream-chassis-type-v1-0-13f676eb71f3@linaro.org>
 <20230622-topic-sm8x50-upstream-chassis-type-v1-5-13f676eb71f3@linaro.org>
 <CAA8EJpphEZa1Vfs1ipm+1x7MvYgF7HMiW-GfNzYi37YPoMzKVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpphEZa1Vfs1ipm+1x7MvYgF7HMiW-GfNzYi37YPoMzKVw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 01:48:30PM +0300, Dmitry Baryshkov wrote:
> On Thu, 22 Jun 2023 at 12:06, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> >
> > Qualcomm's Mobile Test Platforms devices are handsets, set the
> > chassis-type property to 'handset'.
> 
> Is it really a device that you can take into your hand and put close
> to the head?
> 

It's a little bit bulky, but it looks like a handset.

Regards,
Bjorn

> >
> > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> > index b2d4336e764b..41675a8de268 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> > +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> > @@ -15,6 +15,7 @@
> >  / {
> >         model = "Qualcomm Technologies, Inc. SDM845 MTP";
> >         compatible = "qcom,sdm845-mtp", "qcom,sdm845";
> > +       chassis-type = "handset";
> >
> >         aliases {
> >                 serial0 = &uart9;
> >
> > --
> > 2.34.1
> >
> 
> 
> -- 
> With best wishes
> Dmitry
