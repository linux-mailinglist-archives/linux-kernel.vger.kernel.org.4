Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673756024FC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiJRHG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiJRHG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:06:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C555796BE;
        Tue, 18 Oct 2022 00:06:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 534FEB81D54;
        Tue, 18 Oct 2022 07:06:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F5DC433C1;
        Tue, 18 Oct 2022 07:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666076812;
        bh=J6RF9tAF1MFuLDPx06GDwAxd0NEPV+odgtOEQ0YfJ6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TFlu84wEFmVYCt3vicjR1mwSQZMw6t4ueg5GUCGDs6IeJ9+DfDwF+d/o9dYGa0eJw
         iNhajrl0/Wt54Umujt/dQO38lbfpY+xvDC/kUC/udc/blXrTzryivgKN1CY2RZ04OW
         S5X2zeh+sqeiUaglZwEmezMumwDNgAmONTxVXwTOD1mEiC2WNZ4sQSmGE+tS3f8l8/
         9orcu7ygx23yqqKgAlWuZ+iDhO/UivnkVT19bV2mCVID7tmaKyFg+wgLFD7zLwGZJC
         5KUokhVirYgdHkG1e3xIr/MSTdA0UM7xhbf/K5/jgaI8arpzTV5jKtv7led7xjivMv
         th6urGmmC0jZA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1okggR-0007jp-1q; Tue, 18 Oct 2022 09:06:39 +0200
Date:   Tue, 18 Oct 2022 09:06:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/15] dt-bindings: phy: qcom,qmp-pcie: mark current
 bindings as legacy
Message-ID: <Y05Qf2nDCIVg23Zh@hovoldconsulting.com>
References: <20221017145328.22090-1-johan+linaro@kernel.org>
 <20221017145328.22090-10-johan+linaro@kernel.org>
 <5e153119-f853-ff57-8277-2d782e255be2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e153119-f853-ff57-8277-2d782e255be2@linaro.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 01:15:45PM -0400, Krzysztof Kozlowski wrote:
> On 17/10/2022 10:53, Johan Hovold wrote:
> > The current QMP PCIe PHY bindings are based on the original MSM8996
> > binding which provided multiple PHYs per IP block and these in turn were
> > described by child nodes.
> > 
> > Later QMP PCIe PHY blocks only provide a single PHY and the remnant
> > child node does not really reflect the hardware.
> > 
> > The original MSM8996 binding also ended up describing the individual
> > register blocks as belonging to either the wrapper node or the PHY child
> > nodes.
> > 
> > This is an unnecessary level of detail which has lead to problems when
> > later IP blocks using different register layouts have been forced to fit
> > the original mould rather than updating the binding. The bindings are
> > arguable also incomplete as they only the describe register blocks used
> > by the current Linux drivers (e.g. does not include the per lane PCS
> > registers).
> > 
> > In preparation for adding new bindings for SC8280XP which further
> > bindings can be based on, mark the current bindings as "legacy".
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  .../{qcom,qmp-pcie-phy.yaml => qcom,qmp-pcie-phy-legacy.yaml} | 4 ++--
> 
> I don't think we should rename anything as legacy. These are "normal"
> platforms, not legacy ones. SM8450 is not even that old.

I'm not really referring to the platforms as legacy, but the rather the
format of the bindings. The intent is that by marking the current ones
as such, people will not base new bindings on the old scheme.

There's no problem supporting both schemes in the driver also for the
current compatibles, but expressing such a deprecation in DT schema
sounds like it would be painful. We instead decided to simple draw the
line at SC8280XP and have future bindings be based on its binding.

> The recommendation is to keep names matching the compatibles, not adding
> some legacy/newer/newest suffixes.

Yeah, I know, but that's not what the current bindings do. And if we
keep 

	qcom,qmp-pcie-phy.yaml

and add

	qcom,sc8280xp-qmp-pcie-phy.yaml

then I fear that people will base their bindings on the former rather
than the latter.

I guess I can just add a comment in the old schema file with a reference
to the sc8280xp bindings to try to prevent people from adding new ones
in the wrong place.

If I understand you correctly this is what you are suggesting? And that
the new file should still be named "qcom,sc8280xp-qmp-pcie-phy.yaml"
also as new bindings are added to that file?

I could also rename the old schema file after one of the old platforms
platforms therein (e.g. qcom,msm8998-qmp-pcie-phy) to make it sounds
less like a generic schema for new bindings.

That is

	qcom,msm8998-qmp-pcie-phy.yaml + comment (for current bindings)
	qcom,sc8280xp-qmp-pcie-phy.yaml (for new bindings)

Johan
