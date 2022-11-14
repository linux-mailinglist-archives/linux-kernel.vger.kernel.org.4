Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474E4628144
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 14:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236252AbiKNN21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 08:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235655AbiKNN2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:28:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEF6FE3;
        Mon, 14 Nov 2022 05:28:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65C236109A;
        Mon, 14 Nov 2022 13:28:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0049C433C1;
        Mon, 14 Nov 2022 13:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668432503;
        bh=nNGW2Iswzw1r+ZrdtLgk9X55bimO0kAAwJsujwLckSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pzSzze975EcOZvvpsghnV1MIb+1kUOQwwsRIidu+qX1ykxtU9KmtV+YhZlsuLyq8t
         LPbR4mCmuTTcAkqenp9lp64RpkqWcybV9TjPEr7LyPewO+/LjjzG4n5gcVUL+RVii9
         Qh3/rb8Rh5NkI6Iglhyzm7Kn6JHbu74uUpxPzY+9TYPa4Hpbn0qQ85ISaUZHMxJOsU
         60cfOt+rS3GI2MYFZXtx/mhVJkhrEx7q5xtJb4Ew1q8mTO9xDPowfgv8F2KkISanuu
         xrfemjeLBOp7Oqqfry6BtNacnS1Ibjfcx9oM4U5CIZ/wvEJFdYVPqS2+mwrK5YIsgf
         M5TuHmY+sIsmQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ouZV9-0002p3-Mu; Mon, 14 Nov 2022 14:27:51 +0100
Date:   Mon, 14 Nov 2022 14:27:51 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/14] dt-bindings: phy: qcom,qmp-usb3-dp: fix sc8280xp
 bindings
Message-ID: <Y3JCVzJ74YsfcDz4@hovoldconsulting.com>
References: <20221111092457.10546-1-johan+linaro@kernel.org>
 <20221111092457.10546-3-johan+linaro@kernel.org>
 <a22888cd-34cb-3453-0dc2-096da208564c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a22888cd-34cb-3453-0dc2-096da208564c@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 04:17:29PM +0100, Krzysztof Kozlowski wrote:
> On 11/11/2022 10:24, Johan Hovold wrote:
> > The current QMP USB3-DP PHY bindings are based on the original MSM8996
> > binding which provided multiple PHYs per IP block and these in turn were
> > described by child nodes.
> > 
> 
> Thank you for your patch. There is something to discuss/improve.
> 
> 
> > +
> > +maintainers:
> > +  - Vinod Koul <vkoul@kernel.org>
> 
> Maybe you want to add also yourself?

Due to the lack of public documentation for these platforms and the
amount of work involved in effectively reverse-engineering the
corresponding details from random vendor-kernel trees, it's probably
best to leave maintainence with Vinod who at least has access to some
documentation.

> > +
> > +description:
> > +  The QMP PHY controller supports physical layer functionality for a number of
> > +  controllers on Qualcomm chipsets, such as, PCIe, UFS and USB.
> > +
> > +  See also:
> > +    - include/dt-bindings/dt-bindings/phy/phy.h
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - qcom,sc8280xp-qmp-usb43dp-phy
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 4
> > +
> > +  clock-names:
> > +    items:
> > +      - const: aux
> > +      - const: ref
> > +      - const: com_aux
> > +      - const: usb3_pipe
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    maxItems: 2
> > +
> > +  reset-names:
> > +    items:
> > +      - const: phy
> > +      - const: common
> > +
> > +  vdda-phy-supply: true
> > +
> > +  vdda-pll-supply: true
> > +
> > +  "#clock-cells":
> > +    const: 1
> > +
> > +  clock-output-names:
> > +    items:
> > +      - const: usb3_pipe
> > +      - const: dp_link
> > +      - const: dp_vco_div
> 
> Why defining here fixed names? The purpose of this field is to actually
> allow customizing these - at least in most cases. If these have to be
> fixed, then driver should just instantiate these clocks with such names,
> right?

I'm only using these names as documentation of the indexes. The driver
doesn't use these names, but that's a Linux-specific implementation
detail.

I noticed that several bindings leave the clock indexes unspecified, or
have header files defining some or all of them. I first added a QMP
header but that seemed like overkill, especially if we'd end up with
one header per SoC (cf. the GCC headers) due to (known and potential)
platform differences.

On the other hand reproducing this list in each node is admittedly a bit
redundant.

Shall I add back a shared header for all PHYs handled by this driver
(another implementation detail) even if this could eventually lead to
describing clocks not supported by a particular SoC (so such constraints
would still need to be described by the binding somehow):

	/* QMP clocks */
	#define QMP_USB3_PIPE_CLK	0
	#define QMP_DP_LINK_CLK		1
	#define QMP_DP_VCO_DIV_CLK	2

Note that for SC8280XP this list may later get extended with clocks for
USB4 (once we understand how to use them), but those would not apply to
the older USB3-DP PHYs, so we'd still need to describe that in the
binding somehow.

Johan
