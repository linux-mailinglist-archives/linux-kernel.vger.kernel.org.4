Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B990627F19
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 13:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237515AbiKNMzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 07:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237510AbiKNMzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 07:55:21 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479A42790F;
        Mon, 14 Nov 2022 04:55:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A8B32CE0FEE;
        Mon, 14 Nov 2022 12:55:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4F9C433D6;
        Mon, 14 Nov 2022 12:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668430518;
        bh=Y9y2PP3dM3aiSA0/EAu5FI2WtvutiNqnsGRh3fAAYKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JT7GVlQcKaoFspCF0Vi/SNKgAgvJvHP4XchNVWu2eWfohcMUBpjEZhzu6frXmim3T
         k0+elV1VjXnF5OEaMOfpTp5PbvsXAF7ByKuD5V+6GOGIRboRZA4EUoqq4AjXEPaTZm
         sS4dKt+/cWk8Y5poG289Z8uuUdLX2KNQy3ye7ht/aJ+u+ekX4rB5jolOtA5MuzvaTy
         VboHuB1znUQFhL5YXTlCqIuuNr2Ep2ochgjjh5c2IW3g86yeodVM92r4bSW/wHcLlj
         CxkVlfWEn/8IMia/ZJCwuDVHzIXdfjHb1HwzDj04F1bXPyJZQaKVqJpW03q4Vg3ZXF
         w52/SsQs8+FaA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ouYz6-0002SD-TR; Mon, 14 Nov 2022 13:54:45 +0100
Date:   Mon, 14 Nov 2022 13:54:44 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/14] phy: qcom-qmp-combo: rename common-register
 pointers
Message-ID: <Y3I6lN6UTHg2ozNP@hovoldconsulting.com>
References: <20221111092457.10546-1-johan+linaro@kernel.org>
 <20221111092457.10546-13-johan+linaro@kernel.org>
 <f3ae781b-2046-e1be-564f-9de74107f000@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3ae781b-2046-e1be-564f-9de74107f000@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 02:31:27PM +0300, Dmitry Baryshkov wrote:
> On 11/11/2022 12:24, Johan Hovold wrote:
> > The common registers are shared by the USB and DP parts of the PHY so
> > drop the misleading "dp" prefix from the corresponding pointers.
> > 
> > Note that the "DP" prefix could also be dropped from the corresponding
> > defines, but leave that in place for now.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 24 +++++++++++------------
> >   1 file changed, 12 insertions(+), 12 deletions(-)
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Note regarding the last phrase: I'd suggest leaving the DP prefix in 
> register names, it makes it easier to visually note & verify the 
> register block.

My point is that "DP" was never part of the COM register block name. The
confusion likely comes from the vendor driver naming these defines along
the lines of

	USB3_DP_COM_POWER_DOWN_CTRL

Here "USB3_DP" is the common prefix for all defines that apply to both
"parts" of the PHY so the corresponding Linux define

	QPHY_V3_DP_COM_POWER_DOWN_CTRL

should either include "USB3" or drop "DP".

This becomes more apparent on SC8280XP where the corresponding define
is:

	USB43DP_COM_POWER_DOWN_CTRL

Johan
