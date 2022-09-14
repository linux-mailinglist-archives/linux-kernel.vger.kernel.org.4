Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2045B815A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 08:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiINGLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 02:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiINGLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 02:11:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A953F2F037;
        Tue, 13 Sep 2022 23:11:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DCB761835;
        Wed, 14 Sep 2022 06:11:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EBCC433D6;
        Wed, 14 Sep 2022 06:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663135868;
        bh=l3POCh1A9WRyNC+xgdmasXmOBVuTlOUtQ6gCZgppjmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UTFKiq4gC6Wld5PnTagomHBJJmaEoqtyNTAP0e8AjU7WLIrb6JbxSsWOjrso7saci
         gqOVZUAsQpriepShunlr8lT3WVwAfg2AayLxRtZgEkW0Bptg4r7XlLemomUEtIjzUs
         oshbG0yd3Jx+M8CGMZ9g8FFA0/h01thZywo47+rPPY7ArpRLI1mPyc7BBBMMzz4BNF
         9SftonXp4rk5k5MmBVfezAFqf+wkO0mOw/GUMvPxJqlRDd4Chg82rWFkdST7Q9a6fu
         qSpVo9USz3aRSOAfOEx1otSqMkGrqAIeQYs7O9ykfcOocxhOa5p8pPOunHy5rH7Cmx
         YcoanQEuRhNDA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oYLc4-0002vg-Nt; Wed, 14 Sep 2022 08:11:09 +0200
Date:   Wed, 14 Sep 2022 08:11:08 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] phy: qcom-qmp-pcie: shorten function prefixes
Message-ID: <YyFwfBkS9sbGtDtY@hovoldconsulting.com>
References: <20220906074550.4383-1-johan+linaro@kernel.org>
 <YyCZgHx66V3rhv7u@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyCZgHx66V3rhv7u@matsya>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 08:23:52PM +0530, Vinod Koul wrote:
> On 06-09-22, 09:45, Johan Hovold wrote:
> > The QMP PHY driver function prefixes have become unnecessarily long
> > (e.g. after the recent driver split) and hurt readability.
> > 
> > This series shortens the "qcom_qmp_phy_pcie" prefix to "qmp_pcie" (QMP
> > likely stands for "Qualcomm Multi PHY" or similar anyway) and clean up
> > the code somewhat.

> > Once merged I can do the same conversion of the other four QMP drivers.
> 
> Patches welcome!

I went ahead and did the corresponding changes to the rest of the QMP
drivers so the result should already be in you inbox:

	https://lore.kernel.org/lkml/20220907110728.19092-1-johan+linaro@kernel.org/

Johan
