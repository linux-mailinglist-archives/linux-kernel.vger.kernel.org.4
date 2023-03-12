Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D176B6BCD
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 22:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjCLVlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 17:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjCLVk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 17:40:57 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030F734F56;
        Sun, 12 Mar 2023 14:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6f6Y7LE26iLoc26gBiJX3yiT5sQ5r15wZSUvx/W8T2A=; b=y2xckxbzEJzBEgBXHPIVBi2S5P
        UOXuf6LR3jI+mDoCJcROEk8+QZAVMKQMy6jcaPcTGf3P9EWu7CLbwilK71/BMlmFPGvcj/Wama3uh
        7zuZ8IlLHOhLtlC5ehRWNaoMegk+YK9LGXZyJser799SUPp0Vc5PweubB9nEqH48aXCLT2cZPvdu+
        MDyQeu5hHvJUnX4mVks9otMqJzxHUfjzxK+XWjsy6HFJbdtz5tiHEXLF9pSzZsOMNbdh6j1OzISfH
        QZKi96XqBFMSUwGgent5ylrhlt31GmymF7ILDxWPyHKjFHN8GDWdhVRzXc+WTvBXucGjCknXvWqXY
        CuGe8bOw==;
Received: from p200300ccff059e001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff05:9e00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pbTQk-00045m-9W; Sun, 12 Mar 2023 22:40:38 +0100
Date:   Sun, 12 Mar 2023 22:40:36 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, marex@denx.de, max.krummenacher@toradex.com,
        leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] ARM: dts: imx: Add devicetree for Tolino Vison
Message-ID: <20230312224036.37dc4d41@aktux>
In-Reply-To: <1346ce4e-f1fd-1a77-f38e-cd87efc59082@linaro.org>
References: <20230312205236.2281466-1-andreas@kemnade.info>
        <20230312205236.2281466-3-andreas@kemnade.info>
        <1346ce4e-f1fd-1a77-f38e-cd87efc59082@linaro.org>
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

On Sun, 12 Mar 2023 22:02:24 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 12/03/2023 21:52, Andreas Kemnade wrote:
> > This adds a devicetree for the Kobo Aura 2 Ebook reader. It is based
> > on boards marked with "37NB-E60Q30+4A3". It is equipped with an i.MX6SL
> > SoC.
> >   
> 
> Thank you for your patch. There is something to discuss/improve.
[...]
> > +	pinctrl_i2c2: i2c2grp {
> > +		fsl,pins = <
> > +			MX6SL_PAD_I2C2_SCL__I2C2_SCL	 0x4001f8b1
> > +			MX6SL_PAD_I2C2_SDA__I2C2_SDA	 0x4001f8b1
> > +		>;
> > +	};
> > +
> > +	pinctrl_i2c2_sleep: i2c2grp-sleep {  
> 
> Shouldn't all groups end with 'grp' suffix? Are you sure this passes
> dtbs_check?
> 
> ...
> 
No problem with dtbs_check. But I will resend with corrected names.

Regards,
Andreas
