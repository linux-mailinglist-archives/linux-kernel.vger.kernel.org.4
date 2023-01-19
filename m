Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997C86732A1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 08:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjASHlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 02:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjASHk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 02:40:56 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CA567788;
        Wed, 18 Jan 2023 23:40:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 04177CE1FC5;
        Thu, 19 Jan 2023 07:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE71DC433EF;
        Thu, 19 Jan 2023 07:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674114033;
        bh=HBcgxXlu9/ZACXw7g8KqVJy5ZYWiB2l1H7RYFxeC6fQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aikj+Tm0mxQSXuCWYiKIXLRj14UnB+nMSQhIyK8mH6yJLzfHKQc/rtTRBMy9Ln1CL
         /ujxFOzacdbq8flTz7jBikUzUlx544jn/cTroWsxyZP7ksClAwTQOqyEG41doEER2j
         JpOTbf4cl7dWwfUuyykuKegKtmz6nKKhsAOhBWrnqhCYkLMgoY3JEVnxAJ7Ku5ailD
         IqTU+V+vR5s8YmnxQ/rTfNZh89o3XXv6vK4eFwzuSjiUGR4k05X2NpathNGO3xXhH3
         FMumtZ3Xe8sATx8oksRCgca7KvmKLiDgRY2OE4dCzoD5ZyfgMu+JjEmuQDUzkFA1rK
         aNHOe80fu4ImQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pIPXf-00055C-B3; Thu, 19 Jan 2023 08:41:00 +0100
Date:   Thu, 19 Jan 2023 08:40:59 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/8] dt-bindings: phy: Add QMP PCIe PHY comptible for
 SM8550
Message-ID: <Y8j0C+rnUOMG6hLi@hovoldconsulting.com>
References: <20230118005328.2378792-1-abel.vesa@linaro.org>
 <20230118005328.2378792-2-abel.vesa@linaro.org>
 <Y8giHJMtPu4wTlmA@hovoldconsulting.com>
 <Y8hjy8WRpPh8DVvG@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8hjy8WRpPh8DVvG@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 11:25:31PM +0200, Abel Vesa wrote:
> On 23-01-18 17:45:16, Johan Hovold wrote:
> > On Wed, Jan 18, 2023 at 02:53:21AM +0200, Abel Vesa wrote:
> > > Document the QMP PCIe PHY compatible for SM8550.
> > > 
> > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > ---
> > >  .../devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml     | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> > > index 8a85318d9c92..65f26cfff3fb 100644
> > > --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> > > +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> > > @@ -20,6 +20,8 @@ properties:
> > >        - qcom,sc8280xp-qmp-gen3x2-pcie-phy
> > >        - qcom,sc8280xp-qmp-gen3x4-pcie-phy
> > >        - qcom,sm8350-qmp-gen3x1-pcie-phy
> > > +      - qcom,sm8550-qmp-gen3x2-pcie-phy
> > > +      - qcom,sm8550-qmp-gen4x2-pcie-phy
> > >  
> > >    reg:
> > >      minItems: 1
> > 
> > I don't think I'll have time to look at this week, but I did notice that
> > you fail do describe the clocks, regulators, and resets (as you also
> > did for the UFS PHY binding) which are currently different from
> > sc8280xp.
> 
> Hmm, sorry about that. I will double check against the pcie phy nodes I
> have for sm8550.
> 
> As for the UFS, if your are referring to the following patchset [1], the phy
> node looks exactly the same as on sc8280xp, therefore no other binding
> update, other than compatible, was needed.
> 
> [1] https://lore.kernel.org/all/20230117224148.1914627-2-abel.vesa@linaro.org/

Yes, but I was referring to your original submission which added
different names for the clocks without updating the binding. In that
case, those clocks were really the same ones as the ones on sc8280xp so
it was only the driver and dts changes that were wrong:

	https://lore.kernel.org/all/Y8And9VVvpnSInlj@hovoldconsulting.com/

> > Please be more careful when adding compatible strings so we get this
> > right. You should also double check that the differences are really
> > warranted and not just due the vendor using different names for the same
> > resource.

Johan
