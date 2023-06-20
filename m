Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06EB737246
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 19:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjFTRGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 13:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjFTRF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:05:57 -0400
X-Greylist: delayed 80209 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 20 Jun 2023 10:05:55 PDT
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7774E1728;
        Tue, 20 Jun 2023 10:05:55 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1687280753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rTmTy1WXEGmdcqhzGnAmxnaNlJl7OG70Wq3ri14vgRY=;
        b=l1ezp8VHu1KMPm3mGn5zw3f5IbR53qX+AwhtlwlyknMpFjPPjuC9R1/GRoXGM8Stf5EK/g
        rrw8ANWqmK7HwDt9sQkLmjbrQchgs3/drSDuMZbdDpOU8Mgbfm/58J+pmkO7OhVwyltOKy
        TQfZcOYg6W9QrS/ZIyLsRJfovgF5dshyLmptWRTEcaIhARazWWg7/dbYmxOJ05CzrqDYLN
        x9984v3xTjtD1tsMfT4OrL8Uxs9FZgmGMj3m4GaxqtQKVY2mYVOve3E0TxCZuApaT9KqKw
        xLaaIvHgw2PYClD6YTKg0BaFDtSQ3p0zeFf7tAWVogAxQp5sc6cSz5XDkRB/tg==
Message-Id: <1687280004029.3690769854.982412891@manjaro.org>
From:   Furkan Kardame <f.kardame@manjaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        heiko@sntech.de, broonie@kernel.org, deller@gmx.de,
        dsterba@suse.com, arnd@arndb.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 2/2] arm64: dts: rockchip: add dts for Firefly
 Station P2 aka rk3568-roc-pc
Date:   Tue, 20 Jun 2023 17:05:48 +0000
In-Reply-To: <c020531e-c56e-7606-1846-5ca7332de96f@linaro.org>
References: <c020531e-c56e-7606-1846-5ca7332de96f@linaro.org>
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=f.kardame@manjaro.org smtp.mailfrom=f.kardame@manjaro.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




On Tuesday 20 June 2023 09:19:22 (+03:00), Krzysztof Kozlowski wrote:

> On 19/06/2023 20:48, Furkan Kardame wrote:
> > Add dts for Firefly Station P2.
> > Working IO:
> > * eMMC
> > * HDMI
> > * LAN
> > * LED
> > * SD Card
> > * UART
> > * USB2
> > * USB3
> ...
> 
> > +	};
> > +
> > +	hdmi-con {
> > +		compatible = "hdmi-connector";
> > +		type = "a";
> > +
> > +		port {
> > +			hdmi_con_in: endpoint {
> > +			remote-endpoint = <&hdmi_out_con>;
> 
> Missing indentation.

I am not able to see any missing indentation in the patch. 
I did run checkpatch and did not find any such warning.
Please advice in detail ?


> 
> ...
> 
> > +
> > +	vcc3v3_lcd0_n: vcc3v3-lcd0-n-regulator {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vcc3v3_lcd0_n";
> > +		regulator-boot-on;
> > +
> > +		regulator-state-mem {
> > +			regulator-off-in-suspend;
> 
> How do you turn this regulator off in suspend?

These nodes needs to be deleted as they are not used.
I will remove vcc3v3_lcd0_n and send a new patch.

> 
> > +		};
> > +	};
> > +
> > +	vcc3v3_lcd1_n: vcc3v3-lcd1-n-regulator {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vcc3v3_lcd1_n";
> > +		regulator-boot-on;
> > +
> > +		regulator-state-mem {
> > +			regulator-off-in-suspend;
> 
> Same question here.
vcc3v3_lcd1_n will be removed.
> 
> > +		};
> > +	};
> > +};
> 
> 
> 
> Best regards,
> Krzysztof
> 
> 

-- 
-- 
With best regards
Furkan Kardame

