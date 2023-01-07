Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9236D66103E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 17:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjAGQjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 11:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjAGQjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 11:39:17 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B91835905;
        Sat,  7 Jan 2023 08:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/llExgAPZ3RIC0yf5PjNEAEjXlWJCnrBr7593LlMKyE=; b=r2kv/WbN0owuxBxJhQ3LlwirxV
        MCBdMax1ttmUGkeNOh7NDQJtTTCklJYGGcnFbFPFnC899No7cH9CdmvkFyRkyqQ2UAyu4Nl4CnF96
        9L2Nx3+7DeGJFQSX4vpb0NUd261ZPe6+5VqUdAonXey6Ia2+F+Zkd1z7plx5fm0/XaD+prnZym3G2
        xW24LGA7CnZuzvFFgjbbLejKSW3rM9SsaUPpevSV/qjOHesyC71ESc8EWFbAOZON74ymSY05J1web
        rMxd/0QzieQq8iRtUOxdwJUCdYUNCPiYAhSwRIQyMsmH+gS5sBIBrQCMOHhW8RnYcTWo66JUUB09y
        vghQMODw==;
Received: from p200300ccff2fec001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff2f:ec00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pECDu-0005PS-S1; Sat, 07 Jan 2023 17:39:11 +0100
Date:   Sat, 7 Jan 2023 17:39:09 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lucas Stach <lst@pengutronix.de>
Subject: Re: [PATCH v2 4/5] ARM: dts: imx6sl: fix mmc compatibles
Message-ID: <20230107173909.6c798f47@aktux>
In-Reply-To: <CA+Eumj50L-bbVBX99Q-6y1-o_R58JvJFsStck+O2-18qJSUT1g@mail.gmail.com>
References: <20210924091439.2561931-1-andreas@kemnade.info>
        <20210924091439.2561931-5-andreas@kemnade.info>
        <a5ec87f2-7e72-9c23-e13a-75498287b451@pengutronix.de>
        <20210926203314.7c187191@aktux>
        <CA+Eumj50L-bbVBX99Q-6y1-o_R58JvJFsStck+O2-18qJSUT1g@mail.gmail.com>
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

On Mon, 27 Sep 2021 09:34:57 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote:

> On Sun, 26 Sept 2021 at 20:33, Andreas Kemnade <andreas@kemnade.info> wrote:
> >
> > Hi Ahmad,
> >
> > On Sun, 26 Sep 2021 08:54:35 +0200
> > Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> >  
> > > Hello Andreas,
> > >
> > > On 24.09.21 11:14, Andreas Kemnade wrote:  
> > > > Binding specification only allows one compatible here.  
> > >
> > > This same change was NACKed by Lucas here:
> > > https://lore.kernel.org/linux-devicetree/72e1194e10ccb4f87aed96265114f0963e805092.camel@pengutronix.de/
> > >
> > > I also think the schema should be fixed instead.
> > >  
> > well, that argumentation makes sense. Feel free to drop this patch. I
> > will not repost the series if it is just about dropping patches.  
> 
> The argument of using a new DTB with an old kernel, therefore
> prohibiting changes in new DTB, does not make that much sense, except
> when caring about other systems which would like to directly reuse the
> DTB... anyway it's not that important to fight over it.
> 
hmm, imx6sl_data specifies
ESDHC_FLAG_ERR004536 
imx6sq_data does not specify it.

Than there is  ESDHC_FLAG_STD_TUNING vs. ESDHC_FLAG_MAN_TUNING.
So it the fsl,imx6q-usdhc really a technically valid fallback compatible?

Regards,
Andreas
