Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F103E60293C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 12:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJRKV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 06:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJRKVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 06:21:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D123FA8CFD;
        Tue, 18 Oct 2022 03:21:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07B9A61512;
        Tue, 18 Oct 2022 10:21:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546ABC433C1;
        Tue, 18 Oct 2022 10:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666088480;
        bh=sfF7/9UEUczz/iSemE46nzvHfnJvrJujXH2kuSKcrH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SYqbJVN1UHhkiQjYTshnf3Pm/vKl02kG+c0NaqPMBkX7hNboSHYsrd4KxsoxepcP9
         CvAMZUo5jJK0hwvHqR5cOi2V0zRbW+xYbuA7O1sD/NOq8yZ0BCw3sqF476uGi5JlsQ
         cqEujqe37aXDv5K1K9hQlN1YCoCURYiJ3Uv6RueFULW6Wjfd8diaw8xz9Azyat3N1B
         /HYrsNFQboZowMXXxL92kwwiEf5HTHeodQ6nnMcPg+lmecyeaQsuhzQoUF/Gc2hszL
         +bIxLy3YpdTAUuP1tQX2VJlTRp99l6z0COk/5snWkXCscZW6cJxzBDjRUh4n6gh455
         8zGMeS095E9cQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1okjid-0002Xy-Ut; Tue, 18 Oct 2022 12:21:08 +0200
Date:   Tue, 18 Oct 2022 12:21:07 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/15] dt-bindings: phy: qcom,qmp-pcie: mark current
 bindings as legacy
Message-ID: <Y05+E90tmlq2tNFa@hovoldconsulting.com>
References: <20221017145328.22090-1-johan+linaro@kernel.org>
 <20221017145328.22090-10-johan+linaro@kernel.org>
 <CAA8EJpqSWmy5Z4cmJnsdjMjkmACW7HSi-k5JxZ0gLCeUAWEnxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpqSWmy5Z4cmJnsdjMjkmACW7HSi-k5JxZ0gLCeUAWEnxQ@mail.gmail.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 12:52:03PM +0300, Dmitry Baryshkov wrote:
> Hi,
> 
> On Mon, 17 Oct 2022 at 17:54, Johan Hovold <johan+linaro@kernel.org> wrote:
> >
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
> 
> I'd like to point out that it's not only a problem peculiar to the
> PCIe PHYs. Other QMP PHY families also follow the same approach of
> separating the serdes into the common part and rx/tx/PCS/whatever into
> the PHY subnodes.

Yeah, I already mentioned that in the cover letter.

> For the USB+DP combo PHYs we have to have subnodes, however it would
> also be logical to move serdes register to the subnode devices,
> leaving only DP_COM in the base node.

No, not at all. First, we may not even need the subnodes (the individual
PHYs can be indexed), but even if we do keep them for the combo case,
the register block should go in the wrapper node as the registers can be
and are shared (e.g. for sc8280xp for which the current binding is
completely broken).

> That said, I think we should rethink and agree on QMP PHY bindings,
> before renaming the bindings.

Isn't that what we are doing just now?

> And yes, I think we should also upgrade
> older DTs, keeping drivers backwards compatible (for some time?).

Possibly, but I'm not sure it's worth the dts churn. As I mentioned
elsewhere, supporting both the old and new binding in the driver is
mostly trivial, while encoding the deprecated bindings in DT schema
sounds like it would be painful.

On the other hand, adding support for new features to (or fixing bugs
in) old platforms using the current bindings may potentially become
easier if they are also converted.

> > In preparation for adding new bindings for SC8280XP which further
> > bindings can be based on, mark the current bindings as "legacy".
> >
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  .../{qcom,qmp-pcie-phy.yaml => qcom,qmp-pcie-phy-legacy.yaml} | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >  rename Documentation/devicetree/bindings/phy/{qcom,qmp-pcie-phy.yaml => qcom,qmp-pcie-phy-legacy.yaml} (98%)

Johan
