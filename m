Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B728D627E54
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 13:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237211AbiKNMo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 07:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237086AbiKNMoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 07:44:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA6C24F31;
        Mon, 14 Nov 2022 04:43:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 676EEB80EAF;
        Mon, 14 Nov 2022 12:43:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036A9C433D6;
        Mon, 14 Nov 2022 12:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668429789;
        bh=SjB3OqbdMsh6d4Hu5GyXmdkPniVNdvUIeA6TIRfqTzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W0TYITlLU7S8TIhSwP1y4nLqbB5OqjV67/eAW3xwPilR/Dwjh7Nvx6W2xgLftgc8b
         mPhfgPQ+W33tobxRiqd7QMR9aBzpOFdEdGyfxsD6y5d4ZlYTrWXcBUtCAPvVHhmhWC
         M2IKj/XzytJiw4FNCrJsPCSxgoKtzuwOnPNpJ53p5AnmEfycBu7jd/QA6eiTCip4Gv
         /CF/FTN1yyPK/iRgS5pvR4ZcBYojiqqvUx814uidhSbXkK0knuK8Uam2B9MOxu4kV4
         L4zMdrH4G3t9Q8uvW03urk3icV3ir71OGi53N2lUA5nRCVmHpvNDUi2yZPWEy35GMQ
         BFNmDRDoECNIQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ouYnN-0002Hw-0l; Mon, 14 Nov 2022 13:42:37 +0100
Date:   Mon, 14 Nov 2022 13:42:37 +0100
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
Subject: Re: [PATCH 08/14] phy: qcom-qmp-combo: drop redundant clock
 allocation
Message-ID: <Y3I3vec+9Ob1dPhW@hovoldconsulting.com>
References: <20221111092457.10546-1-johan+linaro@kernel.org>
 <20221111092457.10546-9-johan+linaro@kernel.org>
 <75e188ce-99ea-7511-a561-5b0fef9feeaf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75e188ce-99ea-7511-a561-5b0fef9feeaf@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 02:17:44PM +0300, Dmitry Baryshkov wrote:
> On 11/11/2022 12:24, Johan Hovold wrote:
> > Since the QMP driver split, there is no reason to allocate the
> > fixed-rate pipe clock structure separately from the driver data.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 7 ++-----
> >   1 file changed, 2 insertions(+), 5 deletions(-)
> > 
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Note: it would be nice to port these two patches to USB & PCIe QMP PHY 
> drivers.

Already done:

	https://lore.kernel.org/lkml/20221111094239.11547-1-johan+linaro@kernel.org/

Johan
