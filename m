Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EF4677996
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 11:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjAWKt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 05:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjAWKtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 05:49:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA22212A;
        Mon, 23 Jan 2023 02:49:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 636ED60E75;
        Mon, 23 Jan 2023 10:49:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B436EC433D2;
        Mon, 23 Jan 2023 10:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674470993;
        bh=g4mFdXvL6aqm8OEL7mjoXSAfbXNFwG4v64rCqRpd7X4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=osE6ua+mqXa24ikv1uq9gwBDh2nHn+pr7nV0u7+l+3t7xss9EGpAO8i4s4UzgBIq1
         0z313t01wVU8LhE0aSmG9D7ODL8kmHzvHnAGAprAu8OAPzkT6J4iu0DFzK74SEu0JB
         vM7nipCyChNODYFJukQzP//HxsfvCT8baRzfkiko6p0mDyhXN26eKdP7q+VUivUeFq
         D+YIfUhSG3OQ/CcH8jCgHpc37g+eNmFXTCaMjW07D/Q+kKvZs5CQTFUPzWe1/xcy/N
         eajo3F0chlO5NRv+ctkjuYDePy6zc71zglH75I2gaKjBpkF2rDIs/rCq9ufIwrOuEQ
         HW5xnPXrcEopg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pJuOd-0000xI-2l; Mon, 23 Jan 2023 11:49:51 +0100
Date:   Mon, 23 Jan 2023 11:49:51 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH 04/10] dt-bindings: phy: qcom,qmp-usb: Document SM8550
 compatible
Message-ID: <Y85mT7wZH0hsJ7Y6@hovoldconsulting.com>
References: <20221116120157.2706810-1-abel.vesa@linaro.org>
 <20221116120157.2706810-5-abel.vesa@linaro.org>
 <Y3TpzgQ1JaFs5sNk@hovoldconsulting.com>
 <Y85fOgfjEUBMnWar@hovoldconsulting.com>
 <Y85mA3limH9u/NHe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y85mA3limH9u/NHe@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 12:48:35PM +0200, Abel Vesa wrote:
> On 23-01-23 11:19:38, Johan Hovold wrote:
> > On Wed, Nov 16, 2022 at 02:46:54PM +0100, Johan Hovold wrote:
> > > On Wed, Nov 16, 2022 at 02:01:51PM +0200, Abel Vesa wrote:
> > > > Add the SM8550 compatible to the list.
> > > > 
> > > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > > ---
> > > >  .../devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml       | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
> > > > index 0c6b3ba7346b..cba2a252baf8 100644
> > > > --- a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
> > > > +++ b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
> > > > @@ -37,6 +37,7 @@ properties:
> > > >        - qcom,sm8350-qmp-usb3-phy
> > > >        - qcom,sm8350-qmp-usb3-uni-phy
> > > >        - qcom,sm8450-qmp-usb3-phy
> > > > +      - qcom,sm8550-qmp-usb3-phy
> > > 
> > > This one too should be based on sc8280xp rather than the legacy binding
> > > scheme.
> > 
> > I can't seem to find a v2 of this one adding a new-style binding for
> > sm8550.
> > 
> > Note that the corresponding dts changes have already been merged:
> > 
> > 	https://lore.kernel.org/all/20230119004533.1869870-2-abel.vesa@linaro.org/
> 
> As we discussed on Friday, I intend to apply the same strategy as
> for pcie. I haven't managed to send the v2 for this one yet.
> The order is, UFS, PCIe and then USB. Since the patchsets are based
> on each other, I'm trying to make sure PCIe is in the proper shape
> before moving on to USB.

Sounds good.

Johan
