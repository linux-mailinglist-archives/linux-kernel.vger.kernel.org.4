Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30116BB3E8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjCONHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjCONHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:07:47 -0400
X-Greylist: delayed 900 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Mar 2023 06:07:46 PDT
Received: from node.akkea.ca (li1434-30.members.linode.com [45.33.107.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2C482AA0;
        Wed, 15 Mar 2023 06:07:46 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id C285B4E201A;
        Wed, 15 Mar 2023 12:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1678883434; bh=aRhr7S0XMb4dCpigar/jzyprQ8sUWsPeIEm67TGLNu0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=ljkGLcoIB+xvl/ej0cua1hyQmS5e8R+6EdKcEjxruR0Eo0khXOIjo10pR2WOlyegy
         qPKw9jA3jrzK1+ePTcA/k/Bs1xufcsF35zliCbY4GTPCjQTxC93IdFjqnqJpjagAhz
         QxqTEgcXSasnrmwFTy0XEUISZiHbf3RpemrKAVqg=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jhaUJqO1qIO0; Wed, 15 Mar 2023 12:30:34 +0000 (UTC)
Received: from www.akkea.ca (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 2F9154E2010;
        Wed, 15 Mar 2023 12:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1678883434; bh=aRhr7S0XMb4dCpigar/jzyprQ8sUWsPeIEm67TGLNu0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=ljkGLcoIB+xvl/ej0cua1hyQmS5e8R+6EdKcEjxruR0Eo0khXOIjo10pR2WOlyegy
         qPKw9jA3jrzK1+ePTcA/k/Bs1xufcsF35zliCbY4GTPCjQTxC93IdFjqnqJpjagAhz
         QxqTEgcXSasnrmwFTy0XEUISZiHbf3RpemrKAVqg=
MIME-Version: 1.0
Date:   Wed, 15 Mar 2023 05:30:34 -0700
From:   Angus Ainslie <angus@akkea.ca>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Martin Kepplinger <martin.kepplinger@puri.sm>, robh@kernel.org,
        krzysztof.kozlowski@linaro.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, kernel@puri.sm,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Subject: Re: [PATCH v1 11/14] arm64: dts: imx8mq-librem5: Remove
 dis_u3_susphy_quirk from usb_dwc3_0
In-Reply-To: <20230314072832.GC143566@dragon>
References: <20230309204608.237605-1-martin.kepplinger@puri.sm>
 <20230309204608.237605-12-martin.kepplinger@puri.sm>
 <20230314072832.GC143566@dragon>
Message-ID: <c2cf4eb5fc984aec8a21adfc440b511e@akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.3.17
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

On 2023-03-14 00:28, Shawn Guo wrote:
> On Thu, Mar 09, 2023 at 09:46:05PM +0100, Martin Kepplinger wrote:
>> From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
>> 
>> This reduces power consumption in system suspend by about 10%.
> 
> Is there any other impact than this nice power gain?  Otherwise,
> I would wonder why the quirk was enabled in the first place.
> 

This comes from the early days of board bring-up and IIRC it seemed to 
stabilize flashing using the mfgtools over USB. Whatever gremlin was in 
those early boards is long gone and this is no longer needed.

Cheers
Angus

> Shawn
> 
>> 
>> Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
>> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
>> ---
>>  arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 1 -
>>  1 file changed, 1 deletion(-)
>> 
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi 
>> b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
>> index 0b4b49fa1392a..f557632f574fa 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
>> @@ -1322,7 +1322,6 @@ &usb_dwc3_0 {
>>  	#address-cells = <1>;
>>  	#size-cells = <0>;
>>  	dr_mode = "otg";
>> -	snps,dis_u3_susphy_quirk;
>>  	usb-role-switch;
>>  	status = "okay";
>> 
>> --
>> 2.30.2
>> 
