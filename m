Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBDF5B38CA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiIINUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiIINUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:20:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D12CACA21;
        Fri,  9 Sep 2022 06:20:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17FE1B824F7;
        Fri,  9 Sep 2022 13:20:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68F5C433C1;
        Fri,  9 Sep 2022 13:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662729635;
        bh=OPjDbxZoA9mO4XMuKYHJGa1f/L+5w3XwGd4XzkJ8R0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CIvWAb/OYnRpDiKTv5aVChkLKNie0kPXsvHHNwV/FfS7fsToT+t6T5RkUO0x/0TVF
         NZHl4pS7j7yNoV68SCyHxKl9ScvedeLhXWT7Xj/ZkdTBjxCQBvs7vOEO8l+4oVA3ho
         tZFqvkEV/x7ZP9P8lDuh7gEr/xXZ1JnPTG055hJR8c4lpuletoPgsDDur4VnblQdau
         5lb79mIkMay7/+T0CKxQCyuDUAmXRp+B3DdDXguce+Z65soRm1LlG7JzMqkUJpxtd4
         FeJ6yrHb/ctsktHWVtVCxPTxSXMLLSzvbW1tXnxHB+PnTt6tu1ClvL3hbsKYYdvA44
         g+zQsEAdgSplQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oWdw4-00024Y-En; Fri, 09 Sep 2022 15:20:45 +0200
Date:   Fri, 9 Sep 2022 15:20:44 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/16] phy: qcom-qmp-combo: drop unused defines
Message-ID: <Yxs9rCf/JTL5BA1S@hovoldconsulting.com>
References: <20220907110728.19092-1-johan+linaro@kernel.org>
 <20220907110728.19092-3-johan+linaro@kernel.org>
 <7370ba1d-472c-b036-4155-f86ca13f9824@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7370ba1d-472c-b036-4155-f86ca13f9824@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 12:21:12PM +0300, Dmitry Baryshkov wrote:
> On 07/09/2022 14:07, Johan Hovold wrote:
> > Drop defines and enums that are unused since the QMP driver split.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 15 ---------------
> >   1 file changed, 15 deletions(-)
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> > index 9ce2ab56be4c..838f7e328b55 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> > @@ -28,16 +28,11 @@
> >   #define SW_RESET				BIT(0)
> >   /* QPHY_POWER_DOWN_CONTROL */
> >   #define SW_PWRDN				BIT(0)
> > -#define REFCLK_DRV_DSBL				BIT(1)
> >   /* QPHY_START_CONTROL bits */
> >   #define SERDES_START				BIT(0)
> >   #define PCS_START				BIT(1)
> > -#define PLL_READY_GATE_EN			BIT(3)
> >   /* QPHY_PCS_STATUS bit */
> >   #define PHYSTATUS				BIT(6)
> > -#define PHYSTATUS_4_20				BIT(7)
> > -/* QPHY_PCS_READY_STATUS & QPHY_COM_PCS_READY_STATUS bit */
> > -#define PCS_READY				BIT(0)
> 
> I think these defines, describing registers and bits, can go to the 
> common header instead.

Adding those to a common header can be done later if needed at all (and
would include adding a proper prefix etc).

> For the rest of the patch:
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Johan
