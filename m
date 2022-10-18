Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA7E602BFE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 14:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiJRMoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 08:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiJRMou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:44:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669524A111;
        Tue, 18 Oct 2022 05:44:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E7CF61539;
        Tue, 18 Oct 2022 12:44:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5028C433C1;
        Tue, 18 Oct 2022 12:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666097086;
        bh=DVj+R0hWHcmWPxBY1QG65baZUnc/VzNG2kHZVWWIWyw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dd2UU17fM2C0Ifjg20BkynPqLjL1Tez9BWsWFylHnEIhIkFuvgJfKZ4DlIJ2UMPCA
         nlJ7w6l6/NkfTs9/L9ASimwq0MByZG8sL6XoEUTP0QhmMp3oSd96+WJhiNsSm/8qz6
         xRrIJCwNJlScI1gNL5GuEPHaFDe/zHpqqZcKtmCSrn7nXZ3LYnCpgr3LyoBGZxYsN2
         SRp4A0sWoqnB8rX7+vjufOlmJEIOUl/F/EKxBN7P3LeVz+ciFhLHHJvHWMFvWtrViR
         QFYPCiZT+XrBqX5pCLX2/ioFSH0uOvI2QHXob7Tsk7ilxnb1Zgfj+Y0KbQqtFmTF49
         kyzDqkVR7GYWw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oklxS-0003uk-69; Tue, 18 Oct 2022 14:44:34 +0200
Date:   Tue, 18 Oct 2022 14:44:34 +0200
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
Message-ID: <Y06fsvzo8yN/NUth@hovoldconsulting.com>
References: <20221017145328.22090-1-johan+linaro@kernel.org>
 <20221017145328.22090-10-johan+linaro@kernel.org>
 <CAA8EJpqSWmy5Z4cmJnsdjMjkmACW7HSi-k5JxZ0gLCeUAWEnxQ@mail.gmail.com>
 <Y05+E90tmlq2tNFa@hovoldconsulting.com>
 <CAA8EJprwhEvUfUr-zDir4zFh_NAyr0qPbrHi6Hf8=2HC1dAhaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJprwhEvUfUr-zDir4zFh_NAyr0qPbrHi6Hf8=2HC1dAhaw@mail.gmail.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 02:37:35PM +0300, Dmitry Baryshkov wrote:
> On Tue, 18 Oct 2022 at 13:21, Johan Hovold <johan@kernel.org> wrote:
> >
> > On Tue, Oct 18, 2022 at 12:52:03PM +0300, Dmitry Baryshkov wrote:
> > > Hi,
> > >
> > > On Mon, 17 Oct 2022 at 17:54, Johan Hovold <johan+linaro@kernel.org> wrote:
> > > >
> > > > The current QMP PCIe PHY bindings are based on the original MSM8996
> > > > binding which provided multiple PHYs per IP block and these in turn were
> > > > described by child nodes.
> > > >
> > > > Later QMP PCIe PHY blocks only provide a single PHY and the remnant
> > > > child node does not really reflect the hardware.
> > > >
> > > > The original MSM8996 binding also ended up describing the individual
> > > > register blocks as belonging to either the wrapper node or the PHY child
> > > > nodes.
> > > >
> > > > This is an unnecessary level of detail which has lead to problems when
> > > > later IP blocks using different register layouts have been forced to fit
> > > > the original mould rather than updating the binding. The bindings are
> > > > arguable also incomplete as they only the describe register blocks used
> > > > by the current Linux drivers (e.g. does not include the per lane PCS
> > > > registers).
> > >
> > > I'd like to point out that it's not only a problem peculiar to the
> > > PCIe PHYs. Other QMP PHY families also follow the same approach of
> > > separating the serdes into the common part and rx/tx/PCS/whatever into
> > > the PHY subnodes.
> >
> > Yeah, I already mentioned that in the cover letter.
> >
> > > For the USB+DP combo PHYs we have to have subnodes, however it would
> > > also be logical to move serdes register to the subnode devices,
> > > leaving only DP_COM in the base node.
> >
> > No, not at all. First, we may not even need the subnodes (the individual
> > PHYs can be indexed), but even if we do keep them for the combo case,
> > the register block should go in the wrapper node as the registers can be
> > and are shared (e.g. for sc8280xp for which the current binding is
> > completely broken).
> 
> Hmm, which register blocks are shared on the sc8280xp combo PHY? Could
> you please lightly describe it, if possible?

At least serdes and tx. Note that the combo PHY on sc8280xp also
supports USB4, so there is likely some differences compared to the older
platforms.

And while I haven't looked in detail at the older platforms for the
combo PHYs yet, describing the separate register subregions there
appears to be just as misguided for those (e.g. as the binding currently
only describes what Linux is using) and is mostly an artefact of how the
original Linux driver was implemented.

Johan
