Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064B95B7C16
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 22:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiIMUNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 16:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiIMUNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 16:13:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0658E67CAA;
        Tue, 13 Sep 2022 13:13:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D867B810B0;
        Tue, 13 Sep 2022 20:13:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FFCC433C1;
        Tue, 13 Sep 2022 20:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663100008;
        bh=apKo7oAdYEvR3sMQNHuXRqarXZ9Tnm+ayX2PNm24ovU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ImH0UvRP5y3IfbvNWxZ757gzD1KuTu1N9FeLY6prae5JnPXQJeFzgA15XWCZtGWEh
         NAUpNn9pcwL0RFAGIjxkqO1snf1l9US4nt0g+18BqBBy99n0ZGWueNzsuEBq5rvm3J
         NQjxo6SFY1ju6wR2HtIvfDvqgro8jJTHRw/W0zNrnRzwX+9lx2r7B0utIeRGn0zLjd
         KhU9TxIB4yf/TlVfL6lb1s8byL+jbAg+A5gwF6w1TNTsJJGkKn8LLzsHUvp2ybGc7M
         zf92BroyNq8VkRHV9+46+voqoLR638GqWDB9H+Foc4XNO8rb2BsqRcWpzWvOoWJ+Zo
         cyjLwrJrvcQ6g==
Date:   Tue, 13 Sep 2022 15:13:25 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>, konrad.dybcio@somainline.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan+linaro@kernel.org, steev@kali.org
Subject: Re: [PATCH] arm64: dts: qcom: thinkpad-x13s: Update firmware location
Message-ID: <20220913201325.ip66pzu7owm4t33h@builder.lan>
References: <20220913054030.3234-1-manivannan.sadhasivam@linaro.org>
 <YyBWZOMz3mKlje05@hovoldconsulting.com>
 <20220913105734.GD25849@workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913105734.GD25849@workstation>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 04:27:34PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Sep 13, 2022 at 12:07:32PM +0200, Johan Hovold wrote:
> > [ Resend with Bjorn's address updated as the Linaro one now bounces. ]
> > 
> > On Tue, Sep 13, 2022 at 11:10:30AM +0530, Manivannan Sadhasivam wrote:
> > > The firmware location in linux-firmware has been changed to include the
> > > SoC name. So use the updated location in Thinkpad devicetree.
> > > 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > I guess we should pick a commit prefix that we stick to for changes to
> > this driver.
> > 
> > 	arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s:
> > 
> > is arguably unnecessarily long even if it follows the pattern of some
> > other qcom dts.
> > 
> > Shall we just use
> > 
> > 	arm64: dts: qcom: sc8280xp-x13s:
> 
> This looks looks better. I did look into the earlier commits but I found
> the prefix to be too long, so went with the last commit prefix.
> 

+1

> > 
> > which matches sc8280xp-crd? Or stick "lenovo" in there as well? Or just
> > keep the whole thing unchanged?
> > 
> > > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > > index c379650e52b1..3b7943d6e164 100644
> > > --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > > +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > > @@ -554,13 +554,13 @@ keyboard@68 {
> > >  };
> > >  
> > >  &remoteproc_adsp {
> > > -	firmware-name = "qcom/LENOVO/21BX/qcadsp8280.mbn";
> > > +	firmware-name = "qcom/sc8280xp/LENOVO/21BX/qcadsp8280.mbn";
> > >  
> > >  	status = "okay";
> > >  };
> > >  
> > >  &remoteproc_nsp0 {
> > > -	firmware-name = "qcom/LENOVO/21BX/qccdsp8280.mbn";
> > > +	firmware-name = "qcom/sc8280xp/LENOVO/21BX/qccdsp8280.mbn";
> > >  
> > >  	status = "okay";
> > >  };
> > 
> > Change itself looks good otherwise:
> > 
> > Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> > 
> 
> Thanks! I will respin with the agreed prefix.
> 
> Regards,
> Mani
> 
> > Johan
