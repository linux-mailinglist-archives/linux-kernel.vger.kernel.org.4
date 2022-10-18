Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DDF60302C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiJRPuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiJRPuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:50:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCDC1837E;
        Tue, 18 Oct 2022 08:49:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22B80B81FF9;
        Tue, 18 Oct 2022 15:49:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD369C433D6;
        Tue, 18 Oct 2022 15:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666108184;
        bh=faiWi9Fv88r87TFCv9RWuPCZH2dQowLZP52ycV61wcM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GXjx2sByRNEdhb9E81G9wveBcyZU5RAVWNT2tAg7ss4TCz5bSz3cAX56ZMzw7CjB+
         l/bPMBR2EXaCaAEd1tqNoFCalHktyoFzuQrX9KNcAFiNBgTRpcHia6tNnYPnApkcll
         5weOkIB0ZgvvOPHPWir4g8nUUS2Dmwr4fn4HIuQ5tIADRsdanC0uacof2qY4g43vd0
         mDpLeqvSJJG3Z8engRbEeUfahReaAthQR7JpFHCf2qJKys8zgD9fh4hD8p2+9kk4R2
         VF1I8iHvhxUbtmuhXjupw1Pt9sgCy0E3a7j2hFx9sIrf9YgGyF5vQXZFUa2gevJktL
         rVIw9tTGyaelg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1okoqT-00065D-9n; Tue, 18 Oct 2022 17:49:33 +0200
Date:   Tue, 18 Oct 2022 17:49:33 +0200
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
Message-ID: <Y07LDeMvAsiceOfO@hovoldconsulting.com>
References: <20221017145328.22090-1-johan+linaro@kernel.org>
 <20221017145328.22090-10-johan+linaro@kernel.org>
 <5e153119-f853-ff57-8277-2d782e255be2@linaro.org>
 <Y05Qf2nDCIVg23Zh@hovoldconsulting.com>
 <39a7d2d1-06c2-4002-e222-54c24c5eb31f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39a7d2d1-06c2-4002-e222-54c24c5eb31f@linaro.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 11:27:35AM -0400, Krzysztof Kozlowski wrote:
> On 18/10/2022 03:06, Johan Hovold wrote:
> > On Mon, Oct 17, 2022 at 01:15:45PM -0400, Krzysztof Kozlowski wrote:
> >> On 17/10/2022 10:53, Johan Hovold wrote:
> >>> The current QMP PCIe PHY bindings are based on the original MSM8996
> >>> binding which provided multiple PHYs per IP block and these in turn were
> >>> described by child nodes.

> >>> In preparation for adding new bindings for SC8280XP which further
> >>> bindings can be based on, mark the current bindings as "legacy".
> >>>
> >>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> >>> ---
> >>>  .../{qcom,qmp-pcie-phy.yaml => qcom,qmp-pcie-phy-legacy.yaml} | 4 ++--
> >>
> >> I don't think we should rename anything as legacy. These are "normal"
> >> platforms, not legacy ones. SM8450 is not even that old.
> > 
> > I'm not really referring to the platforms as legacy, but the rather the
> > format of the bindings. The intent is that by marking the current ones
> > as such, people will not base new bindings on the old scheme.
> > 
> > There's no problem supporting both schemes in the driver also for the
> > current compatibles, but expressing such a deprecation in DT schema
> > sounds like it would be painful. We instead decided to simple draw the
> > line at SC8280XP and have future bindings be based on its binding.
> > 
> >> The recommendation is to keep names matching the compatibles, not adding
> >> some legacy/newer/newest suffixes.
> > 
> > Yeah, I know, but that's not what the current bindings do. And if we
> > keep 
> > 
> > 	qcom,qmp-pcie-phy.yaml
> > 
> > and add
> > 
> > 	qcom,sc8280xp-qmp-pcie-phy.yaml
> > 
> > then I fear that people will base their bindings on the former rather
> > than the latter.
> 
> Then how about renaming this file to something matching the oldest
> supported SoC? Like: qcom,msm8998-qmp-pcie-phy.yaml
> (I don't know which one is the oldest there)
> 
> Or ipq6018 as the first one appearing in the list.

Sounds good. :)

> > I could also rename the old schema file after one of the old platforms
> > platforms therein (e.g. qcom,msm8998-qmp-pcie-phy) to make it sounds
> > less like a generic schema for new bindings.
> 
> Oh, we thought about the same.
> 
> > 
> > That is
> > 
> > 	qcom,msm8998-qmp-pcie-phy.yaml + comment (for current bindings)
> > 	qcom,sc8280xp-qmp-pcie-phy.yaml (for new bindings)
> 
> Yes, please.

I'll go with that then. Thanks!

Johan
