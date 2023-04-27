Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE93D6F0E47
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 00:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344249AbjD0WTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 18:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344257AbjD0WTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 18:19:04 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9AD3A9B;
        Thu, 27 Apr 2023 15:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=9YQjuFSN4kwLI3L2Pm067bvytAmoH/WRm3VqGn0G0r4=; b=Tr6fVHV2MHVAy3XQNZgDoRWyYA
        bFnWGqd/Y38qMplmga2+xg8VpRgnu6m6Qf8jvgpGgYPpyUC0/el3Nw3DFPPRJCi6DjGuTYJRjmLfE
        h+3QjjLjADfPOjzIwK75DFWJlTl3lIIDvAR7vIZwqtYCV56N0IxsqU0DZaAsgJfxsuzU=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:59662 helo=debian-acer)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1ps9wZ-0004gV-In; Thu, 27 Apr 2023 18:18:27 -0400
Date:   Thu, 27 Apr 2023 18:18:26 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Message-Id: <20230427181826.3929691d2aa4820b6db7def8@hugovil.com>
In-Reply-To: <76302757-5359-5e70-02e2-daf0923843cb@pengutronix.de>
References: <20230427195538.2718661-1-hugo@hugovil.com>
        <CAOMZO5CQeeme6uhb8NCzR2QADjkBM-mRC9-GUnmhLWSGo5MMoQ@mail.gmail.com>
        <20230427160608.f051241d750404939296f60d@hugovil.com>
        <CAOMZO5BNbRV1fLpwDZWgj9+gihHJBBGeZCvkF1tgm5GhwSn8LQ@mail.gmail.com>
        <20230427161226.9c971530c6b848aa813c92b3@hugovil.com>
        <76302757-5359-5e70-02e2-daf0923843cb@pengutronix.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH] imx8mn-var-som: dts: fix PHY detection bug by adding
 deassert delay
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Apr 2023 22:16:45 +0200
Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:

> On 27.04.23 22:12, Hugo Villeneuve wrote:
> > On Thu, 27 Apr 2023 17:07:59 -0300
> > Fabio Estevam <festevam@gmail.com> wrote:
> > 
> >> On Thu, Apr 27, 2023 at 5:06 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> >>
> >>> Hi Fabio,
> >>> it uses a ADIN1300 PHY.
> >>>
> >>> The datasheet indicate that the "Management interface active (t4)" state is reached at most 5ms after the reset signal is deasserted.
> >>
> >> Please add this information to the commit log and please add a Fixes: tag.
> > 
> > Good idea, will do.
> 
> Please also add the PHY name into the DT, e.g.:
> 
>   ethphy: ethernet-phy@4 { /* ADIN1300 */
> 
> I find this very useful when bringing up a new board and looking
> for similar DTs.
> 
> Thanks,
> Ahmad

Hi Ahmad,
altough I agree it is a good idea, I prefer to not add this information for now, because there is probably some (old) versions of this SOM which use other PHY devices (maybe AR8033), but I am not 100% sure as this is not clear from the SOM manufacturer infos/website.

Hugo.
