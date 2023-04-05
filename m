Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06156D77D1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 11:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237054AbjDEJKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 05:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbjDEJKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 05:10:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27D890;
        Wed,  5 Apr 2023 02:10:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47E2062304;
        Wed,  5 Apr 2023 09:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76596C4339B;
        Wed,  5 Apr 2023 09:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680685831;
        bh=l5sX60iJEeJFjkbQM2H90cOtD2sNI6yhbFlyNek5as0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c5fuoR7XGt0dvomYiWEBhKEeQHabvQDQU0uohPQ8wFj7RAAMz7Kf7zfxFZenfhOPg
         EvqSHrYHA6arxtZ4LB0UbDNC3NHqX4MmWaRk47c2VlMzpMHxViHsg2Lux+BbOxI7hf
         vXiwPAhdUq9Nu0lgAJNUaONcN/t+t/YniXbMiMv8w9Ee1tvvYO19gj5C+3wNjOZxoA
         T4m3hJzzhS62QMTtk0PhovTRE4jMirivKLYnq1EmGo/k1S5NGp0KGxDy3jyxj4mEru
         JPtxyV6LbCtmHNZqIETkgY4f0gLlHexjY+VYIpsURrsZHBUk6cPu5hAKtKO1gKYGA4
         wEqcBKzXbXaPA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pjzAT-0001xl-G8; Wed, 05 Apr 2023 11:11:01 +0200
Date:   Wed, 5 Apr 2023 11:11:01 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        mturquette@baylibre.com, sboyd@kernel.org, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 7/8] arm64: dts: qcom: ipq9574: Add USB related nodes
Message-ID: <ZC07JU/F46L9Z9y2@hovoldconsulting.com>
References: <cover.1680162377.git.quic_varada@quicinc.com>
 <c46b542b112b59002ab965be1d3fcae8c372d545.1680162377.git.quic_varada@quicinc.com>
 <CAA8EJpo_ckJtYV4aU613X5L6+wj-1i9vZkud5p72PLdCSnj5ng@mail.gmail.com>
 <20230331092710.GB19162@varda-linux.qualcomm.com>
 <ZCaznloORtzgioOP@hovoldconsulting.com>
 <20230405085831.GA26156@varda-linux.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405085831.GA26156@varda-linux.qualcomm.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 02:28:32PM +0530, Varadarajan Narayanan wrote:
> On Fri, Mar 31, 2023 at 12:19:10PM +0200, Johan Hovold wrote:

> > > > > +               ssphy_0: phy@7d000 {
> > > >
> > > > Nit: usually the label usb_0_qmpphy
> > > >
> > > > > +                       compatible = "qcom,ipq9574-qmp-usb3-phy";
> > > > > +                       reg = <0x0007d000 0xa00>;
> > > > > +                       #phy-cells = <0>;
> > > > > +
> > > > > +                       clocks = <&gcc GCC_USB0_AUX_CLK>,
> > > > > +                                <&xo_board_clk>,
> > > > > +                                <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
> > > > > +                                <&gcc GCC_USB0_PIPE_CLK>;
> > > > > +                       clock-names = "aux",
> > > > > +                                     "ref",
> > > > > +                                     "com_aux",
> >
> > This is not the right name for this clock so you need to update the
> > binding first.
> >
> > Please be more careful.
> 
> Thanks for your feedback. Have posted v6 with the above corrections.

Thanks for the heads up. But for future submission, please try to
remember to add people that have provided feedback on CC when posting
new revisions.

Johan
