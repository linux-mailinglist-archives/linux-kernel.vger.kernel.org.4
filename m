Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D965B38F0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiIIN1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiIIN1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:27:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523A7139AD4;
        Fri,  9 Sep 2022 06:27:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D8E8B824F2;
        Fri,  9 Sep 2022 13:27:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5455BC433C1;
        Fri,  9 Sep 2022 13:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662730059;
        bh=BC1gUHMq3BJSSWU6Z/Gzv92Q+wtt2zl6xCAHE1m3n6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dzX5zbtFXtywmMx/k332HuAqr4nvqBF8nnZDcOTQBMXOF8TuOsNPGEvu3pgsdrVZc
         aua3n0pENO0oMK5mi9IE43DFFckhtg5j5qDDGA70Q72C/fO7YKz9oNG+KyfBnguqbc
         nAthRg9yfy2448byq13FMIbuwKIUii/LfnMspkyRyY3nFP8q3YfmlixFRHlvzNaztN
         MfwKNlbtg/1TVfftGgzWyPr7v0XYzCZOUzIDV6pKE6TPIbt6mixeEvZp3KvYMAH46E
         KL5xfqySXgXfDttHs0R8QKfyZifkckgE7Q/+AMbmXcp94Xwyt5jfx8S4vxwvJh5e2d
         9Epf//aEDg2Pg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oWe2v-00027A-Dm; Fri, 09 Sep 2022 15:27:49 +0200
Date:   Fri, 9 Sep 2022 15:27:49 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/16] phy: qcom-qmp-usb: shorten function prefixes
Message-ID: <Yxs/VZawxRYsGwtB@hovoldconsulting.com>
References: <20220907110728.19092-1-johan+linaro@kernel.org>
 <20220907110728.19092-17-johan+linaro@kernel.org>
 <03814cce-4b48-0570-7638-a84bd84c6f7a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03814cce-4b48-0570-7638-a84bd84c6f7a@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 12:48:48PM +0300, Dmitry Baryshkov wrote:
> On 07/09/2022 14:07, Johan Hovold wrote:
> > The driver function prefix has gotten unnecessarily long and hurts
> > readability.
> > 
> > Shorten "qcom_qmp_phy_" to "qmp_" (which likely stands for "Qualcomm
> > Multi PHY" or similar anyway).
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c |   3 +-
> >   drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 121 ++++++++++++------------
> >   2 files changed, 60 insertions(+), 64 deletions(-)
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> > index b020409b92e0..4d0eee620f37 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> > @@ -1105,8 +1105,7 @@ static const struct phy_ops qcom_qmp_ufs_ops = {
> >   	.owner		= THIS_MODULE,
> >   };
> >   
> > -static
> > -int qmp_ufs_create(struct device *dev, struct device_node *np, int id,
> > +static int qmp_ufs_create(struct device *dev, struct device_node *np, int id,
> >   			void __iomem *serdes, const struct qmp_phy_cfg *cfg)
> 
> This likely should go to the previous patch.

Ah, must have amended the wrong commit. Thanks for catching that.

Not sure its worth resending the series for though.

Vinod, could you fix it up or do you prefer I respin?

> Otherwise:
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Johan
