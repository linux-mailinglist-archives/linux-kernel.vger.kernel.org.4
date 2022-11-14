Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15293628234
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236771AbiKNOTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiKNOTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:19:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7E026132;
        Mon, 14 Nov 2022 06:19:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66CE3611D5;
        Mon, 14 Nov 2022 14:19:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8FCC433C1;
        Mon, 14 Nov 2022 14:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668435548;
        bh=2aKLftbQ7d7X94QwhHlY7BeiBnwhGJBLiqbExnanIN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nnQcKOceHdszQBHmXt4YpVtWaHfZiYkZkfDpnusEGZrY4Vv9uQgnbVZQ/RGiPkgiZ
         sFOzB9BZX66U2KnZBLMqcDHY29kn9iiWTe3h3PVkFaNL/Xs6uDKYoYOgNUIkB0iiJ8
         mo7N1hmq6AH0lGstWNpaqYM+9z0rP3iil4q7QHpM5/XWyNf3y3AjecelEIYeIkN27N
         YMOPJJP5miD+l9liUN5NBVknix+kLUq0KgMmDkvNK82Pi3HHIylg4Z0n7faO0Zuijp
         RYzMFak/kf+i4ZMvtx7+ECmFlVwg7iNr7NaNmNJW73p6+OowEEEECZrwOISZVp5Q/h
         q+8fOPLy6rA4A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ouaIG-0003WR-00; Mon, 14 Nov 2022 15:18:36 +0100
Date:   Mon, 14 Nov 2022 15:18:35 +0100
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
Message-ID: <Y3JOO0kNnaNhnW3K@hovoldconsulting.com>
References: <20221111092457.10546-1-johan+linaro@kernel.org>
 <20221111092457.10546-3-johan+linaro@kernel.org>
 <a22888cd-34cb-3453-0dc2-096da208564c@linaro.org>
 <Y3JCVzJ74YsfcDz4@hovoldconsulting.com>
 <de3a426a-03e8-ed15-a9a1-bb300e776e5f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de3a426a-03e8-ed15-a9a1-bb300e776e5f@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 03:07:41PM +0100, Krzysztof Kozlowski wrote:
> On 14/11/2022 14:27, Johan Hovold wrote:
> > On Fri, Nov 11, 2022 at 04:17:29PM +0100, Krzysztof Kozlowski wrote:
> >> On 11/11/2022 10:24, Johan Hovold wrote:
> >>> The current QMP USB3-DP PHY bindings are based on the original MSM8996
> >>> binding which provided multiple PHYs per IP block and these in turn were
> >>> described by child nodes.

> >>> +  "#clock-cells":
> >>> +    const: 1
> >>> +
> >>> +  clock-output-names:
> >>> +    items:
> >>> +      - const: usb3_pipe
> >>> +      - const: dp_link
> >>> +      - const: dp_vco_div
> >>
> >> Why defining here fixed names? The purpose of this field is to actually
> >> allow customizing these - at least in most cases. If these have to be
> >> fixed, then driver should just instantiate these clocks with such names,
> >> right?
> > 
> > I'm only using these names as documentation of the indexes. The driver
> 
> What do you mean by documentation of indexes? You require these specific
> entries and do not allow anything else.

I'm using this property as documentation of the valid indexes that can
be used when referring to clocks provided by this device.

There are currently three and the mapping is described by the
'clock-output-names' property.
 
> > doesn't use these names, but that's a Linux-specific implementation
> > detail.
> > 
> > I noticed that several bindings leave the clock indexes unspecified, or
> > have header files defining some or all of them. I first added a QMP
> > header but that seemed like overkill, especially if we'd end up with
> > one header per SoC (cf. the GCC headers) due to (known and potential)
> > platform differences.
> 
> Headers for the names? I do not recall such but that does not seem right.

Headers for the indexes.

> > 
> > On the other hand reproducing this list in each node is admittedly a bit
> > redundant.
> > 
> > Shall I add back a shared header for all PHYs handled by this driver
> > (another implementation detail) even if this could eventually lead to
> > describing clocks not supported by a particular SoC (so such constraints
> > would still need to be described by the binding somehow):
> > 
> > 	/* QMP clocks */
> > 	#define QMP_USB3_PIPE_CLK	0
> > 	#define QMP_DP_LINK_CLK		1
> > 	#define QMP_DP_VCO_DIV_CLK	2
> 
> What are these about? To remind - we talk about names of clocks this
> device creates. The output names. Whatever IDs you have are not related
> to the names.

As I mentioned above, this is not about the names that Linux gives to
its representation of these clocks. Its just about defining the valid
indexes in the binding.

If you think that that using 'clock-output-names' for this is a bit too
unconventional, I can add back the header with defines like the above
instead.

Note that the clock schema has:

  clock-output-names:
    description: |
      Recommended to be a list of strings of clock output signal
      names indexed by the first cell in the clock specifier.
      However, the meaning of clock-output-names is domain
      specific to the clock provider, ...

Johan
