Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AF661DA87
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 14:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiKENLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 09:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiKENLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 09:11:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E92E6C;
        Sat,  5 Nov 2022 06:11:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D802260B40;
        Sat,  5 Nov 2022 13:11:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00090C433D6;
        Sat,  5 Nov 2022 13:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667653903;
        bh=LLzF7mUfFtqwVs7HLEL7iQkNM4Z2kHnPEMpGUi58jYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ryQzFqAcIAqNMOztWFJiE75yGo+jgFXDixKUKrVT6DbRhmHlkcc5obOd55vouMjR1
         9Te/SlTLTFZEur1f0DA+tar+COkoK5S4DdDOtuILu3AztHQcjPag2TBg0WXb+Biw4e
         0ndKyyRcvAI6VuNoO3tbU54ZDuCp3QjyXr9slb63e/U4hkBNQst1is5ezVYQDh1ZBu
         dA8rp0GFHGrjrCVnqkwlfTZHw9ylBlDXYq3ZDiQ1BZpttqZLAf3Fu5hlvJFgWDBCsl
         J0J7oIoyNtbT8SnAqwnVqPDniM2QscRVOPcl5F6GlAFKu+rG02ncbI0NcAReqESFLZ
         WcVfovcRq58dA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1orIxG-0005rX-8I; Sat, 05 Nov 2022 14:11:23 +0100
Date:   Sat, 5 Nov 2022 14:11:22 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/16] phy: qcom-qmp-pcie: use shorter tables
 identifier
Message-ID: <Y2Zg+h7bnodMFjlK@hovoldconsulting.com>
References: <20221028133603.18470-1-johan+linaro@kernel.org>
 <20221028133603.18470-9-johan+linaro@kernel.org>
 <Y2ZR/83gZuyDO8ZE@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2ZR/83gZuyDO8ZE@matsya>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2022 at 05:37:27PM +0530, Vinod Koul wrote:
> On 28-10-22, 15:35, Johan Hovold wrote:
> > In preparation for adding a new helper function that initialises all the
> > registers in one place, use a shorter name for the configuration-tables
> > pointer so that it becomes easier to see which table is being processed.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 26 ++++++++++++------------
> >  1 file changed, 13 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > index dd7e72424fc0..791ed7ef0eab 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > @@ -1820,17 +1820,17 @@ static void qmp_pcie_configure(void __iomem *base,
> >  	qmp_pcie_configure_lane(base, tbl, num, 0xff);
> >  }
> >  
> > -static void qmp_pcie_serdes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tables)
> > +static void qmp_pcie_serdes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tbls)
> >  {
> >  	void __iomem *serdes = qmp->serdes;
> >  
> > -	if (!tables)
> > +	if (!tbls)
> 
> I am not sure saving 2 chars really helps either with readability or
> helps with shorter name, but for now am not going to nit pick this...

As I tried to explain earlier, the reason for doing using a shorter
identifier is to improve readability of the initialisation sequence in
the new helper function added by the next patch.

It's more obvious if you compare the end result, but you can also see it
some degree for the tx/tx tables below.

> 
> >  		return;
> >  
> > -	qmp_pcie_configure(serdes, tables->serdes, tables->serdes_num);
> > +	qmp_pcie_configure(serdes, tbls->serdes, tbls->serdes_num);
> >  }
> >  
> > -static void qmp_pcie_lanes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tables)
> > +static void qmp_pcie_lanes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tbls)
> >  {
> >  	const struct qmp_phy_cfg *cfg = qmp->cfg;
> >  	void __iomem *tx = qmp->tx;
> > @@ -1838,28 +1838,28 @@ static void qmp_pcie_lanes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_t
> >  	void __iomem *tx2 = qmp->tx2;
> >  	void __iomem *rx2 = qmp->rx2;
> >  
> > -	if (!tables)
> > +	if (!tbls)
> >  		return;
> >  
> > -	qmp_pcie_configure_lane(tx, tables->tx, tables->tx_num, 1);
> > -	qmp_pcie_configure_lane(rx, tables->rx, tables->rx_num, 1);
> > +	qmp_pcie_configure_lane(tx, tbls->tx, tbls->tx_num, 1);
> > +	qmp_pcie_configure_lane(rx, tbls->rx, tbls->rx_num, 1);
> >  
> >  	if (cfg->lanes >= 2) {
> > -		qmp_pcie_configure_lane(tx2, tables->tx, tables->tx_num, 2);
> > -		qmp_pcie_configure_lane(rx2, tables->rx, tables->rx_num, 2);
> > +		qmp_pcie_configure_lane(tx2, tbls->tx, tbls->tx_num, 2);
> > +		qmp_pcie_configure_lane(rx2, tbls->rx, tbls->rx_num, 2);

Here 'tbls' is no longer significantly longer than 'tx' or 'tx_num'
which I find improves readability.

After this series, there will also be a function call that uses
arguments from the configuration struct and this one is consistently
referred to as 'cfg' rather than 'configuration' as the latter would
likewise hurt readability.

Also note that the driver already used 'tbl' consistently (e.g. see
qmp_pcie_configure() in the context at the top of the diff) until the
new tables struct was recently added.

Johan
