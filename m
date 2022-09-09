Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662AB5B38DC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiIINXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiIINW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:22:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E5A10B578;
        Fri,  9 Sep 2022 06:22:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6DCF61FE6;
        Fri,  9 Sep 2022 13:22:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A0CC433C1;
        Fri,  9 Sep 2022 13:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662729778;
        bh=KEhtKNgdp8JDc/KUsE48MzFDBa4h3l0bmyTow/HSYM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gDWhPJ176Axn7v/bTfnHYLtTZ26sh/MnsZca+jKdo0zl+aXS5fdh0uD62JoICX0wf
         X0lAnzMxkbMOIpRQLFaw6Mv+kJ+4RZHhPoXkYpr14eanZ9qz8vTiF8WqElojh38UwL
         YhwrF0QvoLrLWqvip6bvqtpNoRS2UPkm/bh86sTSNQ1YxEZTkdPwJwN1W1IjCKYqYD
         iTmnFFbJiAv1eGCwJIIBd8v9JljGbxLB8zQtt1Q1W0XUe9lVIfAmV7wtABSOGp/8bI
         gyPLapOIa2u0gVk1u3+hMYPDy3R/6562JnDXlZ3yIE8FTB/QdKVGU5D48S7/xjME99
         fRz6hAcX/zqfw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oWdyO-00025e-3x; Fri, 09 Sep 2022 15:23:08 +0200
Date:   Fri, 9 Sep 2022 15:23:08 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/16] phy: qcom-qmp-usb: disable runtime PM on unbind
Message-ID: <Yxs+PLMvqbuZ3242@hovoldconsulting.com>
References: <20220907110728.19092-1-johan+linaro@kernel.org>
 <20220907110728.19092-10-johan+linaro@kernel.org>
 <1e502a39-6ba4-079c-576f-10fff260d131@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e502a39-6ba4-079c-576f-10fff260d131@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 12:45:43PM +0300, Dmitry Baryshkov wrote:
> On 07/09/2022 14:07, Johan Hovold wrote:
> > Make sure to disable runtime PM also on driver unbind.
> > 
> > Fixes: ac0d239936bd ("phy: qcom-qmp: Add support for runtime PM").
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >   drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 7 +++----
> >   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Nit from the patch 01 applies too.

Still very much disagree with you on that.

Johan
