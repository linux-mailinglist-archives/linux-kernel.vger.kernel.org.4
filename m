Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAC4618A55
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 22:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiKCVLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 17:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbiKCVLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 17:11:13 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C4F2124E;
        Thu,  3 Nov 2022 14:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cDBzOOd6UV3OhT8cDP2xlFJQZeFXRgWjSmWHmEhaMX4=; b=yaChJofSAzAvsXbRN6zyNiPAwH
        XfSHEpBrdRxfwJaOoGSKa2ejTeg8oNMO/aDiWhPLAAiZ1IA1MYyjOsCqcOLQYhF7OVtIRMDUDDpYX
        CcVEfJMtG8a7YzZ0A8eiZ7KmnDB7i+y96cKXJZ8fZZesYUkv48x3IDYyHd2fhuLZf+EdmI2Equkpp
        svNxlsU1T8/HEy3zFqC0ARPS1QEAUUTbAtVd2z2tQ01otnfBvhlVtCfc93LWNNXI/id9ZpZknXS9z
        lZWmM3jjdSfbDMRBQLw16ngoOeb650eWUGMjxCT2hKpjxNxSJG1XqukvbNUticObKxnVNhNMcxUfk
        B1spNKfw==;
Received: from p200300ccff0a66008c01deceb8c061e7.dip0.t-ipconnect.de ([2003:cc:ff0a:6600:8c01:dece:b8c0:61e7] helo=akair)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1oqhSl-00026s-NC; Thu, 03 Nov 2022 22:09:23 +0100
Date:   Thu, 3 Nov 2022 22:09:22 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH] arm: dts: imx: e60k02: Add touchscreen
Message-ID: <20221103220922.261fe8fa@akair>
In-Reply-To: <20221026174300.6f5l6lsg5msrz6op@pengutronix.de>
References: <20221026173015.1172816-1-andreas@kemnade.info>
        <20221026174300.6f5l6lsg5msrz6op@pengutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

Am Wed, 26 Oct 2022 19:43:00 +0200
schrieb Marco Felsch <m.felsch@pengutronix.de>:

> Hi Andreas,
> 
> On 22-10-26, Andreas Kemnade wrote:
> > Add the touchscreen now, since the driver is available.  
> 
> I pulled input/next and grep'ed for the compatible but found nothing.
> Where should the driver be available?

now it is in input/next, so time to clean up this one here, too.


> Regards,
>   Marco
> 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> > runtime/dtbs_check depends
> > https://lore.kernel.org/linux-devicetree/20221026114908.191472-1-alistair@alistair23.me/T/#t
> >  arch/arm/boot/dts/e60k02.dtsi              | 12 +++++++++++-
> >  arch/arm/boot/dts/imx6sl-tolino-shine3.dts | 14 ++++++++++++++
> >  arch/arm/boot/dts/imx6sll-kobo-clarahd.dts | 14 ++++++++++++++
> >  3 files changed, 39 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/e60k02.dtsi
> > b/arch/arm/boot/dts/e60k02.dtsi index 935e2359f8df..4f36cc181a52
> > 100644 --- a/arch/arm/boot/dts/e60k02.dtsi
> > +++ b/arch/arm/boot/dts/e60k02.dtsi
> > @@ -104,7 +104,17 @@ &i2c2 {
> >  	clock-frequency = <100000>;
> >  	status = "okay";
> >  
> > -	/* TODO: CYTTSP5 touch controller at 0x24 */
> > +	touchscreen@24 {
> > +		compatible = "cypress,tt21000";
> > +		reg = <0x24>;
> > +		pinctrl-names = "default","sleep";  
> 
> Does the driver handle the different states?
> 
Well, apparently not, just copied it over from vendor kernel driver
which also does not handle that... So just leaving it out for now.

Regards,
Andreas
