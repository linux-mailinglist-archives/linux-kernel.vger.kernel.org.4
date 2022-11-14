Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F09562858D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237798AbiKNQiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238226AbiKNQhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:37:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782882FFEA;
        Mon, 14 Nov 2022 08:32:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72034B8107E;
        Mon, 14 Nov 2022 16:32:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12299C433D6;
        Mon, 14 Nov 2022 16:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668443557;
        bh=FeL8hcVZ96Ig1ibWMn9cO+EXY2FFjExd+//b5d1iIc8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jMYOPnLTplQBPVAHaO2nCtUSFDjwM/toHZ762LZLbRkMcs2XWfc5LjuAIIwLquvdK
         1c2NNmpsthyGAq96yNSAS3PSg78vMdErfUQwHUhjXMX1PQG8xWD6MU+Pr8Ty6aYCXl
         UthNmMyLVTOMN23c1IiAMvLR+8EUT1rDuWajW1NFGlQplQSS+Lksp5DWKoFcdGibX7
         rSRvWrovNZ07+CUmYQ6hDShK1Wu7SVxpvFfZB3go24OC/whaqmhjIBrXU8WJ7UAyNE
         Czm/91mSOG0RiLPyNkaLQrpYVufYhd+C0V3juJmxI+pCE8D0dgrL34ZP5fG1NbrS17
         0CYvPRdQ1HiTw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oucNQ-00051w-BM; Mon, 14 Nov 2022 17:32:05 +0100
Date:   Mon, 14 Nov 2022 17:32:04 +0100
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
Message-ID: <Y3JthM1jC2vH1Kn+@hovoldconsulting.com>
References: <20221111092457.10546-1-johan+linaro@kernel.org>
 <20221111092457.10546-3-johan+linaro@kernel.org>
 <a22888cd-34cb-3453-0dc2-096da208564c@linaro.org>
 <Y3JCVzJ74YsfcDz4@hovoldconsulting.com>
 <de3a426a-03e8-ed15-a9a1-bb300e776e5f@linaro.org>
 <Y3JOO0kNnaNhnW3K@hovoldconsulting.com>
 <02725b78-04ad-8f4a-25c2-9cdaa1e37ab7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02725b78-04ad-8f4a-25c2-9cdaa1e37ab7@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 04:49:37PM +0100, Krzysztof Kozlowski wrote:
> On 14/11/2022 15:18, Johan Hovold wrote:
> > On Mon, Nov 14, 2022 at 03:07:41PM +0100, Krzysztof Kozlowski wrote:
> >> On 14/11/2022 14:27, Johan Hovold wrote:
> >>> On Fri, Nov 11, 2022 at 04:17:29PM +0100, Krzysztof Kozlowski wrote:
> >>>> On 11/11/2022 10:24, Johan Hovold wrote:
> >>>>> The current QMP USB3-DP PHY bindings are based on the original MSM8996
> >>>>> binding which provided multiple PHYs per IP block and these in turn were
> >>>>> described by child nodes.
> > 
> >>>>> +  "#clock-cells":
> >>>>> +    const: 1
> >>>>> +
> >>>>> +  clock-output-names:
> >>>>> +    items:
> >>>>> +      - const: usb3_pipe
> >>>>> +      - const: dp_link
> >>>>> +      - const: dp_vco_div
> >>>>
> >>>> Why defining here fixed names? The purpose of this field is to actually
> >>>> allow customizing these - at least in most cases. If these have to be
> >>>> fixed, then driver should just instantiate these clocks with such names,
> >>>> right?
> >>>
> >>> I'm only using these names as documentation of the indexes. The driver
> >>
> >> What do you mean by documentation of indexes? You require these specific
> >> entries and do not allow anything else.
> > 
> > I'm using this property as documentation of the valid indexes that can
> > be used when referring to clocks provided by this device.
> > 
> > There are currently three and the mapping is described by the
> > 'clock-output-names' property.
> 
> That's not the purpose of this property. Drop it then. The names do not
> define the ABI and do not document it, actually. You require now that
> every DTB, if providing clock-output-names, will have exactly such names
> instead of having fixed IDs. DTBs are not for defining the ABI.

Fair enough, I'll drop it. But there doesn't seem to be a good way to
describe the indexes currently and most bindings simply ignore to do so.

So what is the preference then? Just leave things undocumented, listing
indexes in a free-text 'description', or adding a free-text reference to
a binding header file and using those define names in a free-text
'description'?

And if going with the last option, does this mean that every SoC and PHY
type needs its own header for those three clocks or so to avoid having
a common dumping ground header file where indexes will not necessarily
be 0-based and consecutive.

Johan
