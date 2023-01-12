Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60061667DD1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240532AbjALSUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240629AbjALSSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:18:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F6960FC;
        Thu, 12 Jan 2023 09:51:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1ED9620E5;
        Thu, 12 Jan 2023 17:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C551DC433EF;
        Thu, 12 Jan 2023 17:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673545891;
        bh=lvNaruzURY6N1iADoLOUBP6m+krDZ1q4OvF3FENwHWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=afDS8FQDUxrdrN/Mh+8UHDcuI601ipjIAglx5CvqRWJsiiCxCRHB/LMTqnrOHSibc
         veg325c7UXQYXftxgJT9HfXamqAxDtFqQ4FGgBnRWnpPrTjsTefw9/fyep1TFT05u6
         yNp3GcbuT3VR5MgGPJjQUC8edclJJA67zFjV58804nP53h4unNGoFQtwppo4UtNsUy
         7rqhiFCpfDgzEfSylj+AmLRqm+QH3YibtAdmecPjkvccQe8tNtkIy0eZEGtxsnncM4
         +C3jier5+Y9GOEc1Ye3E5doocCt3PD3VC9ZvPrigbptsd/Hx93u+x7R3ZqJJMGfrtT
         fvBaHZjz48bwg==
Date:   Thu, 12 Jan 2023 23:20:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Luca Weiss <luca.weiss@fairphone.com>,
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] phy: qcom-qmp-combo: Add config for SM6350
Message-ID: <Y8BIX+js1ircJyb9@matsya>
References: <20221130081430.67831-1-luca.weiss@fairphone.com>
 <20221130081430.67831-2-luca.weiss@fairphone.com>
 <Y6xP4YRAp68TfxFi@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6xP4YRAp68TfxFi@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-12-22, 15:17, Johan Hovold wrote:
> Luca, Vinod,
> 
> On Wed, Nov 30, 2022 at 09:14:28AM +0100, Luca Weiss wrote:
> > Add the tables and config for the combo phy found on SM6350.
> > 
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > ---
> > Changes since v2:
> > * Drop dp_txa/dp_txb changes, not required
> > * Fix dp_dp_phy offset
> > 
> >  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 126 ++++++++++++++++++++++
> >  1 file changed, 126 insertions(+)
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> > index 77052c66cf70..6ac0c68269dc 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> 
> > @@ -975,6 +1039,19 @@ static const char * const sc7180_usb3phy_reset_l[] = {
> >  	"phy",
> >  };
> >  
> > +static const struct qmp_combo_offsets qmp_combo_offsets_v3 = {
> > +	.com		= 0x0000,
> > +	.txa		= 0x1200,
> > +	.rxa		= 0x1400,
> > +	.txb		= 0x1600,
> > +	.rxb		= 0x1800,
> > +	.usb3_serdes	= 0x1000,
> > +	.usb3_pcs_misc	= 0x1a00,
> > +	.usb3_pcs	= 0x1c00,
> > +	.dp_serdes	= 0x1000,
> 
> I would have expected this to be 0x2000 as that's what the older
> platforms have been using for the dp serdes table so far. Without access
> to any documentation it's hard to tell whether everyone's just been
> cargo-culting all along or if there's actually something there at offset
> 0x2000.
> 
> Vinod, could you shed some light on this as presumably you have access
> to some documentation?
> 
> > +	.dp_dp_phy	= 0x2a00,

No sorry, I dont have access to this version...

-- 
~Vinod
