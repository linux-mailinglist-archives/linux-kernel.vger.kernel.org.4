Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03D17486CD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjGEOsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbjGEOss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:48:48 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEEF131;
        Wed,  5 Jul 2023 07:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=XH+JB6gPxXe+FXVZsJKM35nJhqf3bbyIHcipvbdom5E=; b=zICTOD8lF8kXlW310gy4xgd0EQ
        GHRI6twftfT9a64YUlROSQ29nmne+eThuuWAsJVOrciiKIB7gbsWycLfA0l7u8bba1kRZ4N36Rrw6
        /Ez97WtJrWc3VHrB6/5DedOC8zrE0dij8xx28sUlxdnDRmcawj8ATJ7B00pyPho3c87w=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:38280 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qH3o5-0004g6-Rt; Wed, 05 Jul 2023 10:48:38 -0400
Date:   Wed, 5 Jul 2023 10:48:37 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Nate Drude <Nate.D@variscite.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pierluigi Passaro <pierluigi.p@variscite.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-Id: <20230705104837.e620da576f22f28244daacb1@hugovil.com>
In-Reply-To: <AS2PR08MB88085D6B7338AD6D4D3C9956852FA@AS2PR08MB8808.eurprd08.prod.outlook.com>
References: <20230704150240.2022020-1-hugo@hugovil.com>
        <CAOMZO5CX8WzaNeHmE8ohT2_6F-ehRRNWGnF7Dji=uLGphY4q2A@mail.gmail.com>
        <20230704125541.f361cab8de3faacd830418ab@hugovil.com>
        <20230704130204.7ac64cbd76b3440fc351c373@hugovil.com>
        <CAOMZO5Dsp7YZfmpkBNsQgE4d3Ag-v2fpBAU=aZ9NGqGYoaOMWQ@mail.gmail.com>
        <20230704164140.824f6890dae5c87fc92531b4@hugovil.com>
        <CAOMZO5BNaQVMKbxU9rc5zOBwv9c+HayLnkjqrSgPKgMGzQ585A@mail.gmail.com>
        <20230704172801.f11422b3f947c625f53af871@hugovil.com>
        <CAOMZO5CWh0-5eMTBwjvNUrY-yOHE=daj6n-jAAfjWoV-H4rt0Q@mail.gmail.com>
        <CAOMZO5AZiuEAh6nJB8Oub83At6bsvLhzOhsT_yOniZSucrAUMQ@mail.gmail.com>
        <20230705093507.7458eada3ae05e0e1740a10e@hugovil.com>
        <AS2PR08MB88082608DB46EC1287C6E54B852FA@AS2PR08MB8808.eurprd08.prod.outlook.com>
        <CAOMZO5D-a4sUEqqsppjpgkCRFfeetY32+QP0CvrGw6v5q=J+KA@mail.gmail.com>
        <20230705102502.d8c9fa894bd271a5526d81f7@hugovil.com>
        <AS2PR08MB88085D6B7338AD6D4D3C9956852FA@AS2PR08MB8808.eurprd08.prod.outlook.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH] arm64: dts: imx8mn-var-som-symphony: fix USB OTG
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2023 14:31:40 +0000
Nate Drude <Nate.D@variscite.com> wrote:

> Hi Hugo,
> 
> On 7/5/23 9:25 AM, Hugo Villeneuve wrote:
> > [Some people who received this message don't often get email from hugo@hugovil.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > On Wed, 5 Jul 2023 10:49:01 -0300
> > Fabio Estevam <festevam@gmail.com> wrote:
> > 
> >> Hi Nate,
> >>
> >> On Wed, Jul 5, 2023 at 10:42 AM Nate Drude <Nate.D@variscite.com> wrote:
> >>
> >>> The patch 'drivers: extcon: ptn5150: Add irq-is-id-quirk' referred to by Fabio is required for OTG to work correctly on all versions of the Symphony board.
> >>>
> >>> I can submit this patch mainline, do you think it will be accepted as is?
> >>
> >> I think it is worth submitting it to get some feedback from the
> >> ptn5150 and DT maintainers.
> >>
> >> Thanks
> > 
> > Hi,
> > if I understand correctly, the irq-is-id-quirk device tree property
> > would be required for newer EVK boards, but not for older boards.
> > 
> > How can we support both configurations with the current device tree?
> > 
> > Hugo.
> For some time, we maintained a legacy device tree file: https://github.com/varigit/linux-imx/blob/5.4-2.1.x-imx_var01/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony-legacy.dts
> 
> However, it is no longer being maintained in our newest kernel branches.
> 
> Regards,
> Nate

Fabio: do we need to support both configurations in the Linux kernel
tree, and if yes how do you propose we do it?

Thank you,
Hugo.
