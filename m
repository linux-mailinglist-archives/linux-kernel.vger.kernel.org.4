Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F38D748513
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjGENfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjGENfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:35:44 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2971171C;
        Wed,  5 Jul 2023 06:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=KOA/sIxRntn8PaEzfqns3GWcNQXCCvRxyb1RRiU0AGM=; b=jhJu04dlhrYmX4GEJ8FnBBBn5o
        6mTt88FsdEYBXcXqc44N+c9RmgA3SDYSjiq0pAAwFdVYLCuOgiV/IqfDfJrKhXdNEOGFxSUt9xH/M
        r3iznEHBtqPqwe3mGkEu6CI/QWrclH6+GafYiPPk2hy4mZbmvXBmIR6mw4zpceS6T6R8=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:52996 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qH2ey-0003qj-R7; Wed, 05 Jul 2023 09:35:16 -0400
Date:   Wed, 5 Jul 2023 09:35:07 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pierluigi Passaro <pierluigi.p@variscite.com>,
        Nate Drude <nate.d@variscite.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Message-Id: <20230705093507.7458eada3ae05e0e1740a10e@hugovil.com>
In-Reply-To: <CAOMZO5AZiuEAh6nJB8Oub83At6bsvLhzOhsT_yOniZSucrAUMQ@mail.gmail.com>
References: <20230704150240.2022020-1-hugo@hugovil.com>
        <1341ba38-35c1-1657-aed4-a3c11f584367@linaro.org>
        <20230704113124.f2830afe1d9df252afe5abdc@hugovil.com>
        <834a0679-7e0c-150f-68be-c75d7dac0bc8@linaro.org>
        <CAOMZO5CX8WzaNeHmE8ohT2_6F-ehRRNWGnF7Dji=uLGphY4q2A@mail.gmail.com>
        <20230704125541.f361cab8de3faacd830418ab@hugovil.com>
        <20230704130204.7ac64cbd76b3440fc351c373@hugovil.com>
        <CAOMZO5Dsp7YZfmpkBNsQgE4d3Ag-v2fpBAU=aZ9NGqGYoaOMWQ@mail.gmail.com>
        <20230704164140.824f6890dae5c87fc92531b4@hugovil.com>
        <CAOMZO5BNaQVMKbxU9rc5zOBwv9c+HayLnkjqrSgPKgMGzQ585A@mail.gmail.com>
        <20230704172801.f11422b3f947c625f53af871@hugovil.com>
        <CAOMZO5CWh0-5eMTBwjvNUrY-yOHE=daj6n-jAAfjWoV-H4rt0Q@mail.gmail.com>
        <CAOMZO5AZiuEAh6nJB8Oub83At6bsvLhzOhsT_yOniZSucrAUMQ@mail.gmail.com>
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

On Tue, 4 Jul 2023 20:00:13 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> On Tue, Jul 4, 2023 at 6:50 PM Fabio Estevam <festevam@gmail.com> wrote:
> >
> > On Tue, Jul 4, 2023 at 6:28 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> >
> > > Hi Fabio,
> > > it is important to remember that on this board, like I explained
> > > before, the INTB pin is not connected to anything.
> > >
> > > It is only the ID pin (9) that is connected to the GPIO1_11 pin.
> >
> > Now I looked at the schematics and you are right.
> >
> > In this case, GPIO1_11 should not be represented as irq then.
> 
> Variscite added an "irq-is-id-quirk"  property on their tree to handle this:
> 
> https://github.com/varigit/linux-imx/commit/fbe6aa2a9c014fdb10b29a715a1be695dac60828

Hi Fabio,
what do you think of Variscite's patch, is it something
worth doing?

At least the comment is interesting about the different EVK board
versions: mine is v1.6, which confirms the connection of the ID pin to
the GPIO1_11 pin. This also means that old boards have a connection from
the IRQ pin to GPIO1_11, and for these older boards the DTS is probably
Ok as it is?

How can we support both configurations?

Hugo.


